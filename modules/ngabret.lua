local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local currentSpeed = 16
local enabled = false
local speedConnection

local ngabret = {}

local function getHumanoid()
    local char = player.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function lockSpeed(hum)
    if speedConnection then
        speedConnection:Disconnect()
    end

    speedConnection = hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if enabled and hum.WalkSpeed ~= currentSpeed then
            hum.WalkSpeed = currentSpeed
        end
    end)
end

function ngabret:Enable()
    enabled = true

    local hum = getHumanoid()
    if hum then
        hum.WalkSpeed = currentSpeed
        lockSpeed(hum)
    end
end

function ngabret:Disable()
    enabled = false

    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
end

function ngabret:setSpeed(value)
    currentSpeed = value

    local hum = getHumanoid()
    if hum then
        hum.WalkSpeed = currentSpeed
    end
end

return ngabret
