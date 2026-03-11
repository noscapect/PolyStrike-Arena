--!strict
-- PlayerController.lua
-- This script will manage the first-person perspective and character movement.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerController = {}

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local powerUpEvent = ReplicatedStorage:WaitForChild("PowerUpEvent")

local powerUpActive = false
local damageMultiplier = 1
local defaultWalkSpeed
local activeEffects = {}
local playerEffects = {}

local function onRenderStep()
    if player and player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
            -- Lock mouse to the center for first-person view
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter

            -- Make the character follow the camera direction
            local cameraDirection = camera.CFrame.LookVector
            local newCF = CFrame.new(player.Character.HumanoidRootPart.Position) * CFrame.Angles(0, math.atan2(cameraDirection.X, cameraDirection.Z) - math.pi, 0)
            player.Character.HumanoidRootPart.CFrame = newCF
        end
    end
end

function PlayerController.start()
    -- Force first-person mode
    player.CameraMode = Enum.CameraMode.LockFirstPerson

    -- Hide the player's character from their own view
    if player.Character then
        defaultWalkSpeed = player.Character.Humanoid.WalkSpeed
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0.5
            end
        end
    end

    powerUpEvent.OnClientEvent:Connect(function(powerUpType, duration)
        if activeEffects[powerUpType] then return end
        
        activeEffects[powerUpType] = true
        
        -- Apply effect
        if powerUpType == "SpeedBoost" then
            player.Character.Humanoid.WalkSpeed = defaultWalkSpeed * 1.5
            createVisualEffect("Speed", Color3.new(0, 1, 0))
        elseif powerUpType == "DamageAmplifier" then
            damageMultiplier = 2
            createVisualEffect("Damage", Color3.new(1, 0, 0))
        elseif powerUpType == "HealthPack" then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = math.min(humanoid.Health + 50, humanoid.MaxHealth)
            end
            createVisualEffect("Heal", Color3.new(0, 1, 1))
        elseif powerUpType == "AmmoPack" then
            -- Refill ammo for current weapon
            local WeaponController = require(script.Parent.WeaponController)
            local currentWeapon = WeaponController.getCurrentWeapon()
            currentWeapon.CurrentAmmo = currentWeapon.ClipSize
            createVisualEffect("Ammo", Color3.new(1, 1, 0))
        elseif powerUpType == "Shield" then
            player.Character.Humanoid.WalkSpeed = defaultWalkSpeed * 0.8 -- Slight slowdown
            createVisualEffect("Shield", Color3.new(0.5, 0.5, 1))
        elseif powerUpType == "Invisibility" then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = 1
                end
            end
            createVisualEffect("Invisibility", Color3.new(1, 1, 1))
        end

        -- Create timer for effect duration
        if duration > 0 then
            spawn(function()
                wait(duration)
                removeEffect(powerUpType)
            end)
        else
            -- Instant effect, remove immediately
            activeEffects[powerUpType] = false
        end
    end)
    
    -- Connect to the render step
    RunService:BindToRenderStep("PlayerController", Enum.RenderPriority.Character.Value, onRenderStep)
end

function PlayerController.getDamageMultiplier()
    return damageMultiplier
end

function createVisualEffect(effectType, color)
    if player.Character then
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local particle = Instance.new("Part")
            particle.Size = Vector3.new(0.1, 0.1, 0.1)
            particle.Position = rootPart.Position
            particle.Anchored = true
            particle.CanCollide = false
            particle.Transparency = 1
            
            local particleEmitter = Instance.new("ParticleEmitter")
            particleEmitter.Texture = "rbxassetid://243082608"
            particleEmitter.Color = ColorSequence.new(color)
            particleEmitter.Size = NumberSequence.new(0.5, 2)
            particleEmitter.Lifetime = NumberRange.new(1, 2)
            particleEmitter.Rate = 50
            particleEmitter.Speed = NumberRange.new(5, 10)
            particleEmitter.ZOffset = 1
            particleEmitter.Parent = particle
            
            particle.Parent = workspace
            game:GetService("Debris"):AddItem(particle, 3)
        end
    end
end

function removeEffect(effectType)
    activeEffects[effectType] = false
    
    if effectType == "SpeedBoost" then
        player.Character.Humanoid.WalkSpeed = defaultWalkSpeed
    elseif effectType == "DamageAmplifier" then
        damageMultiplier = 1
    elseif effectType == "Shield" then
        player.Character.Humanoid.WalkSpeed = defaultWalkSpeed
    elseif effectType == "Invisibility" then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0.5
            end
        end
    end
end

return PlayerController
