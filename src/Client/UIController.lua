--!strict
-- UIController.lua
-- Manages the main game UI (health, ammo, etc.).

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local WeaponController = require(script.Parent.WeaponController)

local UIController = {}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local mainGui = nil
local healthBar = nil
local healthBarBg = nil
local weaponLabel = nil
local ammoLabel = nil

local function updateUI()
    -- Update Health
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and healthBar then
            local healthPercent = humanoid.Health / humanoid.MaxHealth
            healthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
        end
    end

    -- Update Weapon and Ammo
    if weaponLabel and ammoLabel then
        local currentWeapon = WeaponController.getCurrentWeapon()
        weaponLabel.Text = string.format("Weapon: %s", currentWeapon.Name)
        ammoLabel.Text = string.format("Ammo: %d / %d", currentWeapon.CurrentAmmo, currentWeapon.Ammo)
    end
end

function UIController.start()
    if mainGui then
        mainGui:Destroy()
    end

    mainGui = Instance.new("ScreenGui")
    mainGui.Name = "MainGameGui"
    mainGui.Parent = playerGui

    -- Health Bar
    healthBarBg = Instance.new("Frame")
    healthBarBg.Name = "HealthBarBg"
    healthBarBg.Size = UDim2.new(0.2, 0, 0.05, 0)
    healthBarBg.Position = UDim2.new(0.05, 0, 0.9, 0)
    healthBarBg.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    healthBarBg.Parent = mainGui
    
    healthBar = Instance.new("Frame")
    healthBar.Name = "HealthBar"
    healthBar.Size = UDim2.new(1, 0, 1, 0)
    healthBar.BackgroundColor3 = Color3.new(1, 0, 0)
    healthBar.Parent = healthBarBg
    
    weaponLabel = Instance.new("TextLabel")
    weaponLabel.Name = "WeaponLabel"
    weaponLabel.Size = UDim2.new(0.2, 0, 0.1, 0)
    weaponLabel.Position = UDim2.new(0.05, 0, 0.75, 0)
    weaponLabel.TextColor3 = Color3.new(1, 1, 1)
    weaponLabel.Font = Enum.Font.SourceSansBold
    weaponLabel.TextSize = 24
    weaponLabel.Parent = mainGui
    
    ammoLabel = Instance.new("TextLabel")
    ammoLabel.Name = "AmmoLabel"
    ammoLabel.Size = UDim2.new(0.2, 0, 0.1, 0)
    ammoLabel.Position = UDim2.new(0.05, 0, 0.65, 0)
    ammoLabel.TextColor3 = Color3.new(1, 1, 1)
    ammoLabel.Font = Enum.Font.SourceSansBold
    ammoLabel.TextSize = 24
    ammoLabel.Parent = mainGui

    RunService.Heartbeat:Connect(updateUI)
end

return UIController
