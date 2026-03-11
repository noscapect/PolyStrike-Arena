--!strict
-- EnemyController.lua
-- This script manages the spawning and behavior of enemies.

local EnemyController = {}

local Players = game:GetService("Players")

local EnemyController = {}

local enemyTypes = {
    MeleeZombie = {
        Behavior = "Chase",
        Health = 100,
        WalkSpeed = 14,
        Color = BrickColor.new("Dark green")
    },
    RangedShooter = {
        Behavior = "Ranged",
        Health = 60,
        WalkSpeed = 10,
        Color = BrickColor.new("Bright red")
    },
    Dodger = {
        Behavior = "Dodge",
        Health = 80,
        WalkSpeed = 16,
        Color = BrickColor.new("Bright blue")
    }
}

local function findNearestPlayer(fromPosition)
    local nearestPlayer, minDistance = nil, math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - fromPosition).Magnitude
            if distance < minDistance then
                minDistance = distance
                nearestPlayer = player
            end
        end
    end
    return nearestPlayer
end

local function shootAtPlayer(enemy, player)
    local rootPart = enemy:FindFirstChild("HumanoidRootPart")
    local targetPosition = player.Character.HumanoidRootPart.Position
    local direction = (targetPosition - rootPart.Position).Unit

    local projectile = Instance.new("Part")
    projectile.Name = "EnemyProjectile"
    projectile.Size = Vector3.new(1, 1, 1)
    projectile.Material = Enum.Material.Neon
    projectile.BrickColor = BrickColor.new("Bright red")
    projectile.CanCollide = false
    projectile.CFrame = CFrame.new(rootPart.Position, targetPosition)

    projectile.Touched:Connect(function(otherPart)
        local humanoid = otherPart.Parent:FindFirstChildOfClass("Humanoid")
        if humanoid and otherPart.Parent:IsA("Player") then
            humanoid:TakeDamage(10)
        end
        if otherPart.Parent ~= enemy then
            projectile:Destroy()
        end
    end)
    
    local linearVelocity = Instance.new("LinearVelocity")
    linearVelocity.Attachment0 = Instance.new("Attachment", projectile)
    linearVelocity.MaxForce = math.huge
    linearVelocity.VectorVelocity = direction * 80
    linearVelocity.Parent = projectile

    projectile.Parent = workspace
    game:GetService("Debris"):AddItem(projectile, 5)
end

function EnemyController.startAI(enemy, enemyType)
    local humanoid = enemy:FindFirstChildOfClass("Humanoid")
    local rootPart = enemy:FindFirstChild("HumanoidRootPart")
    if not (humanoid and rootPart) then return end

    coroutine.wrap(function()
        local strafeDirection = 1
        while humanoid.Health > 0 do
            local targetPlayer = findNearestPlayer(rootPart.Position)
            if targetPlayer and targetPlayer.Character then
                local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
                if enemyType.Behavior == "Chase" then
                    humanoid:MoveTo(targetPosition)
                    wait(1)
                elseif enemyType.Behavior == "Ranged" then
                    local distance = (targetPosition - rootPart.Position).Magnitude
                    if distance > 30 then
                        humanoid:MoveTo(targetPosition)
                    else
                        humanoid:MoveTo(rootPart.Position) -- Stop moving
                        shootAtPlayer(enemy, targetPlayer)
                    end
                    wait(2)
                elseif enemyType.Behavior == "Dodge" then
                    local directionToPlayer = (targetPosition - rootPart.Position).Unit
                    local strafe = Vector3.new(directionToPlayer.Z, 0, -directionToPlayer.X) * strafeDirection * 20
                    humanoid.WalkToPoint = targetPosition + strafe
                    
                    if math.random() > 0.95 then
                        strafeDirection = -strafeDirection
                    end
                    
                    wait(0.1)
                end
            else
                wait(1)
            end
        end
    end)()
end

function EnemyController.createEnemy(position, enemyTypeName)
    local enemyType = enemyTypes[enemyTypeName]
    if not enemyType then
        warn("Attempted to create an enemy of an unknown type: " .. enemyTypeName)
        return nil
    end

    local npc = Instance.new("Model")
    npc.Name = "Enemy"

    local humanoid = Instance.new("Humanoid")
    humanoid.Parent = npc
    humanoid.Health = enemyType.Health
    humanoid.WalkSpeed = enemyType.WalkSpeed

    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(2, 2, 2)
    head.BrickColor = enemyType.Color
    head.Parent = npc

    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(4, 4, 2)
    torso.BrickColor = enemyType.Color
    torso.Parent = npc
    
    local humanoidRootPart = Instance.new("Part")
    humanoidRootPart.Name = "HumanoidRootPart"
    humanoidRootPart.Size = Vector3.new(1, 1, 1)
    humanoidRootPart.Transparency = 1
    humanoidRootPart.Parent = npc

    -- Create welds
    local headWeld = Instance.new("Weld")
    headWeld.Part0 = head
    headWeld.Part1 = torso
    headWeld.C0 = CFrame.new(0, 3, 0)
    headWeld.Parent = head

    local rootWeld = Instance.new("Weld")
    rootWeld.Part0 = torso
    rootWeld.Part1 = humanoidRootPart
    rootWeld.Parent = torso

    npc.PrimaryPart = humanoidRootPart
    npc:SetPrimaryPartCFrame(CFrame.new(position))
    npc.Parent = workspace

    EnemyController.startAI(npc, enemyType)

    return npc
end

return EnemyController
