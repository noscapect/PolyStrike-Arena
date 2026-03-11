--!strict
-- WeaponController.lua
-- This script will manage the player's weapon and shooting.

local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundManager = require(script.Parent.SoundManager)

local WeaponController = {}

local shootEvent = ReplicatedStorage:WaitForChild("ShootEvent")
local checkGamePass = ReplicatedStorage:WaitForChild("CheckGamePass")

local weapons = {
    {
        Name = "Pistol",
        FireRate = 0.5,
        NumProjectiles = 1,
        Spread = 0.01,
        ClipSize = 12,
        Ammo = 60,
        ReloadTime = 1.5
    },
    {
        Name = "Shotgun",
        FireRate = 1,
        NumProjectiles = 8,
        Spread = 0.1,
        ClipSize = 8,
        Ammo = 40,
        ReloadTime = 2.5
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
                shootEvent:FireServer(workspace.CurrentCamera.CFrame, weapons[currentWeaponIndex])
            end
        else
            reload()
        end
    elseif input.KeyCode == Enum.KeyCode.One then
        currentWeaponIndex = 1
    elseif input.KeyCode == Enum.KeyCode.Two then
        currentWeaponIndex = 2
    elseif input.KeyCode == Enum.KeyCode.Three then
        currentWeaponIndex = 3
    elseif input.KeyCode == Enum.KeyCode.Four and #weapons >= 4 then
        currentWeaponIndex = 4
    elseif input.KeyCode == Enum.KeyCode.R then
        reload()
    end
end

function WeaponController.start()
    if checkGamePass:InvokeServer("GoldenPistol") then
        local goldenPistol = table.clone(weapons[1])
        goldenPistol.Name = "Golden Pistol"
        table.insert(weapons, goldenPistol)
    end
    
    UserInputService.InputBegan:Connect(onInputBegan)
end

function WeaponController.getCurrentWeapon()
    local weapon = table.clone(weapons[currentWeaponIndex])
    weapon.CurrentAmmo = currentAmmo
    return weapon
end

return WeaponController
