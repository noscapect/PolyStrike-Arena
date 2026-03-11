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
            
            -- Change health bar color based on health level
            if healthPercent < 0.3 then
                healthBar.BackgroundColor3 = Color3.new(1, 0, 0) -- Red for low health
            elseif healthPercent < 0.6 then
                healthBar.BackgroundColor3 = Color3.new(1, 1, 0) -- Yellow for medium health
            else
                healthBar.BackgroundColor3 = Color3.new(0, 1, 0) -- Green for high health
            end
        end
    end

    -- Update Weapon and Ammo
    if weaponLabel and ammoLabel then
        local currentWeapon = WeaponController.getCurrentWeapon()
        weaponLabel.Text = string.format("Weapon: %s", currentWeapon.Name)
        ammoLabel.Text = string.format("Ammo: %d / %d", currentWeapon.CurrentAmmo, currentWeapon.Ammo)
        
        -- Change ammo color if low
        if currentWeapon.CurrentAmmo == 0 then
            ammoLabel.TextColor3 = Color3.new(1, 0, 0)
        elseif currentWeapon.CurrentAmmo < math.ceil(currentWeapon.ClipSize * 0.3) then
            ammoLabel.TextColor3 = Color3.new(1, 1, 0)
        else
            ammoLabel.TextColor3 = Color3.new(1, 1, 1)
        end
    end
end

function UIController.start()
    if mainGui then
        mainGui:Destroy()
    end

    mainGui = Instance.new("ScreenGui")
    mainGui.Name = "MainGameGui"
    mainGui.Parent = playerGui

    -- Crosshair
    local crosshair = Instance.new("Frame")
    crosshair.Name = "Crosshair"
    crosshair.Size = UDim2.new(0, 20, 0, 20)
    crosshair.Position = UDim2.new(0.5, -10, 0.5, -10)
    crosshair.BackgroundColor3 = Color3.new(1, 1, 1)
    crosshair.BackgroundTransparency = 1
    crosshair.Parent = mainGui
    
    -- Crosshair lines
    local leftLine = Instance.new("Frame")
    leftLine.Size = UDim2.new(0, 2, 0, 10)
    leftLine.Position = UDim2.new(0, -2, 0, 5)
    leftLine.BackgroundColor3 = Color3.new(0, 1, 0)
    leftLine.Parent = crosshair
    
    local rightLine = Instance.new("Frame")
    rightLine.Size = UDim2.new(0, 2, 0, 10)
    rightLine.Position = UDim2.new(1, 0, 0, 5)
    rightLine.BackgroundColor3 = Color3.new(0, 1, 0)
    rightLine.Parent = crosshair
    
    local topLine = Instance.new("Frame")
    topLine.Size = UDim2.new(0, 10, 0, 2)
    topLine.Position = UDim2.new(0, 5, 0, -2)
    topLine.BackgroundColor3 = Color3.new(0, 1, 0)
    topLine.Parent = crosshair
    
    local bottomLine = Instance.new("Frame")
    bottomLine.Size = UDim2.new(0, 10, 0, 2)
    bottomLine.Position = UDim2.new(0, 5, 1, 0)
    bottomLine.BackgroundColor3 = Color3.new(0, 1, 0)
    bottomLine.Parent = crosshair

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

    -- Update crosshair based on weapon
    local function updateCrosshair()
        local currentWeapon = WeaponController.getCurrentWeapon()
        local spread = currentWeapon.Spread or 0.05
        
        -- Scale crosshair based on weapon spread
        local scale = 1 + (spread * 100)
        crosshair.Size = UDim2.new(0, 20 * scale, 0, 20 * scale)
        crosshair.Position = UDim2.new(0.5, -(10 * scale), 0.5, -(10 * scale))
        
        -- Change color for different weapons
        if currentWeapon.Name == "Sniper Rifle" then
            leftLine.BackgroundColor3 = Color3.new(1, 0, 0)
            rightLine.BackgroundColor3 = Color3.new(1, 0, 0)
            topLine.BackgroundColor3 = Color3.new(1, 0, 0)
            bottomLine.BackgroundColor3 = Color3.new(1, 0, 0)
        elseif currentWeapon.Name == "Rocket Launcher" then
            leftLine.BackgroundColor3 = Color3.new(1, 0.5, 0)
            rightLine.BackgroundColor3 = Color3.new(1, 0.5, 0)
            topLine.BackgroundColor3 = Color3.new(1, 0.5, 0)
            bottomLine.BackgroundColor3 = Color3.new(1, 0.5, 0)
        else
            leftLine.BackgroundColor3 = Color3.new(0, 1, 0)
            rightLine.BackgroundColor3 = Color3.new(0, 1, 0)
            topLine.BackgroundColor3 = Color3.new(0, 1, 0)
            bottomLine.BackgroundColor3 = Color3.new(0, 1, 0)
        end
    end

    RunService.Heartbeat:Connect(function()
        updateUI()
        updateCrosshair()
    end)
end

return UIController
