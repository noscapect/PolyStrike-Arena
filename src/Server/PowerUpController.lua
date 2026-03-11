--!strict
-- PowerUpController.lua
-- This script manages power-ups in the game.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local PowerUpController = {}

local powerUpEvent = Instance.new("RemoteEvent")
powerUpEvent.Name = "PowerUpEvent"
powerUpEvent.Parent = ReplicatedStorage

local POWERUP_TYPES = {
    "SpeedBoost",
    "DamageAmplifier",
    "HealthPack",
    "AmmoPack",
    "Shield",
    "Invisibility"
}

local POWERUP_DURATION = 10 -- seconds
local POWERUP_EFFECTS = {
    SpeedBoost = {duration = 10, effect = "SpeedBoost"},
    DamageAmplifier = {duration = 10, effect = "DamageAmplifier"},
    HealthPack = {duration = 0, effect = "Heal", amount = 50},
    AmmoPack = {duration = 0, effect = "AmmoRefill"},
    Shield = {duration = 15, effect = "Shield"},
    Invisibility = {duration = 8, effect = "Invisibility"}
}

local function createPowerUpPart(position, powerUpType)
    local part = Instance.new("Part")
    part.Size = Vector3.new(3, 3, 3)
    part.Position = position
    part.Anchored = true
    part.CanCollide = false
    part.Name = "PowerUp"
    part.Material = Enum.Material.Neon
    
    if powerUpType == "SpeedBoost" then
        part.BrickColor = BrickColor.new("Bright yellow")
    elseif powerUpType == "DamageAmplifier" then
        part.BrickColor = BrickColor.new("Bright red")
    end
    
    part.Touched:Connect(function(otherPart)
        local player = Players:GetPlayerFromCharacter(otherPart.Parent)
        if player then
            powerUpEvent:FireClient(player, powerUpType, POWERUP_DURATION)
            part:Destroy()
        end
    end)
    
    return part
end

function PowerUpController.spawnPowerUp(position)
    local powerUpType = POWERUP_TYPES[math.random(1, #POWERUP_TYPES)]
    local powerUpPart = createPowerUpPart(position, powerUpType)
    powerUpPart.Parent = workspace
end

return PowerUpController
