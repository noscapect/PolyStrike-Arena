--!strict
-- EnemyController.lua
-- This script manages the spawning and behavior of enemies.

local EnemyController = {}

local Players = game:GetService("Players")
local EconomyManager = require(script.Parent.EconomyManager)

local enemyTypes = {
    MeleeZombie = {
        Behavior = "Chase",
        Health = 100,
        WalkSpeed = 14,
        Color = BrickColor.new("Dark green"),
        Description = "Basic melee enemy that charges at players"
    },
    RangedShooter = {
        Behavior = "Ranged",
        Health = 60,
        WalkSpeed = 10,
        Color = BrickColor.new("Bright red"),
        Description = "Keeps distance and fires projectiles"
    },
    Dodger = {
        Behavior = "Dodge",
        Health = 80,
        WalkSpeed = 16,
        Color = BrickColor.new("Bright blue"),
        Description = "Fast enemy that strafes to avoid shots"
    },
    Tank = {
        Behavior = "Tank",
        Health = 200,
        WalkSpeed = 8,
        Color = BrickColor.new("Dark gray"),
        Description = "Heavy enemy with high health, slow but dangerous"
    },
    Kamikaze = {
        Behavior = "Suicide",
        Health = 50,
        WalkSpeed = 20,
        Color = BrickColor.new("Bright orange"),
        Description = "Explodes on contact with players"
    },
    Healer = {
        Behavior = "Support",
        Health = 70,
        WalkSpeed = 12,
        Color = BrickColor.new("Bright purple"),
        Description = "Heals nearby enemies, priority target"
    },
    Sniper = {
        Behavior = "Sniper",
        Health = 85,
        WalkSpeed = 11,
        Color = BrickColor.new("Bright cyan"),
        Description = "Long-range enemy that deals high damage"
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
        local lastHealTime = 0
        local lastSniperShot = 0
        
        while humanoid.Health > 0 do
            local targetPlayer = findNearestPlayer(rootPart.Position)
            if targetPlayer and targetPlayer.Character then
                local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
                local distance = (targetPosition - rootPart.Position).Magnitude
                
                if enemyType.Behavior == "Chase" then
                    humanoid:MoveTo(targetPosition)
                    wait(1)
                elseif enemyType.Behavior == "Ranged" then
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
                elseif enemyType.Behavior == "Tank" then
                    -- Tank moves slowly but charges when close
                    if distance < 15 then
                        humanoid.WalkSpeed = 16 -- Charge speed
                        humanoid:MoveTo(targetPosition)
                    else
                        humanoid.WalkSpeed = 8 -- Normal speed
                        humanoid:MoveTo(targetPosition)
                    end
                    wait(0.5)
                elseif enemyType.Behavior == "Suicide" then
                    -- Kamikaze rushes at high speed
                    humanoid:MoveTo(targetPosition)
                    if distance < 5 then
                        -- Explode
                        local explosion = Instance.new("Explosion")
                        explosion.Position = rootPart.Position
                        explosion.BlastRadius = 10
                        explosion.BlastPressure = 50
                        explosion.Parent = workspace
                        
                        -- Damage nearby players
                        for _, player in ipairs(Players:GetPlayers()) do
                            if player.Character then
                                local playerRoot = player.Character:FindFirstChild("HumanoidRootPart")
                                if playerRoot then
                                    local playerDistance = (playerRoot.Position - rootPart.Position).Magnitude
                                    if playerDistance <= 10 then
                                        local playerHumanoid = player.Character:FindFirstChildOfClass("Humanoid")
                                        if playerHumanoid then
                                            playerHumanoid:TakeDamage(50)
                                        end
                                    end
                                end
                            end
                        end
                        enemy:Destroy()
                        return
                    end
                    wait(0.1)
                elseif enemyType.Behavior == "Support" then
                    -- Healer looks for nearby enemies to heal
                    local now = tick()
                    if now - lastHealTime > 3 then
                        lastHealTime = now
                        -- Heal nearby enemies
                        for _, otherEnemy in ipairs(workspace:GetChildren()) do
                            if otherEnemy.Name == "Enemy" and otherEnemy ~= enemy then
                                local otherRoot = otherEnemy:FindFirstChild("HumanoidRootPart")
                                if otherRoot then
                                    local enemyDistance = (otherRoot.Position - rootPart.Position).Magnitude
                                    if enemyDistance <= 20 then
                                        local otherHumanoid = otherEnemy:FindFirstChildOfClass("Humanoid")
                                        if otherHumanoid and otherHumanoid.Health < otherHumanoid.MaxHealth then
                                            otherHumanoid.Health = math.min(otherHumanoid.Health + 10, otherHumanoid.MaxHealth)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    -- Also moves towards players
                    humanoid:MoveTo(targetPosition)
                    wait(1)
                elseif enemyType.Behavior == "Sniper" then
                    -- Sniper keeps distance and takes precise shots
                    local now = tick()
                    if distance > 50 then
                        humanoid:MoveTo(targetPosition)
                    elseif distance < 30 then
                        -- Back away
                        local retreatPos = rootPart.Position + (rootPart.Position - targetPosition).Unit * 10
                        humanoid:MoveTo(retreatPos)
                    else
                        -- Snipe
                        if now - lastSniperShot > 1.5 then
                            lastSniperShot = now
                            shootAtPlayer(enemy, targetPlayer)
                        end
                    end
                    wait(0.5)
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
    
    -- Connect to death event for kill rewards
    humanoid.Died:Connect(function()
        -- Find who killed this enemy
        local creatorValue = npc:FindFirstChild("creator")
        if creatorValue and creatorValue.Value then
            local killer = creatorValue.Value
            if killer and killer:IsA("Player") then
                -- Award bonus money for kill (varies by enemy type)
                local killReward = 0
                if enemyTypeName == "MeleeZombie" then
                    killReward = 20
                elseif enemyTypeName == "RangedShooter" then
                    killReward = 25
                elseif enemyTypeName == "Dodger" then
                    killReward = 30
                elseif enemyTypeName == "Tank" then
                    killReward = 50
                elseif enemyTypeName == "Kamikaze" then
                    killReward = 35
                elseif enemyTypeName == "Healer" then
                    killReward = 40
                elseif enemyTypeName == "Sniper" then
                    killReward = 45
                end
                
                EconomyManager.addMoney(killer, killReward)
                
                -- Trigger special kill effect for the killer
                local showKillEffectEvent = game:GetService("ReplicatedStorage"):FindFirstChild("ShowKillEffectEvent")
                if showKillEffectEvent then
                    showKillEffectEvent:FireClient(killer, rootPart.Position, enemyType.Behavior)
                end
            end
        end
    end)

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
