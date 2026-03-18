local Fly = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local flying = false
local speed = 50
local connection

local bg, bv

-- set speed dari slider
function Fly:setSpeed(val)
    speed = val
end

local function setupBody(char)
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    if not root then return end

    bg = Instance.new("BodyGyro")
    bg.P = 9e4
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.CFrame = root.CFrame
    bg.Parent = root

    bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(0,0,0)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Parent = root

    return root
end

function Fly:Enable()
    if flying then return end
    flying = true

    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")

    hum.PlatformStand = true

    local root = setupBody(char)
    if not root then return end

    connection = RunService.RenderStepped:Connect(function()
        if not flying then return end
        if not char or not char.Parent then return end

        local cam = workspace.CurrentCamera
        local moveDir = hum.MoveDirection

        if moveDir.Magnitude > 0 then
            bv.Velocity = (cam.CFrame.LookVector * moveDir.Z + cam.CFrame.RightVector * moveDir.X) * speed
        else
            bv.Velocity = Vector3.new(0,0,0)
        end

        bg.CFrame = cam.CFrame
    end)
end

function Fly:Disable()
    flying = false

    if connection then
        connection:Disconnect()
        connection = nil
    end

    local char = player.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.PlatformStand = false
        end
    end

    if bg then bg:Destroy() bg = nil end
    if bv then bv:Destroy() bv = nil end
end

return Fly
