--!strict
-- ScoreboardController.lua
-- Manages the leaderboard UI.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ScoreboardController = {}

local updateScoresEvent = ReplicatedStorage:WaitForChild("UpdateScoresEvent")
local scoreboardGui = nil

local function updateScores(scores)
    if not scoreboardGui then
        local player = Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")
        
        scoreboardGui = Instance.new("ScreenGui")
        scoreboardGui.Name = "ScoreboardGui"
        scoreboardGui.Parent = playerGui

        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "MainFrame"
        mainFrame.Size = UDim2.new(0.2, 0, 0.4, 0)
        mainFrame.Position = UDim2.new(0.79, 0, 0.05, 0)
        mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        mainFrame.Parent = scoreboardGui
        
        local uiListLayout = Instance.new("UIListLayout")
        uiListLayout.Parent = mainFrame
        uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    end

    -- Clear old scores
    for _, child in ipairs(scoreboardGui.MainFrame:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    -- Create a sorted list of scores
    local sortedScores = {}
    for userId, score in pairs(scores) do
        local player = Players:GetPlayerByUserId(userId)
        if player then
            table.insert(sortedScores, {name = player.Name, score = score})
        end
    end
    table.sort(sortedScores, function(a, b) return a.score > b.score end)

    -- Display new scores
    for i, data in ipairs(sortedScores) do
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = data.name
        textLabel.Text = string.format("%s: %d", data.name, data.score)
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.Font = Enum.Font.SourceSans
        textLabel.TextSize = 18
        textLabel.LayoutOrder = i
        textLabel.Parent = scoreboardGui.MainFrame
    end
end

function ScoreboardController.start()
    updateScoresEvent.OnClientEvent:Connect(updateScores)
end

return ScoreboardController
