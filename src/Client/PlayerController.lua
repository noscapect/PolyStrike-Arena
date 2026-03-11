--!strict
-- PlayerController.lua
-- This script will manage the first-person perspective and character movement.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local PlayerController = {}

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local function onRenderStep()
    if player and player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
            -- Lock mouse to the center for first-person view
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter

            -- Make the character follow the camera direction
            local cameraDirection = camera.CFrame.LookVector
            local newCF = CFrame.new(player.Character.HumanoidRootPart.Position) * CFrame.Angles(0, math.atan2(cameraDirection.X, cameraDirection.Z) - math.pi, 0)
            player.Character.HumanoidRootPart.CFrame = newCF
        end
    end
end

function PlayerController.start()
    -- Force first-person mode
    player.CameraMode = Enum.CameraMode.LockFirstPerson

    -- Hide the player's character from their own view
    if player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0.5
            end
        end
    end
    
    -- Connect to the render step
    RunService:BindToRenderStep("PlayerController", Enum.RenderPriority.Character.Value, onRenderStep)
end

return PlayerController
