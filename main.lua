repeat task.wait() until game:IsLoaded()
local repo = "https://raw.githubusercontent.com/BroddyDumpcode/luah/main/"
local loader = loadstring(game:HttpGet(repo.."utils/loader.lua"))()
loader:Init()
loader:SetProgress(0.2)
local GUI = loadstring(game:HttpGet(repo.."utils/GUI.lua"))()
loader:SetProgress(0.4)
local modules = {
    ngapung = loadstring(game:HttpGet(repo.."modules/fly.lua"))(),
    ngabret = loadstring(game:HttpGet(repo.."modules/ngabret.lua"))(),
    esp = loadstring(game:HttpGet(repo.."modules/esp.lua"))()
}
loader:SetProgress(0.7)
modules.nclip = loadstring(game:HttpGet(repo.."modules/nclip.lua"))()
modules.infjmp = loadstring(game:HttpGet(repo.."modules/infjmp.lua"))()
modules.pepet = loadstring(game:HttpGet(repo.."utils/tpgui.lua"))()
print("feature has been loaded...")
print("ngabret:", modules.ngabret)
print("setSpeed:", modules.ngabret and modules.ngabret.setSpeed)
loader:SetProgress(1)
task.wait(0.5)
loader:Destroy()
GUI:Init(modules)






