-- services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local GUI = {}
local noclipEnabled = false



function GUI:Init(modules)
    -- GUI
    local gui = Instance.new("ScreenGui")
    gui.Parent = player:WaitForChild("PlayerGui")
    gui.ResetOnSpawn = false
    -- MAIN FRAME
    --local defaultSize = UDim2.new(0, 450, 0, 300)
    local defaultSize = UDim2.new(0, 380, 0, 340)
    local frame = Instance.new("Frame", gui)
    frame.Size = defaultSize
    frame.Position = UDim2.new(0.5, -135, 0.5, -115)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 15)
    -- HEADER
    local header = Instance.new("Frame", frame)
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = Color3.fromRGB(45,45,45)
    -- CONTENT FRANE
    local content = Instance.new("Frame", frame)
    content.Size = UDim2.new(1,0,1, -50) -- kasih offset bawah supaya button keliatan
    content.Position = UDim2.new(0,0,0,10)
    content.BackgroundTransparency = 1
    --UILISTLAYOUT
    local layout = Instance.new("UIListLayout", content)
    layout.Padding = UDim.new(0,10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Top


    -- TITLE
    local title = Instance.new("TextLabel", header)
    title.Size = UDim2.new(1, -40, 1, 0)
    title.BackgroundColor3 = Color3.fromRGB(45,45,45)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.Arcade
    title.Text = "Brodz Hub"
    title.TextColor3 = Color3.fromRGB(0,255,180)
    title.TextScaled = true

    -- MINIMIZE
    local minimize = Instance.new("TextButton", frame)
    minimize.Size = UDim2.new(0, 30, 0, 30)
    minimize.Position = UDim2.new(1, -35, 0, 5)
    minimize.Text = "-"
    minimize.BackgroundColor3 = Color3.fromRGB(200,60,60)
    local miniCorner = Instance.new("UICorner", minimize)
    miniCorner.CornerRadius = UDim.new(1,0)
    -- CIRCLE
    local circle = Instance.new("ImageButton", gui)
    circle.Size = UDim2.new(0, 60, 0, 60)
    circle.Position = UDim2.new(0,20,0.5,0)
    circle.Image = "rbxassetid://75617196126271"
    circle.Visible = false
    circle.BackgroundTransparency = 1
    circle.BackgroundColor3 = Color3.fromRGB(40,40,40)
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1,0)
    circleCorner.Parent = circle

    -- TWEEN
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    -- DRAG SYSTEM (WORKS FOR BOTH)
    local function makeDraggable(uiObject)
        local dragging = false
        local dragStart
        local startPos
        local canDrag = false
    
        uiObject.InputBegan:Connect(function(input)
            if not canDrag then return end
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = uiObject.Position
            end
        end)
    
        uiObject.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                uiObject.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end)
    
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    
        return {
            Enable = function() canDrag = true end,
            Disable = function() canDrag = false end
        }
    end
    -- DEFINISI TOMBOL
    local function makeBtn(parent, text, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.8, 0, 0, 32) -- lebar 80% biar pas
        button.AnchorPoint = Vector2.new(0.5, 0) -- titik tengah horizontal
        button.Position = UDim2.new(0.5, 0, 0, 0) -- otomatis di tengah parent
        button.BackgroundColor3 = Color3.fromRGB(60,60,60)
        button.Font = Enum.Font.Arcade
        button.TextColor3 = Color3.fromRGB(0,255,180)
        button.Text = text
        button.TextSize = 16
        button.TextScaled = false
        button.Parent = parent

        local corner = Instance.new("UICorner", button)
        corner.CornerRadius = UDim.new(0,10)

        -- Hover effect
        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(80,80,80)
        end)
        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(60,60,60)
        end)

        button.MouseButton1Click:Connect(function()
            if callback then
                callback(button)
            end
        end)

        return button
    end
    
    local function createSlider(parent, minValue, maxValue, defaultValue, labelText, callback)
        local container = Instance.new("Frame", parent)
        container.Size = UDim2.new(0.9, 0, 0, 40)
        container.BackgroundTransparency = 1
    
        local label = Instance.new("TextLabel", container)
        label.Size = UDim2.new(1, 0, 0, 15)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(0,255,180)
        label.Text = labelText .. ": " .. defaultValue
        label.Font = Enum.Font.Arcade
        label.TextScaled = true
    
        local bar = Instance.new("Frame", container)
        bar.Size = UDim2.new(1, 0, 0, 8)
        bar.Position = UDim2.new(0, 0, 0, 20)
        bar.BackgroundColor3 = Color3.fromRGB(200,200,200)
    
        local fill = Instance.new("Frame", bar)
        fill.BackgroundColor3 = Color3.fromRGB(0,170,255)
    
        local knob = Instance.new("Frame", bar)
        knob.Size = UDim2.new(0, 20, 0, 20)
        knob.AnchorPoint = Vector2.new(0.5, 0.5)
        knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    
        local dragging = false
    
        -- fungsi update slider
        local function updateSlider(percent)
            percent = math.clamp(percent, 0, 1)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            knob.Position = UDim2.new(percent, 0, 0.5, 0)
            local value = math.floor(minValue + (maxValue-minValue)*percent)
            label.Text = labelText .. ": " .. value
            if typeof(callback) == "function" then
                callback(value)
            end
        end
    
        -- set default
        local defaultPercent = (defaultValue-minValue)/(maxValue-minValue)
        updateSlider(defaultPercent)
    
        knob.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)
        
        bar.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
            or input.UserInputType == Enum.UserInputType.Touch) then
                local percent = (input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
                updateSlider(percent)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

    end


    modules.ngabret:Enable()
    createSlider(content, 16, 100, 16, "Speed", function(value)
        print("Speed slider:", value) -- debug
        if modules.ngabret and typeof(modules.ngabret.setSpeed) == "function" then
            modules.ngabret:setSpeed(value)
        end
    end)
    
    createSlider(content, 16, 100, 16, "Fly Speed", function(value)
        print("Fly slider:", value) -- debug
        if modules.ngapung and typeof(modules.ngapung.setSpeed) == "function" then
            modules.ngapung:setSpeed(value)
        end
    end)


    makeBtn(content, "NOCLIP OFF", function(button)
        noclipEnabled = not noclipEnabled
        modules.nclip:Enable(noclipEnabled)
        button.Text = noclipEnabled and "NOCLIP ON" or "NOCLIP OFF"
        button.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
    end)

    makeBtn(content, "ESP OFF", function(button)
        if button.Text == "ESP OFF" then
            button.BackgroundColor3 = Color3.fromRGB(0,170,0)
            button.Text = "ESP ON"
            modules.esp:Enable()
        else
            button.BackgroundColor3 = Color3.fromRGB(170,0,0)
            button.Text = "ESP OFF"
            modules.esp:Disable()
        end
    end)
    makeBtn(content, "INF JUMP OFF", function(button)
        if button.Text == "INF JUMP OFF" then
            button.BackgroundColor3 = Color3.fromRGB(0,170,0)
            button.Text = "INF JUMP ON"
            modules.infjmp:Enable()
        else
            button.BackgroundColor3 = Color3.fromRGB(170,0,0)
            button.Text = "INF JUMP OFF"
            modules.infjmp:Enable()
        end
    end)
    makeBtn(content,"TELEPORT TO PLAYERS", function()
        modules.pepet:Enable()
    end)
    local frameDrag = makeDraggable(frame)
    local circleDrag = makeDraggable(circle)
    frameDrag:Disable()
    circleDrag:Enable()
    local minimizeTween = TweenService:Create(content, tweenInfo, {
        Size = defaultSize
    })
    local openTween = TweenService:Create(content, tweenInfo, {
        Size = defaultSize
    })
    minimize.MouseButton1Click:Connect(function()
        minimizeTween:Play()
        circle.Position = frame.Position
        frame.Visible = false
        circle.Visible = true
        frameDrag:Disable()
        circleDrag:Enable()
    end)
    circle.MouseButton1Click:Connect(function()
        openTween:Play()
        frame.Position = circle.Position
        frame.Visible = true
        circle.Visible = false
        circleDrag:Enable()
        frameDrag:Disable()
    end)
end

return GUI





















