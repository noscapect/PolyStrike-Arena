--!strict
-- TheMaze.lua
-- A grid-based maze level with tight corners and close-quarters combat.

local TheMaze = {}
TheMaze.Name = "The Maze"
TheMaze.SpawnPoints = {
    Vector3.new(0, 5, 0),
    Vector3.new(60, 5, 60),
    Vector3.new(-60, 5, -60),
    Vector3.new(60, 5, -60),
    Vector3.new(-60, 5, 60),
    Vector3.new(0, 5, 60),
    Vector3.new(0, 5, -60),
    Vector3.new(60, 5, 0),
    Vector3.new(-60, 5, 0)
}

function addWallEffects(wall)
    -- Add wall impact effects
    local wallSparks = Instance.new("ParticleEmitter")
    wallSparks.Texture = "rbxassetid://349236983"
    wallSparks.Color = ColorSequence.new(Color3.new(0.8, 0.6, 0.4), Color3.new(0.4, 0.3, 0.2))
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

function TheMaze.build()
    local map = Instance.new("Model")
    map.Name = "TheMazeMap"
    map.Parent = workspace

    local floor = Instance.new("Part")
    floor.Name = "Floor"
    floor.Size = Vector3.new(120, 1, 120)
    floor.Position = Vector3.new(0, 0, 0)
    floor.Material = Enum.Material.Concrete
    floor.BrickColor = BrickColor.new("Dark stone gray")
    floor.Anchored = true
    floor.CanCollide = true
    floor.Parent = map
    
    -- Add mysterious floor fog
    local floorFog = Instance.new("ParticleEmitter")
    floorFog.Texture = "rbxassetid://243082608"
    floorFog.Color = ColorSequence.new(Color3.new(0.2, 0.2, 0.3), Color3.new(0.1, 0.1, 0.2))
    floorFog.Size = NumberSequence.new(2, 5)
    floorFog.Lifetime = NumberRange.new(3, 6)
    floorFog.Rate = 20
    floorFog.Speed = NumberRange.new(0.1, 0.5)
    floorFog.ZOffset = 1
    floorFog.Parent = floor

    -- Create maze walls
    local wallThickness = 2
    local wallHeight = 10
    
    -- Outer walls
    local outerWalls = {
        {size = Vector3.new(120, wallHeight, wallThickness), pos = Vector3.new(0, wallHeight/2, 60)},
        {size = Vector3.new(120, wallHeight, wallThickness), pos = Vector3.new(0, wallHeight/2, -60)},
        {size = Vector3.new(wallThickness, wallHeight, 120), pos = Vector3.new(60, wallHeight/2, 0)},
        {size = Vector3.new(wallThickness, wallHeight, 120), pos = Vector3.new(-60, wallHeight/2, 0)}
    }
    
    for _, wallData in ipairs(outerWalls) do
        local wall = Instance.new("Part")
        wall.Name = "Wall"
        wall.Size = wallData.size
        wall.Position = wallData.pos
        wall.Material = Enum.Material.Brick
        wall.BrickColor = BrickColor.new("Stone Gray")
        wall.Anchored = true
        wall.CanCollide = true
        wall.Parent = map
        
        -- Add wall impact effects
        addWallEffects(wall)
    end
    
    -- Inner maze walls (creating a grid pattern with some paths blocked)
    local mazeWalls = {
        -- Vertical walls
        {size = Vector3.new(wallThickness, wallHeight, 40), pos = Vector3.new(-40, wallHeight/2, -40)},
        {size = Vector3.new(wallThickness, wallHeight, 40), pos = Vector3.new(-40, wallHeight/2, 40)},
        {size = Vector3.new(wallThickness, wallHeight, 40), pos = Vector3.new(0, wallHeight/2, -40)},
        {size = Vector3.new(wallThickness, wallHeight, 40), pos = Vector3.new(0, wallHeight/2, 40)},
        {size = Vector3.new(wallThickness, wallHeight, 40), pos = Vector3.new(40, wallHeight/2, -40)},
        {size = Vector3.new(wallThickness, wallHeight, 40), pos = Vector3.new(40, wallHeight/2, 40)},
        
        -- Horizontal walls
        {size = Vector3.new(40, wallHeight, wallThickness), pos = Vector3.new(-40, wallHeight/2, -20)},
        {size = Vector3.new(40, wallHeight, wallThickness), pos = Vector3.new(-40, wallHeight/2, 20)},
        {size = Vector3.new(40, wallHeight, wallThickness), pos = Vector3.new(0, wallHeight/2, -20)},
        {size = Vector3.new(40, wallHeight, wallThickness), pos = Vector3.new(0, wallHeight/2, 20)},
        {size = Vector3.new(40, wallHeight, wallThickness), pos = Vector3.new(40, wallHeight/2, -20)},
        {size = Vector3.new(40, wallHeight, wallThickness), pos = Vector3.new(40, wallHeight/2, 20)},
        
        -- Additional blocking walls to create maze paths
        {size = Vector3.new(20, wallHeight, wallThickness), pos = Vector3.new(-50, wallHeight/2, 0)},
        {size = Vector3.new(20, wallHeight, wallThickness), pos = Vector3.new(50, wallHeight/2, 0)},
        {size = Vector3.new(wallThickness, wallHeight, 20), pos = Vector3.new(20, wallHeight/2, -50)},
        {size = Vector3.new(wallThickness, wallHeight, 20), pos = Vector3.new(20, wallHeight/2, 50)},
    }
    
    for _, wallData in ipairs(mazeWalls) do
        local wall = Instance.new("Part")
        wall.Name = "Wall"
        wall.Size = wallData.size
        wall.Position = wallData.pos
        wall.Material = Enum.Material.Brick
        wall.BrickColor = BrickColor.new("Stone Gray")
        wall.Anchored = true
        wall.CanCollide = true
        wall.Parent = map
        
        -- Add wall impact effects
        addWallEffects(wall)
    end

    return map
end

return TheMaze