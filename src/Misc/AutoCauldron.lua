local p = game:GetService("Players").LocalPlayer
local r = game:GetService("ReplicatedStorage")
local w = game:GetService("Workspace")

local b = p:WaitForChild("BackpackTwo")
local add = r.Remotes.TemporaryEvents.AddCauldronItem
local upd = r.Remotes.TemporaryEvents.UpdateCauldronData
local claim = r.Remotes.TemporaryEvents.ClaimCauldron
local equip = r.Remotes.CustomBackpack:WaitForChild("EquipRemote")
local toggleLock = r.Remotes.Inventory.ToggleLock

local progress, quality, endTime = 0, 0, 0
local enabled = true
local autoLock = false
local lastProgress = -1
local timerZeroTime = nil
local stats = {
	itemsSubmitted = 0,
	rewardsClaimed = 0,
	sessionStart = tick()
}

local sg = Instance.new("ScreenGui")
sg.Name = "CauldronUI"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = p:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 360, 0, 460)
main.Position = UDim2.new(0.5, -180, 0.5, -230)
main.BackgroundColor3 = Color3.fromRGB(12, 8, 20)
main.BorderSizePixel = 0
main.Parent = sg

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = main

local mainGlow = Instance.new("UIStroke")
mainGlow.Color = Color3.fromRGB(180, 80, 255)
mainGlow.Thickness = 2
mainGlow.Transparency = 0.3
mainGlow.Parent = main

local dragging, dragInput, dragStart, startPos
main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 10)
headerCorner.Parent = header

local headerCover = Instance.new("Frame")
headerCover.Size = UDim2.new(1, 0, 0, 10)
headerCover.Position = UDim2.new(0, 0, 1, -10)
headerCover.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
headerCover.BorderSizePixel = 0
headerCover.Parent = header

local titleIcon = Instance.new("TextLabel")
titleIcon.Size = UDim2.new(0, 32, 0, 32)
titleIcon.Position = UDim2.new(0, 14, 0, 11)
titleIcon.BackgroundTransparency = 1
titleIcon.Text = "🎃"
titleIcon.TextSize = 26
titleIcon.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -90, 0, 20)
title.Position = UDim2.new(0, 55, 0, 15)
title.BackgroundTransparency = 1
title.Text = "Witch's Cauldron"
title.TextColor3 = Color3.fromRGB(255, 200, 100)
title.TextSize = 15
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center
title.Parent = header



local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -32, 0, 14)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 80)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
	sg:Destroy()
end)

local buttonFrame = Instance.new("Frame")
buttonFrame.Size = UDim2.new(1, -28, 0, 32)
buttonFrame.Position = UDim2.new(0, 14, 0, 70)
buttonFrame.BackgroundTransparency = 1
buttonFrame.Parent = main

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.48, 0, 1, 0)
toggleBtn.Position = UDim2.new(0, 0, 0, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(140, 60, 200)
toggleBtn.Text = "AUTO SUBMIT: ON"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 10
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BorderSizePixel = 0
toggleBtn.Parent = buttonFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 5)
toggleCorner.Parent = toggleBtn

local toggleGlow = Instance.new("UIStroke")
toggleGlow.Color = Color3.fromRGB(180, 100, 255)
toggleGlow.Thickness = 1
toggleGlow.Transparency = 0.5
toggleGlow.Parent = toggleBtn

local lockBtn = Instance.new("TextButton")
lockBtn.Size = UDim2.new(0.48, 0, 1, 0)
lockBtn.Position = UDim2.new(0.52, 0, 0, 0)
lockBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
lockBtn.Text = "AUTO LOCK: OFF"
lockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
lockBtn.TextSize = 10
lockBtn.Font = Enum.Font.GothamBold
lockBtn.BorderSizePixel = 0
lockBtn.Parent = buttonFrame

local lockCorner = Instance.new("UICorner")
lockCorner.CornerRadius = UDim.new(0, 5)
lockCorner.Parent = lockBtn

