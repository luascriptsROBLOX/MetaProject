-- ✅ Final XeraUltron Loader UI (Clean, Large, Full Render, No Logo)
return function()
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local Lighting = game:GetService("Lighting")

    local function createLabel(parent, size, pos, text, font, color, zindex)
        local lbl = Instance.new("TextLabel")
        lbl.Size = size
        lbl.Position = pos
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.Font = font
        lbl.TextScaled = true
        lbl.TextColor3 = color
        lbl.TextTransparency = 1
        lbl.ZIndex = zindex or 10
        lbl.Parent = parent
        return lbl
    end

    local function createRoundedBar(parent, color)
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(0.8, 0, 0.06, 0)
        bg.Position = UDim2.new(0.1, 0, 0.7, 0)
        bg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        bg.BorderSizePixel = 0
        bg.ZIndex = 9
        bg.Parent = parent

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = bg

        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(0, 0, 1, 0)
        bar.Position = UDim2.new(0, 0, 0, 0)
        bar.BackgroundColor3 = color
        bar.BorderSizePixel = 0
        bar.ZIndex = 10
        bar.Parent = bg

        local corner2 = Instance.new("UICorner")
        corner2.CornerRadius = UDim.new(0, 12)
        corner2.Parent = bar

        local glow = Instance.new("UIStroke")
        glow.Thickness = 2
        glow.Color = color
        glow.Transparency = 0.3
        glow.Parent = bar

        return bar
    end

    local XeraUI = {}

    function XeraUI:Start(cfg)
        local player = Players.LocalPlayer

        local gui = Instance.new("ScreenGui")
        gui.Name = "XeraLoaderUI"
        gui.IgnoreGuiInset = true
        gui.ResetOnSpawn = false
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Parent = player:WaitForChild("PlayerGui")

        local blur = Instance.new("BlurEffect")
        blur.Size = 20
        blur.Parent = Lighting

        local bg = Instance.new("Frame")
        bg.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundTransparency = 1
        bg.ZIndex = 5
        bg.Parent = gui
        TweenService:Create(bg, TweenInfo.new(1), {BackgroundTransparency = 0}):Play()

        local title = createLabel(bg, UDim2.new(1, 0, 0.18, 0), UDim2.new(0, 0, 0.13, 0), cfg.Title or "XeraUltron", Enum.Font.GothamBlack, Color3.new(1, 1, 1))
        local subtitle = createLabel(bg, UDim2.new(1, 0, 0.1, 0), UDim2.new(0, 0, 0.27, 0), cfg.SubTitle or "Meta Solution Core", Enum.Font.GothamSemibold, Color3.fromRGB(180, 180, 255))
        local stageLabel = createLabel(bg, UDim2.new(1, 0, 0.07, 0), UDim2.new(0, 0, 0.82, 0), "", Enum.Font.GothamMedium, Color3.fromRGB(255, 255, 255))
        local credit = createLabel(bg, UDim2.new(1, 0, 0.04, 0), UDim2.new(0, 0, 0.95, 0), "Made by Kokil • LuaScripts787 • XeraTEAM", Enum.Font.GothamItalic, Color3.fromRGB(255, 255, 255))

        local bar = createRoundedBar(bg, Color3.fromRGB(0, 255, 255))

        TweenService:Create(title, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
        TweenService:Create(subtitle, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
        task.wait(1.2)

        local stages = cfg.Stages or {"Loading..."}
        local total = #stages

        coroutine.wrap(function()
            for i, stage in ipairs(stages) do
                stageLabel.Text = stage
                TweenService:Create(stageLabel, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
                TweenService:Create(bar, TweenInfo.new(0.4), {
                    Size = UDim2.new(i / total, 0, 1, 0)
                }):Play()
                task.wait(1.1)
                TweenService:Create(stageLabel, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            end

            TweenService:Create(credit, TweenInfo.new(1), {TextTransparency = 0}):Play()
            task.wait(1.3)

            gui:Destroy()
            if blur then blur:Destroy() end
            if cfg.OnFinish then cfg.OnFinish() end
        end)()
    end

    return XeraUI
end
