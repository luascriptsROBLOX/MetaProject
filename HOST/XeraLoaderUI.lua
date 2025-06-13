-- ✅ XeraUltron Loader UI — Refined Final Build (Clean + Fixed)
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
        local barContainer = Instance.new("Frame")
        barContainer.Size = UDim2.new(0.8, 0, 0.06, 0)
        barContainer.Position = UDim2.new(0.1, 0, 0.72, 0)
        barContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        barContainer.BorderSizePixel = 0
        barContainer.ZIndex = 10
        barContainer.Parent = parent

        local bgCorner = Instance.new("UICorner")
        bgCorner.CornerRadius = UDim.new(0, 10)
        bgCorner.Parent = barContainer

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new(0, 0, 1, 0)
        fill.BackgroundColor3 = color
        fill.BorderSizePixel = 0
        fill.ZIndex = 11
        fill.Parent = barContainer

        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(0, 10)
        fillCorner.Parent = fill

        return fill
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
        bg.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundTransparency = 1
        bg.ZIndex = 5
        bg.Parent = gui

        TweenService:Create(bg, TweenInfo.new(0.6), {BackgroundTransparency = 0}):Play()

        local title = createLabel(bg, UDim2.new(1, 0, 0.14, 0), UDim2.new(0, 0, 0.12, 0), cfg.Title or "XeraUltron", Enum.Font.GothamBlack, Color3.new(1, 1, 1))
        local subtitle = createLabel(bg, UDim2.new(1, 0, 0.08, 0), UDim2.new(0, 0, 0.24, 0), cfg.SubTitle or "Meta Solution Core", Enum.Font.GothamMedium, Color3.fromRGB(200, 200, 255))
        local stageText = createLabel(bg, UDim2.new(1, 0, 0.06, 0), UDim2.new(0, 0, 0.85, 0), "", Enum.Font.Gotham, Color3.new(1, 1, 1))
        local credit = createLabel(bg, UDim2.new(1, 0, 0.03, 0), UDim2.new(0, 0, 0.96, 0), "Made by Kokil • LuaScripts787 • XeraTEAM", Enum.Font.GothamItalic, Color3.fromRGB(255, 255, 255))

        local progressBar = createRoundedBar(bg, Color3.fromRGB(0, 255, 255))

        TweenService:Create(title, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
        TweenService:Create(subtitle, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
        task.wait(1)

        local stages = cfg.Stages or {"Loading..."}
        local count = #stages

        coroutine.wrap(function()
            for i, msg in ipairs(stages) do
                stageText.Text = msg
                TweenService:Create(stageText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
                TweenService:Create(progressBar, TweenInfo.new(0.5), {
                    Size = UDim2.new(i / count, 0, 1, 0)
                }):Play()
                task.wait(1)
                TweenService:Create(stageText, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            end

            TweenService:Create(credit, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
            task.wait(1)
            gui:Destroy()
            if blur then blur:Destroy() end
            if cfg.OnFinish then cfg.OnFinish() end
        end)()
    end

    return XeraUI
end
