
local XeraLoader = {}

function XeraLoader:Start(config)
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local Lighting = game:GetService("Lighting")
    local SoundService = game:GetService("SoundService")
    local LocalPlayer = Players.LocalPlayer

    local Title = config.Title or "XeraUltron"
    local SubTitle = config.SubTitle or "Meta Solution"
    local Stages = config.Stages or {"Loading..."}
    local EnableSound = config.Sound ~= false
    local OnFinish = config.OnFinish or function() end

    -- Blur
    local blur = Instance.new("BlurEffect")
    blur.Size = 24
    blur.Parent = Lighting

    -- ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "XeraLoader"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    -- Frame
    local main = Instance.new("Frame")
    main.Size = UDim2.new(1, 0, 1, 0)
    main.BackgroundTransparency = 1
    main.Parent = gui

    -- Title
    local title = Instance.new("TextLabel")
    title.Text = Title
    title.Font = Enum.Font.GothamBlack
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextStrokeTransparency = 0
    title.TextScaled = true
    title.AnchorPoint = Vector2.new(0.5, 0.5)
    title.Position = UDim2.new(0.5, 0, 0.3, 0)
    title.Size = UDim2.new(0.7, 0, 0.1, 0)
    title.BackgroundTransparency = 1
    title.Parent = main

    -- SubTitle
    local sub = Instance.new("TextLabel")
    sub.Text = SubTitle
    sub.Font = Enum.Font.Gotham
    sub.TextColor3 = Color3.fromRGB(200, 200, 200)
    sub.TextStrokeTransparency = 0.8
    sub.TextScaled = true
    sub.AnchorPoint = Vector2.new(0.5, 0.5)
    sub.Position = UDim2.new(0.5, 0, 0.38, 0)
    sub.Size = UDim2.new(0.6, 0, 0.05, 0)
    sub.BackgroundTransparency = 1
    sub.Parent = main

    -- ProgressBar BG
    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(0.5, 0, 0.015, 0)
    barBg.Position = UDim2.new(0.5, 0, 0.5, 0)
    barBg.AnchorPoint = Vector2.new(0.5, 0.5)
    barBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    barBg.BorderSizePixel = 0
    barBg.Parent = main
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = barBg

    -- ProgressBar Fill
    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 16)
    fillCorner.Parent = barFill

    -- Stage Text
    local stageText = Instance.new("TextLabel")
    stageText.Text = ""
    stageText.Font = Enum.Font.GothamMedium
    stageText.TextColor3 = Color3.fromRGB(255, 255, 255)
    stageText.TextScaled = true
    stageText.Position = UDim2.new(0.5, 0, 0.57, 0)
    stageText.AnchorPoint = Vector2.new(0.5, 0.5)
    stageText.Size = UDim2.new(0.8, 0, 0.05, 0)
    stageText.BackgroundTransparency = 1
    stageText.Parent = main

    -- Sound Effect
    local function playSound()
        if EnableSound then
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://9118823104" -- whoosh/click
            sound.Volume = 1
            sound.Parent = SoundService
            sound:Play()
            game.Debris:AddItem(sound, 3)
        end
    end

    -- Animate loading
    coroutine.wrap(function()
        for i, text in ipairs(Stages) do
            stageText.Text = text
            TweenService:Create(barFill, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(i / #Stages, 0, 1, 0)
            }):Play()
            playSound()
            wait(1)
        end

        -- Fade out
        TweenService:Create(main, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
        wait(0.5)
        gui:Destroy()
        blur:Destroy()
        OnFinish()
    end)()
end

return XeraLoader
