--!strict
-- Castle.lua
-- Medieval Castle map with towers, courtyard, and throne room

local Castle = {}

function Castle.create()
    local map = Instance.new("Folder")
    map.Name = "Castle"
    
    -- Create the main floor (stone courtyard)
    local floor = Instance.new("Part")
    floor.Name = "Floor"
    floor.Size = Vector3.new(200, 5, 200)
    floor.Position = Vector3.new(0, 0, 0)
    floor.Anchored = true
    floor.CanCollide = true
    floor.Material = Enum.Material.Brick
    floor.Color = Color3.new(0.3, 0.3, 0.3) -- Stone gray
    floor.Parent = map
    
    -- Add stone texture to floor
    local floorTexture = Instance.new("Texture")
    floorTexture.Texture = "rbxassetid://12345678" -- Stone texture
    floorTexture.Parent = floor
    
    -- Create outer walls (stone walls surrounding the courtyard)
    local wallThickness = 10
    local wallHeight = 30
    
    -- North wall
    local northWall = Instance.new("Part")
    northWall.Name = "NorthWall"
    northWall.Size = Vector3.new(200, wallHeight, wallThickness)
    northWall.Position = Vector3.new(0, wallHeight/2, -100 - wallThickness/2)
    northWall.Anchored = true
    northWall.CanCollide = true
    northWall.Material = Enum.Material.Brick
    northWall.Color = Color3.new(0.4, 0.4, 0.4)
    northWall.Parent = map
    
    -- South wall
    local southWall = Instance.new("Part")
    southWall.Name = "SouthWall"
    southWall.Size = Vector3.new(200, wallHeight, wallThickness)
    southWall.Position = Vector3.new(0, wallHeight/2, 100 + wallThickness/2)
    southWall.Anchored = true
    southWall.CanCollide = true
    southWall.Material = Enum.Material.Brick
    southWall.Color = Color3.new(0.4, 0.4, 0.4)
    southWall.Parent = map
    
    -- East wall
    local eastWall = Instance.new("Part")
    eastWall.Name = "EastWall"
    eastWall.Size = Vector3.new(wallThickness, wallHeight, 200)
    eastWall.Position = Vector3.new(100 + wallThickness/2, wallHeight/2, 0)
    eastWall.Anchored = true
    eastWall.CanCollide = true
    eastWall.Material = Enum.Material.Brick
    eastWall.Color = Color3.new(0.4, 0.4, 0.4)
    eastWall.Parent = map
    
    -- West wall
    local westWall = Instance.new("Part")
    westWall.Name = "WestWall"
    westWall.Size = Vector3.new(wallThickness, wallHeight, 200)
    westWall.Position = Vector3.new(-100 - wallThickness/2, wallHeight/2, 0)
    westWall.Anchored = true
    westWall.CanCollide = true
    westWall.Material = Enum.Material.Brick
    westWall.Color = Color3.new(0.4, 0.4, 0.4)
    westWall.Parent = map
    
    -- Create four corner towers
    local towerSize = 20
    local towerHeight = 40
    
    -- Northwest Tower
    local nwTower = Instance.new("Part")
    nwTower.Name = "NorthwestTower"
    nwTower.Size = Vector3.new(towerSize, towerHeight, towerSize)
    nwTower.Position = Vector3.new(-100 + towerSize/2, towerHeight/2, -100 + towerSize/2)
    nwTower.Anchored = true
    nwTower.CanCollide = true
    nwTower.Material = Enum.Material.Brick
    nwTower.Color = Color3.new(0.35, 0.35, 0.35)
    nwTower.Parent = map
    
    -- Northeast Tower
    local neTower = Instance.new("Part")
    neTower.Name = "NortheastTower"
    neTower.Size = Vector3.new(towerSize, towerHeight, towerSize)
    neTower.Position = Vector3.new(100 - towerSize/2, towerHeight/2, -100 + towerSize/2)
    neTower.Anchored = true
    neTower.CanCollide = true
    neTower.Material = Enum.Material.Brick
    neTower.Color = Color3.new(0.35, 0.35, 0.35)
    neTower.Parent = map
    
    -- Southwest Tower
    local swTower = Instance.new("Part")
    swTower.Name = "SouthwestTower"
    swTower.Size = Vector3.new(towerSize, towerHeight, towerSize)
    swTower.Position = Vector3.new(-100 + towerSize/2, towerHeight/2, 100 - towerSize/2)
    swTower.Anchored = true
    swTower.CanCollide = true
    swTower.Material = Enum.Material.Brick
    swTower.Color = Color3.new(0.35, 0.35, 0.35)
    swTower.Parent = map
    
    -- Southeast Tower
    local seTower = Instance.new("Part")
    seTower.Name = "SoutheastTower"
    seTower.Size = Vector3.new(towerSize, towerHeight, towerSize)
    seTower.Position = Vector3.new(100 - towerSize/2, towerHeight/2, 100 - towerSize/2)
    seTower.Anchored = true
    seTower.CanCollide = true
    seTower.Material = Enum.Material.Brick
    seTower.Color = Color3.new(0.35, 0.35, 0.35)
    seTower.Parent = map
    
    -- Create central keep (castle tower in the middle)
    local keepSize = 40
    local keepHeight = 50
    local keep = Instance.new("Part")
    keep.Name = "Keep"
    keep.Size = Vector3.new(keepSize, keepHeight, keepSize)
    keep.Position = Vector3.new(0, keepHeight/2, 0)
    keep.Anchored = true
    keep.CanCollide = true
    keep.Material = Enum.Material.Brick
    keep.Color = Color3.new(0.3, 0.3, 0.3)
    keep.Parent = map
    
    -- Create throne room (inside the keep)
    local throneRoom = Instance.new("Part")
    throneRoom.Name = "ThroneRoom"
    throneRoom.Size = Vector3.new(25, 20, 25)
    throneRoom.Position = Vector3.new(0, 10, 0)
    throneRoom.Anchored = true
    throneRoom.CanCollide = true
    throneRoom.Material = Enum.Material.Brick
    throneRoom.Color = Color3.new(0.2, 0.2, 0.2)
    throneRoom.Parent = map
    
    -- Create throne (decorative)
    local throne = Instance.new("Part")
    throne.Name = "Throne"
    throne.Size = Vector3.new(6, 8, 8)
    throne.Position = Vector3.new(0, 4, -8)
    throne.Anchored = true
    throne.CanCollide = true
    throne.Material = Enum.Material.Metal
    throne.Color = Color3.new(0.8, 0.6, 0.2) -- Gold color
    throne.Parent = map
    
    -- Create throne backrest
    local throneBack = Instance.new("Part")
    throneBack.Name = "ThroneBack"
    throneBack.Size = Vector3.new(6, 12, 2)
    throneBack.Position = Vector3.new(0, 10, -10)
    throneBack.Anchored = true
    throneBack.CanCollide = true
    throneBack.Material = Enum.Material.Metal
    throneBack.Color = Color3.new(0.8, 0.6, 0.2)
    throneBack.Parent = map
    
    -- Create drawbridge entrance (opening in south wall)
    local drawbridge = Instance.new("Part")
    drawbridge.Name = "Drawbridge"
    drawbridge.Size = Vector3.new(40, 10, 10)
    drawbridge.Position = Vector3.new(0, 5, 100 + wallThickness/2 + 5)
    drawbridge.Anchored = true
    drawbridge.CanCollide = true
    drawbridge.Material = Enum.Material.Wood
    drawbridge.Color = Color3.new(0.6, 0.4, 0.2)
    drawbridge.Parent = map
    
    -- Create moat around the castle (water hazard)
    local moatWidth = 15
    local moatDepth = 10
    local moat = Instance.new("Part")
    moat.Name = "Moat"
    moat.Size = Vector3.new(230, moatDepth, 230)
    moat.Position = Vector3.new(0, -moatDepth/2, 0)
    moat.Anchored = true
    moat.CanCollide = false -- Players can walk over it, but it's visual
    moat.Material = Enum.Material.Ice -- Water-like appearance
    moat.Color = Color3.new(0.2, 0.4, 0.8) -- Water blue
    moat.Transparency = 0.6
    moat.Parent = map
    
    -- Create interior walls dividing the courtyard
    local interiorWall1 = Instance.new("Part")
    interiorWall1.Name = "InteriorWall1"
    interiorWall1.Size = Vector3.new(10, 20, 120)
    interiorWall1.Position = Vector3.new(0, 10, 0)
    interiorWall1.Anchored = true
    interiorWall1.CanCollide = true
    interiorWall1.Material = Enum.Material.Brick
    interiorWall1.Color = Color3.new(0.4, 0.4, 0.4)
    interiorWall1.Parent = map
    
    local interiorWall2 = Instance.new("Part")
    interiorWall2.Name = "InteriorWall2"
    interiorWall2.Size = Vector3.new(120, 20, 10)
    interiorWall2.Position = Vector3.new(0, 10, 0)
    interiorWall2.Anchored = true
    interiorWall2.CanCollide = true
    interiorWall2.Material = Enum.Material.Brick
    interiorWall2.Color = Color3.new(0.4, 0.4, 0.4)
    interiorWall2.Parent = map
    
    -- Create archways in interior walls
    local archway1 = Instance.new("Part")
    archway1.Name = "Archway1"
    archway1.Size = Vector3.new(10, 10, 20)
    archway1.Position = Vector3.new(0, 15, 30)
    archway1.Anchored = true
    archway1.CanCollide = false
    archway1.Transparency = 1
    archway1.Parent = map
    
    local archway2 = Instance.new("Part")
    archway2.Name = "Archway2"
    archway2.Size = Vector3.new(10, 10, 20)
    archway2.Position = Vector3.new(0, 15, -30)
    archway2.Anchored = true
    archway2.CanCollide = false
    archway2.Transparency = 1
    archway2.Parent = map
    
    local archway3 = Instance.new("Part")
    archway3.Name = "Archway3"
    archway3.Size = Vector3.new(20, 10, 10)
    archway3.Position = Vector3.new(30, 15, 0)
    archway3.Anchored = true
    archway3.CanCollide = false
    archway3.Transparency = 1
    archway3.Parent = map
    
    local archway4 = Instance.new("Part")
    archway4.Name = "Archway4"
    archway4.Size = Vector3.new(20, 10, 10)
    archway4.Position = Vector3.new(-30, 15, 0)
    archway4.Anchored = true
    archway4.CanCollide = false
    archway4.Transparency = 1
    archway4.Parent = map
    
    -- Create decorative elements
    -- Banners on walls
    for i = -80, 80, 40 do
        local banner1 = Instance.new("Part")
        banner1.Name = "Banner1_" .. i
        banner1.Size = Vector3.new(4, 8, 0.5)
        banner1.Position = Vector3.new(i, 20, -100 - wallThickness/2 - 0.25)
        banner1.Anchored = true
        banner1.CanCollide = false
        banner1.Material = Enum.Material.Fabric
        banner1.Color = Color3.new(0.8, 0.2, 0.2) -- Red banner
        banner1.Parent = map
        
        local banner2 = Instance.new("Part")
        banner2.Name = "Banner2_" .. i
        banner2.Size = Vector3.new(4, 8, 0.5)
        banner2.Position = Vector3.new(i, 20, 100 + wallThickness/2 + 0.25)
        banner2.Anchored = true
        banner2.CanCollide = false
        banner2.Material = Enum.Material.Fabric
        banner2.Color = Color3.new(0.8, 0.2, 0.2)
        banner2.Parent = map
    end
    
    -- Torches on walls
    for i = -80, 80, 20 do
        local torch1 = Instance.new("Part")
        torch1.Name = "Torch1_" .. i
        torch1.Size = Vector3.new(1, 4, 1)
        torch1.Position = Vector3.new(i, 15, -100 - wallThickness/2 - 0.5)
        torch1.Anchored = true
        torch1.CanCollide = false
        torch1.Material = Enum.Material.Metal
        torch1.Color = Color3.new(0.8, 0.6, 0.2)
        torch1.Parent = map
        
        -- Torch flame
        local flame1 = Instance.new("Part")
        flame1.Name = "Flame1_" .. i
        flame1.Size = Vector3.new(1, 2, 1)
        flame1.Position = Vector3.new(i, 17, -100 - wallThickness/2 - 1)
        flame1.Anchored = true
        flame1.CanCollide = false
        flame1.Material = Enum.Material.Neon
        flame1.Color = Color3.new(1, 0.5, 0)
        flame1.Parent = map
        
        local torch2 = Instance.new("Part")
        torch2.Name = "Torch2_" .. i
        torch2.Size = Vector3.new(1, 4, 1)
        torch2.Position = Vector3.new(i, 15, 100 + wallThickness/2 + 0.5)
        torch2.Anchored = true
        torch2.CanCollide = false
        torch2.Material = Enum.Material.Metal
        torch2.Color = Color3.new(0.8, 0.6, 0.2)
        torch2.Parent = map
        
        local flame2 = Instance.new("Part")
        flame2.Name = "Flame2_" .. i
        flame2.Size = Vector3.new(1, 2, 1)
        flame2.Position = Vector3.new(i, 17, 100 + wallThickness/2 + 1)
        flame2.Anchored = true
        flame2.CanCollide = false
        flame2.Material = Enum.Material.Neon
        flame2.Color = Color3.new(1, 0.5, 0)
        flame2.Parent = map
    end
    
    -- Create spawn points (strategic locations)
    local spawnPoints = {
        Vector3.new(-60, 5, -60),   -- Northwest courtyard
        Vector3.new(60, 5, -60),    -- Northeast courtyard
        Vector3.new(-60, 5, 60),    -- Southwest courtyard
        Vector3.new(60, 5, 60),     -- Southeast courtyard
        Vector3.new(0, 5, -80),     -- North entrance
        Vector3.new(0, 5, 80),      -- South entrance (drawbridge)
        Vector3.new(-80, 5, 0),     -- West entrance
        Vector3.new(80, 5, 0),      -- East entrance
        Vector3.new(0, 5, 0),       -- Center courtyard
        Vector3.new(0, 25, 0),      -- Top of keep
        Vector3.new(-20, 5, -20),   -- Throne room entrance
        Vector3.new(20, 5, 20),     -- Keep courtyard
    }
    
    return {
        Map = map,
        SpawnPoints = spawnPoints
    }
end

return Castle