--service
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
--tools variqabel
local infJump = false
local infinity = {}

function infinity:Enable()
    infJump = not infJump
    if infJump then
        jumpConnect = UserInputService.JumpRequest:Connect(function()
            local char = player.Character
            if char then
                local jelma = char:FindFirstChildOfClass("Humanoid")
                if jelma then
                    jelma:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        if jumpConnect then
            jumpConnect:Disconnect()
        end
    end
end
return infinity