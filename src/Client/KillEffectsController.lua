--!strict
-- KillEffectsController.lua
-- Manages special kill effects for players based on their equipped effects.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundManager = require(script.Parent.SoundManager)

local KillEffectsController = {}

local player = Players.LocalPlayer
local currentKillEffect = "default"

-- Remote event for showing kill effects
local showKillEffectEvent = ReplicatedStorage:FindFirstChild("ShowKillEffectEvent")
if not showKillEffectEvent then
    showKillEffectEvent = Instance.new("RemoteEvent")
    showKillEffectEvent.Name = "ShowKillEffectEvent"
    showKillEffectEvent.Parent = ReplicatedStorage
end

-- Remote function for equipping kill effects
local equipKillEffectEvent = ReplicatedStorage:FindFirstChild("EquipKillEffect")
if not equipKillEffectEvent then
    equipKillEffectEvent = Instance.new("RemoteFunction")
    equipKillEffectEvent.Name = "EquipKillEffect"
    equipKillEffectEvent.Parent = ReplicatedStorage
end

function KillEffectsController.setKillEffect(effectId)
    currentKillEffect = effectId
end

function KillEffectsController.showKillEffect(position, enemyType)
    if currentKillEffect == "default" then
        -- Default effect: simple sparks
        KillEffectsController.createDefaultEffect(position)
    elseif currentKillEffect == "explosion_kill_effect" then
        KillEffectsController.createExplosionEffect(position)
    elseif currentKillEffect == "spark_rain_kill_effect" then
        KillEffectsController.createSparkRainEffect(position)
    elseif currentKillEffect == "confetti_kill_effect" then
        KillEffectsController.createConfettiEffect(position)
    elseif currentKillEffect == "ghost_kill_effect" then
        KillEffectsController.createGhostEffect(position)
    end
end

function KillEffectsController.createDefaultEffect(position)
    -- Simple spark effect
    local spark = Instance.new("Part")
    spark.Name = "KillSpark"
    spark.Shape = Enum.PartType.Ball
    spark.Size = Vector3.new(0.5, 0.5, 0.5)
    spark.Position = position
    spark.Material = Enum.Material.Neon
    spark.BrickColor = BrickColor.new("Bright yellow")
    spark.Anchored = true
    spark.CanCollide = false
    spark.Transparency = 0.5
    
    local sparkParticle = Instance.new("ParticleEmitter")
    sparkParticle.Texture = "rbxassetid://349236983"
    sparkParticle.Color = ColorSequence.new(Color3.new(1, 1, 0), Color3.new(1, 0.5, 0))
    sparkParticle.Size = NumberSequence.new(0.1, 0.3)
    sparkParticle.Lifetime = NumberRange.new(0.2, 0.5)
    sparkParticle.Rate = 20
    sparkParticle.Speed = NumberRange.new(5, 15)
    sparkParticle.Parent = spark
    
    sparkParticle:Emit(10)
    
    game:GetService("Debris"):AddItem(spark, 1)
end

function KillEffectsController.createExplosionEffect(position)
    -- Fire explosion effect
    local explosion = Instance.new("Explosion")
    explosion.Position = position
    explosion.BlastRadius = 8
    explosion.BlastPressure = 20
    explosion.Parent = workspace
    
    -- Fire particles
    local fire = Instance.new("Part")
    fire.Name = "KillFire"
    fire.Shape = Enum.PartType.Cylinder
    fire.Size = Vector3.new(2, 1, 2)
    fire.Position = position
    fire.Material = Enum.Material.Neon
    fire.BrickColor = BrickColor.new("Bright yellow")
    fire.Anchored = true
    fire.CanCollide = false
    fire.Transparency = 0.5
    
    local fireParticle = Instance.new("ParticleEmitter")
    fireParticle.Texture = "rbxassetid://243082608"
    fireParticle.Color = ColorSequence.new(Color3.new(1, 0.5, 0), Color3.new(1, 0, 0))
    fireParticle.Size = NumberSequence.new(0.5, 2)
    fireParticle.Lifetime = NumberRange.new(0.5, 1.5)
    fireParticle.Rate = 50
    fireParticle.Speed = NumberRange.new(2, 8)
    fireParticle.Parent = fire
    
    fireParticle:Emit(25)
    
    game:GetService("Debris"):AddItem(fire, 2)
    
    -- Play explosion sound
    SoundManager.playSound("Explosion")
end

