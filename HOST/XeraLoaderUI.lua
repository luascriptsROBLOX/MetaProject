-- Cinematic XeraUltron Fullscreen Loader UI
return function()
    local UI = {}

    function UI:Start(config)
        local TweenService = game:GetService("TweenService")
        local Lighting = game:GetService("Lighting")

        local Title = config.Title or "XeraUltron"
        local SubTitle = config.SubTitle or "Meta Solution"
        local Stages = config.Stages or {"Loading..."}
        local OnFinish = config.OnFinish or function() end

        -- Blur background
        local blur = Instance.new("BlurEffect")
        blur.Size = 20
        blur.Name = "XeraBlur"
        blur.Parent = Lighting

        -- GUI
        local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        gui.Name = "XeraLoaderUI"
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.ResetOnSpawn = false

        local main = Instance.new("Frame", gui)
        main.Size = UDim2.new(1, 0, 1, 0)
        main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        main.BackgroundTransparency = 1

        -- TITLE (Big)
        local title = Instance.new("TextLabel", main)
        title.Size = UDim2.new(1, 0, 0, 100)
        title.Position = UDim2.new(0, 0, 0.25, 0)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBlack
        title.Text = Title
        title.TextScaled = true
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextTransparency = 1

        -- SUBTITLE (Medium)
        local sub = Instance.new("TextLabel", main)
        sub.Size = UDim2.new(1, 0, 0, 60)
        sub.Position = UDim2.new(0, 0, 0.35, 0)
        sub.BackgroundTransparency = 1
        sub.Font = Enum.Font.GothamBold
        sub.Text = SubTitle
        sub.TextScaled = true
        sub.TextColor3 = Color3.fromRGB(200, 200, 200)
        sub.TextTransparency = 1

        -- PROGRESS BAR
        local barHolder = Instance.new("Frame", main)
        barHolder.Size = UDim2.new(0.6, 0, 0, 30)
        barHolder.Position = UDim2.new(0.2, 0, 0.55, 0)
        barHolder.BackgroundTransparency = 1

        local bar = Instance.new("Frame", barHolder)
        bar.Name = "ProgressBar"
        bar.Size = UDim2.new(0, 0, 1, 0)
        bar.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 15)

        -- STAGE TEXT (Big)
        local stageText = Instance.new("TextLabel", main)
        stageText.Size = UDim2.new(1, 0, 0, 60)
        stageText.Position = UDim2.new(0, 0, 0.65, 0)
        stageText.BackgroundTransparency = 1
        stageText.Font = Enum.Font.GothamMedium
        stageText.Text = ""
        stageText.TextScaled = true
        stageText.TextColor3 = Color3.fromRGB(255, 255, 255)
        stageText.TextTransparency = 1

        -- CREDITS
        local credits = Instance.new("TextLabel", main)
        credits.Size = UDim2.new(1, 0, 0, 30)
        credits.Position = UDim2.new(0, 0, 0.95, 0)
        credits.BackgroundTransparency = 1
        credits.Font = Enum.Font.Gotham
        credits.Text = "Made by Kokil | LuaScripts787 | XeraUltronTEAM"
        credits.TextScaled = true
        credits.TextColor3 = Color3.fromRGB(255, 255, 255)
        credits.TextTransparency = 1

        -- ANIMATE IN
        TweenService:Create(title, TweenInfo.new(1), {TextTransparency = 0}):Play()
        TweenService:Create(sub, TweenInfo.new(1.2), {TextTransparency = 0}):Play()

        wait(1.2)
        TweenService:Create(title, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {TextTransparency = 0.3}):Play()

        -- LOAD STAGES
        coroutine.wrap(function()
            for i, msg in ipairs(Stages) do
                stageText.Text = msg
                TweenService:Create(stageText, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
                TweenService:Create(bar, TweenInfo.new(0.6), {Size = UDim2.new(i / #Stages, 0, 1, 0)}):Play()
                wait(1.2)
                TweenService:Create(stageText, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
                wait(0.3)
            end

            -- Finish
            TweenService:Create(credits, TweenInfo.new(1), {TextTransparency = 0}):Play()
            wait(2)
            blur:Destroy()
            gui:Destroy()
            OnFinish()
        end)()
    end

    return UI
end
