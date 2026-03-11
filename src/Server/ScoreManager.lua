--!strict
-- ScoreManager.lua
-- Manages player scores.

local Players = game:GetService("Players")

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
