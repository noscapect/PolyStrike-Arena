--!strict
-- Warehouse.lua
-- A large industrial space filled with crates for cover.

local Warehouse = {}
Warehouse.Name = "Warehouse"
Warehouse.SpawnPoints = {
    Vector3.new(0, 5, 0),
    Vector3.new(80, 5, 80),
    Vector3.new(-80, 5, -80),
    Vector3.new(80, 5, -80),
    Vector3.new(-80, 5, 80),
    Vector3.new(0, 5, 80),
    Vector3.new(0, 5, -80),
    Vector3.new(80, 5, 0),
    Vector3.new(-80, 5, 0),
    Vector3.new(40, 5, 40),
    Vector3.new(-40, 5, -40),
    Vector3.new(40, 5, -40),
    Vector3.new(-40, 5, 40)
}

function Warehouse.build()
    local map = Instance.new("Model")
    map.Name = "WarehouseMap"
    map.Parent = workspace

    local floor = Instance.new("Part")
    floor.Name = "Floor"
    floor.Size = Vector3.new(200, 1, 200)
    floor.Position = Vector3.new(0, 0, 0)
    floor.Material = Enum.Material.Concrete
    floor.BrickColor = BrickColor.new("Dark stone gray")
    floor.Anchored = true
    floor.CanCollide = true
    floor.Parent = map
    
    -- Add warehouse floor dust effects
    local floorDust = Instance.new("ParticleEmitter")
    floorDust.Texture = "rbxassetid://243082608"
    floorDust.Color = ColorSequence.new(Color3.new(0.3, 0.3, 0.3), Color3.new(0.1, 0.1, 0.1))
    floorDust.Size = NumberSequence.new(0.5, 1.5)
    floorDust.Lifetime = NumberRange.new(2, 4)
    floorDust.Rate = 15
    floorDust.Speed = NumberRange.new(0.2, 0.8)
    floorDust.ZOffset = 1
    floorDust.Parent = floor

    -- Create warehouse walls
    local wallThickness = 3
    local wallHeight = 20
    
    local outerWalls = {
        {size = Vector3.new(200, wallHeight, wallThickness), pos = Vector3.new(0, wallHeight/2, 100)},
        {size = Vector3.new(200, wallHeight, wallThickness), pos = Vector3.new(0, wallHeight/2, -100)},
        {size = Vector3.new(wallThickness, wallHeight, 200), pos = Vector3.new(100, wallHeight/2, 0)},
        {size = Vector3.new(wallThickness, wallHeight, 200), pos = Vector3.new(-100, wallHeight/2, 0)}
    }
    
    for _, wallData in ipairs(outerWalls) do
        local wall = Instance.new("Part")
        wall.Name = "Wall"
        wall.Size = wallData.size
        wall.Position = wallData.pos
        wall.Material = Enum.Material.Metal
        wall.BrickColor = BrickColor.new("Medium stone gray")
        wall.Anchored = true
        wall.Parent = map
    end

    -- Create industrial lighting (ceiling lights)
    for x = -80, 80, 40 do
        for z = -80, 80, 40 do
            local light = Instance.new("Part")
            light.Name = "Light"
            light.Size = Vector3.new(4, 1, 4)
            light.Position = Vector3.new(x, wallHeight - 2, z)
            light.Material = Enum.Material.Neon
            light.BrickColor = BrickColor.new("Bright yellow")
            light.Anchored = true
            light.CanCollide = false
            
            local pointLight = Instance.new("PointLight")
            pointLight.Brightness = 5
            pointLight.Range = 30
            pointLight.Color = Color3.new(1, 1, 0.8)
            pointLight.Parent = light
            
            light.Parent = map
        end
    end
    
    -- Create crates for cover
    local crateSizes = {
        {size = Vector3.new(6, 6, 6), color = BrickColor.new("Brown")},
        {size = Vector3.new(8, 8, 8), color = BrickColor.new("Dark brown")},
        {size = Vector3.new(4, 4, 4), color = BrickColor.new("Really black")}
    }
    
    -- Create crate clusters in different areas
    local crateClusters = {
        -- Center cluster
        {center = Vector3.new(0, 3, 0), radius = 20, count = 15},
        -- Corner clusters
        {center = Vector3.new(60, 3, 60), radius = 15, count = 10},
        {center = Vector3.new(-60, 3, -60), radius = 15, count = 10},
        {center = Vector3.new(60, 3, -60), radius = 15, count = 10},
        {center = Vector3.new(-60, 3, 60), radius = 15, count = 10},
        -- Side clusters
        {center = Vector3.new(0, 3, 60), radius = 12, count = 8},
        {center = Vector3.new(0, 3, -60), radius = 12, count = 8},
        {center = Vector3.new(60, 3, 0), radius = 12, count = 8},
        {center = Vector3.new(-60, 3, 0), radius = 12, count = 8}
    }
    
    for _, cluster in ipairs(crateClusters) do
        for i = 1, cluster.count do
            local crateSize = crateSizes[math.random(1, #crateSizes)]
            local angle = math.random() * 2 * math.pi
            local distance = math.random() * cluster.radius
            local x = cluster.center.X + math.cos(angle) * distance
            local z = cluster.center.Z + math.sin(angle) * distance
            local y = cluster.center.Y + crateSize.size.Y / 2
            
            local crate = Instance.new("Part")
            crate.Name = "Crate"
            crate.Size = crateSize.size
            crate.Position = Vector3.new(x, y, z)
            crate.Material = Enum.Material.Plastic
            crate.BrickColor = crateSize.color
            crate.Anchored = false -- Make crates physics-enabled
            crate.CanCollide = true
            crate.Mass = 50 -- Give crates weight
            
            -- Add some random rotation for variety
            crate.Orientation = Vector3.new(0, math.random(0, 360), 0)
            
            -- Add crate destruction effects
            local crateDebris = Instance.new("ParticleEmitter")
            crateDebris.Texture = "rbxassetid://243082608"
            crateDebris.Color = ColorSequence.new(Color3.new(0.5, 0.3, 0.1), Color3.new(0.2, 0.1, 0.05))
            crateDebris.Size = NumberSequence.new(0.2, 0.6)
            crateDebris.Lifetime = NumberRange.new(1, 2)
            crateDebris.Rate = 0 -- Activated on impact
            crateDebris.Speed = NumberRange.new(5, 15)
            crateDebris.Parent = crate
            
            -- Add crate collision effects
            crate.Touched:Connect(function(hit)
                if hit:IsA("Part") and (hit.Name == "Projectile" or hit.Name == "EnemyProjectile") then
                    crateDebris:Emit(8)
                    -- Apply force to make crates move
                    local bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.Velocity = (crate.Position - hit.Position).Unit * 20
                    bodyVelocity.MaxForce = Vector3.new(1000, 1000, 1000)
                    bodyVelocity.Parent = crate
                    game:GetService("Debris"):AddItem(bodyVelocity, 0.5)
                end
            end)
            
            crate.Parent = map
        end
    end

    return map
end

return Warehouse