local lockGlow = Instance.new("UIStroke")
lockGlow.Color = Color3.fromRGB(100, 80, 120)
lockGlow.Thickness = 1
lockGlow.Transparency = 0.5
lockGlow.Parent = lockBtn

local cauldronFrame = Instance.new("Frame")
cauldronFrame.Size = UDim2.new(1, -28, 0, 130)
cauldronFrame.Position = UDim2.new(0, 14, 0, 117)
cauldronFrame.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
cauldronFrame.BorderSizePixel = 0
cauldronFrame.Parent = main

local cauldronCorner = Instance.new("UICorner")
cauldronCorner.CornerRadius = UDim.new(0, 8)
cauldronCorner.Parent = cauldronFrame

local cauldronStroke = Instance.new("UIStroke")
cauldronStroke.Color = Color3.fromRGB(80, 40, 120)
cauldronStroke.Thickness = 1
cauldronStroke.Transparency = 0.5
cauldronStroke.Parent = cauldronFrame

local statusIcon = Instance.new("TextLabel")
statusIcon.Size = UDim2.new(0, 48, 0, 48)
statusIcon.Position = UDim2.new(0, 14, 0, 12)
statusIcon.BackgroundTransparency = 1
statusIcon.Text = "🔮"
statusIcon.TextSize = 38
statusIcon.Parent = cauldronFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -80, 0, 20)
statusLabel.Position = UDim2.new(0, 70, 0, 12)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Initializing..."
statusLabel.TextColor3 = Color3.fromRGB(200, 180, 240)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = cauldronFrame

local statusDot = Instance.new("Frame")
statusDot.Size = UDim2.new(0, 8, 0, 8)
statusDot.Position = UDim2.new(1, -20, 0, 18)
statusDot.BackgroundColor3 = Color3.fromRGB(150, 150, 170)
statusDot.BorderSizePixel = 0
statusDot.Parent = cauldronFrame

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = statusDot

local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(1, -80, 0, 28)
timerLabel.Position = UDim2.new(0, 70, 0, 34)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "--:--"
timerLabel.TextColor3 = Color3.fromRGB(255, 180, 80)
timerLabel.TextSize = 20
timerLabel.Font = Enum.Font.GothamBold
timerLabel.TextXAlignment = Enum.TextXAlignment.Left
timerLabel.Parent = cauldronFrame

local progressLabel = Instance.new("TextLabel")
progressLabel.Size = UDim2.new(1, -28, 0, 16)
progressLabel.Position = UDim2.new(0, 14, 0, 72)
progressLabel.BackgroundTransparency = 1
progressLabel.Text = "PROGRESS"
progressLabel.TextColor3 = Color3.fromRGB(140, 120, 180)
progressLabel.TextSize = 9
progressLabel.Font = Enum.Font.GothamBold
progressLabel.TextXAlignment = Enum.TextXAlignment.Left
progressLabel.Parent = cauldronFrame

local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(1, -28, 0, 30)
progressBg.Position = UDim2.new(0, 14, 0, 90)
progressBg.BackgroundColor3 = Color3.fromRGB(8, 5, 12)
progressBg.BorderSizePixel = 0
progressBg.Parent = cauldronFrame

local progressBgCorner = Instance.new("UICorner")
progressBgCorner.CornerRadius = UDim.new(0, 6)
progressBgCorner.Parent = progressBg

local progressBgStroke = Instance.new("UIStroke")
progressBgStroke.Color = Color3.fromRGB(60, 30, 90)
progressBgStroke.Thickness = 1
progressBgStroke.Transparency = 0.6
progressBgStroke.Parent = progressBg

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(140, 60, 200)
progressFill.BorderSizePixel = 0
progressFill.Parent = progressBg

local progressFillCorner = Instance.new("UICorner")
progressFillCorner.CornerRadius = UDim.new(0, 6)
progressFillCorner.Parent = progressFill

local progressGradient = Instance.new("UIGradient")
progressGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 80, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 100))
}
progressGradient.Parent = progressFill

