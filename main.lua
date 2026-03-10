local repo = "https://raw.githubusercontent.com/BroddyDumpcode/luah/main/"
local GUI = loadstring(game:HttpGet(repo.."utils/GUI.lua"))()
print(game:HttpGet(repo.."utils/GUI.lua"))
local modules = {
    ngapung = loadstring(game:HttpGet(repo.."modules/fly.lua"))(),
    ngabret = loadstring(game:HttpGet(repo.."modules/ngabret.lua"))(),
    esp = loadstring(game:HttpGet(repo.."modules/esp.lua"))(),
    nclip = loadstring(game:HttpGet(repo.."modules/nclip.lua"))(),
    infjmp = loadstring(game:HttpGet(repo.."modules/infjmp.lua"))(),
    pepet = loadstring(game:HttpGet(repo.."utils/tpgui.lua"))()
}

print("feature has been loaded...")
print("ngabret:", modules.ngabret)
print("setSpeed:", modules.ngabret and modules.ngabret.setSpeed)
--GUI:Init(modules)


