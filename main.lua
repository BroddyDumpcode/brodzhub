repeat task.wait() until game:IsLoaded()

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- SCREEN GUI
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "BrodzLoading"
loadingGui.ResetOnSpawn = false
loadingGui.Parent = playerGui

-- BACKGROUND
local bg = Instance.new("Frame", loadingGui)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(15,15,15)

-- TITLE
local title = Instance.new("TextLabel", bg)
title.Size = UDim2.new(1,0,0,60)
title.Position = UDim2.new(0,0,0.4,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.Arcade
title.Text = "BRODZ HUB"
title.TextColor3 = Color3.fromRGB(0,255,180)
title.TextScaled = true

-- LOADING TEXT
local loadingText = Instance.new("TextLabel", bg)
loadingText.Size = UDim2.new(1,0,0,30)
loadingText.Position = UDim2.new(0,0,0.5,0)
loadingText.BackgroundTransparency = 1
loadingText.Font = Enum.Font.Gotham
loadingText.Text = "Loading..."
loadingText.TextColor3 = Color3.fromRGB(200,200,200)
loadingText.TextScaled = true

-- LOADING BAR BG
local barBg = Instance.new("Frame", bg)
barBg.Size = UDim2.new(0.3,0,0,8)
barBg.Position = UDim2.new(0.35,0,0.58,0)
barBg.BackgroundColor3 = Color3.fromRGB(40,40,40)

Instance.new("UICorner", barBg)

-- LOADING BAR
local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(0,255,180)

Instance.new("UICorner", bar)

local TweenService = game:GetService("TweenService")

local function setProgress(percent)
    TweenService:Create(bar,TweenInfo.new(0.3),{
        Size = UDim2.new(percent,0,1,0)
    }):Play()
end


repeat task.wait() until game:IsLoaded()
local repo = "https://raw.githubusercontent.com/BroddyDumpcode/luah/main/"
setProgress(0.2)
local GUI = loadstring(game:HttpGet(repo.."utils/GUI.lua"))()
setProgress(0.4)
local modules = {
    ngapung = loadstring(game:HttpGet(repo.."modules/fly.lua"))(),
    ngabret = loadstring(game:HttpGet(repo.."modules/ngabret.lua"))(),
    esp = loadstring(game:HttpGet(repo.."modules/esp.lua"))(),
    nclip = loadstring(game:HttpGet(repo.."modules/nclip.lua"))(),
    infjmp = loadstring(game:HttpGet(repo.."modules/infjmp.lua"))(),
    pepet = loadstring(game:HttpGet(repo.."utils/tpgui.lua"))()
}
setProgress(0.7)

print("feature has been loaded...")
print("ngabret:", modules.ngabret)
print("setSpeed:", modules.ngabret and modules.ngabret.setSpeed)
setProgress(1)
task.wait(0.5)
loadingGui:Destroy()
GUI:Init(modules)

