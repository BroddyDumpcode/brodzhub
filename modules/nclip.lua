local Players = game:GetService("Players")
local player = Players.LocalPlayer
--tools variabel
local noclipEnabled = false
local noclipConnection

local nembus = {}

function nembus:Enable(state)
    noclipEnabled = state

    if noclipEnabled then
        noclipConnection = runService.Stepped:Connect(function()
            local char = player.Character
            if not char then return end
            for _, part in pairs(char:GetDescendants())do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
end
return nembus