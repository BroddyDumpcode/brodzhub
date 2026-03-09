local ESP = {}
--service
local Players = game:GetService("Players")
local player = Players.LocalPlayer
--tools variabel
local espEnabled = false
local cacheEsp = {}
local playerAddedConnection


local function clearEsp()
    for _,objs in pairs(cacheEsp) do
        for _,v in pairs(objs) do
            if v then
                v:Destroy()
            end
        end
    end
    cacheEsp = {}
end


local function applyEspToCharacter(plr, char)

    if plr == player then return end

    if cacheEsp[plr] then
        for _,v in pairs(cacheEsp[plr]) do
            v:Destroy()
        end
    end

    local highlight = Instance.new("Highlight")
    highlight.Adornee = char
    highlight.FillTransparency = 0.9
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = Color3.fromRGB(255,0,0)
    highlight.OutlineColor = Color3.fromRGB(255,0,0)
    highlight.Parent = char

    cacheEsp[plr] = {highlight}
end


local function setupPlayer(plr)

    if plr == player then return end

    if plr.Character then
        applyEspToCharacter(plr, plr.Character)
    end

    plr.CharacterAdded:Connect(function(char)
        if espEnabled then
            applyEspToCharacter(plr, char)
        end
    end)
end


function ESP:Enable()

    if espEnabled then return end
    espEnabled = true

    for _,plr in pairs(Players:GetPlayers()) do
        setupPlayer(plr)
    end

    playerAddedConnection = Players.PlayerAdded:Connect(setupPlayer)

end


function ESP:Disable()

    espEnabled = false
    clearEsp()

    if playerAddedConnection then
        playerAddedConnection:Disconnect()
        playerAddedConnection = nil
    end

end

return ESP