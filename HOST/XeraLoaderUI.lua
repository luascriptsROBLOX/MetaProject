return function()
    local XeraUI = {}

    function XeraUI:Start(config)
        local TweenService = game:GetService("TweenService")
        local Players = game:GetService("Players")
        local Lighting = game:GetService("Lighting")

        local player = Players.LocalPlayer
        local gui = Instance.new("ScreenGui")
        gui.Name = "XeraLoaderUI"
        gui.IgnoreGuiInset = true
        gui.ResetOnSpawn = false
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Parent = player:WaitForChild("PlayerGui")

        -- Blur effect
        local blur = Instance.new("BlurEffect")
        blur.Size = 25
        blur.Parent = Lighting

        -- Background
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
        bg.Parent = gui

        -- Container
        local holder = Instance.new("Frame")
        holder.AnchorPoint = Vector2.new(0.5, 0.5)
        holder.Position = UDim2.new(0.5, 0, 0.5, 0)
        holder.Size = UDim2.new(0.65, 0, 0.55, 0)
        holder.BackgroundTransparency = 1
        holder.Parent = bg

        -- Title
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0.25, 0)
        title.Position = UDim2.new(0, 0, 0, 0)
        title.Text = config.Title or "XeraUltron"
        title.Font = Enum.Font.GothamBlack
        title.TextScaled = true
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextTransparency = 1
        title.BackgroundTransparency = 1
        title.Parent = holder

        -- SubTitle
        local subtitle = Instance.new("TextLabel")
        subtitle.Size = UDim2.new(1, 0, 0.15, 0)
        subtitle.Position = UDim2.new(0, 0, 0.25, 0)
        subtitle.Text = config.SubTitle or "Meta Solution Core"
        subtitle.Font = Enum.Font.Gotham
        subtitle.TextScaled = true
        subtitle.TextColor3 = Color3.fromRGB(180, 180, 255)
        subtitle.TextTransparency = 1
        subtitle.BackgroundTransparency = 1
        subtitle.Parent = holder

        -- Progress background
        local barBG = Instance.new("Frame")
        barBG.Size = UDim2.new(0.8, 0, 0.08, 0)
        barBG.Position = UDim2.new(0.1, 0, 0.55, 0)
        barBG.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        barBG.BorderSizePixel = 0
        barBG.Parent = holder
        local barBGCorner = Instance.new("UICorner")
        barBGCorner.CornerRadius = UDim.new(0, 14)
        barBGCorner.Parent = barBG

        -- Neon Progress
        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(0, 0, 1, 0)
        bar.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        bar.BorderSizePixel = 0
        bar.Parent = barBG
        Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 14)

        local glow = Instance.new("UIStroke")
        glow.Thickness = 2
        glow.Color = Color3.fromRGB(0, 255, 255)
        glow.Transparency = 0.5
        glow.Parent = bar

        -- Stage text
        local stageText = Instance.new("TextLabel")
        stageText.Size = UDim2.new(1, 0, 0.1, 0)
        stageText.Position = UDim2.new(0, 0, 0.68, 0)
        stageText.Text = ""
        stageText.Font = Enum.Font.GothamMedium
        stageText.TextScaled = true
        stageText.TextColor3 = Color3.fromRGB(255, 255, 255)
        stageText.TextTransparency = 1
        stageText.BackgroundTransparency = 1
        stageText.Parent = holder

        -- Credits
        local credits = Instance.new("TextLabel")
        credits.Size = UDim2.new(1, 0, 0.04, 0)
        credits.Position = UDim2.new(0, 0, 0.96, 0)
        credits.Text = "Created by Kokil | LuaScripts787 | XeraUltronTEAM"
        credits.Font = Enum.Font.GothamItalic
        credits.TextColor3 = Color3.fromRGB(255, 255, 255)
        credits.TextScaled = true
        credits.TextTransparency = 1
        credits.BackgroundTransparency = 1
        credits.Parent = bg

        -- Show headers
        TweenService:Create(title, TweenInfo.new(0.8), {TextTransparency = 0}):Play()
        TweenService:Create(subtitle, TweenInfo.new(1), {TextTransparency = 0}):Play()
        task.wait(1.2)

        local stages = config.Stages or {"Loading..."}
        local count = #stages

        coroutine.wrap(function()
            for i, text in ipairs(stages) do
                stageText.Text = text
                TweenService:Create(stageText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
                TweenService:Create(bar, TweenInfo.new(0.6), {
                    Size = UDim2.new(i / count, 0, 1, 0)
                }):Play()
                task.wait(1.2)
                TweenService:Create(stageText, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            end

            TweenService:Create(credits, TweenInfo.new(1), {TextTransparency = 0}):Play()
            task.wait(1.5)

            gui:Destroy()
            if blur then blur:Destroy() end
            if config.OnFinish then config.OnFinish() end
        end)()
    end

    return XeraUI
end
