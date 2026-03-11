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
    floor.CanCollide = true
    floor.Parent = map
    
    -- Add floor particle effects
    local floorDust = Instance.new("ParticleEmitter")
    floorDust.Texture = "rbxassetid://243082608"
    floorDust.Color = ColorSequence.new(Color3.new(0.8, 0.8, 0.8))
    floorDust.Size = NumberSequence.new(0.2, 0.5)
    floorDust.Lifetime = NumberRange.new(1, 2)
    floorDust.Rate = 5
    floorDust.Speed = NumberRange.new(1, 3)
    floorDust.ZOffset = 1
    floorDust.Parent = floor

    for i = 1, 4 do
        local pillar = Instance.new("Part")
        pillar.Name = "Pillar"
        pillar.Size = Vector3.new(5, 20, 5)
        pillar.Position = Vector3.new(math.cos(i * math.pi / 2) * 30, 10, math.sin(i * math.pi / 2) * 30)
        pillar.Material = Enum.Material.Concrete
        pillar.BrickColor = BrickColor.new("Gray")
        pillar.Anchored = true
        pillar.CanCollide = true
        pillar.Parent = map
        
        -- Add pillar damage effects
        local pillarSparks = Instance.new("ParticleEmitter")
        pillarSparks.Texture = "rbxassetid://349236983"
        pillarSparks.Color = ColorSequence.new(Color3.new(1, 1, 0), Color3.new(1, 0.5, 0))
        pillarSparks.Size = NumberSequence.new(0.1, 0.3)
        pillarSparks.Lifetime = NumberRange.new(0.5, 1)
        pillarSparks.Rate = 0 -- Activated on impact
        pillarSparks.Speed = NumberRange.new(5, 15)
        pillarSparks.Parent = pillar
        
        -- Add pillar collision detection for effects
        pillar.Touched:Connect(function(hit)
            if hit:IsA("Part") and hit.Name == "Projectile" then
                pillarSparks:Emit(5)
            end
        end)
    end
    
    -- Add ambient lighting
    local ambientLight = Instance.new("PointLight")
    ambientLight.Brightness = 2
    ambientLight.Range = 50
    ambientLight.Color = Color3.new(1, 1, 1)
    ambientLight.Parent = map

    return map
end

return Arena
