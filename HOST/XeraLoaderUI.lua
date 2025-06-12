-- XeraUltron Loader UI - Final Public UI Version
return function()
    local UI = {}

    function UI:Start(config)
        local TweenService = game:GetService("TweenService")
        local Lighting = game:GetService("Lighting")

        local Title = config.Title or "XeraUltron"
        local SubTitle = config.SubTitle or "Meta Solution"
        local Stages = config.Stages or {"Loading..."}
        local Sound = config.Sound ~= false
        local OnFinish = config.OnFinish or function() end

        -- GUI + Blur Setup
        local blur = Instance.new("BlurEffect")
        blur.Size = 16
        blur.Name = "XeraBlur"
        blur.Parent = Lighting

        local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        gui.Name = "XeraLoaderUI"
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.ResetOnSpawn = false

        local main = Instance.new("Frame", gui)
        main.AnchorPoint = Vector2.new(0.5, 0.5)
        main.Position = UDim2.new(0.5, 0, 0.5, 0)
        main.Size = UDim2.new(0, 500, 0, 300)
        main.BackgroundTransparency = 1

        -- Title
        local title = Instance.new("TextLabel", main)
        title.Size = UDim2.new(1, 0, 0, 60)
        title.Position = UDim2.new(0, 0, 0, 0)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.Text = Title
        title.TextScaled = true
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextTransparency = 1

        -- SubTitle
        local sub = Instance.new("TextLabel", main)
        sub.Size = UDim2.new(1, 0, 0, 40)
        sub.Position = UDim2.new(0, 0, 0, 60)
        sub.BackgroundTransparency = 1
        sub.Font = Enum.Font.Gotham
        sub.Text = SubTitle
        sub.TextScaled = true
        sub.TextColor3 = Color3.fromRGB(255, 255, 255)
        sub.TextTransparency = 1

        -- ProgressBar Container
        local barHolder = Instance.new("Frame", main)
        barHolder.Size = UDim2.new(0.9, 0, 0, 20)
        barHolder.Position = UDim2.new(0.05, 0, 0, 200)
        barHolder.BackgroundTransparency = 1

        local bar = Instance.new("Frame", barHolder)
        bar.Size = UDim2.new(0, 0, 1, 0)
        bar.Position = UDim2.new(0, 0, 0, 0)
        bar.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        bar.Name = "ProgressBar"

        local round = Instance.new("UICorner", bar)
        round.CornerRadius = UDim.new(0, 12)

        -- Stage Text
        local stageText = Instance.new("TextLabel", main)
        stageText.Size = UDim2.new(1, 0, 0, 50)
        stageText.Position = UDim2.new(0, 0, 0, 240)
        stageText.BackgroundTransparency = 1
        stageText.Font = Enum.Font.GothamMedium
        stageText.Text = ""
        stageText.TextScaled = true
        stageText.TextColor3 = Color3.fromRGB(255, 255, 255)
        stageText.TextTransparency = 1

        -- Credits
        local credits = Instance.new("TextLabel", main)
        credits.Size = UDim2.new(1, 0, 0, 30)
        credits.Position = UDim2.new(0, 0, 0, 270)
        credits.BackgroundTransparency = 1
        credits.Font = Enum.Font.GothamItalic
        credits.Text = "Developed by Kokil | LuaScripts787 | XeraUltronTEAM"
        credits.TextScaled = true
        credits.TextColor3 = Color3.fromRGB(255, 255, 255)
        credits.TextTransparency = 1

        -- Sound Effects
        local sfx = nil
        if Sound then
            sfx = Instance.new("Sound", gui)
            sfx.SoundId = "rbxassetid://9118823104"
            sfx.Volume = 1
        end

        -- Animate UI In
        TweenService:Create(title, TweenInfo.new(1), {TextTransparency = 0}):Play()
        TweenService:Create(sub, TweenInfo.new(1.2), {TextTransparency = 0}):Play()

        delay(1.3, function()
            local glow = TweenService:Create(title, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {TextTransparency = 0.3})
            glow:Play()
        end)

        -- Stage Cycle
        coroutine.wrap(function()
            for i, msg in ipairs(Stages) do
                stageText.Text = msg
                TweenService:Create(stageText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
                TweenService:Create(bar, TweenInfo.new(0.5), {Size = UDim2.new(i / #Stages, 0, 1, 0)}):Play()
                if sfx then sfx:Play() end
                wait(1.2)
                TweenService:Create(stageText, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
                wait(0.3)
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
