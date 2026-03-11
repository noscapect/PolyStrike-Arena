--!strict
-- EconomyManager.lua
-- Manages player currency, purchases, and the in-game shop system.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local EconomyManager = {}

-- Currency data storage
local playerBalances = {}
local playerInventory = {}

-- Shop items configuration
local shopItems = {
    -- Skins
    {
        id = "golden_pistol_skin",
        name = "Golden Pistol Skin",
        description = "Make your pistol shine with this golden finish!",
        category = "skin",
        weapon = "Pistol",
        price = 500,
        currency = "money",
        color = BrickColor.new("Gold")
    },
    {
        id = "neon_rifle_skin",
        name = "Neon Rifle Skin",
        description = "Give your assault rifle a cyberpunk glow!",
        category = "skin",
        weapon = "Assault Rifle",
        price = 750,
        currency = "money",
        color = BrickColor.new("Bright blue")
    },
    {
        id = "camo_shotgun_skin",
        name = "Camo Shotgun Skin",
        description = "Military-grade camouflage for your shotgun!",
        category = "skin",
        weapon = "Shotgun",
        price = 600,
        currency = "money",
        color = BrickColor.new("Dark green")
    },
    {
        id = "plasma_rifle_skin",
        name = "Plasma Rifle Skin",
        description = "Futuristic plasma coating for your rifle!",
        category = "skin",
        weapon = "Plasma Rifle",
        price = 800,
        currency = "money",
        color = BrickColor.new("Bright purple")
    },
    
    -- Kill Effects
    {
        id = "explosion_kill_effect",
        name = "Explosion Kill Effect",
        description = "Enemies explode in a fiery blast when you defeat them!",
        category = "kill_effect",
        effectType = "explosion",
        price = 1000,
        currency = "money"
    },
    {
        id = "spark_rain_kill_effect",
        name = "Spark Rain Kill Effect",
        description = "Victims rain down electric sparks when defeated!",
        category = "kill_effect",
        effectType = "spark_rain",
        price = 800,
        currency = "money"
    },
    {
        id = "confetti_kill_effect",
        name = "Confetti Kill Effect",
        description = "Celebrate your victory with a confetti explosion!",
        category = "kill_effect",
        effectType = "confetti",
        price = 600,
        currency = "money"
    },
    {
        id = "ghost_kill_effect",
        name = "Ghost Kill Effect",
        description = "Defeated enemies leave behind a spooky ghost!",
        category = "kill_effect",
        effectType = "ghost",
        price = 700,
        currency = "money"
    },
    
    -- Currency Packs (Robux)
    {
        id = "small_currency_pack",
        name = "Small Currency Pack",
        description = "Get 1000 credits instantly!",
        category = "currency_pack",
        price = 99, -- Robux
        currency = "robux",
        amount = 1000
    },
    {
        id = "medium_currency_pack",
        name = "Medium Currency Pack",
        description = "Get 2500 credits instantly!",
        category = "currency_pack",
        price = 249, -- Robux
        currency = "robux",
        amount = 2500
    },
    {
        id = "large_currency_pack",
        name = "Large Currency Pack",
        description = "Get 6000 credits instantly!",
        category = "currency_pack",
        price = 499, -- Robux
        currency = "robux",
        amount = 6000
    },
    {
        id = "mega_currency_pack",
        name = "Mega Currency Pack",
        description = "Get 15000 credits instantly!",
        category = "currency_pack",
        price = 999, -- Robux
        currency = "robux",
        amount = 15000
    }
}

-- Remote events and functions
local purchaseEvent = Instance.new("RemoteEvent")
purchaseEvent.Name = "PurchaseEvent"
purchaseEvent.Parent = ReplicatedStorage

local getShopItemsEvent = Instance.new("RemoteFunction")
getShopItemsEvent.Name = "GetShopItems"
getShopItemsEvent.Parent = ReplicatedStorage

local getPlayerDataEvent = Instance.new("RemoteFunction")
getPlayerDataEvent.Name = "GetPlayerData"
getPlayerDataEvent.Parent = ReplicatedStorage

local robuxPurchaseEvent = Instance.new("RemoteEvent")
robuxPurchaseEvent.Name = "RobuxPurchaseEvent"
robuxPurchaseEvent.Parent = ReplicatedStorage

