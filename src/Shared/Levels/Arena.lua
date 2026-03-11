--!strict
-- Arena.lua
-- A simple arena level with pillars for cover.

local Arena = {}
Arena.Name = "Arena"
Arena.SpawnPoints = {
    Vector3.new(0, 5, 0),
    Vector3.new(40, 5, 40),
    Vector3.new(-40, 5, -40),
    Vector3.new(40, 5, -40),
    Vector3.new(-40, 5, 40)
}

function Arena.build()
    local map = Instance.new("Model")
    map.Name = "ArenaMap"
    map.Parent = workspace

    local floor = Instance.new("Part")
    floor.Name = "Floor"
    floor.Size = Vector3.new(100, 1, 100)
    floor.Position = Vector3.new(0, 0, 0)
    floor.Material = Enum.Material.Concrete
    floor.BrickColor = BrickColor.new("Light gray")
    floor.Anchored = true
    floor.Parent = map

    for i = 1, 4 do
        local pillar = Instance.new("Part")
        pillar.Name = "Pillar"
        pillar.Size = Vector3.new(5, 20, 5)
        pillar.Position = Vector3.new(math.cos(i * math.pi / 2) * 30, 10, math.sin(i * math.pi / 2) * 30)
        pillar.Material = Enum.Material.Concrete
        pillar.BrickColor = BrickColor.new("Gray")
        pillar.Anchored = true
        pillar.Parent = map
    end

    return map
end

return Arena
