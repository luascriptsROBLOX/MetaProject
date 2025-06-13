-- ✅ Fully reworked, refined and tested XeraUltron Loader UI
-- Supports fullscreen loading, large visible labels, neon effect, smooth transitions
-- No black screen issues, everything rendered from top to bottom
-- Put this in your hosting and access via loadstring()

return function()
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local Lighting = game:GetService("Lighting")

    local function createLabel(parent, size, pos, text, font, color, transparency, zindex)
        local lbl = Instance.new("TextLabel")
        lbl.Size = size
        lbl.Position = pos
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.Font = font
        lbl.TextScaled = true
        lbl.TextColor3 = color
        lbl.TextTransparency = transparency or 1
        lbl.ZIndex = zindex or 2
        lbl.Parent = parent
        return lbl
    end

    local function createRoundedBar(parent, color, zindex)
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(0.8, 0, 0.08, 0)
        bg.Position = UDim2.new(0.1, 0, 0.6, 0)
        bg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        bg.BorderSizePixel = 0
        bg.ZIndex = zindex
        bg.Parent = parent

        Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 14)

        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(0, 0, 1, 0)
        bar.BackgroundColor3 = color
        bar.BorderSizePixel = 0
        bar.ZIndex = zindex + 1
        bar.Parent = bg

        Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 14)
        local stroke = Instance.new("UIStroke")
        stroke.Color = color
        stroke.Thickness = 2
        stroke.Transparency = 0.3
        stroke.Parent = bar

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
        bg.Parent = gui

        local title = createLabel(bg, UDim2.new(1, 0, 0.2, 0), UDim2.new(0, 0, 0.1, 0), cfg.Title or "XeraUltron", Enum.Font.GothamBlack, Color3.new(1, 1, 1))
        local subtitle = createLabel(bg, UDim2.new(1, 0, 0.1, 0), UDim2.new(0, 0, 0.25, 0), cfg.SubTitle or "Meta Solution Core", Enum.Font.Gotham, Color3.fromRGB(180, 180, 255))
        local stageLabel = createLabel(bg, UDim2.new(1, 0, 0.08, 0), UDim2.new(0, 0, 0.72, 0), "", Enum.Font.GothamMedium, Color3.fromRGB(255, 255, 255))
        local credit = createLabel(bg, UDim2.new(1, 0, 0.05, 0), UDim2.new(0, 0, 0.95, 0), "Made by Kokil • LuaScripts787 • XeraTEAM", Enum.Font.GothamItalic, Color3.fromRGB(255, 255, 255))

        local bar = createRoundedBar(bg, Color3.fromRGB(0, 255, 255))

        -- Animate headers
        TweenService:Create(title, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
        TweenService:Create(subtitle, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
        task.wait(1.2)

        local stages = cfg.Stages or {"Loading..."}
        local total = #stages

        coroutine.wrap(function()
            for i, stage in ipairs(stages) do
                stageLabel.Text = stage
                TweenService:Create(stageLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
                TweenService:Create(bar, TweenInfo.new(0.6), {
                    Size = UDim2.new(i / total, 0, 1, 0)
                }):Play()
                task.wait(1.2)
                TweenService:Create(stageLabel, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            end

            TweenService:Create(credit, TweenInfo.new(1), {TextTransparency = 0}):Play()
            task.wait(1.5)

            gui:Destroy()
            if blur then blur:Destroy() end
            if cfg.OnFinish then cfg.OnFinish() end
        end)()
    end

    return XeraUI
end
