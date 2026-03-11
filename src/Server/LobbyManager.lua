--!strict
-- LobbyManager.lua
-- Manages the lobby system where players can interact, view leaderboards, shop, and spectate rounds.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EconomyManager = require(script.Parent.EconomyManager)

local LobbyManager = {}

-- Lobby state
local lobbyPlayers = {} -- Players in lobby
local inGamePlayers = {} -- Players actively playing
local isRoundActive = false
local roundStartTime = 0
local roundEndTime = 0

-- Remote events and functions
local lobbyUpdateEvent = Instance.new("RemoteEvent")
lobbyUpdateEvent.Name = "LobbyUpdateEvent"
lobbyUpdateEvent.Parent = ReplicatedStorage

local playerJoinLobbyEvent = Instance.new("RemoteEvent")
playerJoinLobbyEvent.Name = "PlayerJoinLobbyEvent"
playerJoinLobbyEvent.Parent = ReplicatedStorage

local playerLeaveLobbyEvent = Instance.new("RemoteEvent")
playerLeaveLobbyEvent.Name = "PlayerLeaveLobbyEvent"
playerLeaveLobbyEvent.Parent = ReplicatedStorage

local spectateRoundEvent = Instance.new("RemoteEvent")
spectateRoundEvent.Name = "SpectateRoundEvent"
spectateRoundEvent.Parent = ReplicatedStorage

local joinRoundEvent = Instance.new("RemoteEvent")
joinRoundEvent.Name = "JoinRoundEvent"
joinRoundEvent.Parent = ReplicatedStorage

local getLobbyDataEvent = Instance.new("RemoteFunction")
getLobbyDataEvent.Name = "GetLobbyData"
getLobbyDataEvent.Parent = ReplicatedStorage

