--!strict
-- GameController.lua
-- This script manages the game loop, rounds, and enemy spawning.

local LevelManager = require(script.Parent.LevelManager)
local VoteManager = require(script.Parent.VoteManager)
local EnemyController = require(script.Parent.EnemyController)
local ScoreManager = require(script.Parent.ScoreManager)
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

function GameController.start()
    coroutine.wrap(function()
        while true do
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
            teleportPlayers(loadedMap.SpawnPoints)

            -- Round Phase
            local roundEndTime = tick() + ROUND_DURATION
            local spawnTimer = 0
            local scoreUpdateTimer = 0
            
            while tick() < roundEndTime do
                local dt = wait()
                spawnTimer = spawnTimer + dt
                scoreUpdateTimer = scoreUpdateTimer + dt

                if spawnTimer >= 5 then
                    spawnTimer = 0
                    local spawnPoint = loadedMap.SpawnPoints[math.random(1, #loadedMap.SpawnPoints)]
                    local enemyTypes = {"MeleeZombie", "RangedShooter", "Dodger"}
                    local enemyType = enemyTypes[math.random(1, #enemyTypes)]
                    EnemyController.createEnemy(spawnPoint, enemyType)
                end

                if scoreUpdateTimer >= 1 then
                    scoreUpdateTimer = 0
                    updateScoresEvent:FireAllClients(ScoreManager.getScores())
                end
            end
            
            -- Intermission
            cleanupEnemies()
            wait(INTERMISSION_DURATION)
        end
    end)()
end

return GameController
