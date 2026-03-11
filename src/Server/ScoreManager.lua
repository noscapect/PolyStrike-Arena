--!strict
-- ScoreManager.lua
-- Manages player scores and integrates with the economy system.

local Players = game:GetService("Players")
local EconomyManager = require(script.Parent.EconomyManager)

local ScoreManager = {}

local scores = {}

Players.PlayerAdded:Connect(function(player)
    scores[player.UserId] = 0
end)

Players.PlayerRemoving:Connect(function(player)
    scores[player.UserId] = nil
end)

function ScoreManager.getScores()
    return scores
end

function ScoreManager.addScore(player, amount)
    if scores[player.UserId] then
        scores[player.UserId] += amount
        
        -- Award money for damage dealt (1 credit per 10 damage)
        local moneyAwarded = math.floor(amount / 10)
        if moneyAwarded > 0 then
            EconomyManager.addMoney(player, moneyAwarded)
        end
    end
end

function ScoreManager.resetScores()
    for userId, _ in pairs(scores) do
        scores[userId] = 0
    end
end

-- Initialize scores for players already in the game
for _, player in ipairs(Players:GetPlayers()) do
    scores[player.UserId] = 0
end

return ScoreManager
