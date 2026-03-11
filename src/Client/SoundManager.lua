--!strict
-- SoundManager.lua
-- Manages playing sounds in the game.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SoundManager = {}

-- It's up to the user to create these sound objects in ReplicatedStorage
local sounds = {
    Shoot = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("Shoot"),
    Reload = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("Reload"),
    EnemyHit = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("EnemyHit")
}

function SoundManager.playSound(soundName)
    local sound = sounds[soundName]
    if sound then
        sound:Play()
    else
        warn("Attempted to play a sound that does not exist: " .. soundName)
    end
end

return SoundManager
