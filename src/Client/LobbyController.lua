--!strict
-- LobbyController.lua
-- Manages the client-side lobby interface with leaderboards, shop access, and spectating.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShopController = require(script.Parent.ShopController)
local SoundManager = require(script.Parent.SoundManager)

local LobbyController = {}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local lobbyGui = nil
local lobbyData = {}
local isPlayerInLobby = false

-- Remote events and functions
local lobbyUpdateEvent = ReplicatedStorage:WaitForChild("LobbyUpdateEvent")
local playerJoinLobbyEvent = ReplicatedStorage:WaitForChild("PlayerJoinLobbyEvent")
local playerLeaveLobbyEvent = ReplicatedStorage:WaitForChild("PlayerLeaveLobbyEvent")
local spectateRoundEvent = ReplicatedStorage:WaitForChild("SpectateRoundEvent")
local joinRoundEvent = ReplicatedStorage:WaitForChild("JoinRoundEvent")
local getLobbyDataEvent = ReplicatedStorage:WaitForChild("GetLobbyData")

function LobbyController.start()
    -- Create lobby UI
    LobbyController.createLobbyInterface()
    
    -- Connect to lobby updates
    lobbyUpdateEvent.OnClientEvent:Connect(function(data)
        lobbyData = data
        LobbyController.updateLobbyInterface()
    end)
    
    -- Get initial lobby data
    coroutine.wrap(function()
        wait(1) -- Wait for other systems to initialize
        local initialData = getLobbyDataEvent:InvokeServer()
        if initialData then
            lobbyData = initialData
            LobbyController.updateLobbyInterface()
        end
    end)()
    
    -- Bind lobby toggle key (L key)
    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.L then
            if isPlayerInLobby then
                LobbyController.joinRound()
            else
                LobbyController.enterLobby()
            end
        end
    end)
end