-- Initialize lobby for existing players
Players.PlayerAdded:Connect(function(player)
    -- Add player to lobby by default
    LobbyManager.addPlayerToLobby(player)
    
    -- Set up player character removal for spectating
    player.CharacterRemoving:Connect(function()
        if lobbyPlayers[player.UserId] then
            LobbyManager.addPlayerToLobby(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    LobbyManager.removePlayer(player)
end)

function LobbyManager.addPlayerToLobby(player)
    if lobbyPlayers[player.UserId] then return end
    
    lobbyPlayers[player.UserId] = {
        player = player,
        isInLobby = true,
        isSpectating = false,
        balance = EconomyManager.getSpendableMoney(player),
        inventory = EconomyManager.getInventory(player)
    }
    
    -- Teleport to lobby area
    LobbyManager.teleportToLobby(player)
    
    -- Update all clients
    lobbyUpdateEvent:FireAllClients(LobbyManager.getLobbyData())
    
    print(player.Name .. " joined the lobby")
end

function LobbyManager.removePlayer(player)
    lobbyPlayers[player.UserId] = nil
    inGamePlayers[player.UserId] = nil
    
    -- Update all clients
    lobbyUpdateEvent:FireAllClients(LobbyManager.getLobbyData())
    
    print(player.Name .. " left the game")
end

function LobbyManager.teleportToLobby(player)
    if not player.Character then return end
    
    -- Create or find lobby area
    local lobbyArea = workspace:FindFirstChild("LobbyArea")
    if not lobbyArea then
        lobbyArea = Instance.new("Model")
        lobbyArea.Name = "LobbyArea"
        lobbyArea.Parent = workspace
        
        -- Create lobby floor
        local lobbyFloor = Instance.new("Part")
        lobbyFloor.Name = "LobbyFloor"
        lobbyFloor.Size = Vector3.new(100, 1, 100)
        lobbyFloor.Position = Vector3.new(0, 0, 0)
        lobbyFloor.Material = Enum.Material.Concrete
        lobbyFloor.BrickColor = BrickColor.new("Dark stone gray")
        lobbyFloor.Anchored = true
        lobbyFloor.CanCollide = true
        lobbyFloor.Parent = lobbyArea
        
        -- Create lobby walls (transparent for visibility)
        local wallThickness = 5
        local wallHeight = 20
        
        local walls = {
            {size = Vector3.new(100, wallHeight, wallThickness), pos = Vector3.new(0, wallHeight/2, 50)},
            {size = Vector3.new(100, wallHeight, wallThickness), pos = Vector3.new(0, wallHeight/2, -50)},
            {size = Vector3.new(wallThickness, wallHeight, 100), pos = Vector3.new(50, wallHeight/2, 0)},
            {size = Vector3.new(wallThickness, wallHeight, 100), pos = Vector3.new(-50, wallHeight/2, 0)}
        }
        
        for _, wallData in ipairs(walls) do
            local wall = Instance.new("Part")
            wall.Name = "LobbyWall"
            wall.Size = wallData.size
            wall.Position = wallData.pos
            wall.Material = Enum.Material.Glass
            wall.Transparency = 0.8
            wall.Anchored = true
            wall.CanCollide = true
            wall.Parent = lobbyArea
        end
        
        -- Create spectator viewing platform
        local viewingPlatform = Instance.new("Part")
        viewingPlatform.Name = "ViewingPlatform"
        viewingPlatform.Size = Vector3.new(40, 1, 40)
        viewingPlatform.Position = Vector3.new(0, 10, -30)
        viewingPlatform.Material = Enum.Material.Glass
        viewingPlatform.Transparency = 0.5
        viewingPlatform.Anchored = true
        viewingPlatform.CanCollide = true
        viewingPlatform.Parent = lobbyArea
        
        -- Add viewing platform text
        local viewingText = Instance.new("TextLabel")
        viewingText.Text = "SPECTATOR VIEW"
        viewingText.TextColor3 = Color3.new(1, 1, 1)
        viewingText.BackgroundTransparency = 1
        viewingText.Font = Enum.Font.SourceSansBold
        viewingText.TextSize = 24
        viewingText.Size = UDim2.new(1, 0, 0.2, 0)
        viewingText.Position = UDim2.new(0, 0, 0.4, 0)
        viewingText.Parent = viewingPlatform
    end
    
    -- Teleport player to lobby
    player.Character:SetPrimaryPartCFrame(CFrame.new(0, 5, 0))
end

function LobbyManager.joinRound(player)
    if not lobbyPlayers[player.UserId] then return end
    
    -- Move player from lobby to in-game
    lobbyPlayers[player.UserId] = nil
    inGamePlayers[player.UserId] = {
        player = player,
        isInLobby = false,
        isSpectating = false
    }
    
    -- Notify that player joined round
    joinRoundEvent:FireAllClients(player.Name)
    
    -- Update lobby data
    lobbyUpdateEvent:FireAllClients(LobbyManager.getLobbyData())
    
    print(player.Name .. " joined the round")
end

function LobbyManager.spectateRound(player)
    if not lobbyPlayers[player.UserId] then return end
    
    lobbyPlayers[player.UserId].isSpectating = true
    
    -- Move player to viewing platform
    if player.Character then
        player.Character:SetPrimaryPartCFrame(CFrame.new(0, 15, -30))
    end
    
    -- Update lobby data
    lobbyUpdateEvent:FireAllClients(LobbyManager.getLobbyData())
    
    print(player.Name .. " is now spectating")
end

function LobbyManager.getLobbyData()
    local data = {
        lobbyPlayers = {},
        inGamePlayers = {},
        isRoundActive = isRoundActive,
        roundTimeRemaining = math.max(0, roundEndTime - tick()),
        roundStartTime = roundStartTime,
        roundEndTime = roundEndTime
    }
    
    -- Add lobby players
    for userId, playerData in pairs(lobbyPlayers) do
        table.insert(data.lobbyPlayers, {
            name = playerData.player.Name,
            isInLobby = playerData.isInLobby,
            isSpectating = playerData.isSpectating,
            balance = playerData.balance,
            inventory = playerData.inventory
        })
    end
    
    -- Add in-game players
    for userId, playerData in pairs(inGamePlayers) do
        table.insert(data.inGamePlayers, {
            name = playerData.player.Name,
            isInLobby = playerData.isInLobby,
            isSpectating = playerData.isSpectating
        })
    end
    
    return data
end

function LobbyManager.setRoundActive(active)
    isRoundActive = active
    if active then
        roundStartTime = tick()
        roundEndTime = roundStartTime + 120 -- 2 minutes
    else
        roundStartTime = 0
        roundEndTime = 0
    end
    
    -- Update all clients
    lobbyUpdateEvent:FireAllClients(LobbyManager.getLobbyData())
end

function LobbyManager.clearLobby()
    -- Move all players back to lobby
    for userId, playerData in pairs(inGamePlayers) do
        LobbyManager.addPlayerToLobby(playerData.player)
    end
    inGamePlayers = {}
    
    -- Reset spectating status
    for userId, playerData in pairs(lobbyPlayers) do
        playerData.isSpectating = false
    end
    
    -- Update all clients
    lobbyUpdateEvent:FireAllClients(LobbyManager.getLobbyData())
end

-- Remote function handlers
getLobbyDataEvent.OnServerInvoke = function(player)
    return LobbyManager.getLobbyData()
end

-- Remote event connections
playerJoinLobbyEvent.OnServerEvent:Connect(function(player)
    LobbyManager.addPlayerToLobby(player)
end)

playerLeaveLobbyEvent.OnServerEvent:Connect(function(player)
    LobbyManager.removePlayer(player)
end)

joinRoundEvent.OnServerEvent:Connect(function(player)
    LobbyManager.joinRound(player)
end)

spectateRoundEvent.OnServerEvent:Connect(function(player)
    LobbyManager.spectateRound(player)
end)

return LobbyManager