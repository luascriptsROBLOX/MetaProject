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

        -- Optional Blur
        local blur = Instance.new("BlurEffect")
        blur.Size = 24
        blur.Parent = Lighting
        blur.Name = "XeraUILoaderBlur"

        -- Config Vars
        local Title = config.Title or "XeraUltron"
        local SubTitle = config.SubTitle or "Meta Core System"
        local Stages = config.Stages or { "Loading..." }
        local OnFinish = config.OnFinish or function() end

        -- Main container
        local container = Instance.new("Frame", gui)
        container.Size = UDim2.new(1, 0, 1, 0)
        container.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        container.BackgroundTransparency = 0
        container.Name = "MainFrame"

        -- Title
        local titleLabel = Instance.new("TextLabel", container)
        titleLabel.Size = UDim2.new(1, 0, 0.15, 0)
        titleLabel.Position = UDim2.new(0, 0, 0.12, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = Title
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.Font = Enum.Font.GothamBlack
        titleLabel.TextScaled = true
        titleLabel.TextTransparency = 1

        -- Subtitle
        local subLabel = Instance.new("TextLabel", container)
        subLabel.Size = UDim2.new(1, 0, 0.1, 0)
        subLabel.Position = UDim2.new(0, 0, 0.27, 0)
        subLabel.BackgroundTransparency = 1
        subLabel.Text = SubTitle
        subLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        subLabel.Font = Enum.Font.Gotham
        subLabel.TextScaled = true
        subLabel.TextTransparency = 1

        -- Progress Holder
        local barHolder = Instance.new("Frame", container)
        barHolder.Size = UDim2.new(0.6, 0, 0, 28)
        barHolder.Position = UDim2.new(0.2, 0, 0.47, 0)
        barHolder.BackgroundTransparency = 1

        local progressBar = Instance.new("Frame", barHolder)
        progressBar.Name = "ProgressBar"
        progressBar.Size = UDim2.new(0, 0, 1, 0)
        progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        local barCorner = Instance.new("UICorner", progressBar)
        barCorner.CornerRadius = UDim.new(0, 14)

        -- Stage Label
        local stageLabel = Instance.new("TextLabel", container)
        stageLabel.Size = UDim2.new(1, 0, 0.08, 0)
        stageLabel.Position = UDim2.new(0, 0, 0.60, 0)
        stageLabel.BackgroundTransparency = 1
        stageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        stageLabel.Font = Enum.Font.GothamBold
        stageLabel.TextScaled = true
        stageLabel.TextTransparency = 1
        stageLabel.Text = ""

        -- Credits
        local credits = Instance.new("TextLabel", container)
        credits.Size = UDim2.new(1, 0, 0.05, 0)
        credits.Position = UDim2.new(0, 0, 0.93, 0)
        credits.BackgroundTransparency = 1
        credits.Text = "Made by Kokil | LuaScripts787 | XeraUltronTEAM"
        credits.Font = Enum.Font.GothamItalic
        credits.TextColor3 = Color3.fromRGB(255, 255, 255)
        credits.TextTransparency = 1
        credits.TextScaled = true

        -- Anim Start
        TweenService:Create(titleLabel, TweenInfo.new(1), { TextTransparency = 0 }):Play()
        TweenService:Create(subLabel, TweenInfo.new(1.2), { TextTransparency = 0 }):Play()
        wait(1.4)

        -- Stage loop
        coroutine.wrap(function()
            for i, stageText in ipairs(Stages) do
                stageLabel.Text = stageText
                TweenService:Create(stageLabel, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
                TweenService:Create(progressBar, TweenInfo.new(0.7), {
                    Size = UDim2.new(i / #Stages, 0, 1, 0)
                }):Play()
                wait(1.3)
                TweenService:Create(stageLabel, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
                wait(0.2)
            end

            TweenService:Create(credits, TweenInfo.new(1), { TextTransparency = 0 }):Play()
            wait(2)

            gui:Destroy()
            blur:Destroy()
            OnFinish()
        end)()
    end

    return XeraUI
end