function LobbyController.createLobbyInterface()
    -- Main lobby GUI
    lobbyGui = Instance.new("ScreenGui")
    lobbyGui.Name = "LobbyGui"
    lobbyGui.Enabled = false
    lobbyGui.Parent = playerGui

    -- Lobby background
    local lobbyFrame = Instance.new("Frame")
    lobbyFrame.Name = "LobbyFrame"
    lobbyFrame.Size = UDim2.new(0.8, 0, 0.9, 0)
    lobbyFrame.Position = UDim2.new(0.1, 0, 0.05, 0)
    lobbyFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    lobbyFrame.BorderSizePixel = 2
    lobbyFrame.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
    lobbyFrame.Parent = lobbyGui

    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "LOBBY"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 48
    title.BackgroundTransparency = 1
    title.Parent = lobbyFrame

    -- Balance display
    local balanceLabel = Instance.new("TextLabel")
    balanceLabel.Name = "BalanceLabel"
    balanceLabel.Size = UDim2.new(0.3, 0, 0.05, 0)
    balanceLabel.Position = UDim2.new(0.7, 0, 0.02, 0)
    balanceLabel.Text = "Balance: 0"
    balanceLabel.TextColor3 = Color3.new(0, 1, 0)
    balanceLabel.Font = Enum.Font.SourceSansBold
    balanceLabel.TextSize = 20
    balanceLabel.BackgroundTransparency = 1
    balanceLabel.Parent = lobbyFrame

    -- Round status
    local roundStatus = Instance.new("TextLabel")
    roundStatus.Name = "RoundStatus"
    roundStatus.Size = UDim2.new(0.5, 0, 0.05, 0)
    roundStatus.Position = UDim2.new(0.25, 0, 0.02, 0)
    roundStatus.Text = "Round Status: Waiting..."
    roundStatus.TextColor3 = Color3.new(1, 1, 0)
    roundStatus.Font = Enum.Font.SourceSansBold
    roundStatus.TextSize = 20
    roundStatus.BackgroundTransparency = 1
    roundStatus.Parent = lobbyFrame

    -- Player lists container
    local listsContainer = Instance.new("Frame")
    listsContainer.Name = "ListsContainer"
    listsContainer.Size = UDim2.new(0.95, 0, 0.7, 0)
    listsContainer.Position = UDim2.new(0.025, 0, 0.12, 0)
    listsContainer.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    listsContainer.BorderSizePixel = 1
    listsContainer.BorderColor3 = Color3.new(0.25, 0.25, 0.25)
    listsContainer.Parent = lobbyFrame

    -- Lobby players section
    local lobbyPlayersLabel = Instance.new("TextLabel")
    lobbyPlayersLabel.Name = "LobbyPlayersLabel"
    lobbyPlayersLabel.Size = UDim2.new(0.48, 0, 0.08, 0)
    lobbyPlayersLabel.Position = UDim2.new(0.01, 0, 0.01, 0)
    lobbyPlayersLabel.Text = "LOBBY PLAYERS"
    lobbyPlayersLabel.TextColor3 = Color3.new(0.5, 0.5, 1)
    lobbyPlayersLabel.Font = Enum.Font.SourceSansBold
    lobbyPlayersLabel.TextSize = 18
    lobbyPlayersLabel.BackgroundTransparency = 1
    lobbyPlayersLabel.Parent = listsContainer

    local lobbyPlayersList = Instance.new("ScrollingFrame")
    lobbyPlayersList.Name = "LobbyPlayersList"
    lobbyPlayersList.Size = UDim2.new(0.48, 0, 0.85, 0)
    lobbyPlayersList.Position = UDim2.new(0.01, 0, 0.1, 0)
    lobbyPlayersList.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    lobbyPlayersList.BorderSizePixel = 1
    lobbyPlayersList.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
    lobbyPlayersList.ScrollBarThickness = 8
    lobbyPlayersList.Parent = listsContainer

    local lobbyListLayout = Instance.new("UIListLayout")
    lobbyListLayout.Parent = lobbyPlayersList

    -- In-game players section
    local inGamePlayersLabel = Instance.new("TextLabel")
    inGamePlayersLabel.Name = "InGamePlayersLabel"
    inGamePlayersLabel.Size = UDim2.new(0.48, 0, 0.08, 0)
    inGamePlayersLabel.Position = UDim2.new(0.51, 0, 0.01, 0)
    inGamePlayersLabel.Text = "IN-GAME PLAYERS"
    inGamePlayersLabel.TextColor3 = Color3.new(1, 0.5, 0.5)
    inGamePlayersLabel.Font = Enum.Font.SourceSansBold
    inGamePlayersLabel.TextSize = 18
    inGamePlayersLabel.BackgroundTransparency = 1
    inGamePlayersLabel.Parent = listsContainer

    local inGamePlayersList = Instance.new("ScrollingFrame")
    inGamePlayersList.Name = "InGamePlayersList"
    inGamePlayersList.Size = UDim2.new(0.48, 0, 0.85, 0)
    inGamePlayersList.Position = UDim2.new(0.51, 0, 0.1, 0)
    inGamePlayersList.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    inGamePlayersList.BorderSizePixel = 1
    inGamePlayersList.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
    inGamePlayersList.ScrollBarThickness = 8
    inGamePlayersList.Parent = listsContainer

    local inGameListLayout = Instance.new("UIListLayout")
    inGameListLayout.Parent = inGamePlayersList

    -- Action buttons
    local buttonsContainer = Instance.new("Frame")
    buttonsContainer.Name = "ButtonsContainer"
    buttonsContainer.Size = UDim2.new(0.95, 0, 0.15, 0)
    buttonsContainer.Position = UDim2.new(0.025, 0, 0.83, 0)
    buttonsContainer.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    buttonsContainer.BorderSizePixel = 1
    buttonsContainer.BorderColor3 = Color3.new(0.25, 0.25, 0.25)
    buttonsContainer.Parent = lobbyFrame

    -- Shop button
    local shopButton = Instance.new("TextButton")
    shopButton.Name = "ShopButton"
    shopButton.Size = UDim2.new(0.2, 0, 0.7, 0)
    shopButton.Position = UDim2.new(0.02, 0, 0.15, 0)
    shopButton.Text = "SHOP"
    shopButton.TextColor3 = Color3.new(1, 1, 1)
    shopButton.Font = Enum.Font.SourceSansBold
    shopButton.TextSize = 20
    shopButton.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
    shopButton.Parent = buttonsContainer

    shopButton.MouseButton1Click:Connect(function()
        ShopController.toggleShop()
        SoundManager.playSound("MenuSelect")
    end)

    -- Spectate button
    local spectateButton = Instance.new("TextButton")
    spectateButton.Name = "SpectateButton"
    spectateButton.Size = UDim2.new(0.2, 0, 0.7, 0)
    spectateButton.Position = UDim2.new(0.25, 0, 0.15, 0)
    spectateButton.Text = "SPECTATE"
    spectateButton.TextColor3 = Color3.new(1, 1, 1)
    spectateButton.Font = Enum.Font.SourceSansBold
    spectateButton.TextSize = 20
    spectateButton.BackgroundColor3 = Color3.new(0.2, 0.6, 1)
    spectateButton.Parent = buttonsContainer

    spectateButton.MouseButton1Click:Connect(function()
        spectateRoundEvent:FireServer()
        SoundManager.playSound("MenuSelect")
    end)

    -- Join round button
    local joinButton = Instance.new("TextButton")
    joinButton.Name = "JoinButton"
    joinButton.Size = UDim2.new(0.2, 0, 0.7, 0)
    joinButton.Position = UDim2.new(0.48, 0, 0.15, 0)
    joinButton.Text = "JOIN ROUND"
    joinButton.TextColor3 = Color3.new(1, 1, 1)
    joinButton.Font = Enum.Font.SourceSansBold
    joinButton.TextSize = 20
    joinButton.BackgroundColor3 = Color3.new(1, 0.5, 0.2)
    joinButton.Parent = buttonsContainer

    joinButton.MouseButton1Click:Connect(function()
        LobbyController.joinRound()
        SoundManager.playSound("MenuSelect")
    end)

    -- Leave lobby button
    local leaveButton = Instance.new("TextButton")
    leaveButton.Name = "LeaveButton"
    leaveButton.Size = UDim2.new(0.2, 0, 0.7, 0)
    leaveButton.Position = UDim2.new(0.71, 0, 0.15, 0)
    leaveButton.Text = "LEAVE LOBBY"
    leaveButton.TextColor3 = Color3.new(1, 1, 1)
    leaveButton.Font = Enum.Font.SourceSansBold
    leaveButton.TextSize = 20
    leaveButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    leaveButton.Parent = buttonsContainer

    leaveButton.MouseButton1Click:Connect(function()
        LobbyController.leaveLobby()
        SoundManager.playSound("MenuSelect")
    end)
