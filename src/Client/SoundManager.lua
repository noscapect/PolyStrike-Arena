--!strict
-- SoundManager.lua
-- Manages playing sounds in the game.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SoundManager = {}

-- It's up to the user to create these sound objects in ReplicatedStorage
local sounds = {
    Shoot = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("Shoot"),
    Reload = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("Reload"),
    EnemyHit = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("EnemyHit"),
    PlayerHit = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("PlayerHit"),
    Explosion = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("Explosion"),
    PowerUp = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("PowerUp"),
    MenuSelect = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("MenuSelect"),
    RoundStart = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("RoundStart"),
    RoundEnd = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("RoundEnd")
}

-- Sound volume settings
local volumeSettings = {
    Shoot = 0.8,
    Reload = 0.6,
    EnemyHit = 0.7,
    PlayerHit = 1.0,
    Explosion = 1.0,
    PowerUp = 0.8,
    MenuSelect = 0.5,
    RoundStart = 0.9,
    RoundEnd = 0.9
}

function SoundManager.playSound(soundName, position)
    local sound = sounds[soundName]
    if sound then
        -- Set volume
        sound.Volume = volumeSettings[soundName] or 1.0
        
        -- If position is provided, create a temporary sound at that location
        if position then
            local tempSound = sound:Clone()
            tempSound.Position = position
            tempSound.Parent = workspace
            tempSound:Play()
            game:GetService("Debris"):AddItem(tempSound, sound.TimeLength + 1)
        else
            sound:Play()
        end
    else
        warn("Attempted to play a sound that does not exist: " .. soundName)
    end
end

function SoundManager.playMusic(musicName)
    local music = sounds[musicName]
    if music then
        music.Looped = true
        music.Volume = 0.5
        music:Play()
    end
end

function SoundManager.stopMusic(musicName)
    local music = sounds[musicName]
    if music then
        music:Stop()
    end
end

return SoundManager
