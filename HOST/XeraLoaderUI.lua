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
		pcall(function()
			local blur = Instance.new("BlurEffect")
			blur.Size = 20
			blur.Name = "XeraUILoaderBlur"
			blur.Parent = Lighting
		end)

		local Title = config.Title or "XeraUltron"
		local SubTitle = config.SubTitle or "Meta Solution Core"
		local Stages = config.Stages or { "Starting..." }
		local OnFinish = config.OnFinish or function() end

		-- Main Container
		local container = Instance.new("Frame", gui)
		container.Size = UDim2.new(1, 0, 1, 0)
		container.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
		container.BackgroundTransparency = 0

		-- Center Box
		local center = Instance.new("Frame", container)
		center.AnchorPoint = Vector2.new(0.5, 0.5)
		center.Position = UDim2.new(0.5, 0, 0.5, 0)
		center.Size = UDim2.new(0.7, 0, 0.5, 0)
		center.BackgroundTransparency = 1

		-- Title
		local titleLabel = Instance.new("TextLabel", center)
		titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
		titleLabel.Position = UDim2.new(0, 0, 0, 0)
		titleLabel.BackgroundTransparency = 1
		titleLabel.Text = Title
		titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		titleLabel.Font = Enum.Font.FredokaOne
		titleLabel.TextScaled = true
		titleLabel.TextTransparency = 1

		-- Subtitle
		local subLabel = Instance.new("TextLabel", center)
		subLabel.Size = UDim2.new(1, 0, 0.15, 0)
		subLabel.Position = UDim2.new(0, 0, 0.25, 0)
		subLabel.BackgroundTransparency = 1
		subLabel.Text = SubTitle
		subLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
		subLabel.Font = Enum.Font.Gotham
		subLabel.TextScaled = true
		subLabel.TextTransparency = 1

		-- Progress bar holder
		local barHolder = Instance.new("Frame", center)
		barHolder.Size = UDim2.new(0.8, 0, 0.07, 0)
		barHolder.Position = UDim2.new(0.1, 0, 0.47, 0)
		barHolder.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
		local barCorner = Instance.new("UICorner", barHolder)
		barCorner.CornerRadius = UDim.new(0, 12)

		local progressBar = Instance.new("Frame", barHolder)
		progressBar.Size = UDim2.new(0, 0, 1, 0)
		progressBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
		Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 12)
		progressBar.Parent = barHolder

		-- Stage Text
		local stageText = Instance.new("TextLabel", center)
		stageText.Size = UDim2.new(1, 0, 0.1, 0)
		stageText.Position = UDim2.new(0, 0, 0.6, 0)
		stageText.BackgroundTransparency = 1
		stageText.TextColor3 = Color3.fromRGB(255, 255, 255)
		stageText.Font = Enum.Font.GothamBold
		stageText.TextScaled = true
		stageText.TextTransparency = 1
		stageText.Text = ""

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

		-- Animate In
		TweenService:Create(titleLabel, TweenInfo.new(1), { TextTransparency = 0 }):Play()
		TweenService:Create(subLabel, TweenInfo.new(1.2), { TextTransparency = 0 }):Play()
		task.wait(1.2)

		coroutine.wrap(function()
			for i, msg in ipairs(Stages) do
				stageText.Text = msg
				TweenService:Create(stageText, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
				TweenService:Create(progressBar, TweenInfo.new(0.7), {
					Size = UDim2.new(i / #Stages, 0, 1, 0)
				}):Play()
				task.wait(1.2)
				TweenService:Create(stageText, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
				task.wait(0.2)
			end

			TweenService:Create(credits, TweenInfo.new(1), { TextTransparency = 0 }):Play()
			task.wait(2)

			gui:Destroy()
			local blur = Lighting:FindFirstChild("XeraUILoaderBlur")
			if blur then blur:Destroy() end

			OnFinish()
		end)()
	end

	return XeraUI
end