end

function LobbyController.updateLobbyInterface()
    if not lobbyGui then return end
    
    -- Update balance
    local balanceLabel = lobbyGui:FindFirstChild("LobbyFrame"):FindFirstChild("BalanceLabel")
    if balanceLabel and lobbyData.lobbyPlayers then
        for _, playerData in ipairs(lobbyData.lobbyPlayers) do
            if playerData.name == player.Name then
                balanceLabel.Text = string.format("Balance: %d", playerData.balance)
                break
            end
        end
    end
    
    -- Update round status
    local roundStatus = lobbyGui:FindFirstChild("LobbyFrame"):FindFirstChild("RoundStatus")
    if roundStatus then
        if lobbyData.isRoundActive then
            local timeRemaining = math.ceil(lobbyData.roundTimeRemaining)
            roundStatus.Text = string.format("Round Active - Time Remaining: %d seconds", timeRemaining)
            roundStatus.TextColor3 = Color3.new(1, 0, 0)
        else
            roundStatus.Text = "Round Status: Waiting for players..."
            roundStatus.TextColor3 = Color3.new(1, 1, 0)
        end
    end
    
    -- Update player lists
    LobbyController.updatePlayerLists()
end

function LobbyController.updatePlayerLists()
    local listsContainer = lobbyGui:FindFirstChild("LobbyFrame"):FindFirstChild("ListsContainer")
    if not listsContainer then return end
    
    -- Clear existing player entries
    for _, child in ipairs(listsContainer:GetChildren()) do
        if child:IsA("ScrollingFrame") then
            for _, entry in ipairs(child:GetChildren()) do
                if entry:IsA("TextButton") then
                    entry:Destroy()
                end
            end
        end
    end
    
    -- Add lobby players
    local lobbyList = listsContainer:FindFirstChild("LobbyPlayersList")
    if lobbyList and lobbyData.lobbyPlayers then
        for _, playerData in ipairs(lobbyData.lobbyPlayers) do
            LobbyController.createPlayerEntry(lobbyList, playerData, true)
        end
    end
    
    -- Add in-game players
    local inGameList = listsContainer:FindFirstChild("InGamePlayersList")
    if inGameList and lobbyData.inGamePlayers then
        for _, playerData in ipairs(lobbyData.inGamePlayers) do
            LobbyController.createPlayerEntry(inGameList, playerData, false)
        end
    end
end

function LobbyController.createPlayerEntry(parentList, playerData, isInLobby)
    local entry = Instance.new("TextButton")
    entry.Name = "PlayerEntry_" .. playerData.name
    entry.Size = UDim2.new(1, 0, 0.1, 0)
    entry.Position = UDim2.new(0, 0, 0, 0)
    entry.Text = string.format("%s%s", playerData.name, playerData.isSpectating and " (Spectating)" or "")
    entry.TextColor3 = isInLobby and Color3.new(0.5, 0.5, 1) or Color3.new(1, 0.5, 0.5)
    entry.Font = Enum.Font.SourceSansBold
    entry.TextSize = 16
    entry.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
    entry.BorderSizePixel = 1
    entry.BorderColor3 = Color3.new(0.4, 0.4, 0.4)
    entry.Parent = parentList
    
    -- Highlight current player
    if playerData.name == player.Name then
        entry.BackgroundColor3 = Color3.new(0.3, 0.3, 0.5)
        entry.TextColor3 = Color3.new(1, 1, 1)
    end
end

function LobbyController.enterLobby()
    playerJoinLobbyEvent:FireServer()
    isPlayerInLobby = true
    if lobbyGui then
        lobbyGui.Enabled = true
    end
    SoundManager.playSound("MenuSelect")
end

function LobbyController.leaveLobby()
    playerLeaveLobbyEvent:FireServer()
    isPlayerInLobby = false
    if lobbyGui then
        lobbyGui.Enabled = false
    end
    SoundManager.playSound("MenuSelect")
end

function LobbyController.joinRound()
    joinRoundEvent:FireServer()
    isPlayerInLobby = false
    if lobbyGui then
        lobbyGui.Enabled = false
    end
    SoundManager.playSound("RoundStart")
end

function LobbyController.toggleLobby()
    if isPlayerInLobby then
        LobbyController.leaveLobby()
    else
        LobbyController.enterLobby()
    end
end

return LobbyController