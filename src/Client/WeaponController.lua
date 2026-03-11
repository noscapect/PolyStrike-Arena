--!strict
-- WeaponController.lua
-- This script will manage the player's weapon and shooting.

local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundManager = require(script.Parent.SoundManager)
local PlayerController = require(script.Parent.PlayerController)

local WeaponController = {}

local shootEvent = ReplicatedStorage:WaitForChild("ShootEvent")
local checkGamePass = ReplicatedStorage:WaitForChild("CheckGamePass")
local toggleScopeEvent = Instance.new("RemoteEvent", ReplicatedStorage)
toggleScopeEvent.Name = "ToggleScopeEvent"

local weapons = {
    {
        Name = "Pistol",
        FireRate = 0.5,
        NumProjectiles = 1,
        Spread = 0.01,
        ClipSize = 12,
        Ammo = 60,
        ReloadTime = 1.5,
        Damage = 10
    },
    {
        Name = "Shotgun",
        FireRate = 1,
        NumProjectiles = 8,
        Spread = 0.1,
        ClipSize = 8,
        Ammo = 40,
        ReloadTime = 2.5,
        Damage = 25
    },
    {
        Name = "Rocket Launcher",
        FireRate = 2,
        NumProjectiles = 1,
        Spread = 0,
        ClipSize = 1,
        Ammo = 10,
        ReloadTime = 3,
        DamageRadius = 15,
        Damage = 100
    },
    {
        Name = "Assault Rifle",
        FireRate = 0.1,
        NumProjectiles = 1,
        Spread = 0.05,
        ClipSize = 30,
        Ammo = 120,
        ReloadTime = 2,
        Damage = 15
    },
    {
        Name = "Sniper Rifle",
        FireRate = 1.5,
        NumProjectiles = 1,
        Spread = 0,
        ClipSize = 5,
        Ammo = 20,
        ReloadTime = 3,
        Damage = 75
    },
    {
        Name = "Submachine Gun",
        FireRate = 0.05,
        NumProjectiles = 1,
        Spread = 0.08,
        ClipSize = 40,
        Ammo = 160,
        ReloadTime = 1.8,
        Damage = 8
    },
    {
        Name = "Light Machine Gun",
        FireRate = 0.08,
        NumProjectiles = 1,
        Spread = 0.06,
        ClipSize = 100,
        Ammo = 400,
        ReloadTime = 3.5,
        Damage = 12
    },
    {
        Name = "Crossbow",
        FireRate = 1.2,
        NumProjectiles = 1,
        Spread = 0,
        ClipSize = 1,
        Ammo = 20,
        ReloadTime = 2.5,
        Damage = 90,
        Piercing = true
    },
    {
        Name = "Plasma Rifle",
        FireRate = 0.2,
        NumProjectiles = 1,
        Spread = 0.03,
        ClipSize = 25,
        Ammo = 100,
        ReloadTime = 2.2,
        Damage = 18,
        ChargedShot = true,
        ChargeTime = 1.5
    }
}
local currentWeaponIndex = 1
local currentAmmo = weapons[currentWeaponIndex].ClipSize
local isReloading = false
local lastShotTime = 0

local function reload()
    if isReloading or currentAmmo == weapons[currentWeaponIndex].ClipSize then
        return
    end

    isReloading = true
    SoundManager.playSound("Reload")
    wait(weapons[currentWeaponIndex].ReloadTime)
    
    local ammoNeeded = weapons[currentWeaponIndex].ClipSize - currentAmmo
    local ammoToReload = math.min(ammoNeeded, weapons[currentWeaponIndex].Ammo)
    
    currentAmmo += ammoToReload
    weapons[currentWeaponIndex].Ammo -= ammoToReload
    
    isReloading = false
end

local function onInputBegan(input, gameProcessed)
    if gameProcessed then return end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if isReloading then return end
        
        if currentAmmo > 0 then
            local now = tick()
            if now - lastShotTime > weapons[currentWeaponIndex].FireRate then
                lastShotTime = now
                currentAmmo -= 1
                SoundManager.playSound("Shoot")
                local weapon = table.clone(weapons[currentWeaponIndex])
                weapon.Damage = weapon.Damage * PlayerController.getDamageMultiplier()
                shootEvent:FireServer(workspace.CurrentCamera.CFrame, weapon)
            end
        else
            reload()
        end
    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
        if weapons[currentWeaponIndex].Name == "Sniper Rifle" then
            toggleScopeEvent:FireServer(true)
        end
    elseif input.KeyCode == Enum.KeyCode.One then
        currentWeaponIndex = 1
    elseif input.KeyCode == Enum.KeyCode.Two then
        currentWeaponIndex = 2
    elseif input.KeyCode == Enum.KeyCode.Three then
        currentWeaponIndex = 3
    elseif input.KeyCode == Enum.KeyCode.Four then
        currentWeaponIndex = 4
    elseif input.KeyCode == Enum.KeyCode.Five then
        currentWeaponIndex = 5
    elseif input.KeyCode == Enum.KeyCode.Six and #weapons >= 6 then
        currentWeaponIndex = 6
    elseif input.KeyCode == Enum.KeyCode.R then
        reload()
    end
end

local function onInputEnded(input, gameProcessed)
    if gameProcessed then return end

    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        if weapons[currentWeaponIndex].Name == "Sniper Rifle" then
            toggleScopeEvent:FireServer(false)
        end
    end
end

function WeaponController.start()
    if checkGamePass:InvokeServer("GoldenPistol") then
        local goldenPistol = table.clone(weapons[1])
        goldenPistol.Name = "Golden Pistol"
        table.insert(weapons, goldenPistol)
    end
    
    UserInputService.InputBegan:Connect(onInputBegan)
    UserInputService.InputEnded:Connect(onInputEnded)
end

function WeaponController.getCurrentWeapon()
    local weapon = table.clone(weapons[currentWeaponIndex])
    weapon.CurrentAmmo = currentAmmo
    return weapon
end

return WeaponController
