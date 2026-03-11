--!strict
-- Client.lua
-- Main entry point for client-side scripts.

-- For now, it just starts the PlayerController.
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerController = require(script.Parent.PlayerController)
local WeaponController = require(script.Parent.WeaponController)
local VotingController = require(script.Parent.VotingController)
local ScoreboardController = require(script.Parent.ScoreboardController)
local UIController = require(script.Parent.UIController)
local SoundManager = require(script.Parent.SoundManager)
local KillEffectController = require(script.Parent.KillEffectController)
local ShopController = require(script.Parent.ShopController)
local KillEffectsController = require(script.Parent.KillEffectsController)

local showVoteScreenEvent = ReplicatedStorage:WaitForChild("ShowVoteScreenEvent")
local clientSoundEvent = ReplicatedStorage:WaitForChild("ClientSoundEvent")

PlayerController.start()
WeaponController.start()
ScoreboardController.start()
UIController.start()
KillEffectController.start()
ShopController.start()
KillEffectsController.start()

showVoteScreenEvent.OnClientEvent:Connect(function(mapOptions)
    VotingController.showVotingScreen(mapOptions)
end)

clientSoundEvent.OnClientEvent:Connect(function(soundName)
    SoundManager.playSound(soundName)
end)
