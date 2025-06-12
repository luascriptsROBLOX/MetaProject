-- Final XeraUltron Cinematic Loader UI
return function()
    local UI = {}

    function UI:Start(config)
        local TweenService = game:GetService("TweenService")
        local Lighting = game:GetService("Lighting")
        local Players = game:GetService("Players")

        local Title = config.Title or "XeraUltron"
        local SubTitle = config.SubTitle or "Meta Solution"
        local Stages = config.Stages or {"Loading..."}
        local OnFinish = config.OnFinish or function() end

        -- Blur Effect
        local blur = Instance.new("BlurEffect")
        blur.Size = 25
        blur.Name = "XeraBlur"
        blur.Parent = Lighting

        -- GUI Setup
        local gui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
        gui.Name = "XeraLoaderUI"
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.IgnoreGuiInset = true
        gui.ResetOnSpawn = false

        local main = Instance.new("Frame", gui)
        main.Size = UDim2.new(1, 0, 1, 0)
        main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        main.BackgroundTransparency = 1

        -- Title
        local title = Instance.new("TextLabel", main)
        title.Size = UDim2.new(1, 0, 0.15, 0)
        title.Position = UDim2.new(0, 0, 0.2, 0)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBlack
        title.Text = Title
        title.TextScaled = true
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextTransparency = 1

        -- SubTitle
        local sub = Instance.new("TextLabel", main)
        sub.Size = UDim2.new(1, 0, 0.1, 0)
        sub.Position = UDim2.new(0, 0, 0.33, 0)
        sub.BackgroundTransparency = 1
        sub.Font = Enum.Font.Gotham
        sub.Text = SubTitle
        sub.TextScaled = true
        sub.TextColor3 = Color3.fromRGB(180, 180, 180)
        sub.TextTransparency = 1

        -- ProgressBar Container
        local barHolder = Instance.new("Frame", main)
        barHolder.Size = UDim2.new(0.6, 0, 0, 30)
        barHolder.Position = UDim2.new(0.2, 0, 0.55, 0)
        barHolder.BackgroundTransparency = 1

        local bar = Instance.new("Frame", barHolder)
        bar.Name = "ProgressBar"
        bar.Size = UDim2.new(0, 0, 1, 0)
        bar.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        bar.BorderSizePixel = 0
        local barCorner = Instance.new("UICorner", bar)
        barCorner.CornerRadius = UDim.new(0, 15)

        -- Stage Text
        local stageText = Instance.new("TextLabel", main)
        stageText.Size = UDim2.new(1, 0, 0.08, 0)
        stageText.Position = UDim2.new(0, 0, 0.65, 0)
        stageText.BackgroundTransparency = 1
        stageText.Font = Enum.Font.GothamMedium
        stageText.Text = ""
        stageText.TextScaled = true
        stageText.TextColor3 = Color3.fromRGB(255, 255, 255)
        stageText.TextTransparency = 1

        -- Credits
        local credits = Instance.new("TextLabel", main)
        credits.Size = UDim2.new(1, 0, 0.05, 0)
        credits.Position = UDim2.new(0, 0, 0.95, 0)
        credits.BackgroundTransparency = 1
        credits.Font = Enum.Font.GothamItalic
        credits.Text = "Made by Kokil | LuaScripts787 | XeraUltronTEAM"
        credits.TextScaled = true
        credits.TextColor3 = Color3.fromRGB(255, 255, 255)
        credits.TextTransparency = 1

        -- Animate In
        TweenService:Create(title, TweenInfo.new(1), {TextTransparency = 0}):Play()
        TweenService:Create(sub, TweenInfo.new(1.2), {TextTransparency = 0}):Play()
        wait(1.3)
        TweenService:Create(title, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {TextTransparency = 0.3}):Play()

        -- Stage Loop
        coroutine.wrap(function()
            for i, msg in ipairs(Stages) do
                stageText.Text = msg
                TweenService:Create(stageText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
                TweenService:Create(bar, TweenInfo.new(0.6), {Size = UDim2.new(i / #Stages, 0, 1, 0)}):Play()
                wait(1.3)
                TweenService:Create(stageText, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
                wait(0.2)
            end

            TweenService:Create(credits, TweenInfo.new(1), {TextTransparency = 0}):Play()
            wait(2)
            blur:Destroy()
            gui:Destroy()
            OnFinish()
        end)()
    end

    return UI
end
