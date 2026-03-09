-- services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GUI = {}
local noclipEnabled = false



function GUI:Init(modules)
    -- GUI
    local gui = Instance.new("ScreenGui")
    gui.Parent = player:WaitForChild("PlayerGui")
    gui.ResetOnSpawn = false
    -- MAIN FRAME
    --local defaultSize = UDim2.new(0, 450, 0, 300)
    local defaultSize = UDim2.new(0, 550, 0, 450)
    local frame = Instance.new("Frame", gui)
    frame.Size = defaultSize
    frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 15)
    -- HEADER
    local header = Instance.new("Frame", frame)
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = Color3.fromRGB(45,45,45)
    -- CONTENT FRANE
    local content = Instance.new("Frame", frame)
    content.Size = UDim2.new(1, 0, 1, -40)
    content.Position = UDim2.new(0, 0, 0, 40)
    content.BackgroundTransparency = 1
    --UILISTLAYOUT
    local layout = Instance.new("UIListLayout", content)
    layout.Padding = UDim.new(0, 10)
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
        local canDrag = false -- DEFAULT: mati

        uiObject.InputBegan:Connect(function(input)
            if canDrag and input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = uiObject.Position
            end
        end)

        uiObject.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
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
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        return {
            Enable = function()
                canDrag = true
            end,
            Disable = function()
                canDrag = false
            end
        }
    end
    -- DEFINISI TOMBOL
    local function makeBtn(parent, text, yPos, callback)

        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.8, 0, 0, 40)
        button.BackgroundColor3 = Color3.fromRGB(60,60,60)
        button.Font = Enum.Font.Arcade
        button.TextColor3 = Color3.fromRGB(0,255,180)
        button.Text = text
        button.TextSize = 16
        button.TextScaled = false
        button.Parent = parent

        local corner = Instance.new("UICorner", button)
        corner.CornerRadius = UDim.new(0,10)
        corner.Parent = button

        -- Hover
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
    local function createSlider(parent, posY, minValue, maxValue, defaultValue, textLabel, callback)
        local container = Instance.new("Frame", parent)
        container.Size = UDim2.new(0.8, 0, 0, 60)
        container.Position = UDim2.new(0.1, 0, 0, posY)
        container.BackgroundTransparency = 1

        -- TITLE
        local title = Instance.new("TextLabel", container)
        title.Size = UDim2.new(1, 0, 0, 20)
        title.BackgroundTransparency = 1
        title.TextColor3 = Color3.fromRGB(0,255,180)
        title.Text = textLabel .. ": " .. defaultValue
        title.Font = Enum.Font.Arcade
        title.TextScaled = true

        -- SLIDER BAR
        local sliderFrame = Instance.new("Frame", container)
        sliderFrame.Size = UDim2.new(1, 0, 0, 20)
        sliderFrame.Position = UDim2.new(0, 0, 0, 30)
        sliderFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)

        local sliderCorner = Instance.new("UICorner", sliderFrame)
        sliderCorner.CornerRadius = UDim.new(0,10)

        -- FILL
        local fill = Instance.new("Frame", sliderFrame)
        fill.BackgroundColor3 = Color3.fromRGB(0,170,255)

        local fillCorner = Instance.new("UICorner", fill)
        fillCorner.CornerRadius = UDim.new(0,10)

        -- KNOB
        local knob = Instance.new("Frame", sliderFrame)
        knob.Size = UDim2.new(0, 18, 0, 18)
        knob.BackgroundColor3 = Color3.fromRGB(255,255,255)

        local knobCorner = Instance.new("UICorner", knob)
        knobCorner.CornerRadius = UDim.new(1,0)

        local dragging = false

        -- UPDATE FUNCTION
        local function update(percent)
            percent = math.clamp(percent, 0, 1)

            fill.Size = UDim2.new(percent, 0, 1, 0)
            knob.Position = UDim2.new(percent, -9, 0.5, -9)

            local value = math.floor(minValue + (maxValue - minValue) * percent)
            title.Text = textLabel .. ": " .. value

            if callback then
                callback(value)
            end
        end

        -- DEFAULT SET
        local defaultPercent = (defaultValue - minValue) / (maxValue - minValue)
        update(defaultPercent)

        -- INPUT
        knob.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local percent = (input.Position.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X
                update(percent)
            end
        end)

    end
    modules.ngabret:Enable()
    createSlider(content, 60, 16, 100, 16, "Speed", function(value)
        modules.ngabret:setSpeed(value)
    end)
    createSlider(content, 40, 16, 100, 16, "Fly Speed", function(value)
        modules.ngapung:setSpeed = value
    end)
    local flyBtn = makeBtn(content, "FLY OFF", 170, function(button)
        if button.text == "FLY OFF" then
            button.Text = "FLY ON"
            button.BackgroundColor3 = Color3.fromRGB(0,170,0)
            modules.ngapung:Enable()
        else
            button.Text = "FLY OFF"
            button.BackgroundColor3 = Color3.fromRGB(170,0,0)
            modules.ngapung:Disable()
        end
    end)
    local nclipBtn = makeBtn(content, "NOCLIP OFF", 0.38, function(button)
        noclipEnabled = not noclipEnabled
        modules.nclip:Enable(noclipEnabled)
        button.Text = noclipEnabled and "NOCLIP ON" or "NOCLIP OFF"
        button.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
    end)
    local espBtn = makeBtn(content,"ESP OFF", 110, function(button)
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
    local infJumpBtn = makeBtn(content, "INF JUMP OFF", 110, function(button)
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
    local tpBtn = makeBtn(content,"TELEPORT TO PLAYERS", 110, function()
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



