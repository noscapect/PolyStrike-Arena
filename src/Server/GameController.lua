--!strict
-- GameController.lua
-- This script manages the game loop, rounds, and enemy spawning.

local LevelManager = require(script.Parent.LevelManager)
local VoteManager = require(script.Parent.VoteManager)
local EnemyController = require(script.Parent.EnemyController)
local ScoreManager = require(script.Parent.ScoreManager)
local PowerUpController = require(script.Parent.PowerUpController)
local LobbyManager = require(script.Parent.LobbyManager)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameController = {}

local ROUND_DURATION = 120 -- 2 minutes
local INTERMISSION_DURATION = 20 -- 20 seconds
local updateScoresEvent = ReplicatedStorage:WaitForChild("UpdateScoresEvent")

local function teleportPlayers(spawnPoints)
    local players = Players:GetPlayers()
    for i, player in ipairs(players) do
        if player.Character then
            local spawnPoint = spawnPoints[((i-1) % #spawnPoints) + 1]
            player.Character:SetPrimaryPartCFrame(CFrame.new(spawnPoint))
        end
    end
end

local function cleanupEnemies()
    for _, child in ipairs(workspace:GetChildren()) do
        if child.Name == "Enemy" then
            child:Destroy()
        end
    end
end

local function cleanupPowerUps()
    for _, child in ipairs(workspace:GetChildren()) do
        if child.Name == "PowerUp" then
            child:Destroy()
        end
    end
end

function GameController.start()
    coroutine.wrap(function()
        while true do
            -- Lobby Phase - Players can interact, shop, spectate
            LobbyManager.setRoundActive(false)
            LobbyManager.clearLobby() -- Move all players to lobby
            
            -- Wait for players to join round or start voting
            wait(5) -- Brief pause for lobby setup
            
            -- Voting Phase
            local mapOptions = LevelManager.getLevels()
            local winningMapName = VoteManager.startVote(mapOptions)
            
            -- Load the next map
            local loadedMap = LevelManager.loadMap(winningMapName)
            if not loadedMap then
                warn("Failed to load map: " .. winningMapName)
                wait(INTERMISSION_DURATION)
                continue
            end
            
            ScoreManager.resetScores()
            
            -- Teleport active players to map, keep lobby players in lobby
            local activePlayers = {}
            for userId, playerData in pairs(LobbyManager.inGamePlayers) do
                table.insert(activePlayers, playerData.player)
            end
            
            -- If no players joined, still run the round for spectators
            if #activePlayers > 0 then
                for i, player in ipairs(activePlayers) do
                    if player.Character then
                        local spawnPoint = loadedMap.SpawnPoints[((i-1) % #loadedMap.SpawnPoints) + 1]
                        player.Character:SetPrimaryPartCFrame(CFrame.new(spawnPoint))
                    end
                end
            end

            -- Round Phase
            LobbyManager.setRoundActive(true)
            local roundEndTime = tick() + ROUND_DURATION
            local spawnTimer = 0
            local scoreUpdateTimer = 0
            local powerUpSpawnTimer = 0
            
            while tick() < roundEndTime do
                local dt = wait()
                spawnTimer = spawnTimer + dt
                scoreUpdateTimer = scoreUpdateTimer + dt
                powerUpSpawnTimer = powerUpSpawnTimer + dt

                if spawnTimer >= 5 then
                    spawnTimer = 0
                    local spawnPoint = loadedMap.SpawnPoints[math.random(1, #loadedMap.SpawnPoints)]
                    
                    -- Enemy spawning with increasing difficulty over time
                    local timeElapsed = ROUND_DURATION - (roundEndTime - tick())
                    local spawnChance = {
                        MeleeZombie = math.max(0.3, 0.8 - (timeElapsed / ROUND_DURATION) * 0.5),
                        RangedShooter = 0.3 + (timeElapsed / ROUND_DURATION) * 0.3,
                        Dodger = 0.2 + (timeElapsed / ROUND_DURATION) * 0.4,
                        Tank = math.max(0, (timeElapsed / ROUND_DURATION) - 0.3),
                        Kamikaze = math.max(0, (timeElapsed / ROUND_DURATION) - 0.4),
                        Healer = math.max(0, (timeElapsed / ROUND_DURATION) - 0.5),
                        Sniper = math.max(0, (timeElapsed / ROUND_DURATION) - 0.6)
                    }
                    
                    -- Select enemy type based on weighted probabilities
                    local totalWeight = 0
                    for _, weight in pairs(spawnChance) do
                        totalWeight += weight
                    end
                    
                    local randomValue = math.random() * totalWeight
                    local currentWeight = 0
                    local selectedType = "MeleeZombie"
                    
                    for enemyType, weight in pairs(spawnChance) do
                        currentWeight += weight
                        if randomValue <= currentWeight then
                            selectedType = enemyType
                            break
                        end
                    end
                    
                    EnemyController.createEnemy(spawnPoint, selectedType)
                end

                if scoreUpdateTimer >= 1 then
                    scoreUpdateTimer = 0
                    updateScoresEvent:FireAllClients(ScoreManager.getScores())
                end

                if powerUpSpawnTimer >= 15 then
                    powerUpSpawnTimer = 0
                    local spawnPoint = loadedMap.SpawnPoints[math.random(1, #loadedMap.SpawnPoints)]
                    PowerUpController.spawnPowerUp(spawnPoint)
                end
            end
            
            -- Intermission
            cleanupEnemies()
            cleanupPowerUps()
            LobbyManager.setRoundActive(false)
            wait(INTERMISSION_DURATION)
        end
    end)()
end

return GameController
