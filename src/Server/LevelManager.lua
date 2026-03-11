--!strict
-- LevelManager.lua
-- Manages the loading and unloading of levels.

local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LevelManager = {}

local levels = {}
local currentMap = nil

function LevelManager.loadLevels()
    local levelModules = ReplicatedStorage:WaitForChild("Levels"):GetChildren()
    for _, levelModule in ipairs(levelModules) do
        local level = require(levelModule)
        levels[level.Name] = level
    end
end

function LevelManager.getLevels()
    local levelNames = {}
    for name, _ in pairs(levels) do
        table.insert(levelNames, name)
    end
    return levelNames
end

function LevelManager.loadMap(levelName)
    if currentMap then
        currentMap:Destroy()
    end

    local level = levels[levelName]
    if level then
        currentMap = level.build()
        return level
    else
        warn("Attempted to load a map that does not exist: " .. levelName)
        return nil
    end
end

return LevelManager
