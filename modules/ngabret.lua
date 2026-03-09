local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
--tools variabel
local currentSpeed = 16
local enabled = false
local ngabret = {}



local function dataHumanoid()
    local char = player.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end
--[[
local function lockSpeed()
    local jelma = dataHumanoid()

    jelma:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if jelma.WalkSpeed ~= currentSpeed then
            jelma.WalkSpeed = currentSpeed
        end
    end)
end
]]
RunService.Heartbeat:Connect(function()

    if not enabled then return end

    local hum = dataHumanoid()

    if hum and hum.WalkSpeed ~= currentSpeed then
        hum.WalkSpeed = currentSpeed
    end
end)
function ngabret.setSpeed(value)
    currentSpeed = value
end
function ngabret.Enable()
    enabled = true
end

return ngabret
