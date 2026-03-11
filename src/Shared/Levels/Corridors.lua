--!strict
-- Corridors.lua
-- A level with intersecting corridors.

local Corridors = {}
Corridors.Name = "Corridors"
Corridors.SpawnPoints = {
    Vector3.new(0, 5, 0),
    Vector3.new(0, 5, 40),
    Vector3.new(0, 5, -40),
    Vector3.new(40, 5, 0),
    Vector3.new(-40, 5, 0)
}

function addWallEffects(wall)
    -- Add wall impact effects
    local wallSparks = Instance.new("ParticleEmitter")
    wallSparks.Texture = "rbxassetid://349236983"
    wallSparks.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.8, 0.8, 0.8))
    wallSparks.Size = NumberSequence.new(0.1, 0.3)
    wallSparks.Lifetime = NumberRange.new(0.3, 0.8)
    wallSparks.Rate = 0 -- Activated on impact
    wallSparks.Speed = NumberRange.new(3, 8)
    wallSparks.Parent = wall
    
    -- Add wall collision detection for effects
    wall.Touched:Connect(function(hit)
        if hit:IsA("Part") and (hit.Name == "Projectile" or hit.Name == "EnemyProjectile") then
            wallSparks:Emit(3)
        end
    end)
end

function Corridors.build()
    local map = Instance.new("Model")
    map.Name = "CorridorsMap"
    map.Parent = workspace

    local floor = Instance.new("Part")
    floor.Name = "Floor"
    floor.Size = Vector3.new(100, 1, 100)
    floor.Position = Vector3.new(0, 0, 0)
    floor.Material = Enum.Material.Metal
    floor.BrickColor = BrickColor.new("Dark stone gray")
    floor.Anchored = true
    floor.CanCollide = true
    floor.Parent = map
    
    -- Add metallic floor effects
    local floorSparks = Instance.new("ParticleEmitter")
    floorSparks.Texture = "rbxassetid://349236983"
    floorSparks.Color = ColorSequence.new(Color3.new(0.8, 0.8, 0.8), Color3.new(0.5, 0.5, 0.5))
    floorSparks.Size = NumberSequence.new(0.1, 0.2)
    floorSparks.Lifetime = NumberRange.new(0.5, 1)
    floorSparks.Rate = 2
    floorSparks.Speed = NumberRange.new(2, 5)
    floorSparks.ZOffset = 1
    floorSparks.Parent = floor

    -- Walls
    local wall1 = Instance.new("Part")
    wall1.Name = "Wall"
    wall1.Size = Vector3.new(100, 20, 5)
    wall1.Position = Vector3.new(0, 10, 50)
    wall1.Material = Enum.Material.Metal
    wall1.BrickColor = BrickColor.new("Medium stone gray")
    wall1.Anchored = true
    wall1.CanCollide = true
    wall1.Parent = map
    
    -- Add wall impact effects
    addWallEffects(wall1)
    
    local wall2 = wall1:Clone()
    wall2.Position = Vector3.new(0, 10, -50)
    addWallEffects(wall2)
    wall2.Parent = map
    
    local wall3 = Instance.new("Part")
    wall3.Name = "Wall"
    wall3.Size = Vector3.new(5, 20, 100)
    wall3.Position = Vector3.new(50, 10, 0)
    wall3.Material = Enum.Material.Metal
    wall3.BrickColor = BrickColor.new("Medium stone gray")
    wall3.Anchored = true
    wall3.CanCollide = true
    addWallEffects(wall3)
    wall3.Parent = map
    
    local wall4 = wall3:Clone()
    wall4.Position = Vector3.new(-50, 10, 0)
    addWallEffects(wall4)
    wall4.Parent = map
    
    -- Add corridor lighting
    for x = -40, 40, 20 do
        for z = -40, 40, 20 do
            local light = Instance.new("Part")
            light.Name = "CorridorLight"
            light.Size = Vector3.new(2, 2, 2)
            light.Position = Vector3.new(x, 19, z)
            light.Material = Enum.Material.Neon
            light.BrickColor = BrickColor.new("Bright yellow")
            light.Anchored = true
            light.CanCollide = false
            
            local pointLight = Instance.new("PointLight")
            pointLight.Brightness = 3
            pointLight.Range = 15
            pointLight.Color = Color3.new(1, 1, 0.8)
            pointLight.Parent = light
            
            local glow = Instance.new("ParticleEmitter")
            glow.Texture = "rbxassetid://243082608"
            glow.Color = ColorSequence.new(Color3.new(1, 1, 0))
            glow.Size = NumberSequence.new(0.5, 1)
            glow.Lifetime = NumberRange.new(2, 3)
            glow.Rate = 10
            glow.Speed = NumberRange.new(0.5, 1)
            glow.Parent = light
            
            light.Parent = map
        end
    end

    return map
end

return Corridors
