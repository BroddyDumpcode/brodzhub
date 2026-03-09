local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local cam = workspace.CurrentCamera

local fly = {}
local speed = 40
local flying = false
local bv, bg, flyConnection

-- movement control
local control = {f=0, b=0, l=0, r=0, u=0, d=0}

local function getHRP()
    local char = player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getHumanoid()
    local char = player.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

function fly:setSpeed(v)
    speed = v
end

function fly:Enable()
    local hrp = getHRP()
    if not hrp then return end
    if flying then return end
    flying = true

    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.zero
    bv.Parent = hrp

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.CFrame = hrp.CFrame
    bg.Parent = hrp

    flyConnection = RunService.RenderStepped:Connect(function()
        if not flying then return end
        local hum = getHumanoid()
        local joystick = hum and hum.MoveDirection or Vector3.zero

        -- movement vector
        local move = Vector3.new(
            control.l + control.r + joystick.X,
            control.u + control.d,
            control.f + control.b + joystick.Z
        )

        local camCF = cam.CFrame
        bv.Velocity = 
            camCF.LookVector * move.Z * speed +
            camCF.RightVector * move.X * speed +
            Vector3.new(0, move.Y * speed, 0)
        bg.CFrame = camCF
    end)
end

function fly:Disable()
    flying = false
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
end

local flyDragging = false
local dragging = false

-- slider knob events

return fly