-- Initialize player data
Players.PlayerAdded:Connect(function(player)
    -- Initialize balance (starting bonus)
    playerBalances[player.UserId] = 100
    
    -- Initialize inventory
    playerInventory[player.UserId] = {
        skins = {},
        killEffects = {},
        equippedKillEffect = "default"
    }
    
    -- Give default items
    playerInventory[player.UserId].killEffects["default"] = true
end)

Players.PlayerRemoving:Connect(function(player)
    playerBalances[player.UserId] = nil
    playerInventory[player.UserId] = nil
end)

-- Currency earning functions
function EconomyManager.addMoney(player, amount)
    if playerBalances[player.UserId] then
        playerBalances[player.UserId] += amount
        
        -- Notify client of balance update
        local updateEvent = ReplicatedStorage:FindFirstChild("BalanceUpdateEvent")
        if updateEvent then
            updateEvent:FireClient(player, playerBalances[player.UserId])
        end
    end
end

function EconomyManager.getSpendableMoney(player)
    return playerBalances[player.UserId] or 0
end

-- Shop functions
function EconomyManager.getShopItems()
    return shopItems
end

function EconomyManager.purchaseItem(player, itemId)
    local item = nil
    for _, shopItem in ipairs(shopItems) do
        if shopItem.id == itemId then
            item = shopItem
            break
        end
    end
    
    if not item then
        return false, "Item not found"
    end
    
    local playerBalance = playerBalances[player.UserId] or 0
    
    if item.currency == "money" then
        if playerBalance >= item.price then
            playerBalances[player.UserId] -= item.price
            
            -- Add item to inventory
            if item.category == "skin" then
                table.insert(playerInventory[player.UserId].skins, item)
            elseif item.category == "kill_effect" then
                playerInventory[player.UserId].killEffects[item.id] = true
            end
            
            -- Notify client
            local updateEvent = ReplicatedStorage:FindFirstChild("BalanceUpdateEvent")
            if updateEvent then
                updateEvent:FireClient(player, playerBalances[player.UserId])
            end
            
            return true, "Purchase successful"
        else
            return false, "Insufficient funds"
        end
    end
    
    return false, "Invalid currency type"
end

function EconomyManager.getInventory(player)
    return playerInventory[player.UserId] or {
        skins = {},
        killEffects = {},
        equippedKillEffect = "default"
    }
end

function EconomyManager.equipKillEffect(player, effectId)
    local inventory = playerInventory[player.UserId]
    if inventory and inventory.killEffects[effectId] then
        inventory.equippedKillEffect = effectId
        return true
    end
    return false
end

-- Robux purchase handling
function EconomyManager.processRobuxPurchase(player, productId)
    -- This would be connected to actual Roblox purchase processing
    -- For now, we'll simulate the currency addition
    
    local pack = nil
    for _, item in ipairs(shopItems) do
        if item.category == "currency_pack" and item.id == productId then
            pack = item
            break
        end
    end
    
    if pack then
        EconomyManager.addMoney(player, pack.amount)
        return true
    end
    
    return false
end

-- Remote function handlers
getShopItemsEvent.OnServerInvoke = function(player)
    return EconomyManager.getShopItems()
end

getPlayerDataEvent.OnServerInvoke = function(player)
    return {
        balance = EconomyManager.getSpendableMoney(player),
        inventory = EconomyManager.getInventory(player)
    }
end

purchaseEvent.OnServerEvent:Connect(function(player, itemId)
    local success, message = EconomyManager.purchaseItem(player, itemId)
    -- Send result back to client (you'd need a response event for this)
end)

robuxPurchaseEvent.OnServerEvent:Connect(function(player, productId)
    local success = EconomyManager.processRobuxPurchase(player, productId)
    -- Send result back to client
end)

-- Initialize starting players
for _, player in ipairs(Players:GetPlayers()) do
    playerBalances[player.UserId] = 100
    playerInventory[player.UserId] = {
        skins = {},
        killEffects = {},
        equippedKillEffect = "default"
    }
    playerInventory[player.UserId].killEffects["default"] = true
end

return EconomyManager