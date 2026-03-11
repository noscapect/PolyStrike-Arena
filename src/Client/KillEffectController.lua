--!strict
-- KillEffectController.lua
-- Manages the display of special kill effects.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local KillEffectController = {}

local showKillEffectEvent = ReplicatedStorage:WaitForChild("ShowKillEffectEvent")

local function showEffect(position)
    local part = Instance.new("Part")
    part.Position = position
    part.Size = Vector3.new(1, 1, 1)
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1
    part.Parent = workspace

    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Texture = "rbxassetid://1379434319" -- A star texture
    particleEmitter.Size = NumberSequence.new(0.5, 1)
    particleEmitter.Lifetime = NumberRange.new(0.5, 1)
    particleEmitter.Rate = 50
    particleEmitter.Speed = NumberRange.new(5, 10)
    particleEmitter.Parent = part

    game:GetService("Debris"):AddItem(part, 2)
end

function KillEffectController.start()
    showKillEffectEvent.OnClientEvent:Connect(showEffect)
end

return KillEffectController
