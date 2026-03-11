--!strict
-- VotingController.lua
-- Manages the UI for map voting.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local VotingController = {}

local voteEvent = ReplicatedStorage:WaitForChild("VoteEvent")
local votingScreen = nil

local function onVoteButtonClicked(mapName)
    voteEvent:FireServer(mapName)
    votingScreen:Destroy()
end

function VotingController.showVotingScreen(mapOptions)
    if votingScreen then
        votingScreen:Destroy()
    end

    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    votingScreen = Instance.new("ScreenGui")
    votingScreen.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
    mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    mainFrame.Parent = votingScreen

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0.2, 0)
    title.Text = "Vote for the next map!"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 30
    title.Parent = mainFrame

    for i, mapName in ipairs(mapOptions) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.4, 0, 0.6, 0)
        button.Position = UDim2.new(0.05 + (i-1) * 0.45, 0, 0.3, 0)
        button.Text = mapName
        button.Font = Enum.Font.SourceSans
        button.TextSize = 24
        button.Parent = mainFrame
        button.MouseButton1Click:Connect(function()
            onVoteButtonClicked(mapName)
        end)
    end
end

return VotingController
