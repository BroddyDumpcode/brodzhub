local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Loading = {}
local sound
local gui
local bar
function Loading:Init()
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    gui = Instance.new("ScreenGui")
    gui.Name = "BrodzLoading"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui
    local panel = Instance.new("Frame", gui)
    panel.Size = UDim2.new(0,300,0,150)
    panel.Position = UDim2.new(0.5,-150,0.5,-75)
    panel.BackgroundColor3 = Color3.fromRGB(25,25,25)
    local corner = Instance.new("UICorner", panel)
    corner.CornerRadius = UDim.new(0,15)
    local stroke = Instance.new("UIStroke", panel)
    stroke.Color = Color3.fromRGB(0,255,180)
    stroke.Transparency = 0.4
    local title = Instance.new("TextLabel", panel)
    title.Size = UDim2.new(1,0,0,40)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.Arcade
    title.Text = "BRODZ HUB"
    title.TextColor3 = Color3.fromRGB(0,255,180)
    title.TextScaled = true
    local loadingText = Instance.new("TextLabel", panel)
    loadingText.Size = UDim2.new(1,0,0,30)
    loadingText.Position = UDim2.new(0,0,0,45)
    loadingText.BackgroundTransparency = 1
    loadingText.Font = Enum.Font.Gotham
    loadingText.Text = "Loading..."
    loadingText.TextColor3 = Color3.fromRGB(200,200,200)
    loadingText.TextScaled = true
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://135545038339685"
    sound.Volume = 2
    sound.Parent = gui
    local barBg = Instance.new("Frame", panel)
    barBg.Size = UDim2.new(0.8,0,0,8)
    barBg.Position = UDim2.new(0.1,0,0.75,0)
    barBg.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", barBg)
    bar = Instance.new("Frame", barBg)
    bar.Size = UDim2.new(0,0,1,0)
    bar.BackgroundColor3 = Color3.fromRGB(0,255,180)
    Instance.new("UICorner", bar)
    sound:Play()

end

function Loading:SetProgress(percent)
    if not bar then return end
    TweenService:Create(bar,TweenInfo.new(0.25),{
        Size = UDim2.new(percent,0,1,0)
    }):Play()

end
function Loading:Destroy()
    if sound then
        sound:Stop()
    end
    if gui then
        gui:Destroy()
    end

end

return Loading



