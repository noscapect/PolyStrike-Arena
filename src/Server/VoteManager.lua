--!strict
-- VoteManager.lua
-- Manages the server-side logic for map voting.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local VoteManager = {}

local votes = {}
local voteEvent = ReplicatedStorage:WaitForChild("VoteEvent")
local showVoteScreenEvent = ReplicatedStorage:WaitForChild("ShowVoteScreenEvent")

local function onVoteReceived(player, mapName)
    if not votes[mapName] then
        votes[mapName] = 0
    end
    votes[mapName] += 1
end

function VoteManager.startVote(mapOptions)
    votes = {}
    showVoteScreenEvent:FireAllClients(mapOptions)

    local connection = voteEvent.OnServerEvent:Connect(onVoteReceived)

    -- Wait for voting to finish (e.g., 15 seconds)
    wait(15)

    connection:Disconnect()

    -- Tally votes
    local winningMap, maxVotes = nil, 0
    for mapName, numVotes in pairs(votes) do
        if numVotes > maxVotes then
            maxVotes = numVotes
            winningMap = mapName
        end
    end

    -- If no one voted, pick a random map
    if not winningMap then
        winningMap = mapOptions[math.random(1, #mapOptions)]
    end

    return winningMap
end

return VoteManager
