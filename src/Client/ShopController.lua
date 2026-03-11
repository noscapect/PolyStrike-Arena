--!strict
-- ShopController.lua
-- Manages the in-game shop interface for purchasing skins and effects.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundManager = require(script.Parent.SoundManager)

local ShopController = {}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local shopGui = nil
local balanceLabel = nil
local shopItemsContainer = nil

local getShopItemsEvent = ReplicatedStorage:WaitForChild("GetShopItems")
local getPlayerDataEvent = ReplicatedStorage:WaitForChild("GetPlayerData")
local purchaseEvent = ReplicatedStorage:WaitForChild("PurchaseEvent")
local robuxPurchaseEvent = ReplicatedStorage:WaitForChild("RobuxPurchaseEvent")

local currentBalance = 0
local currentInventory = {}

function ShopController.start()
    -- Create shop UI
    shopGui = Instance.new("ScreenGui")
    shopGui.Name = "ShopGui"
    shopGui.Enabled = false
    shopGui.Parent = playerGui

    -- Shop background
    local shopFrame = Instance.new("Frame")
    shopFrame.Name = "ShopFrame"
    shopFrame.Size = UDim2.new(0.6, 0, 0.8, 0)
    shopFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
    shopFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    shopFrame.BorderSizePixel = 2
    shopFrame.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
    shopFrame.Parent = shopGui

    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "ITEM SHOP"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 36
    title.BackgroundTransparency = 1
    title.Parent = shopFrame

    -- Balance display
    balanceLabel = Instance.new("TextLabel")
    balanceLabel.Name = "BalanceLabel"
    balanceLabel.Size = UDim2.new(0.3, 0, 0.05, 0)
    balanceLabel.Position = UDim2.new(0.7, 0, 0.02, 0)
    balanceLabel.Text = "Balance: 0"
    balanceLabel.TextColor3 = Color3.new(0, 1, 0)
    balanceLabel.Font = Enum.Font.SourceSansBold
    balanceLabel.TextSize = 20
    balanceLabel.BackgroundTransparency = 1
    balanceLabel.Parent = shopFrame

    -- Close button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.1, 0, 0.05, 0)
    closeButton.Position = UDim2.new(0.9, 0, 0.02, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextSize = 20
    closeButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    closeButton.Parent = shopFrame

    closeButton.MouseButton1Click:Connect(function()
        ShopController.closeShop()
    end)

    -- Shop items container
    shopItemsContainer = Instance.new("ScrollingFrame")
    shopItemsContainer.Name = "ItemsContainer"
    shopItemsContainer.Size = UDim2.new(0.95, 0, 0.85, 0)
    shopItemsContainer.Position = UDim2.new(0.025, 0, 0.12, 0)
    shopItemsContainer.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    shopItemsContainer.BorderSizePixel = 1
    shopItemsContainer.BorderColor3 = Color3.new(0.25, 0.25, 0.25)
    shopItemsContainer.ScrollBarThickness = 10
    shopItemsContainer.Parent = shopFrame

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = shopItemsContainer
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Load initial data
    ShopController.refreshShop()
    
    -- Bind toggle key (B key)
    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.B then
            ShopController.toggleShop()
        end
    end)
end

function ShopController.toggleShop()
    if shopGui then
        shopGui.Enabled = not shopGui.Enabled
        if shopGui.Enabled then
            ShopController.refreshShop()
            SoundManager.playSound("MenuSelect")
        end
    end
end

function ShopController.closeShop()
    if shopGui then
        shopGui.Enabled = false
    end
end

function ShopController.refreshShop()
    -- Get shop items and player data
    local shopItems = getShopItemsEvent:InvokeServer()
    currentInventory = getPlayerDataEvent:InvokeServer()
    currentBalance = currentInventory.balance

    -- Update balance display
    if balanceLabel then
        balanceLabel.Text = string.format("Balance: %d", currentBalance)
    end

    -- Clear existing items
    for _, child in ipairs(shopItemsContainer:GetChildren()) do
        if child:IsA("Frame") and child.Name ~= "UIListLayout" then
            child:Destroy()
        end
    end

    -- Create shop items
    for _, item in ipairs(shopItems) do
        ShopController.createShopItem(item)
    end
end