local progressText = Instance.new("TextLabel")
progressText.Size = UDim2.new(1, 0, 1, 0)
progressText.BackgroundTransparency = 1
progressText.Text = "0 / 10 Items"
progressText.TextColor3 = Color3.fromRGB(240, 240, 250)
progressText.TextSize = 12
progressText.Font = Enum.Font.GothamBold
progressText.ZIndex = 2
progressText.Parent = progressBg

local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(1, -28, 0, 85)
statsFrame.Position = UDim2.new(0, 14, 0, 262)
statsFrame.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
statsFrame.BorderSizePixel = 0
statsFrame.Parent = main

local statsCorner = Instance.new("UICorner")
statsCorner.CornerRadius = UDim.new(0, 8)
statsCorner.Parent = statsFrame

local statsStroke = Instance.new("UIStroke")
statsStroke.Color = Color3.fromRGB(80, 40, 120)
statsStroke.Thickness = 1
statsStroke.Transparency = 0.5
statsStroke.Parent = statsFrame

local function createStat(pos, icon, label, value)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(0.333, -8, 1, 0)
	container.Position = UDim2.new(pos * 0.333, pos > 0 and 4 or 0, 0, 0)
	container.BackgroundTransparency = 1
	container.Parent = statsFrame
	
	local statIcon = Instance.new("TextLabel")
	statIcon.Size = UDim2.new(1, 0, 0, 26)
	statIcon.Position = UDim2.new(0, 0, 0, 10)
	statIcon.BackgroundTransparency = 1
	statIcon.Text = icon
	statIcon.TextSize = 22
	statIcon.Parent = container
	
	local statValue = Instance.new("TextLabel")
	statValue.Size = UDim2.new(1, 0, 0, 20)
	statValue.Position = UDim2.new(0, 0, 0, 36)
	statValue.BackgroundTransparency = 1
	statValue.Text = value
	statValue.TextColor3 = Color3.fromRGB(255, 200, 100)
	statValue.TextSize = 16
	statValue.Font = Enum.Font.GothamBold
	statValue.Parent = container
	
	local statLabel = Instance.new("TextLabel")
	statLabel.Size = UDim2.new(1, 0, 0, 14)
	statLabel.Position = UDim2.new(0, 0, 0, 58)
	statLabel.BackgroundTransparency = 1
	statLabel.Text = label
	statLabel.TextColor3 = Color3.fromRGB(140, 120, 180)
	statLabel.TextSize = 9
	statLabel.Font = Enum.Font.Gotham
	statLabel.Parent = container
	
	return statValue
end

local itemsLabel = createStat(0, "📦", "SUBMITTED", "0")
local rewardsLabel = createStat(1, "✨", "REWARDS", "0")
local uptimeLabel = createStat(2, "⏱️", "UPTIME", "00:00")

local logFrame = Instance.new("Frame")
logFrame.Size = UDim2.new(1, -28, 0, 90)
logFrame.Position = UDim2.new(0, 14, 0, 362)
logFrame.BackgroundColor3 = Color3.fromRGB(8, 5, 12)
logFrame.BorderSizePixel = 0
logFrame.Parent = main

local logCorner = Instance.new("UICorner")
logCorner.CornerRadius = UDim.new(0, 8)
logCorner.Parent = logFrame

local logStroke = Instance.new("UIStroke")
logStroke.Color = Color3.fromRGB(60, 30, 90)
logStroke.Thickness = 1
logStroke.Transparency = 0.6
logStroke.Parent = logFrame

local logTitle = Instance.new("TextLabel")
logTitle.Size = UDim2.new(1, -20, 0, 18)
logTitle.Position = UDim2.new(0, 10, 0, 4)
logTitle.BackgroundTransparency = 1
logTitle.Text = "ACTIVITY LOG"
logTitle.TextColor3 = Color3.fromRGB(140, 120, 180)
logTitle.TextSize = 9
logTitle.Font = Enum.Font.GothamBold
logTitle.TextXAlignment = Enum.TextXAlignment.Left
logTitle.Parent = logFrame