function KillEffectsController.createSparkRainEffect(position)
    -- Electric spark rain effect
    for i = 1, 15 do
        local spark = Instance.new("Part")
        spark.Name = "ElectricSpark"
        spark.Shape = Enum.PartType.Ball
        spark.Size = Vector3.new(0.3, 0.3, 0.3)
        spark.Position = position + Vector3.new(math.random(-3, 3), 5, math.random(-3, 3))
        spark.Material = Enum.Material.Neon
        spark.BrickColor = BrickColor.new("Bright blue")
        spark.Anchored = false
        spark.CanCollide = true
        
        -- Add physics for falling
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, -20, 0)
        bodyVelocity.MaxForce = Vector3.new(0, 1000, 0)
        bodyVelocity.Parent = spark
        
        local sparkParticle = Instance.new("ParticleEmitter")
        sparkParticle.Texture = "rbxassetid://349236983"
        sparkParticle.Color = ColorSequence.new(Color3.new(0, 1, 1), Color3.new(0, 0.5, 1))
        sparkParticle.Size = NumberSequence.new(0.1, 0.2)
        sparkParticle.Lifetime = NumberRange.new(0.3, 0.8)
        sparkParticle.Rate = 10
        sparkParticle.Speed = NumberRange.new(1, 3)
        sparkParticle.Parent = spark
        
        sparkParticle:Emit(5)
        
        game:GetService("Debris"):AddItem(spark, 3)
        game:GetService("Debris"):AddItem(bodyVelocity, 3)
    end
    
    -- Electric sound
    SoundManager.playSound("PowerUp")
end

function KillEffectsController.createConfettiEffect(position)
    -- Confetti celebration effect
    for i = 1, 20 do
        local confetti = Instance.new("Part")
        confetti.Name = "Confetti"
        confetti.Shape = Enum.PartType.Block
        confetti.Size = Vector3.new(0.2, 0.2, 0.2)
        confetti.Position = position + Vector3.new(math.random(-2, 2), 0, math.random(-2, 2))
        confetti.Material = Enum.Material.Plastic
        confetti.BrickColor = BrickColor.random()
        confetti.Anchored = false
        confetti.CanCollide = true
        
        -- Random velocity
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(
            math.random(-10, 10),
            math.random(5, 15),
            math.random(-10, 10)
        )
        bodyVelocity.MaxForce = Vector3.new(1000, 1000, 1000)
        bodyVelocity.Parent = confetti
        
        confetti.Parent = workspace
        game:GetService("Debris"):AddItem(confetti, 4)
        game:GetService("Debris"):AddItem(bodyVelocity, 4)
    end
    
    -- Cheer sound
    SoundManager.playSound("PowerUp")
end

function KillEffectsController.createGhostEffect(position)
    -- Spooky ghost effect
    local ghost = Instance.new("Part")
    ghost.Name = "GhostEffect"
    ghost.Shape = Enum.PartType.Ball
    ghost.Size = Vector3.new(3, 3, 3)
    ghost.Position = position
    ghost.Material = Enum.Material.Neon
    ghost.BrickColor = BrickColor.new("Bright white")
    ghost.Anchored = true
    ghost.CanCollide = false
    ghost.Transparency = 0.3
    
    local ghostParticle = Instance.new("ParticleEmitter")
    ghostParticle.Texture = "rbxassetid://243082608"
    ghostParticle.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.5, 0.5, 1))
    ghostParticle.Size = NumberSequence.new(0.5, 2)
    ghostParticle.Lifetime = NumberRange.new(1, 3)
    ghostParticle.Rate = 30
    ghostParticle.Speed = NumberRange.new(1, 3)
    ghostParticle.Parent = ghost
    
    ghostParticle:Emit(20)
    
    -- Ghostly sound
    SoundManager.playSound("PowerUp")
    
    game:GetService("Debris"):AddItem(ghost, 3)
end

-- Connect to remote event
showKillEffectEvent.OnClientEvent:Connect(function(position, enemyType)
    KillEffectsController.showKillEffect(position, enemyType)
end)

-- Connect to equip function
equipKillEffectEvent.OnServerInvoke = function(player, effectId)
    local EconomyManager = require(game.ServerScriptService:FindFirstChild("EconomyManager"))
    local inventory = EconomyManager.getInventory(player)
    
    if inventory.killEffects[effectId] then
        inventory.equippedKillEffect = effectId
        return true
    end
    return false
end)

return KillEffectsController