function ShopController.createShopItem(item)
    local itemFrame = Instance.new("Frame")
    itemFrame.Name = "ShopItem"
    itemFrame.Size = UDim2.new(0.95, 0, 0.2, 0)
    itemFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    itemFrame.BorderSizePixel = 2
    itemFrame.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
    itemFrame.Parent = shopItemsContainer

    -- Item preview/color
    local preview = Instance.new("Frame")
    preview.Name = "Preview"
    preview.Size = UDim2.new(0.2, 0, 0.8, 0)
    preview.Position = UDim2.new(0.02, 0, 0.1, 0)
    preview.BackgroundColor3 = item.color or Color3.new(0.5, 0.5, 0.5)
    preview.BorderSizePixel = 2
    preview.BorderColor3 = Color3.new(0, 0, 0)
    preview.Parent = itemFrame

    -- Item info
    local infoFrame = Instance.new("Frame")
    infoFrame.Name = "InfoFrame"
    infoFrame.Size = UDim2.new(0.5, 0, 0.8, 0)
    infoFrame.Position = UDim2.new(0.25, 0, 0.1, 0)
    infoFrame.BackgroundTransparency = 1
    infoFrame.Parent = itemFrame

    local itemName = Instance.new("TextLabel")
    itemName.Name = "ItemName"
    itemName.Size = UDim2.new(1, 0, 0.3, 0)
    itemName.Position = UDim2.new(0, 0, 0, 0)
    itemName.Text = item.name
    itemName.TextColor3 = Color3.new(1, 1, 1)
    itemName.Font = Enum.Font.SourceSansBold
    itemName.TextSize = 18
    itemName.BackgroundTransparency = 1
    itemName.Parent = infoFrame

    local itemDesc = Instance.new("TextLabel")
    itemDesc.Name = "ItemDesc"
    itemDesc.Size = UDim2.new(1, 0, 0.4, 0)
    itemDesc.Position = UDim2.new(0, 0, 0.3, 0)
    itemDesc.Text = item.description
    itemDesc.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    itemDesc.Font = Enum.Font.SourceSans
    itemDesc.TextSize = 14
    itemDesc.BackgroundTransparency = 1
    itemDesc.TextWrapped = true
    itemDesc.Parent = infoFrame

    local itemType = Instance.new("TextLabel")
    itemType.Name = "ItemType"
    itemType.Size = UDim2.new(1, 0, 0.3, 0)
    itemType.Position = UDim2.new(0, 0, 0.7, 0)
    itemType.Text = string.upper(item.category)
    itemType.TextColor3 = Color3.new(0.5, 0.5, 1)
    itemType.Font = Enum.Font.SourceSansBold
    itemType.TextSize = 14
    itemType.BackgroundTransparency = 1
    itemType.Parent = infoFrame

    -- Price and button
    local priceFrame = Instance.new("Frame")
    priceFrame.Name = "PriceFrame"
    priceFrame.Size = UDim2.new(0.2, 0, 0.8, 0)
    priceFrame.Position = UDim2.new(0.78, 0, 0.1, 0)
    priceFrame.BackgroundTransparency = 1
    priceFrame.Parent = itemFrame

    local priceLabel = Instance.new("TextLabel")
    priceLabel.Name = "PriceLabel"
    priceLabel.Size = UDim2.new(1, 0, 0.4, 0)
    priceLabel.Position = UDim2.new(0, 0, 0, 0)
    priceLabel.Text = string.format("%d", item.price)
    priceLabel.TextColor3 = Color3.new(1, 1, 0)
    priceLabel.Font = Enum.Font.SourceSansBold
    priceLabel.TextSize = 24
    priceLabel.BackgroundTransparency = 1
    priceLabel.Parent = priceFrame

    local currencyIcon = Instance.new("TextLabel")
    currencyIcon.Name = "CurrencyIcon"
    currencyIcon.Size = UDim2.new(1, 0, 0.2, 0)
    currencyIcon.Position = UDim2.new(0, 0, 0.45, 0)
    currencyIcon.Text = item.currency == "money" and "CREDITS" or "ROBUX"
    currencyIcon.TextColor3 = item.currency == "money" and Color3.new(0, 1, 0) or Color3.new(1, 0.5, 0)
    currencyIcon.Font = Enum.Font.SourceSansBold
    currencyIcon.TextSize = 12
    currencyIcon.BackgroundTransparency = 1
    currencyIcon.Parent = priceFrame

    local buyButton = Instance.new("TextButton")
    buyButton.Name = "BuyButton"
    buyButton.Size = UDim2.new(1, 0, 0.3, 0)
    buyButton.Position = UDim2.new(0, 0, 0.6, 0)
    buyButton.Text = "BUY"
    buyButton.TextColor3 = Color3.new(1, 1, 1)
    buyButton.Font = Enum.Font.SourceSansBold
    buyButton.TextSize = 18
    buyButton.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
    buyButton.Parent = priceFrame

    -- Check if item is already owned
    local isOwned = false
    if item.category == "skin" then
        for _, ownedSkin in ipairs(currentInventory.inventory.skins) do
            if ownedSkin.id == item.id then
                isOwned = true
                break
            end
        end
    elseif item.category == "kill_effect" then
        isOwned = currentInventory.inventory.killEffects[item.id] or false
    end

    if isOwned then
        buyButton.Text = "OWNED"
        buyButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
        buyButton.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    elseif currentBalance < item.price then
        buyButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
        buyButton.Text = "INSUFFICIENT"
    end

    -- Button click handler
    buyButton.MouseButton1Click:Connect(function()
        if isOwned then
            if item.category == "kill_effect" then
                -- Equip the effect
                local equipEvent = ReplicatedStorage:FindFirstChild("EquipKillEffect")
                if equipEvent then
                    equipEvent:InvokeServer(item.id)
                    ShopController.refreshShop()
                end
            end
        elseif currentBalance >= item.price then
            -- Purchase the item
            purchaseEvent:FireServer(item.id)
            wait(0.1) -- Small delay for server response
            ShopController.refreshShop()
        end
        SoundManager.playSound("MenuSelect")
    end)
end

return ShopController