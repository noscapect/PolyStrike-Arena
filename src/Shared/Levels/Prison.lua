--!strict
-- Prison.lua
-- Maximum security prison map with cells, guard towers, and industrial areas

local Prison = {}

function Prison.create()
    local map = Instance.new("Folder")
    map.Name = "Prison"
    
    -- Create the main floor (concrete prison yard)
    local floor = Instance.new("Part")
    floor.Name = "Floor"
    floor.Size = Vector3.new(250, 5, 250)
    floor.Position = Vector3.new(0, 0, 0)
    floor.Anchored = true
    floor.CanCollide = true
    floor.Material = Enum.Material.Concrete
    floor.Color = Color3.new(0.5, 0.5, 0.5) -- Concrete gray
    floor.Parent = map
    
    -- Create outer prison walls (high security barriers)
    local wallThickness = 15
    local wallHeight = 40
    
    -- North wall with guard tower
    local northWall = Instance.new("Part")
    northWall.Name = "NorthWall"
    northWall.Size = Vector3.new(250, wallHeight, wallThickness)
    northWall.Position = Vector3.new(0, wallHeight/2, -125 - wallThickness/2)
    northWall.Anchored = true
    northWall.CanCollide = true
    northWall.Material = Enum.Material.Concrete
    northWall.Color = Color3.new(0.4, 0.4, 0.4)
    northWall.Parent = map
    
    -- South wall
    local southWall = Instance.new("Part")
    southWall.Name = "SouthWall"
    southWall.Size = Vector3.new(250, wallHeight, wallThickness)
    southWall.Position = Vector3.new(0, wallHeight/2, 125 + wallThickness/2)
    southWall.Anchored = true
    southWall.CanCollide = true
    southWall.Material = Enum.Material.Concrete
    southWall.Color = Color3.new(0.4, 0.4, 0.4)
    southWall.Parent = map
    
    -- East wall
    local eastWall = Instance.new("Part")
    eastWall.Name = "EastWall"
    eastWall.Size = Vector3.new(wallThickness, wallHeight, 250)
    eastWall.Position = Vector3.new(125 + wallThickness/2, wallHeight/2, 0)
    eastWall.Anchored = true
    eastWall.CanCollide = true
    eastWall.Material = Enum.Material.Concrete
    eastWall.Color = Color3.new(0.4, 0.4, 0.4)
    eastWall.Parent = map
    
    -- West wall
    local westWall = Instance.new("Part")
    westWall.Name = "WestWall"
    westWall.Size = Vector3.new(wallThickness, wallHeight, 250)
    westWall.Position = Vector3.new(-125 - wallThickness/2, wallHeight/2, 0)
    westWall.Anchored = true
    westWall.CanCollide = true
    westWall.Material = Enum.Material.Concrete
    westWall.Color = Color3.new(0.4, 0.4, 0.4)
    westWall.Parent = map
    
    -- Create guard towers at corners
    local towerSize = 15
    local towerHeight = 50
    
    -- Northwest Guard Tower
    local nwTower = Instance.new("Part")
    nwTower.Name = "NorthwestTower"
    nwTower.Size = Vector3.new(towerSize, towerHeight, towerSize)
    nwTower.Position = Vector3.new(-125 + towerSize/2, towerHeight/2, -125 + towerSize/2)
    nwTower.Anchored = true
    nwTower.CanCollide = true
    nwTower.Material = Enum.Material.Concrete
    nwTower.Color = Color3.new(0.35, 0.35, 0.35)
    nwTower.Parent = map
    
    -- Northeast Guard Tower
    local neTower = Instance.new("Part")
    neTower.Name = "NortheastTower"
    neTower.Size = Vector3.new(towerSize, towerHeight, towerSize)
    neTower.Position = Vector3.new(125 - towerSize/2, towerHeight/2, -125 + towerSize/2)
    neTower.Anchored = true
    neTower.CanCollide = true
    neTower.Material = Enum.Material.Concrete
    neTower.Color = Color3.new(0.35, 0.35, 0.35)
    neTower.Parent = map
    
    -- Southwest Guard Tower
    local swTower = Instance.new("Part")
    swTower.Name = "SouthwestTower"
    swTower.Size = Vector3.new(towerSize, towerHeight, towerSize)
    swTower.Position = Vector3.new(-125 + towerSize/2, towerHeight/2, 125 - towerSize/2)
    swTower.Anchored = true
    swTower.CanCollide = true
    swTower.Material = Enum.Material.Concrete
    swTower.Color = Color3.new(0.35, 0.35, 0.35)
    swTower.Parent = map
    
    -- Southeast Guard Tower
    local seTower = Instance.new("Part")
    seTower.Name = "SoutheastTower"
    seTower.Size = Vector3.new(towerSize, towerHeight, towerSize)
    seTower.Position = Vector3.new(125 - towerSize/2, towerHeight/2, 125 - towerSize/2)
    seTower.Anchored = true
    seTower.CanCollide = true
    seTower.Material = Enum.Material.Concrete
    seTower.Color = Color3.new(0.35, 0.35, 0.35)
    seTower.Parent = map
    
    -- Create central prison building (administration block)
    local adminBuilding = Instance.new("Part")
    adminBuilding.Name = "AdminBuilding"
    adminBuilding.Size = Vector3.new(80, 30, 80)
    adminBuilding.Position = Vector3.new(0, 15, 0)
    adminBuilding.Anchored = true
    adminBuilding.CanCollide = true
    adminBuilding.Material = Enum.Material.Concrete
    adminBuilding.Color = Color3.new(0.45, 0.45, 0.45)
    adminBuilding.Parent = map
    
    -- Create cell block (long narrow building)
    local cellBlock = Instance.new("Part")
    cellBlock.Name = "CellBlock"
    cellBlock.Size = Vector3.new(40, 25, 150)
    cellBlock.Position = Vector3.new(0, 12.5, -60)
    cellBlock.Anchored = true
    cellBlock.CanCollide = true
    cellBlock.Material = Enum.Material.Concrete
    cellBlock.Color = Color3.new(0.4, 0.4, 0.4)
    cellBlock.Parent = map
    
    -- Create exercise yard area (open space)
    local yardArea = Instance.new("Part")
    yardArea.Name = "YardArea"
    yardArea.Size = Vector3.new(120, 5, 120)
    yardArea.Position = Vector3.new(0, 2.5, 40)
    yardArea.Anchored = true
    yardArea.CanCollide = true
    yardArea.Material = Enum.Material.Concrete
    yardArea.Color = Color3.new(0.55, 0.55, 0.55)
    yardArea.Parent = map
    
    -- Create interior walls and barriers
    -- Cell block interior walls
    local cellWall1 = Instance.new("Part")
    cellWall1.Name = "CellWall1"
    cellWall1.Size = Vector3.new(30, 20, 140)
    cellWall1.Position = Vector3.new(-5, 10, -60)
    cellWall1.Anchored = true
    cellWall1.CanCollide = true
    cellWall1.Material = Enum.Material.Concrete
    cellWall1.Color = Color3.new(0.4, 0.4, 0.4)
    cellWall1.Parent = map
    
    local cellWall2 = Instance.new("Part")
    cellWall2.Name = "CellWall2"
    cellWall2.Size = Vector3.new(30, 20, 140)
    cellWall2.Position = Vector3.new(5, 10, -60)
    cellWall2.Anchored = true
    cellWall2.CanCollide = true
    cellWall2.Material = Enum.Material.Concrete
    cellWall2.Color = Color3.new(0.4, 0.4, 0.4)
    cellWall2.Parent = map
    
    -- Create cell doors (gaps in walls)
    local cellDoor1 = Instance.new("Part")
    cellDoor1.Name = "CellDoor1"
    cellDoor1.Size = Vector3.new(30, 8, 10)
    cellDoor1.Position = Vector3.new(-5, 14, -20)
    cellDoor1.Anchored = true
    cellDoor1.CanCollide = false
    cellDoor1.Transparency = 1
    cellDoor1.Parent = map
    
    local cellDoor2 = Instance.new("Part")
    cellDoor2.Name = "CellDoor2"
    cellDoor2.Size = Vector3.new(30, 8, 10)
    cellDoor2.Position = Vector3.new(5, 14, -20)
    cellDoor2.Anchored = true
    cellDoor2.CanCollide = false
    cellDoor2.Transparency = 1
    cellDoor2.Parent = map
    
    -- Create exercise yard obstacles
    -- Basketball hoop area
    local hoopBase = Instance.new("Part")
    hoopBase.Name = "HoopBase"
    hoopBase.Size = Vector3.new(10, 2, 10)
    hoopBase.Position = Vector3.new(-20, 1, 50)
    hoopBase.Anchored = true
    hoopBase.CanCollide = true
    hoopBase.Material = Enum.Material.Metal
    hoopBase.Color = Color3.new(0.2, 0.2, 0.2)
    hoopBase.Parent = map
    
    local hoopPole = Instance.new("Part")
    hoopPole.Name = "HoopPole"
    hoopPole.Size = Vector3.new(1, 10, 1)
    hoopPole.Position = Vector3.new(-20, 5, 50)
    hoopPole.Anchored = true
    hoopPole.CanCollide = true
    hoopPole.Material = Enum.Material.Metal
    hoopPole.Color = Color3.new(0.2, 0.2, 0.2)
    hoopPole.Parent = map
    
    local hoop = Instance.new("Part")
    hoop.Name = "Hoop"
    hoop.Size = Vector3.new(4, 0.5, 4)
    hoop.Position = Vector3.new(-20, 10, 50)
    hoop.Anchored = true
    hoop.CanCollide = true
    hoop.Material = Enum.Material.Metal
    hoop.Color = Color3.new(0.8, 0.2, 0.2)
    hoop.Parent = map
    
    -- Weight bench area
    local bench = Instance.new("Part")
    bench.Name = "WeightBench"
    bench.Size = Vector3.new(8, 1, 2)
    bench.Position = Vector3.new(20, 1, 45)
    bench.Anchored = true
    bench.CanCollide = true
    bench.Material = Enum.Material.Metal
    bench.Color = Color3.new(0.2, 0.2, 0.2)
    bench.Parent = map
    
    local benchLegs = Instance.new("Part")
    benchLegs.Name = "BenchLegs"
    benchLegs.Size = Vector3.new(8, 1.5, 0.5)
    benchLegs.Position = Vector3.new(20, 0.75, 45)
    benchLegs.Anchored = true
    benchLegs.CanCollide = true
    benchLegs.Material = Enum.Material.Metal
    benchLegs.Color = Color3.new(0.2, 0.2, 0.2)
    benchLegs.Parent = map
    
    -- Create guard posts and barriers
    local guardPost1 = Instance.new("Part")
    guardPost1.Name = "GuardPost1"
    guardPost1.Size = Vector3.new(6, 15, 6)
    guardPost1.Position = Vector3.new(-40, 7.5, 20)
    guardPost1.Anchored = true
    guardPost1.CanCollide = true
    guardPost1.Material = Enum.Material.Metal
    guardPost1.Color = Color3.new(0.2, 0.2, 0.2)
    guardPost1.Parent = map
    
    local guardPost2 = Instance.new("Part")
    guardPost2.Name = "GuardPost2"
    guardPost2.Size = Vector3.new(6, 15, 6)
    guardPost2.Position = Vector3.new(40, 7.5, 20)
    guardPost2.Anchored = true
    guardPost2.CanCollide = true
    guardPost2.Material = Enum.Material.Metal
    guardPost2.Color = Color3.new(0.2, 0.2, 0.2)
    guardPost2.Parent = map
    
    -- Create barbed wire on walls (decorative)
    for i = -110, 110, 20 do
        local wire1 = Instance.new("Part")
        wire1.Name = "Wire1_" .. i
        wire1.Size = Vector3.new(2, 0.5, 2)
        wire1.Position = Vector3.new(i, wallHeight - 2, -125 - wallThickness/2 - 1)
        wire1.Anchored = true
        wire1.CanCollide = false
        wire1.Material = Enum.Material.Metal
        wire1.Color = Color3.new(0.1, 0.1, 0.1)
        wire1.Parent = map
        
        local wire2 = Instance.new("Part")
        wire2.Name = "Wire2_" .. i
        wire2.Size = Vector3.new(2, 0.5, 2)
        wire2.Position = Vector3.new(i, wallHeight - 2, 125 + wallThickness/2 + 1)
        wire2.Anchored = true
        wire2.CanCollide = false
        wire2.Material = Enum.Material.Metal
        wire2.Color = Color3.new(0.1, 0.1, 0.1)
        wire2.Parent = map
        
        local wire3 = Instance.new("Part")
        wire3.Name = "Wire3_" .. i
        wire3.Size = Vector3.new(2, 0.5, 2)
        wire3.Position = Vector3.new(-125 - wallThickness/2 - 1, wallHeight - 2, i)
        wire3.Anchored = true
        wire3.CanCollide = false
        wire3.Material = Enum.Material.Metal
        wire3.Color = Color3.new(0.1, 0.1, 0.1)
        wire3.Parent = map
        
        local wire4 = Instance.new("Part")
        wire4.Name = "Wire4_" .. i
        wire4.Size = Vector3.new(2, 0.5, 2)
        wire4.Position = Vector3.new(125 + wallThickness/2 + 1, wallHeight - 2, i)
        wire4.Anchored = true
        wire4.CanCollide = false
        wire4.Material = Enum.Material.Metal
        wire4.Color = Color3.new(0.1, 0.1, 0.1)
        wire4.Parent = map
    end
    
    -- Create searchlights on guard towers
    for _, tower in pairs({nwTower, neTower, swTower, seTower}) do
        local searchlight = Instance.new("Part")
        searchlight.Name = "Searchlight_" .. tower.Name
        searchlight.Size = Vector3.new(3, 3, 3)
        searchlight.Position = tower.Position + Vector3.new(0, towerSize/2 + 2, 0)
        searchlight.Anchored = true
        searchlight.CanCollide = false
        searchlight.Material = Enum.Material.Glass
        searchlight.Color = Color3.new(1, 1, 0.8)
        searchlight.Parent = map
        
        -- Searchlight beam
        local beam = Instance.new("Part")
        beam.Name = "Beam_" .. tower.Name
        beam.Size = Vector3.new(2, 50, 2)
        beam.Position = tower.Position + Vector3.new(0, towerSize/2 + 25, 0)
        beam.Anchored = true
        beam.CanCollide = false
        beam.Material = Enum.Material.Neon
        beam.Color = Color3.new(1, 1, 0.5)
        beam.Transparency = 0.5
        beam.Parent = map
    end
    
    -- Create security cameras
    for i = -80, 80, 40 do
        local camera1 = Instance.new("Part")
        camera1.Name = "Camera1_" .. i
        camera1.Size = Vector3.new(2, 2, 2)
        camera1.Position = Vector3.new(i, 25, -125 - wallThickness/2 - 1)
        camera1.Anchored = true
        camera1.CanCollide = false
        camera1.Material = Enum.Material.Metal
        camera1.Color = Color3.new(0.2, 0.2, 0.2)
        camera1.Parent = map
        
        local camera2 = Instance.new("Part")
        camera2.Name = "Camera2_" .. i
        camera2.Size = Vector3.new(2, 2, 2)
        camera2.Position = Vector3.new(i, 25, 125 + wallThickness/2 + 1)
        camera2.Anchored = true
        camera2.CanCollide = false
        camera2.Material = Enum.Material.Metal
        camera2.Color = Color3.new(0.2, 0.2, 0.2)
        camera2.Parent = map
    end
    
    -- Create emergency lighting
    local emergencyLight1 = Instance.new("Part")
    emergencyLight1.Name = "EmergencyLight1"
    emergencyLight1.Size = Vector3.new(4, 2, 4)
    emergencyLight1.Position = Vector3.new(0, 25, 0)
    emergencyLight1.Anchored = true
    emergencyLight1.CanCollide = false
    emergencyLight1.Material = Enum.Material.Neon
    emergencyLight1.Color = Color3.new(1, 0, 0) -- Red emergency light
    emergencyLight1.Parent = map
    
    -- Create spawn points (strategic locations)
    local spawnPoints = {
        Vector3.new(-80, 5, -80),    -- Northwest corner
        Vector3.new(80, 5, -80),     -- Northeast corner
        Vector3.new(-80, 5, 80),     -- Southwest corner
        Vector3.new(80, 5, 80),      -- Southeast corner
        Vector3.new(0, 5, -100),     -- North entrance
        Vector3.new(0, 5, 100),      -- South entrance
        Vector3.new(-100, 5, 0),     -- West entrance
        Vector3.new(100, 5, 0),      -- East entrance
        Vector3.new(0, 5, 0),        -- Center yard
        Vector3.new(-40, 5, 40),     -- Guard post area
        Vector3.new(40, 5, 40),      -- Guard post area
        Vector3.new(0, 15, -60),     -- Cell block entrance
        Vector3.new(-20, 1, 50),     -- Basketball area
        Vector3.new(20, 1, 45),      -- Weight bench area
        Vector3.new(0, 25, 0),       -- Admin building roof
    }
    
    return {
        Map = map,
        SpawnPoints = spawnPoints
    }
end

return Prison