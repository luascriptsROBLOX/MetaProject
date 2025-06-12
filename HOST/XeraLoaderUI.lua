return function()
    local UI = {}

    function UI:Start(config)
        local TweenService = game:GetService("TweenService")
        local Lighting = game:GetService("Lighting")
        local Players = game:GetService("Players")

        local Title = config.Title or "XeraUltron"
        local SubTitle = config.SubTitle or "Meta Soul System"
        local Stages = config.Stages or {"Loading..."}
        local OnFinish = config.OnFinish or function() end

        -- Blur
        local blur = Instance.new("BlurEffect", Lighting)
        blur.Size = 24
        blur.Name = "XeraBlur"

        -- Main UI
        local gui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
        gui.Name = "XeraLoaderUI"
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.IgnoreGuiInset = true
        gui.ResetOnSpawn = false

        local main = Instance.new("Frame", gui)
        main.Size = UDim2.new(1, 0, 1, 0)
        main.BackgroundTransparency = 1
        main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

        local title = Instance.new("TextLabel", main)
        title.Size = UDim2.new(0.9, 0, 0.15, 0)
        title.Position = UDim2.new(0.05, 0, 0.15, 0)
        title.BackgroundTransparency = 1
        title.Text = Title
        title.TextColor3 = Color3.new(1, 1, 1)
        title.TextScaled = true
        title.TextWrapped = true
        title.TextTransparency = 1
        title.Font = Enum.Font.GothamBlack

        local subtitle = Instance.new("TextLabel", main)
        subtitle.Size = UDim2.new(0.8, 0, 0.1, 0)
        subtitle.Position = UDim2.new(0.1, 0, 0.30, 0)
        subtitle.BackgroundTransparency = 1
        subtitle.Text = SubTitle
        subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
        subtitle.TextScaled = true
        subtitle.TextWrapped = true
        subtitle.TextTransparency = 1
        subtitle.Font = Enum.Font.GothamMedium

        local barHolder = Instance.new("Frame", main)
        barHolder.Size = UDim2.new(0.6, 0, 0, 30)
        barHolder.Position = UDim2.new(0.2, 0, 0.52, 0)
        barHolder.BackgroundTransparency = 1

        local bar = Instance.new("Frame", barHolder)
        bar.Name = "ProgressBar"
        bar.Size = UDim2.new(0, 0, 1, 0)
        bar.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 15)

        local stageText = Instance.new("TextLabel", main)
        stageText.Size = UDim2.new(0.8, 0, 0.1, 0)
        stageText.Position = UDim2.new(0.1, 0, 0.64, 0)
        stageText.BackgroundTransparency = 1
        stageText.TextColor3 = Color3.new(1, 1, 1)
        stageText.TextScaled = true
        stageText.TextWrapped = true
        stageText.Text = ""
        stageText.TextTransparency = 1
        stageText.Font = Enum.Font.GothamBold

        local credits = Instance.new("TextLabel", main)
        credits.Size = UDim2.new(1, 0, 0.05, 0)
        credits.Position = UDim2.new(0, 0, 0.95, 0)
        credits.BackgroundTransparency = 1
        credits.Text = "Made by Kokil | LuaScripts787 | XeraUltronTEAM"
        credits.TextScaled = true
        credits.TextColor3 = Color3.fromRGB(255, 255, 255)
        credits.TextTransparency = 1
        credits.Font = Enum.Font.GothamItalic

        -- Appear animations
        TweenService:Create(title, TweenInfo.new(1), {TextTransparency = 0}):Play()
        TweenService:Create(subtitle, TweenInfo.new(1.2), {TextTransparency = 0}):Play()
        wait(1.3)
        TweenService:Create(title, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            TextTransparency = 0.25,
        }):Play()

        coroutine.wrap(function()
            for i, text in ipairs(Stages) do
                stageText.Text = text
                TweenService:Create(stageText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
                TweenService:Create(bar, TweenInfo.new(0.6), {
                    Size = UDim2.new(i / #Stages, 0, 1, 0),
                }):Play()
                wait(1.3)
                TweenService:Create(stageText, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
                wait(0.2)
            end
            TweenService:Create(credits, TweenInfo.new(1), {TextTransparency = 0}):Play()
            wait(2)
            gui:Destroy()
            blur:Destroy()
            OnFinish()
        end)()
    end

    return UI
end
