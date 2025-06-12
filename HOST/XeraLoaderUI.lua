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

        -- Clean blur
        pcall(function()
            local blur = Instance.new("BlurEffect")
            blur.Size = 24
            blur.Name = "XeraUILoaderBlur"
            blur.Parent = Lighting
        end)

        local Title = config.Title or "XeraUltron"
        local SubTitle = config.SubTitle or "Meta Core System"
        local Stages = config.Stages or {"Loading..."}
        local OnFinish = config.OnFinish or function() end

        -- Base Frame
        local container = Instance.new("Frame", gui)
        container.Size = UDim2.new(1, 0, 1, 0)
        container.BackgroundColor3 = Color3.fromRGB(60, 60, 70) -- brighter background
        container.Name = "MainFrame"

        -- Center Group
        local centerFrame = Instance.new("Frame", container)
        centerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        centerFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        centerFrame.Size = UDim2.new(0.7, 0, 0.5, 0)
        centerFrame.BackgroundTransparency = 1

        -- Title
        local titleLabel = Instance.new("TextLabel", centerFrame)
        titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
        titleLabel.Position = UDim2.new(0, 0, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = Title
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.Font = Enum.Font.GothamBlack
        titleLabel.TextScaled = true
        titleLabel.TextTransparency = 1

        -- Subtitle
        local subLabel = Instance.new("TextLabel", centerFrame)
        subLabel.Size = UDim2.new(1, 0, 0.15, 0)
        subLabel.Position = UDim2.new(0, 0, 0.22, 0)
        subLabel.BackgroundTransparency = 1
        subLabel.Text = SubTitle
        subLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        subLabel.Font = Enum.Font.Gotham
        subLabel.TextScaled = true
        subLabel.TextTransparency = 1

        -- Progress bar container
        local barHolder = Instance.new("Frame", centerFrame)
        barHolder.Size = UDim2.new(0.8, 0, 0, 26)
        barHolder.Position = UDim2.new(0.1, 0, 0.45, 0)
        barHolder.BackgroundTransparency = 1

        -- Bar
        local progressBar = Instance.new("Frame", barHolder)
        progressBar.Name = "ProgressBar"
        progressBar.Size = UDim2.new(0, 0, 1, 0)
        progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        local barCorner = Instance.new("UICorner", progressBar)
        barCorner.CornerRadius = UDim.new(0, 13)

        -- Stage
        local stageLabel = Instance.new("TextLabel", centerFrame)
        stageLabel.Size = UDim2.new(1, 0, 0.1, 0)
        stageLabel.Position = UDim2.new(0, 0, 0.62, 0)
        stageLabel.BackgroundTransparency = 1
        stageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        stageLabel.Font = Enum.Font.GothamBold
        stageLabel.TextScaled = true
        stageLabel.TextTransparency = 1
        stageLabel.Text = ""

        -- Credits
        local credits = Instance.new("TextLabel", container)
        credits.Size = UDim2.new(1, 0, 0.04, 0)
        credits.Position = UDim2.new(0, 0, 0.96, 0)
        credits.BackgroundTransparency = 1
        credits.Text = "Made by Kokil | LuaScripts787 | XeraUltronTEAM"
        credits.Font = Enum.Font.GothamItalic
        credits.TextColor3 = Color3.fromRGB(255, 255, 255)
        credits.TextTransparency = 1
        credits.TextScaled = true

        -- Animations
        TweenService:Create(titleLabel, TweenInfo.new(1), { TextTransparency = 0 }):Play()
        TweenService:Create(subLabel, TweenInfo.new(1.2), { TextTransparency = 0 }):Play()
        task.wait(1.4)

        coroutine.wrap(function()
            for i, stageText in ipairs(Stages) do
                stageLabel.Text = stageText
                TweenService:Create(stageLabel, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
                TweenService:Create(progressBar, TweenInfo.new(0.6), {
                    Size = UDim2.new(i / #Stages, 0, 1, 0)
                }):Play()
                task.wait(1.2)
                TweenService:Create(stageLabel, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
                task.wait(0.1)
            end

            TweenService:Create(credits, TweenInfo.new(1), { TextTransparency = 0 }):Play()
            task.wait(1.5)

            gui:Destroy()
            local blur = Lighting:FindFirstChild("XeraUILoaderBlur")
            if blur then blur:Destroy() end

            OnFinish()
        end)()
    end

    return XeraUI
end
