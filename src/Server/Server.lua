--!strict
-- Server.lua
-- Main entry point for server-side scripts.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- Setup Levels folder
local levelsFolder = Instance.new("Folder")
levelsFolder.Name = "Levels"
levelsFolder.Parent = ReplicatedStorage

-- Setup Sounds folder
local soundsFolder = Instance.new("Folder")
soundsFolder.Name = "Sounds"
soundsFolder.Parent = ReplicatedStorage

-- Move level modules to ReplicatedStorage
ServerScriptService:WaitForChild("Corridors"):Clone().Parent = levelsFolder
ServerScriptService:WaitForChild("Arena"):Clone().Parent = levelsFolder


local shootEvent = ReplicatedStorage:WaitForChild("ShootEvent")
local voteEvent = Instance.new("RemoteEvent", ReplicatedStorage)
voteEvent.Name = "VoteEvent"
local showVoteScreenEvent = Instance.new("RemoteEvent", ReplicatedStorage)
showVoteScreenEvent.Name = "ShowVoteScreenEvent"
local updateScoresEvent = Instance.new("RemoteEvent", ReplicatedStorage)
updateScoresEvent.Name = "UpdateScoresEvent"
local clientSoundEvent = Instance.new("RemoteEvent", ReplicatedStorage)
clientSoundEvent.Name = "ClientSoundEvent"
local checkGamePass = Instance.new("RemoteFunction", ReplicatedStorage)
checkGamePass.Name = "CheckGamePass"
local showKillEffectEvent = Instance.new("RemoteEvent", ReplicatedStorage)
showKillEffectEvent.Name = "ShowKillEffectEvent"

local LevelManager = require(script.Parent.LevelManager)
local GameController = require(script.Parent.GameController)
local ScoreManager = require(script.Parent.ScoreManager)
local MonetizationManager = require(script.Parent.MonetizationManager)

checkGamePass.OnServerInvoke = function(player, passName)
    return MonetizationManager.ownsGamePass(player, passName)
end

LevelManager.loadLevels()

local function onShoot(player, cameraCFrame, weapon)
    for i = 1, weapon.NumProjectiles do
        local projectile = Instance.new("Part")
        projectile.Name = "Projectile"
        projectile.Size = Vector3.new(0.5, 0.5, 2)
        projectile.Material = Enum.Material.Neon
        projectile.BrickColor = BrickColor.new("Bright yellow")
        projectile.CanCollide = false
        
        local spread = Vector3.new(
            math.random() * 2 - 1,
            math.random() * 2 - 1,
            math.random() * 2 - 1
        ) * weapon.Spread
        
        local direction = (cameraCFrame.LookVector + spread).Unit
        projectile.CFrame = CFrame.new(cameraCFrame.Position, cameraCFrame.Position + direction) * CFrame.new(0, 0, -2)
        
        local creatorTag = Instance.new("ObjectValue")
        creatorTag.Name = "creator"
        creatorTag.Value = player
        creatorTag.Parent = projectile
        
        projectile.Parent = workspace

        local linearVelocity = Instance.new("LinearVelocity")
        linearVelocity.Attachment0 = Instance.new("Attachment", projectile)
        linearVelocity.MaxForce = math.huge
        linearVelocity.VectorVelocity = direction * 150
        linearVelocity.Parent = projectile

        projectile.Touched:Connect(function(otherPart)
            if weapon.DamageRadius then
                local explosion = Instance.new("Explosion")
                explosion.Position = projectile.Position
                explosion.BlastRadius = weapon.DamageRadius
                explosion.BlastPressure = 0 -- We'll handle damage manually
                explosion.Parent = workspace
                
                -- Damage enemies in radius
                for _, child in ipairs(workspace:GetChildren()) do
                    if child:IsA("Model") and child.Name == "Enemy" then
                        local humanoid = child:FindFirstChildOfClass("Humanoid")
                        local distance = (child.HumanoidRootPart.Position - projectile.Position).Magnitude
                        if humanoid and distance <= weapon.DamageRadius then
                            humanoid:TakeDamage(weapon.Damage)
                            ScoreManager.addScore(player, 10)
                            clientSoundEvent:FireAllClients("EnemyHit")
                            if humanoid.Health <= 0 and MonetizationManager.ownsGamePass(player, "SpecialKillEffects") then
                                showKillEffectEvent:FireAllClients(child.HumanoidRootPart.Position)
                            end
                        end
                    end
                end
            else
                local humanoid = otherPart.Parent:FindFirstChildOfClass("Humanoid")
                if humanoid and otherPart.Parent:IsA("Model") and otherPart.Parent.Name == "Enemy" then
                    humanoid:TakeDamage(25)
                    ScoreManager.addScore(player, 10)
                    clientSoundEvent:FireAllClients("EnemyHit")
                    if humanoid.Health <= 0 and MonetizationManager.ownsGamePass(player, "SpecialKillEffects") then
                        showKillEffectEvent:FireAllClients(otherPart.Parent.HumanoidRootPart.Position)
                    end
                end
            end
            
            if otherPart.Parent ~= projectile.Parent then
                projectile:Destroy()
            end
        end)

        -- Clean up the projectile after a few seconds
        game:GetService("Debris"):AddItem(projectile, 3)
    end
end

shootEvent.OnServerEvent:Connect(onShoot)

-- Start the game
GameController.start()