local logContainer = Instance.new("ScrollingFrame")
logContainer.Size = UDim2.new(1, -14, 1, -28)
logContainer.Position = UDim2.new(0, 7, 0, 24)
logContainer.BackgroundTransparency = 1
logContainer.BorderSizePixel = 0
logContainer.ScrollBarThickness = 3
logContainer.ScrollBarImageColor3 = Color3.fromRGB(140, 60, 200)
logContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
logContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
logContainer.Parent = logFrame

local logLayout = Instance.new("UIListLayout")
logLayout.Padding = UDim.new(0, 1)
logLayout.SortOrder = Enum.SortOrder.LayoutOrder
logLayout.Parent = logContainer

local function fmt(t)
	t = math.max(0, math.floor(t))
	local m, s = math.floor(t / 60), t % 60
	return string.format("%02d:%02d", m, s)
end

local function addLog(text, color)
	local log = Instance.new("TextLabel")
	log.Size = UDim2.new(1, -8, 0, 14)
	log.BackgroundTransparency = 1
	log.Text = os.date("[%H:%M:%S] ") .. text
	log.TextColor3 = color or Color3.fromRGB(180, 160, 200)
	log.TextSize = 9
	log.Font = Enum.Font.Code
	log.TextXAlignment = Enum.TextXAlignment.Left
	log.TextWrapped = true
	log.Parent = logContainer
	
	if # logContainer:GetChildren() > 100 then
		logContainer:GetChildren()[2]:Destroy()
	end
	
	logContainer.CanvasPosition = Vector2.new(0, logContainer.AbsoluteCanvasSize.Y)
end

local function updateStatus(state, color, icon)
	if not enabled then
		statusLabel.Text = "Paused"
		statusDot.BackgroundColor3 = Color3.fromRGB(120, 100, 140)
		statusIcon.Text = "⏸️"
	else
		statusLabel.Text = state
		statusDot.BackgroundColor3 = color
		statusIcon.Text = icon or "🔮"
	end
end

local function updateProgress(current)
	progressFill.Size = UDim2.new(current / 10, 0, 1, 0)
	progressText.Text = current .. " / 10 Items"
end

toggleBtn.MouseButton1Click:Connect(function()
	enabled = not enabled
	if enabled then
		toggleBtn.Text = "AUTO SUBMIT: ON"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(140, 60, 200)
		toggleGlow.Color = Color3.fromRGB(180, 100, 255)
		addLog("Auto submit enabled", Color3.fromRGB(100, 255, 150))
	else
		toggleBtn.Text = "AUTO SUBMIT: OFF"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
		toggleGlow.Color = Color3.fromRGB(100, 80, 120)
		addLog("Auto submit paused", Color3.fromRGB(255, 180, 100))
		updateStatus("Paused", Color3.fromRGB(120, 100, 140), "⏸️")
	end
end)

lockBtn.MouseButton1Click:Connect(function()
	autoLock = not autoLock
	if autoLock then
		lockBtn.Text = "AUTO LOCK: ON"
		lockBtn.BackgroundColor3 = Color3.fromRGB(140, 60, 200)
		lockGlow.Color = Color3.fromRGB(180, 100, 255)
		addLog("Auto lock enabled", Color3.fromRGB(100, 255, 150))
	else
		lockBtn.Text = "AUTO LOCK: OFF"
		lockBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
		lockGlow.Color = Color3.fromRGB(100, 80, 120)
		addLog("Auto lock disabled", Color3.fromRGB(255, 180, 100))
	end
end)

local function getMod(i)
	local d = i:FindFirstChild("ItemData")
	if not d then
		return
	end
	local ok, m = pcall(function()
		return d:GetAttribute("Modifier")
	end)
	if ok and m then
		return m
	end
	for _, n in ipairs({
		"modifier",
		"Mod",
		"modType"
	}) do
		local v = d:GetAttribute(n)
		if v then
			return v
		end
	end
	local s = d:FindFirstChildWhichIsA("StringValue")
	return s and s.Value
end

local function eligible(i)
	local m = getMod(i)
	return type(m) == "string" and (m:lower():find("spooky") or m:lower():find("ghostly"))
end

local function lockItem(i)
	pcall(function()
		toggleLock:FireServer(i)
	end)
	addLog("Locked: " .. i.Name, Color3.fromRGB(255, 200, 100))
