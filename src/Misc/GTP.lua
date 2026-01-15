local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local AUTO_LOOP_DELAY = 0.1

local currentModelIndex = 1
local autoLoopEnabled = false
local lastAutoTeleportTime = 0
local teleportConnection

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GT"
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
title.BorderSizePixel = 0
title.Text = "Geode Teleporter | BETA "
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.Parent = frame

local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0.9, 0, 0, 35)
teleportButton.Position = UDim2.new(0.05, 0, 0, 40)
teleportButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
teleportButton.BorderSizePixel = 1
teleportButton.BorderColor3 = Color3.new(0.1, 0.4, 0.1)
teleportButton.Text = "Teleport to Next Model"
teleportButton.TextColor3 = Color3.new(1, 1, 1)
teleportButton.TextScaled = true
teleportButton.Font = Enum.Font.SourceSans
teleportButton.Parent = frame

local autoLoopButton = Instance.new("TextButton")
autoLoopButton.Size = UDim2.new(0.9, 0, 0, 35)
autoLoopButton.Position = UDim2.new(0.05, 0, 0, 85)
autoLoopButton.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
autoLoopButton.BorderSizePixel = 1
autoLoopButton.BorderColor3 = Color3.new(0.4, 0.1, 0.1)
autoLoopButton.Text = "Auto Loop: OFF"
autoLoopButton.TextColor3 = Color3.new(1, 1, 1)
autoLoopButton.TextScaled = true
autoLoopButton.Font = Enum.Font.SourceSans
autoLoopButton.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0, 60)
statusLabel.Position = UDim2.new(0.05, 0, 0, 130)
statusLabel.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
statusLabel.BorderSizePixel = 1
statusLabel.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
statusLabel.Text = "Ready to teleport"
statusLabel.TextColor3 = Color3.new(1, 1, 1)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextWrapped = true
statusLabel.Parent = frame

local function getGeodeModels()
	local geodeFolder = workspace:FindFirstChild("Geode")
	if not geodeFolder then
		return {}
	end
	local models = {}
	for _, child in pairs(geodeFolder:GetChildren()) do
		if child:IsA("Model") then
			table.insert(models, child)
		end
	end
	return models
end

local function getTeleportPosition(model)
	local cf, size = model:GetBoundingBox()
	return cf.Position
end

local function teleportToPosition(position)
	local character = player.Character
	if not character then
		return false
	end
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return false
	end
	humanoidRootPart.CFrame = CFrame.new(position)
	return true
end

local function teleportToNextModel()
	local models = getGeodeModels()
	if # models == 0 then
		statusLabel.Text = "No models found in workspace.Geode"
		return false
	end
	if currentModelIndex > # models then
		currentModelIndex = 1
	end
	local targetModel = models[currentModelIndex]
	local teleportPosition = getTeleportPosition(targetModel)
	if teleportToPosition(teleportPosition) then
		statusLabel.Text = string.format("Teleported to: %s (%d/%d)", targetModel.Name, currentModelIndex, # models)
		currentModelIndex = currentModelIndex + 1
		return true
	else
		statusLabel.Text = "Failed to teleport - Character not found"
		return false
	end
end

teleportButton.MouseButton1Click:Connect(function()
	teleportToNextModel()
end)

autoLoopButton.MouseButton1Click:Connect(function()
	autoLoopEnabled = not autoLoopEnabled
	if autoLoopEnabled then
		autoLoopButton.Text = "Auto Loop: ON"
		autoLoopButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
		autoLoopButton.BorderColor3 = Color3.new(0.1, 0.4, 0.1)
		lastAutoTeleportTime = tick()
		teleportConnection = RunService.Heartbeat:Connect(function()
			if autoLoopEnabled and tick() - lastAutoTeleportTime >= AUTO_LOOP_DELAY then
				teleportToNextModel()
				lastAutoTeleportTime = tick()
			end
		end)
	else
		autoLoopButton.Text = "Auto Loop: OFF"
		autoLoopButton.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
		autoLoopButton.BorderColor3 = Color3.new(0.4, 0.1, 0.1)
		if teleportConnection then
			teleportConnection:Disconnect()
			teleportConnection = nil
		end
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	if input.KeyCode == Enum.KeyCode.T then
		teleportToNextModel()
	elseif input.KeyCode == Enum.KeyCode.L then
		autoLoopButton.MouseButton1Click:Fire()
	end
end)

local models = getGeodeModels()
if # models > 0 then
	statusLabel.Text = string.format("Found %d models in workspace.Geode\nPress T to teleport or L for auto loop", # models)
else
	statusLabel.Text = "No models found in workspace.Geode"
end

print("Controls:")
print("- Click 'Teleport to Next Model' or press T to manually teleport")
print("- Click 'Auto Loop' or press L to toggle automatic teleporting")
print("- Auto loop teleports every " .. AUTO_LOOP_DELAY .. " seconds")