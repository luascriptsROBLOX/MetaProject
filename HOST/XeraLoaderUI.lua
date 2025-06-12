return function()
    local XeraUI = {}

    function XeraUI:Start(config)
        local TweenService = game:GetService("TweenService")
        local Players = game:GetService("Players")
        local Lighting = game:GetService("Lighting")

        local player = Players.LocalPlayer
        local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
        gui.Name = "XeraLoaderUI"
        gui.IgnoreGuiInset = true
        gui.ResetOnSpawn = false
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        -- Blur Background
        local blur = Instance.new("BlurEffect")
        blur.Size = 24
        blur.Name = "XeraUILoaderBlur"
        blur.Parent = Lighting

        -- Config Vars
        local Title = config.Title or "XeraUltron"
        local SubTitle = config.SubTitle or "Meta Solution Core"
        local Stages = config.Stages or {"Loading..."}
        local OnFinish = config.OnFinish or function() end

        -- Main Background
        local mainFrame = Instance.new("Frame", gui)
        mainFrame.Size = UDim2.new(1, 0, 1, 0)
        mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)

        -- Center Frame
        local center = Instance.new("Frame", mainFrame)
        center.AnchorPoint = Vector2.new(0.5, 0.5)
        center.Position = UDim2.new(0.5, 0, 0.5, 0)
        center.Size = UDim2.new(0.6, 0, 0.5, 0)
        center.BackgroundTransparency = 1

        -- Title Label
        local title = Instance.new("TextLabel", center)
        title.Size = UDim2.new(1, 0, 0.2, 0)
        title.Position = UDim2.new(0, 0, 0.05, 0)
        title.BackgroundTransparency = 1
        title.Text = Title
        title.Font = Enum.Font.GothamBlack
        title.TextColor3 = Color3.fromRGB(0, 255, 255)
        title.TextScaled = true
        title.TextTransparency = 1

        -- SubTitle Label
        local subtitle = Instance.new("TextLabel", center)
        subtitle.Size = UDim2.new(1, 0, 0.1, 0)
        subtitle.Position = UDim2.new(0, 0, 0.22, 0)
        subtitle.BackgroundTransparency = 1
        subtitle.Text = SubTitle
        subtitle.Font = Enum.Font.Gotham
        subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
        subtitle.TextScaled = true
        subtitle.TextTransparency = 1

        -- Stage Label
        local stageText = Instance.new("TextLabel", center)
        stageText.Size = UDim2.new(1, 0, 0.1, 0)
        stageText.Position = UDim2.new(0, 0, 0.75, 0)
        stageText.BackgroundTransparency = 1
        stageText.TextColor3 = Color3.fromRGB(255, 255, 255)
        stageText.Font = Enum.Font.GothamBold
        stageText.TextScaled = true
        stageText.TextTransparency = 1

        -- Progress Bar Background
        local progressHolder = Instance.new("Frame", center)
        progressHolder.Size = UDim2.new(0.8, 0, 0.08, 0)
        progressHolder.Position = UDim2.new(0.1, 0, 0.55, 0)
        progressHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        progressHolder.BorderSizePixel = 0
        local corner1 = Instance.new("UICorner", progressHolder)
        corner1.CornerRadius = UDim.new(0, 15)

        -- Progress Bar
        local progressBar = Instance.new("Frame", progressHolder)
        progressBar.Size = UDim2.new(0, 0, 1, 0)
        progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        progressBar.BorderSizePixel = 0
        local corner2 = Instance.new("UICorner", progressBar)
        corner2.CornerRadius = UDim.new(0, 15)

        -- Credits
        local credits = Instance.new("TextLabel", mainFrame)
        credits.Size = UDim2.new(1, 0, 0.04, 0)
        credits.Position = UDim2.new(0, 0, 0.96, 0)
        credits.BackgroundTransparency = 1
        credits.Text = "Made by Kokil | LuaScripts787 | XeraUltronTEAM"
        credits.Font = Enum.Font.GothamItalic
        credits.TextColor3 = Color3.fromRGB(255, 255, 255)
        credits.TextTransparency = 1
        credits.TextScaled = true

        -- Show Header
        TweenService:Create(title, TweenInfo.new(1), {TextTransparency = 0}):Play()
        TweenService:Create(subtitle, TweenInfo.new(1.2), {TextTransparency = 0}):Play()
        task.wait(1.3)

        coroutine.wrap(function()
            for i, stage in ipairs(Stages) do
                stageText.Text = stage
                TweenService:Create(stageText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
                TweenService:Create(progressBar, TweenInfo.new(0.5), {
                    Size = UDim2.new(i / #Stages, 0, 1, 0)
                }):Play()
                task.wait(1.1)
                TweenService:Create(stageText, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
                task.wait(0.2)
            end

            TweenService:Create(credits, TweenInfo.new(1), {TextTransparency = 0}):Play()
            task.wait(1.5)

            gui:Destroy()
            if blur then blur:Destroy() end
            OnFinish()
        end)()
    end

    return XeraUI
end