end

local function equipItem(i)
	pcall(function()
		equip:FireServer(i)
	end)
	addLog("Equipped: " .. i.Name, Color3.fromRGB(180, 160, 255))
end

local function submitItem(i)
	local ok, res = pcall(function()
		return add:InvokeServer(i)
	end)
	if ok and res then
		stats.itemsSubmitted = stats.itemsSubmitted + 1
		itemsLabel.Text = tostring(stats.itemsSubmitted)
		addLog("Submitted: " .. i.Name, Color3.fromRGB(100, 255, 150))
	end
	return ok and res
end

local function claimReward()
	pcall(function()
		claim:InvokeServer()
	end)
	stats.rewardsClaimed = stats.rewardsClaimed + 1
	rewardsLabel.Text = tostring(stats.rewardsClaimed)
	addLog("Claimed reward!", Color3.fromRGB(255, 200, 100))
end

b.ChildAdded:Connect(function(item)
	if autoLock and eligible(item) then
		task.wait(0.1)
		lockItem(item)
	end
end)

upd.OnClientEvent:Connect(function(c, q, e)
	progress, quality, endTime = c or 0, q or 0, e or 0
	
	if progress ~= lastProgress then
		updateProgress(progress)
		lastProgress = progress
	end
	
	local synced = w:GetAttribute("SyncedTime") or 0
	local remain = (endTime - synced) + 1800
	local brewing = (progress >= 10) and not ((remain <= 0) or w:GetAttribute("WitchesBrew"))
	
	if brewing then
		updateStatus("Brewing Potion...", Color3.fromRGB(255, 140, 60), "⚗️")
	elseif progress >= 10 then
		updateStatus("Ready to Claim!", Color3.fromRGB(100, 255, 150), "✨")
	else
		updateStatus("Collecting Items", Color3.fromRGB(140, 120, 255), "🔍")
	end
end)

task.spawn(function()
	addLog("Witch's cauldron initialized", Color3.fromRGB(180, 140, 255))
	task.wait(3)
	upd:FireServer()
	while task.wait(1) do
		if not enabled then 
			timerZeroTime = nil
			continue 
		end
		
		local synced = w:GetAttribute("SyncedTime") or 0
		local remain = (endTime - synced) + 1800
		local brewing = (progress >= 10) and not ((remain <= 0) or w:GetAttribute("WitchesBrew"))
		
		if brewing then
			timerLabel.Text = fmt(remain)
		elseif progress >= 10 then
			timerLabel.Text = "READY"
		else
			timerLabel.Text = "ACTIVE"
		end
		
		if remain <= 0 and progress >= 10 then
			if not timerZeroTime then
				timerZeroTime = tick()
				addLog("Timer reached 0, waiting 5 seconds...", Color3.fromRGB(255, 200, 100))
			elseif tick() - timerZeroTime >= 5 then
				addLog("Claiming reward...", Color3.fromRGB(100, 255, 150))
				claimReward()
				timerZeroTime = nil
				task.wait(3)
			end
		else
			timerZeroTime = nil
		end
		
		if progress < 10 and (tick() % 2) < 1 then
			local found = {}
			for _, i in ipairs(b:GetChildren()) do
				if eligible(i) then
					table.insert(found, i)
				end
			end
			
			if # found > 0 then
				addLog("Found " .. # found .. " spooky items", Color3.fromRGB(255, 180, 100))
				for _, i in ipairs(found) do
					if progress >= 10 then 
						addLog("Cauldron full!", Color3.fromRGB(255, 140, 60))
						break 
					end
					equipItem(i)
					task.wait(0.3)
					if submitItem(i) then 
						task.wait(0.8)
					else
						addLog("Failed to submit", Color3.fromRGB(255, 100, 100))
						break
					end
				end
			end
		end
	end
end)

task.spawn(function()
	while task.wait(1) do
		local elapsed = tick() - stats.sessionStart
		uptimeLabel.Text = fmt(elapsed)
	end
end)

addLog("Ready to brew!", Color3.fromRGB(255, 200, 100))