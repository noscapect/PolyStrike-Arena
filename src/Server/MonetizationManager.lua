--!strict
-- MonetizationManager.lua
-- Manages Game Passes and other monetization features.

local MarketplaceService = game:GetService("MarketplaceService")

local MonetizationManager = {}

-- IMPORTANT: Replace these with your actual Game Pass IDs
local gamePasses = {
    GoldenPistol = 0, -- Replace with your Golden Pistol Game Pass ID
    SpecialKillEffects = 0 -- Replace with your Special Kill Effects Game Pass ID
}

-- Cache for player's owned passes to avoid repeated API calls
local playerPassCache = {}

game:GetService("Players").PlayerAdded:Connect(function(player)
    playerPassCache[player.UserId] = {}
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
    playerPassCache[player.UserId] = nil
end)

function MonetizationManager.ownsGamePass(player, passName)
    local passId = gamePasses[passName]
    if not passId or passId == 0 then
        warn("Game Pass '" .. passName .. "' does not have a valid ID set.")
        return false
    end

    -- Check cache first
    if playerPassCache[player.UserId][passId] ~= nil then
        return playerPassCache[player.UserId][passId]
    end

    -- If not in cache, check with Roblox and cache the result
    local success, ownsPass = pcall(function()
        return MarketplaceService:UserOwnsGamePassAsync(player.UserId, passId)
    end)

    if success then
        playerPassCache[player.UserId][passId] = ownsPass
        return ownsPass
    else
        warn("Failed to check Game Pass ownership for player " .. player.Name)
        return false
    end
end

return MonetizationManager
