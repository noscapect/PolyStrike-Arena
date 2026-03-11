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
    floor.Parent = map

    -- Walls
    local wall1 = Instance.new("Part")
    wall1.Name = "Wall"
    wall1.Size = Vector3.new(100, 20, 5)
    wall1.Position = Vector3.new(0, 10, 50)
    wall1.Anchored = true
    wall1.Parent = map
    
    local wall2 = wall1:Clone()
    wall2.Position = Vector3.new(0, 10, -50)
    wall2.Parent = map
    
    local wall3 = Instance.new("Part")
    wall3.Name = "Wall"
    wall3.Size = Vector3.new(5, 20, 100)
    wall3.Position = Vector3.new(50, 10, 0)
    wall3.Anchored = true
    wall3.Parent = map
    
    local wall4 = wall3:Clone()
    wall4.Position = Vector3.new(-50, 10, 0)
    wall4.Parent = map

    return map
end

return Corridors
