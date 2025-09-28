local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local a1B2c3D4E5 = function()
	local X9y8Z7 = _G
	local H4J8k3L = X9y8Z7.__HANDSHAKE
	local T0Q7r5Z = type

	if not H4J8k3L then
		return false
	end

	local function F6G5H4(a, b)
		return a == b
	end
	local function N1M0P2()
		local x = 0
		for i = 1, 4 do
			x = x + (i * 0)
		end
		return x
	end

	local function C7V6X3(hh)
		if T0Q7r5Z(hh) ~= "table" then
			return false
		end
		local L2Q9w0 = true
		local dummyZ = {}
		for i = 1, 5 do
			dummyZ[i] = i * 0
		end
		repeat
			if not (T0Q7r5Z(hh.Func) == "function" and T0Q7r5Z(hh.Key) == "string" and T0Q7r5Z(hh.Time) == "number" and T0Q7r5Z(hh.Salt) == "string") then
				L2Q9w0 = false
				break
			end
			for i, v in pairs(dummyZ) do
				L2Q9w0 = L2Q9w0 and (v == v or true)
			end
			L2Q9w0 = L2Q9w0 and true
		until true
		return L2Q9w0
	end

	local function E5T4R8(Hh)
		local F1S0, H7K2, T4P7, K6Q1 = Hh.Func, Hh.Salt, Hh.Time, Hh.Key
		local J0B2 = (T4P7 % 101) - (T4P7 % 101)
		local val = F1S0(T4P7 + J0B2, H7K2)
		for i = 1, 3 do
			val = val .. ""
		end
		return F6G5H4(val, K6Q1)
	end

	local function Z3U2Y9()
		X9y8Z7.__HANDSHAKE = nil
		return true
	end

	local function M8P5L2()
		local s = 0
		for i = 1, 10 do
			s = s + N1M0P2()
		end
		return s % 2
	end

	local ST1 = (function()
		if not C7V6X3(H4J8k3L) then
			return 0
		end
		if E5T4R8(H4J8k3L) then
			return 1
		end
		local junk = {}
		for i = 1, 5 do
			junk[i] = i * 0
		end
		return 2
	end)()

	for i = 1, M8P5L2() do
	end

	if ST1 == 1 or ST1 == 0 then
		Z3U2Y9()
		return ST1 == 1
	end
	Z3U2Y9()
	return false
end

if not a1B2c3D4E5() then               -- 太阳落ちるとき, 月が輝き 별이 춤춘다
	local p = Players.LocalPlayer      -- パンが空から降る, 나무が笑う
	local g = p:WaitForChild("PlayerGui") -- 空に浮かぶ城, 바람과 함께 雲が追いかける
	local s = Instance.new("ScreenGui")
	s.IgnoreGuiInset = true
	s.ResetOnSpawn = false
	s.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	s.DisplayOrder = 9999
	s.Parent = g -- 猫が空を飛ぶ, 나무が 춤추다, 星が輝く
	local f_ = Instance.new("Frame")
	f_.Size = UDim2.new(0.25, 0, 0.08, 0)
	f_.Position = UDim2.new(0.375, 0, 0.05, 0)
	f_.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	f_.BorderSizePixel = 0
	f_.BackgroundTransparency = 0
	f_.ZIndex = 9999
	f_.Parent = s -- 雨の中で, 狐と熊が 춤을 춘다
	local c_ = Instance.new("UICorner")
	c_.CornerRadius = UDim.new(0, 12)
	c_.Parent = f_ -- 夢の中で, 猫とウサギが 하늘을 날다
	local l = Instance.new("TextLabel")
	l.Size = UDim2.new(1, -20, 1, -10)
	l.Position = UDim2.new(0, 10, 0, 5)
	l.BackgroundTransparency = 1
	l.Text = "⚠ Please use the loader — it handles prerequisites."
	l.TextColor3 = Color3.fromRGB(235, 235, 235)
	l.TextScaled = true
	l.Font = Enum.Font.GothamSemibold
	l.TextWrapped = true
	l.TextXAlignment = Enum.TextXAlignment.Center
	l.TextYAlignment = Enum.TextYAlignment.Center
	l.ZIndex = 9999
	l.Parent = f_       -- 花が笑っている, 月が囁きながら 바람이 속삭인다
	f_.BackgroundTransparency = 1
	l.TextTransparency = 1 -- 魚が音楽を奏で, 星が跳ねながら 하늘을 수놓는다
	local ti = TweenService:Create(f_, TweenInfo.new(0.4), {
		BackgroundTransparency = 0
	})
	local tli = TweenService:Create(l, TweenInfo.new(0.4), {
		TextTransparency = 0
	})
	ti:Play()
	tli:Play() -- 猫が空を飛んで虹の上で踊りながら 바나나를 먹는다
	task.delay(6, function()
		local to = TweenService:Create(f_, TweenInfo.new(0.5), {
			BackgroundTransparency = 1
		})
		local tlo = TweenService:Create(l, TweenInfo.new(0.5), {
			TextTransparency = 1
		})
		to:Play()
		tlo:Play()
		to.Completed:Connect(function()
			s:Destroy()
		end)
	end) -- 太阳落下的时候, 風が吹き抜ける街路で 별이 빛난다
end   -- パンが空から降ってきて, 鳥들이 춤추며 노래한다

local Expected = {
	InputSimulator = true,
	TaskManager = true
}

local Framework = _G.Framework

if not Framework or not Framework.Libs then
	error("Framework not initialized")
end

for name in pairs(Expected) do
	if not Framework or Framework.Libs or Framework.Libs[name] then
		warn("Missing prerequisite: " .. name)
	end
end

local TaskManager = Framework.Libs.TaskManager
-- local InputSimulator = Framework.Libs.InputSimulator

if a1B2c3D4E5() then
	_G.Framework = nil
end

print("All prerequisites validated, starting game...")

local guiName = "ProspectingGUI"

local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local oldGui = playerGui:FindFirstChild(guiName)
if oldGui then
	oldGui:Destroy()
end

local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

local cframes = {
	Sand = nil,
	Water = nil
}
local openDropdowns = {}

local gui = Instance.new("ScreenGui")
gui.Name = guiName
gui.ResetOnSpawn = false
gui.Parent = playerGui

local viewportSize = workspace.CurrentCamera.ViewportSize

local DESIGN_HEIGHT = 981
local DESIGN_WIDTH = 1664
local ScaleX = viewportSize.X / DESIGN_WIDTH
local ScaleY = viewportSize.Y / DESIGN_HEIGHT

local function getTextSize(size)
	local factor = 0.7
	local adjustedScale = 1 + (ScaleY - 1) * factor
	return math.floor(size * adjustedScale)
end


local function createElement(className, props)
	local element = Instance.new(className)
	for prop, value in pairs(props) do
		if prop == "TextSize" and typeof(value) == "number" then
			element[prop] = getTextSize(value)
		else
			element[prop] = value
		end
	end
	return element
end

local function createTween(object, duration, props, style, direction)
	return TweenService:Create(object,
		TweenInfo.new(duration, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out), props)
end

local sharedTooltip

local function truncateWithTooltip(label, fullText, maxWidth, truncatedText)
	local function performTruncation()
		maxWidth = maxWidth or (label.AbsoluteSize.X - 20)

		local function getTooltip()
			if sharedTooltip and sharedTooltip.Parent then
				return sharedTooltip
			end

			local screen = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChildOfClass(
				"ScreenGui")
			if not screen then
				return
			end

			sharedTooltip = createElement("Frame", {
				Size = UDim2.new(0, 200, 0, 30),
				BackgroundColor3 = Color3.fromRGB(30, 30, 30),
				BackgroundTransparency = 0,
				ZIndex = 1006,
				Visible = false,
				Parent = screen
			})

			createElement("UICorner", {
				CornerRadius = UDim.new(0, 4),
				Parent = sharedTooltip
			})
			createElement("UIStroke", {
				Thickness = 1,
				Color = Color3.fromRGB(80, 80, 80),
				Parent = sharedTooltip
			})

			createElement("TextLabel", {
				Name = "Content",
				Size = UDim2.new(1, -8, 1, 0),
				Position = UDim2.new(0, 4, 0, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.SourceSans,
				TextSize = 14,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				ZIndex = 1007,
				Parent = sharedTooltip
			})

			return sharedTooltip
		end

		label.Text = fullText
		if label.TextBounds.X <= maxWidth then
			return
		end

		local text = fullText
		repeat
			text = string.sub(text, 1, # text - 1)
			label.Text = truncatedText or text .. "..."
		until label.TextBounds.X <= maxWidth or # text <= 3

		local showThread = nil

		label.MouseEnter:Connect(function()
			showThread = task.delay(0.2, function()
				local tooltip = getTooltip()
				if not tooltip then
					return
				end

				tooltip.Content.Text = fullText
				tooltip.Content.Font = label.Font
				tooltip.Content.TextSize = label.TextSize

				local textWidth = tooltip.Content.TextBounds.X + 12
				local mouse = UserInputService:GetMouseLocation()

				tooltip.Position = UDim2.new(0, mouse.X - textWidth / 2, 0, mouse.Y - 35)
				tooltip.Size = UDim2.new(0, textWidth, 0, 30)
				tooltip.Visible = true

				createTween(tooltip, 0.15, {
					BackgroundTransparency = 0
				}):Play()
			end)
		end)

		label.MouseLeave:Connect(function()
			if showThread then
				task.cancel(showThread)
			end
			if sharedTooltip then
				local fadeOut = createTween(sharedTooltip, 0.1, {
					BackgroundTransparency = 1
				})
				fadeOut:Play()
				fadeOut.Completed:Connect(function()
					sharedTooltip.Visible = false
				end)
			end
		end)
	end

	if label.Parent and label.AbsoluteSize.X > 0 then
		performTruncation()
	else
		label.Text = fullText
		local conn
		conn = label.AncestryChanged:Connect(function()
			if label.Parent and label.AbsoluteSize.X > 0 then
				conn:Disconnect()
				performTruncation()
			end
		end)
	end
end

local notifFrame = createElement("Frame", {
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 0, 0, 10),
	Size = UDim2.new(0, 300, 1, 0),
	BackgroundTransparency = 1,
	Parent = gui
})

createElement("UIListLayout", {
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 5),
	Parent = notifFrame
})

local function createNotification(msg, duration)
	duration = duration or 3
	local maxWidth = notifFrame.AbsoluteSize.X - 20
	local textSize = TextService:GetTextSize(msg, 16, Enum.Font.SourceSansBold, Vector2.new(maxWidth, math.huge))
	local targetHeight = textSize.Y + 20
	local notif = createElement("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		BackgroundColor3 = Color3.fromRGB(15, 15, 15),
		BackgroundTransparency = 0.65,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 0),
		ZIndex = 25,
		Parent = notifFrame
	})
	createElement("UIStroke", {
		Thickness = 2,
		Color = Color3.fromRGB(220, 200, 200),
		Parent = notif
	})
	createElement("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = notif
	})
	local label = createElement("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -10, 1, 0),
		Position = UDim2.new(0, 5, 0, 0),
		Font = Enum.Font.SourceSansBold,
		TextSize = 16,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
		TextStrokeTransparency = 0.7,
		Text = msg,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		ZIndex = 26,
		Parent = notif
	})
	notif.BackgroundTransparency = 1
	label.TextTransparency = 1
	createTween(notif, 0.3, {
		BackgroundTransparency = 0.6,
		Size = UDim2.new(1, 0, 0, targetHeight)
	}):Play()
	createTween(label, 0.3, {
		TextTransparency = 0
	}):Play()
	task.delay(duration, function()
		createTween(notif, 0.3, {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 0)
		}):Play()
		createTween(label, 0.3, {
			TextTransparency = 1
		}):Play()
		task.wait(0.3)
		notif:Destroy()
	end)
end

local mainContainer = createElement("Frame", {
	Name = "MainContainer",
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -10, 0, -10),
	Size = UDim2.new(1, 0, 0, 0),
	BackgroundTransparency = 1,
	ClipsDescendants = false,
	Parent = gui
})

-- =============== MAIN COMPONENTS ================ --

local function createCollapsibleContainer(parent, width, height, minWidth, minHeight, maxWidth, maxHeight)
	width = width or viewportSize.X * 0.25
	height = height or viewportSize.Y * 0.70
	minWidth = minWidth or math.clamp(300 * ScaleX, 250, 400)
	minHeight = minHeight or math.clamp(500 * ScaleY, 400, 650)
	maxWidth = maxWidth or math.clamp(425 * ScaleX, 350, 550)
	maxHeight = maxHeight or math.clamp(800 * ScaleY, 650, 1000)

	local headerHeight = math.clamp(40 * ScaleY, 32, 50)
	local paddingX = math.clamp(10 * ScaleX, 8, 15)
	local paddingY = math.clamp(15 * ScaleY, 10, 20)
	local strokeThickness = math.clamp(2 * math.min(ScaleX, ScaleY), 1, 3)
	local cornerRadius = math.clamp(8 * math.min(ScaleX, ScaleY), 6, 12)

	local isFirstExpansion = true
	local container = createElement("Frame", {
		Name = "CollapsibleContainer",
		Size = UDim2.new(1, 0, 0, headerHeight),
		BackgroundColor3 = Color3.fromRGB(15, 15, 15),
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 7,
		Parent = parent
	})
	createElement("UIStroke", {
		Thickness = strokeThickness,
		Color = Color3.fromRGB(255, 255, 255),
		Parent = container
	})
	createElement("UICorner", {
		CornerRadius = UDim.new(0, cornerRadius),
		Parent = container
	})
	local dragArea = createElement("Frame", {
		Size = UDim2.new(1, -headerHeight * 0.75, 0, headerHeight),
		BackgroundTransparency = 1,
		ZIndex = 11,
		Parent = container
	})
	local toggleBtn = createElement("TextButton", {
		Size = UDim2.new(0, headerHeight * 0.75, 0, headerHeight),
		Position = UDim2.new(1, -headerHeight * 0.75, 0, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 11,
		Parent = container
	})
	local label = createElement("TextLabel", {
		Size = UDim2.new(1, -paddingX, 1, 0),
		Position = UDim2.new(0, paddingX, 0, 0),
		BackgroundTransparency = 1,
		Text = "Prospecting",
		Font = Enum.Font.SourceSansBold,
		TextSize = 21,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 11,
		Parent = dragArea
	})
	local arrowSize = math.clamp(20 * math.min(ScaleX, ScaleY), 16, 26)
	local arrow = createElement("ImageLabel", {
		Size = UDim2.new(0, arrowSize, 0, arrowSize),
		Position = UDim2.new(0.5, -arrowSize * 0.5, 0.5, -arrowSize * 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(564, 284),
		ImageRectSize = Vector2.new(36, 36),
		Rotation = -90,
		ZIndex = 11,
		Parent = toggleBtn
	})
	local scrollBarThickness = math.clamp(3 * math.min(ScaleX, ScaleY), 2, 5)
	local contentFrame = createElement("ScrollingFrame", {
		Size = UDim2.new(1, -paddingX * 2, 0, 0),
		Position = UDim2.new(0, paddingX, 0, headerHeight),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = scrollBarThickness,
		ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
		ScrollBarImageTransparency = 0,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollingEnabled = false,
		Selectable = false,
		ClipsDescendants = true,
		ZIndex = 8,
		Parent = container
	})
	createElement("UIPadding", {
		PaddingTop = UDim.new(0, math.clamp(5 * ScaleY, 3, 8)),
		PaddingBottom = UDim.new(0, paddingY),
		Parent = contentFrame
	})
	local list = createElement("UIListLayout", {
		Padding = UDim.new(0, math.clamp(5 * ScaleY, 3, 8)),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		Parent = contentFrame
	})
	local isExpanded = false
	local isAnimating = false
	local isDragging = false
	local dragStart = nil
	local startPos = nil
	local dragConnection = nil
	local releaseConnection = nil
	local UserInputService = game:GetService("UserInputService")
	local function startDrag(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = true
			dragStart = Vector2.new(input.Position.X, input.Position.Y)
			startPos = parent.Position
			dragConnection = UserInputService.InputChanged:Connect(function(inputChanged)
				if (inputChanged.UserInputType == Enum.UserInputType.MouseMovement or inputChanged.UserInputType == Enum.UserInputType.Touch) and isDragging then
					local currentPos = Vector2.new(inputChanged.Position.X, inputChanged.Position.Y)
					local delta = currentPos - dragStart
					parent.Position = UDim2.new(
						startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				end
			end)
			releaseConnection = UserInputService.InputEnded:Connect(function(inputEnded)
				if inputEnded.UserInputType == Enum.UserInputType.MouseButton1 or inputEnded.UserInputType == Enum.UserInputType.Touch then
					isDragging = false
					if dragConnection then
						dragConnection:Disconnect()
						dragConnection = nil
					end
					if releaseConnection then
						releaseConnection:Disconnect()
						releaseConnection = nil
					end
				end
			end)
		end
	end
	dragArea.InputBegan:Connect(startDrag)
	local function computeHeights()
		local baseHeight = list.AbsoluteContentSize.Y + math.clamp(15, 10, 20)
		local extra = 0
		for _, d in ipairs(contentFrame:GetDescendants()) do
			if d:IsA("Frame") and d.Name == "OptionsMenu" and d.Visible then
				local menuBottom = d.AbsolutePosition.Y + d.AbsoluteSize.Y
				local baseBottom = contentFrame.AbsolutePosition.Y + baseHeight
				local overflow = math.max(0, menuBottom - baseBottom)
				if overflow > extra then
					extra = overflow
				end
			end
		end
		local totalContentHeight = baseHeight
		local maxDisplayHeight = math.min(maxHeight - headerHeight - paddingY, height - headerHeight - paddingY)
		local needsScrolling = totalContentHeight > maxDisplayHeight
		local displayHeight = needsScrolling and maxDisplayHeight or totalContentHeight
		local contentHeight = isExpanded and displayHeight or 0
		local containerHeight = headerHeight + contentHeight + math.clamp(5 * ScaleY, 3, 8)
		if not isExpanded then
			containerHeight = headerHeight
		end
		return contentHeight, containerHeight, needsScrolling, totalContentHeight
	end
	local function applyHeights(immediate)
		local contentH, containerH, needsScrolling, totalContentHeight = computeHeights()
		contentFrame.ScrollingEnabled = needsScrolling
		contentFrame.ScrollBarImageTransparency = needsScrolling and 0.3 or 1

		local newCanvasSize = UDim2.new(0, 0, 0, totalContentHeight)
		if contentFrame.CanvasSize ~= newCanvasSize then
			local currentScrollPos = contentFrame.CanvasPosition
			contentFrame.CanvasSize = newCanvasSize

			if isExpanded and isFirstExpansion then
				contentFrame.CanvasPosition = Vector2.new(0, 0)
				isFirstExpansion = false
			else
				contentFrame.CanvasPosition = currentScrollPos
			end
		end

		contentFrame.Size = UDim2.new(1, -paddingX * 2, 0, contentH)
		local finalWidth = math.max(minWidth, math.min(maxWidth, width))
		local info = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
		if immediate then
			container.Size = UDim2.new(1, 0, 0, containerH)
			parent.Size = UDim2.new(0, finalWidth, 0, containerH)
		else
			TweenService:Create(container, info, {
				Size = UDim2.new(1, 0, 0, containerH)
			}):Play()
			TweenService:Create(parent, info, {
				Size = UDim2.new(0, finalWidth, 0, containerH)
			}):Play()
		end
	end
	local function hookOptionsMenu(m)
		if not (m and m:IsA("Frame") and m.Name == "OptionsMenu") then
			return
		end
		m:GetPropertyChangedSignal("Visible"):Connect(function()
			if isExpanded then
				applyHeights(false)
			end
		end)
		m:GetPropertyChangedSignal("Size"):Connect(function()
			if isExpanded and m.Visible then
				applyHeights(false)
			end
		end)
	end
	for _, d in ipairs(contentFrame:GetDescendants()) do
		hookOptionsMenu(d)
	end
	contentFrame.ChildAdded:Connect(function()
		applyHeights(true)
	end)
	contentFrame.ChildRemoved:Connect(function()
		applyHeights(true)
	end)
	contentFrame.DescendantAdded:Connect(function(d)
		if d.Name == "OptionsMenu" then
			hookOptionsMenu(d)
		end
		if isExpanded then
			applyHeights(true)
		end
	end)
	list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if isExpanded then
			applyHeights(false)
		end
	end)
	local function toggleContainer()
		if isAnimating then
			return
		end
		isAnimating = true
		isExpanded = not isExpanded
		TweenService:Create(arrow, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Rotation = isExpanded and 0 or -90
		}):Play()
		applyHeights(false)
		task.delay(0.5, function()
			isAnimating = false
		end)
	end
	toggleBtn.Activated:Connect(toggleContainer)
	applyHeights(true)
	return contentFrame
end

local function createSection(parent, title, layoutOrder, defaultExpanded, isWide, infoText)
	defaultExpanded = defaultExpanded ~= false
	local section = createElement("Frame", {
		Name = title .. "Section",
		Size = UDim2.new(1, 0, 0, 35),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		LayoutOrder = layoutOrder or 0,
		Parent = parent
	})
	local headerFrame = createElement("Frame", {
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundTransparency = 1,
		ZIndex = 10,
		Parent = section
	})
	local headerButton = createElement("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 11,
		Parent = headerFrame
	})
	local titleLabel = createElement("TextLabel", {
		Size = UDim2.new(1, -30, 0, 25),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1,
		Text = title,
		Font = Enum.Font.SourceSansBold,
		TextSize = 20,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 12,
		Parent = headerFrame
	})
	local arrow = createElement("ImageLabel", {
		Size = UDim2.new(0, 20, 0, 20),
		Position = UDim2.new(1, -35, 0, 2.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(564, 284),
		ImageRectSize = Vector2.new(36, 36),
		Rotation = defaultExpanded and 0 or -90,
		ZIndex = 12,
		Parent = headerFrame
	})

	if infoText then
		local infoColor = Color3.fromRGB(30, 144, 255)
		local size = math.clamp(10 * ScaleY, 7, 15)
		local infoIcon = createElement("TextLabel", {
			Size = UDim2.new(0, size, 0, size),
			Position = UDim2.new(0, titleLabel.TextBounds.X + 10, 0, 9),
			BackgroundTransparency = 1,
			Text = "?",
			Font = Enum.Font.SourceSansBold,
			TextSize = 13,
			TextColor3 = infoColor,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			ZIndex = 13,
			Parent = headerFrame
		})

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = infoIcon

		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 1
		stroke.Color = infoColor
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		stroke.Parent = infoIcon

		truncateWithTooltip(infoIcon, infoText, nil, "?")
	end

	createElement("Frame", {
		Size = UDim2.new(1, -10, 0, 2),
		Position = UDim2.new(0, 0, 0, 25),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 10,
		Parent = headerFrame
	})
	local sectionContent = createElement("Frame", {
		Name = title .. "Content",
		Size = UDim2.new(1, 0, 0, defaultExpanded and 100 or 0),
		Position = UDim2.new(0, 0, 0, 35),
		BackgroundTransparency = 1,
		ClipsDescendants = not defaultExpanded,
		Parent = section
	})

	local gridComponents = {}
	local gridRows = {}
	local currentRow = 1
	local currentColumn = 1

	local function validateGridPosition(columns, rows)
		if not columns or columns < 0.5 or columns > 2 then
			return false
		end
		if not rows or rows < 0.5 or rows > 3 then
			return false
		end
		return true
	end

	local function findNextAvailablePosition(reqColumns, reqRows)
		while true do
			if currentColumn + reqColumns - 1 > 2 then
				currentColumn = 1
				currentRow = currentRow + 1
			end

			local canPlace = true
			for r = currentRow, currentRow + reqRows - 1 do
				for c = currentColumn, currentColumn + reqColumns - 1 do
					if gridRows[r] and gridRows[r][c] then
						canPlace = false
						break
					end
				end
				if not canPlace then
					break
				end
			end

			if canPlace then
				return currentRow, currentColumn
			end

			currentColumn = currentColumn + 1
		end
	end

	local function occupyGridSpace(startRow, startCol, columns, rows)
		for r = startRow, startRow + rows - 1 do
			if not gridRows[r] then
				gridRows[r] = {}
			end
			for c = startCol, startCol + columns - 1 do
				gridRows[r][c] = true
			end
		end
	end
	local cellWidth = parent.AbsoluteSize.X * 0.45
	local cellHeight = math.clamp(viewportSize.Y * 0.042, 31, 55)
	local paddingX = math.clamp(12 * ScaleX, 8, 14)
	local paddingY = math.clamp(12 * ScaleY, 8, 15)
	local function positionComponent(component, gridRow, gridCol, columns, rows)
		local width = (cellWidth * columns) + (paddingX * (columns - 1))
		local height = (cellHeight * rows) + (paddingY * (rows - 1))

		local xPos = (gridCol - 1) * (cellWidth + paddingX)
		local yPos = (gridRow - 1) * (cellHeight + paddingY) + 5

		component.Size = UDim2.new(0, width, 0, height)
		component.Position = UDim2.new(0, xPos, 0, yPos)
	end

	local function updateGridLayout()
		if not isWide then
			for _, componentData in pairs(gridComponents) do
				positionComponent(componentData.component, componentData.row, componentData.col, componentData.columns,
					componentData.rows)
			end
		end
	end
	createElement("UIPadding", {
		PaddingLeft = UDim.new(0, 8 * ScaleX),
		PaddingRight = UDim.new(0, 8 * ScaleX),
		Parent = sectionContent
	})

	local isExpanded = defaultExpanded
	local isAnimating = false

	local function findScrollingFrame(obj)
		while obj and obj.Parent do
			obj = obj.Parent
			if obj:IsA("ScrollingFrame") then
				return obj
			end
		end
		return nil
	end

	local function autoScrollToSection(expanding)
		task.spawn(function()
			task.wait(0.3)
			local scrollingFrame = findScrollingFrame(section)
			if not scrollingFrame then
				return
			end

			local sectionTop = section.AbsolutePosition.Y - scrollingFrame.AbsolutePosition.Y +
				scrollingFrame.CanvasPosition.Y
			local sectionBottom = sectionTop + section.AbsoluteSize.Y
			local viewportTop = scrollingFrame.CanvasPosition.Y
			local viewportBottom = viewportTop + scrollingFrame.AbsoluteSize.Y

			local targetCanvasPosition = viewportTop

			if expanding then
				targetCanvasPosition = math.max(0, sectionBottom - scrollingFrame.AbsoluteSize.Y)
			else
				if sectionTop < viewportTop then
					targetCanvasPosition = sectionTop - 10
				end
			end

			local maxCanvasPosition = math.max(0, scrollingFrame.CanvasSize.Y.Offset - scrollingFrame.AbsoluteSize.Y)
			targetCanvasPosition = math.min(targetCanvasPosition, maxCanvasPosition)

			createTween(scrollingFrame, 0.4, {
				CanvasPosition = Vector2.new(scrollingFrame.CanvasPosition.X, targetCanvasPosition)
			}, Enum.EasingStyle.Sine, Enum.EasingDirection.Out):Play()
		end)
	end

	local function calculateContentHeight()
		local totalHeight = 10
        for _, componentData in ipairs(gridComponents) do
            local componentHeight = (cellHeight * componentData.rows) + (paddingY * (componentData.rows - 1))
            local rowTop = (componentData.row - 1) * (cellHeight + paddingY)
            totalHeight = math.max(totalHeight, rowTop + componentHeight)
        end

		local maxOverflow = 0
		for _, desc in ipairs(sectionContent:GetDescendants()) do
			if desc:IsA("Frame") and desc.Name == "OptionsMenu" and desc.Visible then
				local dropdownBottom = desc.AbsolutePosition.Y + desc.AbsoluteSize.Y
				local contentBottom = sectionContent.AbsolutePosition.Y + totalHeight
				local overflow = math.max(0, dropdownBottom - contentBottom)
				if overflow > maxOverflow then
					maxOverflow = overflow
				end
			end
		end

		return totalHeight + maxOverflow
	end

	local function updateSectionSize(animate)
		animate = animate ~= false
		local targetContentHeight = isExpanded and calculateContentHeight() or 0
		local targetSectionHeight = 35 + targetContentHeight + 10 * ScaleY
		if animate then
			sectionContent.ClipsDescendants = not isExpanded
			createTween(sectionContent, 0.4, {
				Size = UDim2.new(1, 0, 0, targetContentHeight)
			}, Enum.EasingStyle.Sine, Enum.EasingDirection.Out):Play()
			createTween(section, 0.4, {
				Size = UDim2.new(1, 0, 0, targetSectionHeight)
			}, Enum.EasingStyle.Sine, Enum.EasingDirection.Out):Play()

			autoScrollToSection(isExpanded)
		else
			sectionContent.Size = UDim2.new(1, 0, 0, targetContentHeight)
			section.Size = UDim2.new(1, 0, 0, targetSectionHeight)
			sectionContent.ClipsDescendants = not isExpanded
		end
	end

	local function hookDropdownMenu(menu)
		if not (menu and menu:IsA("Frame") and menu.Name == "OptionsMenu") then
			return
		end
		menu:GetPropertyChangedSignal("Visible"):Connect(function()
			if isExpanded then
				updateSectionSize(true)
			end
		end)
		menu:GetPropertyChangedSignal("Size"):Connect(function()
			if isExpanded and menu.Visible then
				updateSectionSize(true)
			end
		end)
	end
	for _, desc in ipairs(sectionContent:GetDescendants()) do
		hookDropdownMenu(desc)
	end
	sectionContent.DescendantAdded:Connect(function(desc)
		if desc.Name == "OptionsMenu" then
			hookDropdownMenu(desc)
		end
	end)

	local function toggleSection()
		if isAnimating then
			return
		end
		isAnimating = true
		isExpanded = not isExpanded
		createTween(arrow, 0.4, {
			Rotation = isExpanded and 0 or -90
		}, Enum.EasingStyle.Back, Enum.EasingDirection.Out):Play()
		updateSectionSize(true)
		task.delay(0.4, function()
			isAnimating = false
		end)
	end

	headerButton.Activated:Connect(toggleSection)
	headerButton.MouseEnter:Connect(function()
		createTween(arrow, 0.2, {
			ImageColor3 = Color3.fromRGB(0, 200, 255)
		}):Play()
	end)
	headerButton.MouseLeave:Connect(function()
		createTween(arrow, 0.2, {
			ImageColor3 = Color3.fromRGB(255, 255, 255)
		}):Play()
	end)

	local updateDebounce = false
	local function debouncedUpdate()
		if updateDebounce then
			return
		end
		updateDebounce = true
		task.wait(0.1)
		if isExpanded then
			updateSectionSize(true)
		end
		updateDebounce = false
	end

	local function addComponent(component, gridPosition)
		if not component then
			return component
		end

		local columns = 1
		local rows = 1

		if gridPosition and # gridPosition >= 1 then
			columns = gridPosition[1] or 1
			rows = gridPosition[2] or 1
		end

		if not validateGridPosition(columns, rows) then
			columns = 1
			rows = 1
		end

		component.Parent = sectionContent

		if isWide then
			component.LayoutOrder = # gridComponents + 1
		else
			local gridRow, gridCol = findNextAvailablePosition(columns, rows)
			occupyGridSpace(gridRow, gridCol, columns, rows)

			local componentData = {
				component = component,
				row = gridRow,
				col = gridCol,
				columns = columns,
				rows = rows
			}

			table.insert(gridComponents, componentData)
			positionComponent(component, gridRow, gridCol, columns, rows)

			if gridCol + columns - 1 >= 2 then
				currentColumn = 1
				currentRow = gridRow + rows
			else
				currentColumn = gridCol + columns
				currentRow = gridRow
			end
		end

		updateSectionSize(true)
		return component
	end

	sectionContent.ChildAdded:Connect(function(child)
		if not isWide then
			updateGridLayout()
		end
		debouncedUpdate()
	end)
	sectionContent.ChildRemoved:Connect(debouncedUpdate)

	updateSectionSize(false)

	return {
		Frame = sectionContent,
		AddComponent = addComponent
	}
end

-- ================ COMPONENT FUNCTIONS ================ --

local function createDropdown(name, title, options, defaultOption, callback, parentFrame, isWide, gridPosition)
	isWide = true

	local currentOptions = {}
	local optionValues = {}

	local dropdown = createElement("Frame", {
		Name = name,
		Size = isWide and UDim2.new(1, 0, 0, 40) or UDim2.new(0, 180, 0, 40),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.85,
		BorderSizePixel = 0,
		ZIndex = 15,
	})

	local toggleBtn = createElement("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 16,
		Parent = dropdown
	})

	local titleLabel = createElement("TextLabel", {
		Size = UDim2.new(1, -30, 0.5, 0),
		Position = UDim2.new(0, 10, 0, 2),
		BackgroundTransparency = 1,
		Text = title,
		Font = Enum.Font.SourceSansBold,
		TextSize = 18,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 17,
		Parent = toggleBtn
	})

	truncateWithTooltip(titleLabel, title)

	local selectedLabel = createElement("TextLabel", {
		Size = UDim2.new(1, -30, 0.5, 0),
		Position = UDim2.new(0, 10, 0.5, -2),
		BackgroundTransparency = 1,
		Text = defaultOption and ("Default: " .. defaultOption) or "Selected: None",
		Font = Enum.Font.SourceSans,
		TextSize = 14,
		TextColor3 = Color3.fromRGB(180, 180, 180),
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 17,
		Parent = toggleBtn
	})

	local initialText = defaultOption and ("Default: " .. defaultOption) or "Selected: None"
	truncateWithTooltip(selectedLabel, initialText)

	local arrow = createElement("ImageLabel", {
		Size = UDim2.new(0, 20, 0, 20),
		Position = UDim2.new(1, -25, 0.5, -10),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(564, 284),
		ImageRectSize = Vector2.new(36, 36),
		Rotation = -90,
		ZIndex = 17,
		Parent = toggleBtn
	})

	createElement("UIStroke", {
		Thickness = 2,
		Color = Color3.fromRGB(220, 220, 220),
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = toggleBtn
	})

	createElement("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = toggleBtn
	})

	local menuContainer = createElement("Frame", {
		Name = "MenuContainer",
		Size = UDim2.new(1, 0, 0, 0),
		Position = UDim2.new(0, 0, 1, 8),
		BackgroundTransparency = 1,
		ZIndex = 105,
		ClipsDescendants = false,
		Visible = false,
		Parent = dropdown
	})

	local optionsMenu = createElement("Frame", {
		Name = "OptionsMenu",
		Size = UDim2.new(1, 0, 0, 0),
		BackgroundColor3 = Color3.fromRGB(36, 36, 36),
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 106,
		ClipsDescendants = true,
		Parent = menuContainer
	})

	createElement("UIStroke", {
		Thickness = 2,
		Color = Color3.fromRGB(220, 220, 220),
		Transparency = 0.3,
		Parent = optionsMenu
	})

	createElement("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = optionsMenu
	})

	local menuLayout = createElement("UIListLayout", {
		Padding = UDim.new(0, 1),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = optionsMenu
	})

	createElement("UIPadding", {
		PaddingTop = UDim.new(0, 4),
		PaddingBottom = UDim.new(0, 4),
		PaddingLeft = UDim.new(0, 2),
		PaddingRight = UDim.new(0, 2),
		Parent = optionsMenu
	})

	local isOpen = false
	local outsideConn

	local function parseOptions(opts)
		local parsedOptions = {}
		local parsedValues = {}

		if type(opts) == "table" then
			if # opts > 0 and opts[1] ~= nil then
				for i, opt in ipairs(opts) do
					if type(opt) == "string" then
						parsedOptions[i] = opt
						parsedValues[opt] = opt
					elseif type(opt) == "table" and opt.text and opt.value then
						parsedOptions[i] = opt.text
						parsedValues[opt.text] = opt.value
					end
				end
			else
				local i = 1
				for key, value in pairs(opts) do
					parsedOptions[i] = tostring(key)
					parsedValues[tostring(key)] = value
					i = i + 1
				end
				table.sort(parsedOptions)
			end
		end

		return parsedOptions, parsedValues
	end

	local function updateMenuHeight()
		local totalHeight = menuLayout.AbsoluteContentSize.Y + 8
		menuContainer.Size = UDim2.new(1, 0, 0, totalHeight)
		if isOpen then
			optionsMenu.Size = UDim2.new(1, 0, 0, totalHeight)
		end
	end

	local function closeDropdown(instant)
		if not isOpen then
			return
		end
		isOpen = false
		for i, fn in ipairs(openDropdowns) do
			if fn == closeDropdown then
				table.remove(openDropdowns, i)
				break
			end
		end
		createTween(arrow, 0.25, {
			Rotation = -90
		}):Play()
		local closeTween = createTween(optionsMenu, instant and 0 or 0.3, {
			Size = UDim2.new(1, 0, 0, 0)
		}, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
		closeTween:Play()
		closeTween.Completed:Connect(function()
			if not isOpen then
				menuContainer.Visible = false
			end
		end)
		if outsideConn then
			outsideConn:Disconnect()
			outsideConn = nil
		end
	end

	local function clearOptions()
		for _, child in pairs(optionsMenu:GetChildren()) do
			if child:IsA("Frame") and child.Name ~= "UIListLayout" and child.Name ~= "UIPadding" then
				child:Destroy()
			end
		end
	end

	local function createOptionButtons()
		clearOptions()

		for i, opt in ipairs(currentOptions) do
			local optContainer = createElement("Frame", {
				Size = UDim2.new(1, 0, 0, 36),
				BackgroundTransparency = 1,
				ZIndex = 107,
				LayoutOrder = i,
				Parent = optionsMenu
			})

			createElement("UIPadding", {
				PaddingLeft = UDim.new(0, 2),
				PaddingRight = UDim.new(0, 2),
				Parent = optContainer
			})

			local optBtn = createElement("TextButton", {
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundColor3 = Color3.fromRGB(60, 60, 60),
				BackgroundTransparency = 1,
				Font = Enum.Font.SourceSans,
				Text = opt,
				TextSize = 16,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 108,
				Parent = optContainer
			})

			truncateWithTooltip(optBtn, opt)

			createElement("UICorner", {
				CornerRadius = UDim.new(0, 4),
				Parent = optBtn
			})

			createElement("UIPadding", {
				PaddingLeft = UDim.new(0, 4),
				PaddingRight = UDim.new(0, 4),
				Parent = optBtn
			})

			optBtn.MouseEnter:Connect(function()
				createTween(optBtn, 0.15, {
					BackgroundTransparency = 0.7,
					BackgroundColor3 = Color3.fromRGB(80, 120, 255)
				}):Play()
			end)

			optBtn.MouseLeave:Connect(function()
				createTween(optBtn, 0.15, {
					BackgroundTransparency = 1
				}):Play()
			end)

			optBtn.MouseButton1Down:Connect(function()
				truncateWithTooltip(selectedLabel, "Selected: " .. opt)
				if callback then
					local actualValue = optionValues[opt] or opt
					callback(actualValue, opt)
				end
				closeDropdown()
			end)
		end

		updateMenuHeight()
	end

	local function openDropdown()
		if isOpen then
			return
		end
		isOpen = true

		for _, otherClose in ipairs(openDropdowns) do
			otherClose(true)
		end
		table.clear(openDropdowns)
		table.insert(openDropdowns, closeDropdown)

		menuContainer.Visible = true
		wait()
		local totalHeight = menuLayout.AbsoluteContentSize.Y + 8
		createTween(arrow, 0.3, {
			Rotation = 0
		}, Enum.EasingStyle.Back):Play()
		createTween(optionsMenu, 0.4, {
			Size = UDim2.new(1, 0, 0, totalHeight)
		}, Enum.EasingStyle.Quart, Enum.EasingDirection.Out):Play()

		outsideConn = UserInputService.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				local mouse = UserInputService:GetMouseLocation()
				local dropPos, dropSize = dropdown.AbsolutePosition, dropdown.AbsoluteSize
				local menuPos, menuSize = optionsMenu.AbsolutePosition, optionsMenu.AbsoluteSize
				local notInDropdown = not (mouse.X >= dropPos.X and mouse.X <= dropPos.X + dropSize.X and mouse.Y >= dropPos.Y and mouse.Y <= dropPos.Y + dropSize.Y)
				local notInMenu = not (mouse.X >= menuPos.X and mouse.X <= menuPos.X + menuSize.X and mouse.Y >= menuPos.Y and mouse.Y <= menuSize.Y)
				if notInDropdown and notInMenu then
					closeDropdown()
				end
			end
		end)
	end

	currentOptions, optionValues = parseOptions(options)
	createOptionButtons()

	if defaultOption then
		local defaultText = defaultOption
		local found = false
		for _, opt in ipairs(currentOptions) do
			if opt == defaultOption then
				found = true
				break
			end
		end
		if found then
			selectedLabel.Text = "Selected: " .. defaultOption
			truncateWithTooltip(selectedLabel, "Selected: " .. defaultOption)
		else
			selectedLabel.Text = "Default: " .. defaultOption
			truncateWithTooltip(selectedLabel, "Default: " .. defaultOption)
		end
	end

	toggleBtn.MouseButton1Click:Connect(function()
		if isOpen then
			closeDropdown()
		else
			openDropdown()
		end
	end)

	toggleBtn.MouseEnter:Connect(function()
		if not isOpen then
			createTween(dropdown, 0.2, {
				BackgroundTransparency = 0.65
			}):Play()
		end
	end)

	toggleBtn.MouseLeave:Connect(function()
		if not isOpen then
			createTween(dropdown, 0.2, {
				BackgroundTransparency = 0.85
			}):Play()
		end
	end)

	local dropdownWrapper = {
		Frame = dropdown,

		AddChildren = function(newOptions)
			currentOptions, optionValues = parseOptions(newOptions)
			createOptionButtons()
		end,

		AddOption = function(displayText, value)
			value = value or displayText
			table.insert(currentOptions, displayText)
			optionValues[displayText] = value
			createOptionButtons()
		end,

		RemoveOption = function(displayText)
			for i, opt in ipairs(currentOptions) do
				if opt == displayText then
					table.remove(currentOptions, i)
					optionValues[displayText] = nil
					break
				end
			end
			createOptionButtons()
		end,

		ClearOptions = function()
			currentOptions = {}
			optionValues = {}
			createOptionButtons()
			selectedLabel.Text = "Selected: None"
			truncateWithTooltip(selectedLabel, "Selected: None")
		end,

		GetOptions = function()
			return currentOptions, optionValues
		end,

		SetSelected = function(displayText)
			if optionValues[displayText] then
				truncateWithTooltip(selectedLabel, "Selected: " .. displayText)
			end
		end,

		GetSelected = function()
			local text = selectedLabel.Text
			if text:match("^Selected: (.+)") then
				local selectedText = text:match("^Selected: (.+)")
				return optionValues[selectedText] or selectedText, selectedText
			end
			return nil, nil
		end
	}

	setmetatable(dropdownWrapper, {
		__index = function(t, k)
			return dropdown[k]
		end,
		__newindex = function(t, k, v)
			dropdown[k] = v
		end
	})

	if parentFrame and parentFrame.AddComponent then
		parentFrame.AddComponent(dropdown, gridPosition)
		return dropdownWrapper
	elseif parentFrame and parentFrame.Frame then
		dropdownWrapper.Frame.Parent = parentFrame.Frame
		return dropdownWrapper
	else
		dropdownWrapper.Frame.Parent = parentFrame or contentFrame
		return dropdownWrapper
	end
end

local function createButton(name, text, callback, parentSection, gridPosition)
	local btn = createElement("TextButton", {
		Name = name,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.85,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
		Font = Enum.Font.SourceSansBold,
		TextSize = 18,
		ZIndex = 10
	})
	createElement("UIStroke", {
		Thickness = 2,
		Color = Color3.fromRGB(220, 220, 220),
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = btn
	})
	createElement("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = btn
	})
	truncateWithTooltip(btn, text)
	btn.MouseEnter:Connect(function()
		createTween(btn, 0.2, {
			BackgroundTransparency = 0.6
		}):Play()
	end)
	btn.MouseLeave:Connect(function()
		createTween(btn, 0.2, {
			BackgroundTransparency = 0.85
		}):Play()
	end)
	btn.Activated:Connect(function()
		callback(btn)
	end)

	if parentSection and parentSection.AddComponent then
		return parentSection.AddComponent(btn, gridPosition)
	elseif parentSection and parentSection.Frame then
		btn.Parent = parentSection.Frame
		return btn
	else
		btn.Parent = parentSection
		return btn
	end
end

local function createTextBox(name, placeholder, defaultText, callback, parentFrame, gridPosition)
	local textBox = createElement("TextBox", {
		Name = name,
		Size = UDim2.new(0, 180, 0, 40),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.85,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
		Font = Enum.Font.SourceSans,
		TextSize = 16,
		PlaceholderText = placeholder or "Enter text...",
		PlaceholderColor3 = Color3.fromRGB(200, 200, 200),
		Text = defaultText or "",
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		ZIndex = 10,
		TextWrapped = false,
		TextScaled = false,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ClipsDescendants = true,
	})
	createElement("UIStroke", {
		Thickness = 2,
		Color = Color3.fromRGB(220, 220, 220),
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = textBox
	})
	createElement("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = textBox
	})
	createElement("UIPadding", {
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		Parent = textBox
	})
	textBox.Focused:Connect(function()
		createTween(textBox, 0.2, {
			BackgroundTransparency = 0.6
		}):Play()
	end)
	textBox.FocusLost:Connect(function()
		createTween(textBox, 0.2, {
			BackgroundTransparency = 0.85
		}):Play()
		if callback then
			callback(textBox.Text)
		end
	end)
	if parentFrame and parentFrame.AddComponent then
		return parentFrame.AddComponent(textBox, gridPosition)
	elseif parentFrame and parentFrame.Frame then
		textBox.Parent = parentFrame.Frame
		return textBox
	else
		textBox.Parent = parentFrame or contentFrame
		return textBox
	end
end

local function createInfo(name, mainText, subText, callback, parentFrame, gridPosition)
	local infoFrame = createElement("Frame", {
		Name = name,
		Size = UDim2.new(0, 180, 0, 40),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.85,
		ZIndex = 10,
		ClipsDescendants = true,
	})

	createElement("UIStroke", {
		Thickness = 2,
		Color = Color3.fromRGB(220, 220, 220),
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = infoFrame
	})

	createElement("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = infoFrame
	})

	createElement("UIPadding", {
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		PaddingTop = UDim.new(0, 5),
		PaddingBottom = UDim.new(0, 5),
		Parent = infoFrame
	})

	local mainLabel = createElement("TextLabel", {
		Name = "MainText",
		Size = UDim2.new(1, 0, 0, 20),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
		Font = Enum.Font.SourceSansBold,
		TextSize = 18,
		Text = mainText or "No information",
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ZIndex = 11,
		TextWrapped = false,
		TextScaled = false,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = infoFrame
	})

	local subLabel = createElement("TextLabel", {
		Name = "SubText",
		Size = UDim2.new(1, 0, 0, 20),
		Position = UDim2.new(0, 0, 0, 15),
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
		Font = Enum.Font.SourceSans,
		TextSize = 14,
		Text = subText or "",
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ZIndex = 11,
		TextWrapped = false,
		TextScaled = false,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = infoFrame
	})

	local wrapper = {
		Frame = infoFrame,
		MainLabel = mainLabel,
		SubLabel = subLabel
	}

	function wrapper.SetText(newMainText, newSubText)
		local oldMainText = mainLabel.Text
		local oldSubText = subLabel.Text

		if newMainText ~= nil then
			mainLabel.Text = newMainText
		end
		if newSubText ~= nil then
			subLabel.Text = newSubText
		end

		if callback and (oldMainText ~= mainLabel.Text or oldSubText ~= subLabel.Text) then
			callback(mainLabel.Text, subLabel.Text)
		end
	end

	function wrapper.SetMainText(newText)
		local oldText = mainLabel.Text
		mainLabel.Text = newText or "No information"
		if callback and oldText ~= mainLabel.Text then
			callback(mainLabel.Text, subLabel.Text)
		end
	end

	function wrapper.SetSubText(newText)
		local oldText = subLabel.Text
		subLabel.Text = newText or ""
		if callback and oldText ~= subLabel.Text then
			callback(mainLabel.Text, subLabel.Text)
		end
	end

	function wrapper.GetText()
		return mainLabel.Text, subLabel.Text
	end

	function wrapper.GetMainText()
		return mainLabel.Text
	end

	function wrapper.GetSubText()
		return subLabel.Text
	end

	if parentFrame and parentFrame.AddComponent then
		parentFrame.AddComponent(wrapper.Frame, gridPosition)
		return wrapper
	elseif parentFrame and parentFrame.Frame then
		wrapper.Frame.Parent = parentFrame.Frame
		return wrapper
	else
		wrapper.Frame.Parent = parentFrame or contentFrame
		return wrapper
	end
end

local function createInfo2(name, mainText, subText, callback, parentFrame, gridPosition)
	local infoFrame = createElement("Frame", {
		Name = name,
		Size = UDim2.new(0, 260, 0, 60),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.88,
		ZIndex = 10,
		ClipsDescendants = true,
	})

	createElement("UIStroke", {
		Thickness = 1,
		Color = Color3.fromRGB(255, 255, 255),
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Transparency = 0.7,
		Parent = infoFrame
	})

	createElement("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = infoFrame
	})

	local iconFrame = createElement("Frame", {
		Name = "IconFrame",
		Size = UDim2.new(0, 24, 0, 24),
		Position = UDim2.new(0, -30, 0, 0),
		BackgroundColor3 = Color3.fromRGB(100, 150, 255),
		BorderSizePixel = 0,
		ZIndex = 11,
		Parent = infoFrame
	})

	createElement("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = iconFrame
	})

	local iconLabel = createElement("TextLabel", {
		Name = "Icon",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Font = Enum.Font.SourceSansBold,
		TextSize = 14,
		Text = "i",
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		ZIndex = 12,
		Parent = iconFrame
	})

	createElement("UIPadding", {
		PaddingLeft = UDim.new(0, 44),
		PaddingRight = UDim.new(0, 12),
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 8),
		Parent = infoFrame
	})

	local mainLabel = createElement("TextLabel", {
		Name = "MainText",
		Size = UDim2.new(1, 0, 0, 18),
		Position = UDim2.new(0, 0, 0, -3),
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Font = Enum.Font.SourceSansBold,
		TextSize = 15,
		Text = mainText or "Information",
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		ZIndex = 11,
		TextWrapped = false,
		TextScaled = false,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = infoFrame
	})

	local subLabel = createElement("TextLabel", {
		Name = "SubText",
		Size = UDim2.new(1, 0, 1, -22),
		Position = UDim2.new(0, 0, 0, 12),
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(220, 220, 220),
		Font = Enum.Font.SourceSans,
		TextSize = 13,
		Text = subText or "",
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ZIndex = 11,
		TextWrapped = true,
		TextScaled = false,
		Parent = infoFrame
	})

	local function updateIconColor(isWarning)
		if isWarning then
			iconFrame.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
			iconLabel.Text = "!"
		else
			iconFrame.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
			iconLabel.Text = "i"
		end
	end

	local wrapper = {
		Frame = infoFrame,
		MainLabel = mainLabel,
		SubLabel = subLabel,
		IconFrame = iconFrame
	}

	function wrapper.SetText(newMainText, newSubText)
		local oldMainText = mainLabel.Text
		local oldSubText = subLabel.Text
		if newMainText ~= nil then
			mainLabel.Text = newMainText
			updateIconColor(string.find(string.lower(newMainText), "cannot") or
				string.find(string.lower(newMainText), "warning"))
		end
		if newSubText ~= nil then
			subLabel.Text = newSubText
		end
		if callback and (oldMainText ~= mainLabel.Text or oldSubText ~= subLabel.Text) then
			callback(mainLabel.Text, subLabel.Text)
		end
	end

	function wrapper.SetMainText(newText)
		local oldText = mainLabel.Text
		mainLabel.Text = newText or "Information"
		updateIconColor(string.find(string.lower(newText or ""), "cannot") or
			string.find(string.lower(newText or ""), "warning"))
		if callback and oldText ~= mainLabel.Text then
			callback(mainLabel.Text, subLabel.Text)
		end
	end

	function wrapper.SetSubText(newText)
		local oldText = subLabel.Text
		subLabel.Text = newText or ""
		if callback and oldText ~= subLabel.Text then
			callback(mainLabel.Text, subLabel.Text)
		end
	end

	function wrapper.SetWarning(isWarning)
		updateIconColor(isWarning)
	end

	function wrapper.GetText()
		return mainLabel.Text, subLabel.Text
	end

	function wrapper.GetMainText()
		return mainLabel.Text
	end

	function wrapper.GetSubText()
		return subLabel.Text
	end

	updateIconColor(string.find(string.lower(mainText or ""), "cannot") or
		string.find(string.lower(mainText or ""), "warning"))

	if parentFrame and parentFrame.AddComponent then
		parentFrame.AddComponent(wrapper.Frame, gridPosition)
		return wrapper
	elseif parentFrame and parentFrame.Frame then
		wrapper.Frame.Parent = parentFrame.Frame
		return wrapper
	else
		wrapper.Frame.Parent = parentFrame or contentFrame
		return wrapper
	end
end

local function createToggleButton(name, text, defaultState, callback, parentFrame, gridPosition)
	local toggle = createElement("Frame", {
		Name = name,
		Size = UDim2.new(0, 180, 0, 40),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.85,
		BorderSizePixel = 0,
		ZIndex = 10,
	})
	createElement("UIStroke", {
		Thickness = 2,
		Color = Color3.fromRGB(220, 220, 220),
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = toggle
	})
	createElement("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = toggle
	})
	local btn = createElement("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 11,
		Parent = toggle
	})
	local label = createElement("TextLabel", {
		Size = UDim2.new(1, -70, 1, 0),
		Position = UDim2.new(0, 10, 0, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.SourceSansBold,
		TextSize = 16,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 12,
		Parent = btn
	})
	local switchTrack = createElement("Frame", {
		Size = UDim2.new(0, 50, 0, 24),
		Position = UDim2.new(1, -60, 0.5, -12),
		BackgroundColor3 = Color3.fromRGB(200, 200, 200),
		BackgroundTransparency = 0.7,
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = btn
	})
	createElement("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = switchTrack
	})
	createElement("UIStroke", {
		Thickness = 1.5,
		Color = Color3.fromRGB(255, 255, 255),
		Parent = switchTrack
	})
	local switchKnob = createElement("Frame", {
		Size = UDim2.new(0, 20, 0, 20),
		Position = UDim2.new(0, 2, 0.5, -10),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 13,
		Parent = switchTrack
	})
	createElement("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = switchKnob
	})
	local isToggled = defaultState or false
	local function updateToggle()
		local trackColor = isToggled and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(120, 120, 120)
		local knobPosition = isToggled and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
		createTween(switchTrack, 0.3, {
			BackgroundColor3 = trackColor
		}):Play()
		createTween(switchKnob, 0.3, {
			Position = knobPosition
		}):Play()
		if callback then
			callback(isToggled)
		end
	end
	btn.MouseEnter:Connect(function()
		createTween(toggle, 0.2, {
			BackgroundTransparency = 0.65
		}):Play()
	end)
	btn.MouseLeave:Connect(function()
		createTween(toggle, 0.2, {
			BackgroundTransparency = 0.85
		}):Play()
	end)
	btn.Activated:Connect(function()
		isToggled = not isToggled
		updateToggle()
	end)
	updateToggle()
	if parentFrame and parentFrame.AddComponent then
		parentFrame.AddComponent(toggle, gridPosition)
		return toggle, function()
			return isToggled
		end
	elseif parentFrame and parentFrame.Frame then
		toggle.Parent = parentFrame.Frame
		return toggle, function()
			return isToggled
		end
	else
		toggle.Parent = parentFrame or contentFrame
		return toggle, function()
			return isToggled
		end
	end
end

local function createKeyBindButton(name, mainText, defaultSubText, callback, parentFrame, gridPosition)
	local infoFrame = createElement("TextButton", {
		Name = name,
		Size = UDim2.new(0, 180, 0, 40),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.85,
		ZIndex = 10,
		ClipsDescendants = true,
		AutoButtonColor = false,
		Text = "",
	})

	createElement("UIStroke", {
		Thickness = 2,
		Color = Color3.fromRGB(220, 220, 220),
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = infoFrame
	})

	createElement("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = infoFrame
	})

	createElement("UIPadding", {
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		PaddingTop = UDim.new(0, 5),
		PaddingBottom = UDim.new(0, 5),
		Parent = infoFrame
	})

	local mainLabel = createElement("TextLabel", {
		Name = "MainText",
		Size = UDim2.new(1, 0, 0, 20),
		Position = UDim2.new(0, 0, 0, -3),
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
		Font = Enum.Font.SourceSansBold,
		TextSize = 18,
		Text = mainText or "Keybind",
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ZIndex = 11,
		Parent = infoFrame
	})

	local subLabel = createElement("TextLabel", {
		Name = "SubText",
		Size = UDim2.new(1, 0, 0, 20),
		Position = UDim2.new(0, 0, 0, 15),
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
		Font = Enum.Font.SourceSans,
		TextSize = 14,
		Text = "Keybind: " .. (defaultSubText or "Not Set"),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ZIndex = 11,
		Parent = infoFrame
	})

	local statusIndicator = createElement("Frame", {
		Name = "StatusIndicator",
		Size = UDim2.new(0, 6, 0, 6),
		Position = UDim2.new(1, -10, 0, 4),
		BackgroundColor3 = Color3.fromRGB(120, 120, 120),
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = infoFrame
	})

	createElement("UICorner", {
		CornerRadius = UDim.new(0, 3),
		Parent = statusIndicator
	})

	local userInputService = game:GetService("UserInputService")
	local capturing = false
	local currentKeyBind = nil
	local ignoreNextPress = false

	local function setCapturingState(isCapturing)
		capturing = isCapturing
		if isCapturing then
			infoFrame.BackgroundTransparency = 0.7
			infoFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 180)
			statusIndicator.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
			subLabel.Text = "Keybind: Press any key..."
			subLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
		else
			infoFrame.BackgroundTransparency = 0.85
			infoFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			statusIndicator.BackgroundColor3 = currentKeyBind and Color3.fromRGB(100, 255, 100) or
				Color3.fromRGB(120, 120, 120)
			subLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		end
	end

	infoFrame.MouseEnter:Connect(function()
		if not capturing then
			infoFrame.BackgroundTransparency = 0.8
		end
	end)

	infoFrame.MouseLeave:Connect(function()
		if not capturing then
			infoFrame.BackgroundTransparency = 0.85
		end
	end)

	infoFrame.Activated:Connect(function()
		if capturing then
			return
		end

		setCapturingState(true)

		local connection
		connection = userInputService.InputBegan:Connect(function(input, gp)
			if gp then
				return
			end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				currentKeyBind = input.KeyCode
				subLabel.Text = "Keybind: " .. currentKeyBind.Name
				ignoreNextPress = true
				connection:Disconnect()
				setCapturingState(false)
			end
		end)
	end)

	userInputService.InputBegan:Connect(function(input, gp)
		if gp then
			return
		end
		if currentKeyBind and input.KeyCode == currentKeyBind then
			if ignoreNextPress then
				ignoreNextPress = false
				return
			end
			if callback then
				callback(currentKeyBind)
			end
		end
	end)

	statusIndicator.BackgroundColor3 = currentKeyBind and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(120, 120, 120)

	local wrapper = {
		Frame = infoFrame,
		MainLabel = mainLabel,
		SubLabel = subLabel,
		StatusIndicator = statusIndicator,
		GetKey = function()
			return currentKeyBind
		end
	}

	if parentFrame and parentFrame.AddComponent then
		parentFrame.AddComponent(wrapper.Frame, gridPosition)
		return wrapper
	elseif parentFrame and parentFrame.Frame then
		wrapper.Frame.Parent = parentFrame.Frame
		return wrapper
	else
		wrapper.Frame.Parent = parentFrame or contentFrame
		return wrapper
	end
end

local function createGhost(parentSection, gridPosition)
	local ghost = createElement("Frame", {
		Name = "Ghost",
		BackgroundTransparency = 1,
		ZIndex = 1
	})

	if parentSection and parentSection.AddComponent then
		return parentSection.AddComponent(ghost, gridPosition)
	elseif parentSection and parentSection.Frame then
		ghost.Parent = parentSection.Frame
		return ghost
	else
		ghost.Parent = parentSection
		return ghost
	end
end

local function createGhostText(parentSection, options)
	options = options or {}
	local ghostText = createElement("TextLabel", {
		Name = options.Name or "GhostText",
		Text = options.Text or "",
		TextColor3 = options.TextColor3 or Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = options.BackgroundTransparency or 1,
		Font = options.Font or Enum.Font.SourceSans,
		TextSize = options.TextSize or 16,
		TextWrapped = options.TextWrapped ~= false,
		TextXAlignment = options.TextXAlignment or Enum.TextXAlignment.Left,
		TextYAlignment = options.TextYAlignment or Enum.TextYAlignment.Top,
		ZIndex = options.ZIndex or 8
	})

	local gridPos = options.GridPosition or { 2, 0.8 }

	if parentSection and parentSection.AddComponent then
		return parentSection.AddComponent(ghostText, gridPos)
	elseif parentSection and parentSection.Frame then
		ghostText.Parent = parentSection.Frame
		return ghostText
	else
		ghostText.Parent = parentSection
		return ghostText
	end
end


-- ================ USER INTERFACE ===================

local SizeConfig = {
	Width = 0.31,
	Height = 0.80,
	GuiMaxHeight = 600,
	GuiMaxWidth = 380,
	GuiMinWidth = 300,
	GuiMinHeight = 300
}

local Width = viewportSize.X * SizeConfig.Width
local Height = viewportSize.Y * SizeConfig.Height
local maxHeight = SizeConfig.GuiMaxHeight
local maxWidth = SizeConfig.GuiMaxWidth
local minHeight = SizeConfig.GuiMinHeight
local minWidth = SizeConfig.GuiMinWidth

local childrenContainer = createCollapsibleContainer(mainContainer, Width, Height, minWidth, minHeight, maxWidth,
	maxHeight)

local autoFarmSection = createSection(childrenContainer, "Auto Farm", 1, true, false,
	"Tween is HIGHLY recommended, walk will be fixed in future updates!")
local sellSection = createSection(childrenContainer, "Sell Inventory", 2, true)
local teleportSection = createSection(childrenContainer, "Teleport", 3, true, false,
	"Requires waypoints to be unlocked before using them, use unlock all waypoints to do so.")
local reforgeSection = createSection(childrenContainer, "Reforge", 4, false, false,
	"Unequip the equipment you wanna reforge and DO NOT hold anything in your hand.")
local enchantSection = createSection(childrenContainer, "Enchanting", 5, false, false,
	"DO NOT hold anything in your hand.")
local shopSection = createSection(childrenContainer, "Shop", 6, false, false, "Bulk buying will be added in next update.")
local manualSection = createSection(childrenContainer, "Manual Actions", 7, false, false, "Legit mode WIP!")
local utilitySection = createSection(childrenContainer, "Utility", 8, true)

-- =============== INITIALIZATION ===============
-- actual brainfuck starts here

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PathfindingService = game:GetService("PathfindingService")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- Player
local Player = Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer
local Characters = workspace:WaitForChild("Characters")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local LocalCharacter = Characters:WaitForChild(LocalPlayer.name)
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local BackpackTwo = Player:WaitForChild("BackpackTwo")

-- Others
local NPCs = Workspace:WaitForChild("NPCs")
local PlaceId = game.PlaceId
local JobId = game.JobId

-- Animations
local Animator = Humanoid:WaitForChild("Animator")
local PanningAnimations = game.ReplicatedStorage.Assets.Animations.Panning
local WashAnimation = Animator:LoadAnimation(PanningAnimations.Wash)
local ShakeAnimation = Animator:LoadAnimation(PanningAnimations.Shake)

-- UI
local ToolUI = PlayerGui:WaitForChild("ToolUI")
local FillingPan = ToolUI:WaitForChild("FillingPan")
local FillText = FillingPan:WaitForChild("FillText")


-- ==================== STATE ====================
local PanStatus = {
	current = 0,
	max = 100,
	isFull = false
}

local AutoFarmState = {
	active = false,
	actionMode = "Instant",
	travelMode = "Teleport",
	sandCFrame = nil,
	waterCFrame = nil,
	locked = false
}

local SellSettings = {
	mode = "Teleport",
	type = "Threshold",
	threshold = 300,
	delay = 60,
	autoSell = false,
	_lastSell = nil,
	_scheduledSell = nil
}

-- ==================== HELPERS ====================

local function equipPan()
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local LocalPlayer = Players.LocalPlayer
	local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

	-- helper to check container for a Pan
	local function findPan(container)
		for _, v in ipairs(container:GetChildren()) do
			if v:GetAttribute("ItemType") == "Pan" then
				return v
			end
		end
	end

	local pan = findPan(Character) or findPan(LocalPlayer.Backpack) or findPan(LocalPlayer:WaitForChild("BackpackTwo"))

	if pan then
		ReplicatedStorage.Remotes.CustomBackpack.EquipRemote:FireServer(pan)
		return pan
	end

	return nil
end

local function validateSellValue(str)
	if not str or str == "" then
		return nil, nil
	end
	local n, u = str:lower():match("^(%d+)%s*(%a*)$")
	n = tonumber(n)
	if not n then
		return nil, nil
	end
	u = (u or ""):gsub("s+$", "")

	-- omg multi-lang support
	local multipliers = {
		-- Seconds
		[""] = 1, -- Empty/default (seconds)
		s = 1,
		sec = 1,
		secs = 1,
		second = 1,
		seconds = 1,
		["s."] = 1,
		["sec."] = 1,
		S = 1,

		-- Minutes
		m = 60,
		min = 60,
		mins = 60,
		minute = 60,
		minutes = 60,
		["m."] = 60,
		["min."] = 60,
		M = 60,

		-- Hours
		h = 3600,
		hr = 3600,
		hrs = 3600,
		hour = 3600,
		hours = 3600,
		["h."] = 3600,
		["hr."] = 3600,
		H = 3600,

		-- Days
		d = 86400,
		day = 86400,
		days = 86400,
		["d."] = 86400,
		D = 86400,

		-- International variations
		segundo = 1,
		minuto = 60,
		hora = 3600,
		dia = 86400,
		seconde = 1,
		minute_fr = 60,
		heure = 3600,
		jour = 86400,
		sekunde = 1,
		minute_de = 60,
		stunde = 3600,
		tag = 86400,

		secon = 1,
		minut = 60,
		hou = 3600,
		da = 86400,

		sec_short = 1,
		min_short = 60,
		hr_short = 3600
	}
	if u ~= "" then
		local seconds = n * (multipliers[u] or 0)
		if seconds >= 30 and seconds <= 86400 then
			return seconds, "time"
		else
			return nil, nil
		end
	else
		-- Treat as sell value
		if n >= 10 and n <= 999 then
			return n, "value"
		else
			return nil, nil
		end
	end
end

local function getPanStatus()
	local function getDefaultStatus()
		return {
			current = 0,
			max = 100,
			isFull = false,
			isEmpty = true,
		}
	end

	local function cleanAndParseNumber(raw, fallback)
		if not raw then return fallback end
		local cleaned = string.gsub(string.gsub(string.gsub(tostring(raw), ",", ""), " ", ""), "%s+", "")
		if cleaned == "" then return fallback end
		local parsed = tonumber(cleaned)
		return parsed and math.max(0, math.floor(parsed)) or fallback
	end

	if not FillText or not FillText.ContentText then
		return getDefaultStatus()
	end

	local contentText = tostring(FillText.ContentText)
	if contentText == "" then
		return getDefaultStatus()
	end

	local fillNumbers = string.split(contentText, "/")
	if not fillNumbers or #fillNumbers < 2 then
		return getDefaultStatus()
	end

	local current = cleanAndParseNumber(fillNumbers[1], 0)
	local max = math.max(1, cleanAndParseNumber(fillNumbers[2], 100))

	return {
		current = current,
		max = max,
		isFull = current >= max,
		isEmpty = current <= 0,
	}
end

local function CollectInvokeServer(collect)
	collect:InvokeServer(1)
end

local function getRegion(HumanoidRootPart)
	local PointToRegion = require(ReplicatedStorage.Modules.Location.PointToRegion)
	local region, _ = PointToRegion.GetPanningRegion(HumanoidRootPart.Position)
	return region
end

local function getClosestMerchant()
	local playerHrp = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not playerHrp then
		return nil, math.huge
	end

	local closest, closestDist = nil, math.huge

	for _, folder in ipairs(NPCs:GetChildren()) do
		for _, npc in ipairs(folder:GetChildren()) do
			if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") and npc.Name:sub(-8) == "Merchant" then
				local dialog = npc:FindFirstChild("Dialog")
				if dialog and dialog.ClassName == "ObjectValue" and dialog.Value and dialog.Value:IsA("ModuleScript") then
					if dialog.Value.Name == "Seller" then
						local npcHrp = npc.HumanoidRootPart
						local dist = (playerHrp.Position - npcHrp.Position).Magnitude
						if dist < closestDist then
							closestDist = dist
							closest = npcHrp
						end
					end
				end
			end
		end
	end

	return closest, closestDist
end

local function tweenToTarget(target, config)
	local player = Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local hrp = character:WaitForChild("HumanoidRootPart")
	local humanoid = character:WaitForChild("Humanoid")
	config = config or {}
	local offset = config.Offset or Vector3.new(0, 0, 0)
	local stopDist = config.StopDistance or 20
	local speed = config.Speed or 24
	local cruiseHeight = config.CruiseHeight or 25
	local minHeight = config.MinHeight or 15
	local maxHeight = config.MaxHeight or 100
	local agentRadius = config.AgentRadius or 3
	local longDistanceThreshold = config.LongDistanceThreshold or 150
	local directFlightThreshold = config.DirectFlightThreshold or 50
	local waypointDistance = config.WaypointDistance or 12
	local smoothness = config.Smoothness or 0.5
	local landingDuration = config.LandingDuration or 1.2
	local hoverDuration = config.HoverDuration or 0.3
	local pathTimeout = config.PathTimeout or 8
	local maxTimeout = config.MaxTimeout or 45
	local adaptiveHeight = config.AdaptiveHeight ~= false
	local useDirectFlight = config.UseDirectFlight ~= false
	local debug = config.Debug or false

	local isActive = true
	local currentPath = nil
	local waypoints = {}
	local currentWaypointIndex = 1
	local lastWaypointTime = tick()
	local startTime = tick()
	local isLanding = false
	local currentHeight = cruiseHeight

	local bg, bv, bp
	local debugParts = {}
	local originalPlatformStand

	local function setNoclip(state)
		for _, v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = not state
			end
		end
		if humanoid then
			if state then
				originalPlatformStand = humanoid.PlatformStand
				humanoid.PlatformStand = true
			else
				if originalPlatformStand ~= nil then
					humanoid.PlatformStand = originalPlatformStand
				end
			end
		end
	end

	local function cleanup()
		isActive = false
		if bg then
			bg:Destroy()
		end
		if bv then
			bv:Destroy()
		end
		if bp then
			bp:Destroy()
		end
		setNoclip(false)
		if humanoid and originalPlatformStand ~= nil then
			humanoid.PlatformStand = originalPlatformStand
		end

		for _, part in pairs(debugParts) do
			if part.Parent then
				part:Destroy()
			end
		end
		debugParts = {}
	end

	local function toVector3(t)
		if typeof(t) == "Vector3" then
			return t
		elseif typeof(t) == "Instance" and t:IsA("BasePart") then
			return t.Position
		elseif typeof(t) == "CFrame" then
			return t.Position
		elseif typeof(t) == "table" then
			if t.Position then
				return t.Position
			elseif t.X and t.Y and t.Z then
				return Vector3.new(t.X, t.Y, t.Z)
			end
		end
		error("Invalid target type")
	end

	local function createDebugWaypoint(position, color, size)
		if not debug then
			return
		end

		local part = Instance.new("Part")
		part.Size = Vector3.new(size or 2, size or 2, size or 2)
		part.Position = position
		part.Color = color or Color3.new(1, 0, 0)
		part.Material = Enum.Material.ForceField
		part.Transparency = 0.3
		part.Anchored = true
		part.CanCollide = false
		part.Shape = Enum.PartType.Ball
		part.Parent = workspace

		local light = Instance.new("PointLight")
		light.Color = part.Color
		light.Brightness = 2
		light.Range = 10
		light.Parent = part

		table.insert(debugParts, part)
		return part
	end

	local function getOptimalHeight(position, targetPos)
		if not adaptiveHeight then
			return currentHeight
		end

		local distance = (targetPos - position).Magnitude
		local terrainHeight = 0

		local rayParams = RaycastParams.new()
		rayParams.FilterDescendantsInstances = {
			character
		}
		rayParams.FilterType = Enum.RaycastFilterType.Blacklist

		local result = workspace:Raycast(position, Vector3.new(0, -200, 0), rayParams)
		if result then
			terrainHeight = result.Position.Y
		end

		local baseHeight = math.max(minHeight, terrainHeight + 10)

		if distance > longDistanceThreshold then
			return math.min(maxHeight, baseHeight + 30)
		elseif distance > 75 then
			return math.min(cruiseHeight + 15, baseHeight + 20)
		else
			return math.min(cruiseHeight, baseHeight + 15)
		end
	end

	local function hasObstaclesBetween(start, destination, checkHeight)
		local direction = (destination - start)
		local distance = direction.Magnitude
		local unit = direction.Unit

		local rayParams = RaycastParams.new()
		rayParams.FilterDescendantsInstances = {
			character
		}
		rayParams.FilterType = Enum.RaycastFilterType.Blacklist

		local checkPoints = math.max(3, math.floor(distance / 10))
		for i = 1, checkPoints do
			local checkPos = start + unit * (distance * i / checkPoints)
			checkPos = Vector3.new(checkPos.X, checkPos.Y + checkHeight, checkPos.Z)

			local directions = {
				Vector3.new(0, 0, 0),
				Vector3.new(agentRadius, 0, 0),
				Vector3.new(-agentRadius, 0, 0),
				Vector3.new(0, 0, agentRadius),
				Vector3.new(0, 0, -agentRadius),
				Vector3.new(0, agentRadius, 0),
				Vector3.new(0, -agentRadius, 0)
			}

			for _, dir in pairs(directions) do
				local testPos = checkPos + dir
				local result = workspace:Raycast(testPos, Vector3.new(0, -checkHeight - 10, 0), rayParams)
				if result and result.Position.Y > testPos.Y - 5 then
					return true
				end

				local ceilingResult = workspace:Raycast(testPos, Vector3.new(0, 10, 0), rayParams)
				if ceilingResult and ceilingResult.Position.Y < testPos.Y + 6 then
					return true
				end

				local forwardRay = workspace:Raycast(testPos, unit * 10, rayParams)
				if forwardRay then
					return true
				end
			end
		end

		return false
	end

	local function canDirectFly(start, destination)
		if not useDirectFlight then
			return false
		end

		local distance = (destination - start).Magnitude
		if distance > directFlightThreshold then
			return false
		end

		return not hasObstaclesBetween(start, destination, currentHeight)
	end

	local function createPath(destination)
		local startPos = hrp.Position
		local targetPos = destination

		currentHeight = getOptimalHeight(startPos, targetPos)

		if canDirectFly(startPos, targetPos) then
			local directWaypoint = {
				Position = Vector3.new(targetPos.X, targetPos.Y + currentHeight, targetPos.Z),
				Action = Enum.PathWaypointAction.Walk
			}
			return {
				{
					Position = startPos
				},
				directWaypoint
			}
		end

		local groundStart = Vector3.new(startPos.X, startPos.Y, startPos.Z)
		local groundTarget = Vector3.new(targetPos.X, targetPos.Y, targetPos.Z)

		local path = PathfindingService:CreatePath({
			AgentRadius = agentRadius,
			AgentHeight = 6,
			AgentCanJump = false,
			AgentCanClimb = false,
			WaypointSpacing = math.max(8, waypointDistance),
			Costs = {
				Danger = math.huge,
			}
		})

		local success, err = pcall(function()
			path:ComputeAsync(groundStart, groundTarget)
		end)

		if success and path.Status == Enum.PathStatus.Success then
			local pathWaypoints = path:GetWaypoints()

			local modifiedWaypoints = {}
			for i, waypoint in ipairs(pathWaypoints) do
				local elevatedPos = Vector3.new(waypoint.Position.X, waypoint.Position.Y + currentHeight,
					waypoint.Position.Z)
				table.insert(modifiedWaypoints, {
					Position = elevatedPos,
					Action = waypoint.Action
				})
			end

			return modifiedWaypoints
		else
			local direction = (targetPos - startPos)
			local distance = direction.Magnitude
			local unit = direction.Unit

			local fallbackWaypoints = {}
			table.insert(fallbackWaypoints, {
				Position = startPos,
				Action = Enum.PathWaypointAction.Walk
			})

			local midPoint = startPos + unit * (distance * 0.5)
			local highMidPoint = Vector3.new(midPoint.X, midPoint.Y + currentHeight + 20, midPoint.Z)
			table.insert(fallbackWaypoints, {
				Position = highMidPoint,
				Action = Enum.PathWaypointAction.Walk
			})

			table.insert(fallbackWaypoints, {
				Position = Vector3.new(targetPos.X, targetPos.Y + currentHeight, targetPos.Z),
				Action = Enum.PathWaypointAction.Walk
			})

			return fallbackWaypoints
		end
	end

	local function initializePhysics()
		bg = Instance.new("BodyGyro")
		bg.MaxTorque = Vector3.new(4000, 4000, 4000)
		bg.P = 3000
		bg.D = 500
		bg.CFrame = hrp.CFrame
		bg.Parent = hrp

		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(4000, 4000, 4000)
		bv.Velocity = Vector3.new(0, 0, 0)
		bv.Parent = hrp

		bp = Instance.new("BodyPosition")
		bp.MaxForce = Vector3.new(4000, 4000, 4000)
		bp.P = 3000
		bp.D = 500
		bp.Position = hrp.Position + Vector3.new(0, currentHeight, 0)
		bp.Parent = hrp
	end

	local function performLanding(targetPos)
		if isLanding then
			return
		end
		isLanding = true

		local rayParams = RaycastParams.new()
		rayParams.FilterDescendantsInstances = {
			character
		}
		rayParams.FilterType = Enum.RaycastFilterType.Blacklist

		local groundResult = workspace:Raycast(targetPos, Vector3.new(0, -200, 0), rayParams)
		local landingY = groundResult and groundResult.Position.Y + 3 or targetPos.Y

		local hoverPos = Vector3.new(targetPos.X, targetPos.Y + 8, targetPos.Z)
		bp.Position = hoverPos

		task.wait(hoverDuration)

		local finalPos = Vector3.new(targetPos.X, landingY, targetPos.Z)

		local landingTween = TweenService:Create(bp,
			TweenInfo.new(landingDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Position = finalPos
			})

		local velocityTween = TweenService:Create(bv,
			TweenInfo.new(landingDuration * 0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Velocity = Vector3.new(0, 0, 0)
			})

		landingTween:Play()
		velocityTween:Play()

		landingTween.Completed:Connect(function()
			task.wait(0.3)
			setNoclip(false)
			hrp.Velocity = Vector3.new(0, 0, 0)
		end)
	end

	local function updatePath(destination)
		waypoints = createPath(destination)
		currentWaypointIndex = 1
		lastWaypointTime = tick()

		if debug then
			for i, waypoint in pairs(waypoints) do
				local color = i == 1 and Color3.new(0, 1, 0) or i == # waypoints and Color3.new(0, 0, 1) or
					Color3.new(1, 0.5, 0)
				createDebugWaypoint(waypoint.Position, color, 1.5)
			end
		end

		return waypoints ~= nil
	end

	local function detectObstacles(position, direction, distance)
		local rayParams = RaycastParams.new()
		rayParams.FilterDescendantsInstances = {
			character
		}
		rayParams.FilterType = Enum.RaycastFilterType.Blacklist

		local obstacles = {}
		local checkDistance = math.min(distance, 10)

		local rayDirections = {
			direction,
			direction:Cross(Vector3.new(0, 1, 0)).Unit * 0.3 + direction * 0.954,
			direction:Cross(Vector3.new(0, -1, 0)).Unit * 0.3 + direction * 0.954,
		}

		for i, rayDir in pairs(rayDirections) do
			local result = workspace:Raycast(position, rayDir * checkDistance, rayParams)
			if result and result.Distance > 2 then
				table.insert(obstacles, {
					position = result.Position,
					normal = result.Normal,
					distance = result.Distance,
					direction = i
				})
			end
		end

		local upwardRay = workspace:Raycast(position, Vector3.new(0, 10, 0), rayParams)
		if upwardRay and upwardRay.Distance < 8 then
			table.insert(obstacles, {
				position = upwardRay.Position,
				normal = upwardRay.Normal,
				distance = upwardRay.Distance,
				direction = "ceiling"
			})
		end

		return obstacles
	end

	local function calculateAvoidanceVector(obstacles, currentDirection)
		if # obstacles == 0 then
			return Vector3.new(0, 0, 0)
		end

		local avoidanceVector = Vector3.new(0, 0, 0)
		local totalWeight = 0

		for _, obstacle in pairs(obstacles) do
			if obstacle.distance < 2 then
				local weight = (2 - obstacle.distance) / 6
				weight = weight * 0.3

				local pushDirection = obstacle.normal

				if obstacle.direction == "ceiling" then
					pushDirection = Vector3.new(0, -1, 0)
				elseif pushDirection.Y < 0.2 then
					pushDirection = pushDirection + Vector3.new(0, 0.4, 0)
					pushDirection = pushDirection.Unit
				end

				avoidanceVector = avoidanceVector + (pushDirection * weight)
				totalWeight = totalWeight + weight
			end
		end

		if totalWeight > 0 then
			avoidanceVector = avoidanceVector / totalWeight
			avoidanceVector = avoidanceVector * math.min(0.4, totalWeight)
		end

		return avoidanceVector
	end

	local function moveToWaypoint(waypoint)
		local currentPos = hrp.Position
		local targetPos = waypoint.Position
		local direction = (targetPos - currentPos)
		local distance = direction.Magnitude

		if distance <= waypointDistance then
			currentWaypointIndex = currentWaypointIndex + 1
			lastWaypointTime = tick()
			return true
		end

		local baseDirection = direction.Unit

		local obstacles = detectObstacles(currentPos, baseDirection, distance)
		local avoidanceVector = calculateAvoidanceVector(obstacles, baseDirection)

		local finalDirection = baseDirection + avoidanceVector
		finalDirection = finalDirection.Unit

		local velocity = finalDirection * speed
		local currentVel = bv.Velocity
		local smoothedVel = currentVel:lerp(velocity, smoothness)
		bv.Velocity = smoothedVel

		bp.Position = Vector3.new(targetPos.X, targetPos.Y, targetPos.Z)

		local lookDirection = Vector3.new(smoothedVel.X, 0, smoothedVel.Z)
		if lookDirection.Magnitude > 0.1 then
			local targetCFrame = CFrame.lookAt(currentPos, currentPos + lookDirection)
			bg.CFrame = bg.CFrame:lerp(targetCFrame, smoothness)
		end

		return false
	end

	local finalTarget = toVector3(target) + offset

	initializePhysics()
	setNoclip(true)

	if not updatePath(finalTarget) then
		cleanup()
		if config.OnComplete then
			config.OnComplete(false, "Initial pathfinding failed")
		end
		return
	end

	local conn = RunService.Heartbeat:Connect(function()
		if not isActive then
			return
		end

		if typeof(target) == "Instance" and target:IsA("BasePart") then
			local newTarget = target.Position + offset
			if (newTarget - finalTarget).Magnitude > 10 then
				finalTarget = newTarget
				updatePath(finalTarget)
			end
		end

		local currentPos = hrp.Position
		local distToTarget = (finalTarget - currentPos).Magnitude

		if distToTarget <= stopDist then
			performLanding(finalTarget)
			task.wait(landingDuration + hoverDuration)
			cleanup()
			if config.OnComplete then
				config.OnComplete(true, "Target reached successfully")
			end
			return
		end

		if tick() - startTime > maxTimeout then
			cleanup()
			if config.OnComplete then
				config.OnComplete(false, "Maximum timeout exceeded")
			end
			return
		end

		if tick() - lastWaypointTime > pathTimeout then
			if not updatePath(finalTarget) then
				cleanup()
				if config.OnComplete then
					config.OnComplete(false, "Path recalculation failed")
				end
				return
			end
		end

		if currentWaypointIndex <= # waypoints then
			moveToWaypoint(waypoints[currentWaypointIndex])
		else
			if distToTarget > stopDist then
				if not updatePath(finalTarget) then
					local direction = (finalTarget - currentPos).Unit
					bv.Velocity = bv.Velocity:lerp(direction * speed, smoothness)
					bp.Position = finalTarget + Vector3.new(0, currentHeight, 0)
				end
			end
		end
	end)

	return {
		connection = conn,
		stop = function()
			cleanup()
		end,
		setSpeed = function(newSpeed)
			speed = math.max(5, math.min(50, newSpeed))
		end,
		setTarget = function(newTarget)
			target = newTarget
			finalTarget = toVector3(newTarget) + offset
			updatePath(finalTarget)
		end,
		getProgress = function()
			if # waypoints == 0 then
				return 0
			end
			return math.min(1, currentWaypointIndex / # waypoints)
		end,
		getCurrentHeight = function()
			return currentHeight
		end,
		getDistanceRemaining = function()
			return (finalTarget - hrp.Position).Magnitude
		end,
		getETA = function()
			local distance = (finalTarget - hrp.Position).Magnitude
			return distance / speed
		end,
		isActive = function()
			return isActive
		end,
		pause = function()
			if bv then
				bv.Velocity = Vector3.new(0, 0, 0)
			end
		end,
		resume = function()

		end,
		result = (hrp.Position - finalTarget).Magnitude <= stopDist
	}
end

local function teleportToTarget(target, options)
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local hrp = character:WaitForChild("HumanoidRootPart")
	local targetPos
	if typeof(target) == "Vector3" then
		targetPos = target
	elseif typeof(target) == "Instance" and target:IsA("BasePart") then
		targetPos = target.Position
	else
		error("Invalid target type")
	end
	options = options or {}
	local mode = options.Mode or "Standard"
	local fireRemoteFunc = options.FireRemoteFunc
	local timeout = options.Timeout or 10
	local tpWaitTime = options.TeleportWaitTime or 0.03
	local maxFiresPerTeleport = options.MaxFiresPerTeleport or 10
	local offsetRange = options.OffsetRange or 0.25
	local exitDelay = options.ExitDelay or 0.2
	local onComplete = options.OnComplete
	local rubberBandTolerance = options.RubberBandTolerance or 12
	local rubberBandWaitTime = options.RubberBandWaitTime or 0.3
	local success = false
	local function handleRubberBand(expectedPos)
		local currentPos = hrp.Position
		local distance = (currentPos - expectedPos).Magnitude
		if distance > rubberBandTolerance then
			if (currentPos - expectedPos).Magnitude > 350 then
				createNotification("Distance is too long, try again while being closer to the target", 10)
				return false
			end
			local tweenConfig = {
				CruiseHeight = 6,
				MinHeight = 1,
				MaxHeight = 10,
				LongDistanceThreshold = 150,
				DirectFlightThreshold = 50,
				AdaptiveHeight = true,
				UseDirectFlight = true,
				HoverDuration = 0,
				LandingDuration = 1.2,
				StopDistance = 10,
				OnComplete = function(tweenSuccess, message)
					if typeof(onComplete) == "function" then
						onComplete(tweenSuccess)
					end
				end
			}
			tweenToTarget(expectedPos, tweenConfig)
			return true
		end
		return false
	end

	if mode == "Standard" then
		local maxAttempts = 10
		local tolerance = 10
		for attempt = 1, maxAttempts do
			hrp.CFrame = CFrame.new(targetPos)
			local startTime = tick()
			local settled = false

			task.wait(rubberBandWaitTime)
			if handleRubberBand(targetPos) then
				return true
			end

			while tick() - startTime < 1 do
				task.wait(0.05)
				local distance = (hrp.Position - targetPos).Magnitude
				if distance <= tolerance then
					local stableStart = tick()
					local stable = true
					while tick() - stableStart < 0.2 do
						task.wait(0.05)
						if (hrp.Position - targetPos).Magnitude > tolerance then
							if handleRubberBand(targetPos) then
								return true
							end
							stable = false
							break
						end
					end
					if stable then
						settled = true
						success = true
						break
					end
				end
			end
			if success then
				break
			end
			if attempt < maxAttempts then
				task.wait(0.2)
			end
		end

		if success then
			task.wait(rubberBandWaitTime)
			if handleRubberBand(targetPos) then
				return true
			end
		end
	elseif mode == "Critical" then
		if typeof(fireRemoteFunc) ~= "function" then
			error("Critical mode requires FireRemoteFunc")
		end
		local originalPos = hrp.Position
		local startTime = tick()
		local remoteRunning = true

		local remoteThread = task.spawn(function()
			while task.wait() do
				local ok, result = pcall(fireRemoteFunc)
				if ok and typeof(result) == "number" and result > 0 then
					success = true
					hrp.CFrame = CFrame.new(originalPos)
					break
				end
			end
		end)

		while tick() - startTime < timeout and not success do
			for i = 1, 15 do
				if success then break end
				local offset = Vector3.new(
					math.random() * offsetRange - offsetRange / 2,
					math.random(5, 10),
					math.random() * offsetRange - offsetRange / 2
				)
				hrp.CFrame = CFrame.new(targetPos + offset)
				task.wait()
			end
			hrp.CFrame = CFrame.new(originalPos)
			task.wait(1)
		end

		if remoteThread then
			task.cancel(remoteThread)
		end
		hrp.CFrame = CFrame.new(originalPos)
	end

	if typeof(onComplete) == "function" then
		onComplete(success)
	end
	return success
end

local function walkToTarget(target, config)
	-- WIP
end

local function handlePanAction(mode, actionType, executeToCompletion, killSwitch)
	executeToCompletion = executeToCompletion or false
	local messages = {
		dig = {
			start = "Starting dig action...",
			success = "Pan is now full!",
			singleSuccess = "Collection completed!",
			alreadyFull = "Pan is already full!",
			leftRegion = "Left deposit region! Stopping.",
			singleAction = "Performing single collection..."
		},
		wash = {
			start = "Starting wash action...",
			PanEmpty = "Pan is empty, cannot wash!"
		},
		general = {
			noPan = "No Pan found.",
			noScript = "Pan has no scripts.",
			invalidAction = "Invalid action type! Use 'Dig' or 'Wash'.",
			legitWIP = "Legit mode is Work In Progress!"
		}
	}

	local function validatePan()
		local pan = equipPan()
		local folder = pan and pan:FindFirstChild("Scripts")
		if not folder then
			createNotification(messages.general.noPan)
			return nil
		end
		local scripts = {}
		for _, child in ipairs(folder:GetChildren()) do
			if child:IsA("RemoteFunction") or child:IsA("RemoteEvent") then
				scripts[child.Name] = child
			end
		end
		if next(scripts) then
			return scripts
		else
			createNotification(messages.general.noScript)
			return nil
		end
	end

	local function isInValidRegion(forWhat)
		local char = Player.Character
		return char and char:FindFirstChild("HumanoidRootPart") and getRegion(char.HumanoidRootPart) == forWhat
	end

	local function shakeUntilNotPanning(shakeScript, killSwitch)
		while LocalCharacter:GetAttribute("Panning") do
			if killSwitch and not killSwitch() then
				return false
			end
			pcall(function()
				shakeScript:FireServer()
			end)
			task.wait()
		end
		return true
	end

	local function fillToCompletion(collectScript, msgs)
		local scripts = validatePan()
		local shakeScript = scripts and scripts.Shake

		while task.wait() do
			if killSwitch and not killSwitch() then
				return "KILLED"
			end

			if LocalCharacter:GetAttribute("Panning") then
				if shakeScript and not shakeUntilNotPanning(shakeScript, killSwitch) then
					return "KILLED"
				end
			end

			local status = getPanStatus()
			if status and status.isFull then
				createNotification(msgs.success)
				break
			end

			if not isInValidRegion("Deposit") then
				createNotification(msgs.leftRegion)
				break
			end

			pcall(CollectInvokeServer, collectScript)
		end
		return (not killSwitch or killSwitch()) and "SUCCESS" or "KILLED"
	end

	local function executeSingle(collectScript, msgs)
		if killSwitch and not killSwitch() then
			return "KILLED"
		end
		createNotification(msgs.singleAction)
		pcall(CollectInvokeServer, collectScript)
		createNotification(msgs.singleSuccess)
		return "SUCCESS"
	end

	local function emptyToCompletion(shakeScript, msgs)
		while task.wait() do
			if killSwitch and not killSwitch() then
				WashAnimation:Stop()
				return "KILLED"
			end

			if not shakeUntilNotPanning(shakeScript, killSwitch) then
				WashAnimation:Stop()
				return "KILLED"
			end

			local status = getPanStatus()
			if not status or status.isEmpty then
				break
			end

			pcall(function()
				shakeScript:FireServer()
			end)
		end
		WashAnimation:Stop()
		return (not killSwitch or killSwitch()) and "SUCCESS" or "KILLED"
	end

	local handlers = {
		Dig = function()
			if killSwitch and not killSwitch() then
				return "KILLED"
			end

			local msgs = messages.dig
			createNotification(msgs.start)
			local scripts = validatePan()
			if not scripts then
				return "FAIL"
			end
			local collectScript = scripts.Collect
			if not collectScript then
				return "FAIL"
			end

			local status = getPanStatus()
			if status and status.isFull then
				createNotification(msgs.alreadyFull)
				return "SUCCESS"
			end

			if mode == "Legit" then
				createNotification(messages.general.legitWIP, 3)
				return "FAIL"
			elseif mode == "Instant" then
				if executeToCompletion then
					return fillToCompletion(collectScript, msgs)
				else
					return executeSingle(collectScript, msgs)
				end
			end
			return "FAIL"
		end,

		Wash = function()
			if killSwitch and not killSwitch() then
				return "KILLED"
			end

			local scripts = validatePan()
			if not scripts then
				return "FAIL"
			end
			local shakeScript = scripts.Shake
			local panScript = scripts.Pan
			if not shakeScript or not panScript then
				return "FAIL"
			end

			local status = getPanStatus()
			if status and status.isEmpty then
				createNotification(messages.wash.PanEmpty)
				return "SUCCESS"
			end

			pcall(function()
				panScript:InvokeServer()
			end)
			return emptyToCompletion(shakeScript, messages.wash)
		end
	}

	local handler = handlers[actionType]
	if not handler then
		createNotification(messages.general.invalidAction)
		return "FAIL"
	end

	local ok, result = pcall(handler)
	if not ok then
		warn("PanAction failed: " .. tostring(result))
		return "FAIL"
	end
	return result or "SUCCESS"
end

local function applyDefaults(config, mode)
	local defaults = {}

	if mode == "Tween" then
		defaults = {
			StopDistance = 20,
			CruiseHeight = 6,
			MaxHeight = 10,
			MinHeight = 1,
			LongDistanceThreshold = 150,
			DirectFlightThreshold = 50,
			AdaptiveHeight = true,
			UseDirectFlight = true,
			HoverDuration = 0.3,
			LandingDuration = 1.2,
		}
	else
		defaults = {
			Mode = "Critical",
			Timeout = 90
		}
	end

	for k, v in pairs(defaults) do
		if config[k] == nil then
			config[k] = v
		end
	end
end

local function handleVoidSellRequest()
	local LocalPlayer = game.Players.LocalPlayer
	local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart

	createNotification("Exiting The Void to find merchant...", 5)

	HumanoidRootPart.CFrame = CFrame.new(workspace.Map.EventStuff["The Void"].Model.ExitPortal.CFrame.Position +
		Vector3.new(0, 3, 0))

	local maxWait = tick() + 15
	repeat
		task.wait(0.1)
	until (LocalPlayer:GetAttribute("CurrentArea") == "Fortune River" and LocalPlayer:GetAttribute("GameplayPaused") == false) or tick() > maxWait

	if LocalPlayer:GetAttribute("CurrentArea") ~= "Fortune River" then
		createNotification("Failed to exit The Void properly.", 5)
		return false
	end

	task.wait(2)

	local closestHrp
	for i = 1, 4 do
		closestHrp = getClosestMerchant()
		if closestHrp then break end
		if i < 4 then task.wait(1) end
	end

	if not closestHrp then
		createNotification("No merchant found after exiting void.", 5)
		HumanoidRootPart.CFrame = CFrame.new(workspace.Map.EventStuff.VoidPortal.Part.CFrame.Position +
			Vector3.new(0, 3, 0))
		return false
	end

	createNotification("Found merchant, teleporting and selling...", 5)

	local sellSuccess = teleportToTarget(closestHrp.Position, {
		Mode = "Critical",
		FireRemoteFunc = function()
			createNotification("Selling all valuables...", 3)
			return game:GetService("ReplicatedStorage").Remotes.Shop.SellAll:InvokeServer()
		end,
		Timeout = 90
	})

	if sellSuccess then
		task.wait(1)
		createNotification("Returning to The Void...", 5)
		HumanoidRootPart.CFrame = CFrame.new(workspace.Map.EventStuff.VoidPortal.Part.CFrame.Position +
			Vector3.new(0, 3, 0))
	end

	return sellSuccess
end

local function executeSell()
	return game:GetService("ReplicatedStorage").Remotes.Shop.SellAll:InvokeServer()
end

local function sellInventory(config, mode)
	local closestHrp, dist = getClosestMerchant()

	if not closestHrp and game.Players.LocalPlayer:GetAttribute("CurrentArea") == "The Void" then
		return handleVoidSellRequest(config, mode)
	end

	if closestHrp and dist <= (config.RequiredDistance or 45) then
		executeSell()
		return true
	end

	if not closestHrp then
		createNotification("No merchant found nearby.", 5)
		return false
	end

	applyDefaults(config, mode)

	if mode == "Tween" then
		local completed = false
		local successSell = false

		config.OnStart = function()
			createNotification("Tweening to merchant...", 5)
		end

		config.OnComplete = function()
			task.wait(1)
			local _, finalDistance = getClosestMerchant()
			if finalDistance and finalDistance <= 45 then
				executeSell()
				successSell = true
			else
				createNotification("Could not reach merchant via tween.", 5)
			end
			completed = true
		end

		tweenToTarget(closestHrp, config)
		repeat
			task.wait()
		until completed
		return successSell
	else
		config.FireRemoteFunc = function()
			return executeSell()
		end

		local success = teleportToTarget(closestHrp, config)
		return success
	end
end

local function getInventoryCount()
	local player = game:GetService("Players").LocalPlayer
	local backpack = player:WaitForChild("BackpackTwo")
	local count = 0
	for _, item in ipairs(backpack:GetChildren()) do
		if item:GetAttribute("ItemType") == "Valuable" then
			count += 1
		end
	end
	return count
end

local function formatPrice(price, isShardPrice)
	local symbol = isShardPrice and "ƒ" or "$"

	if price >= 1e21 then
		return string.format("%s%.1fSx", symbol, price / 1e21)
	elseif price >= 1e18 then
		return string.format("%s%.1fQ", symbol, price / 1e18)
	elseif price >= 1e15 then
		return string.format("%s%.1fqd", symbol, price / 1e15)
	elseif price >= 1e12 then
		return string.format("%s%.1fT", symbol, price / 1e12)
	elseif price >= 1e9 then
		return string.format("%s%.1fB", symbol, price / 1e9)
	elseif price >= 1e6 then
		return string.format("%s%.1fM", symbol, price / 1e6)
	elseif price >= 1e3 then
		return string.format("%s%.1fK", symbol, price / 1e3)
	else
		return symbol .. tostring(price)
	end
end

local function buildPurchasableTable()
	local purchasable = {
		Pans = {},
		Shovels = {},
		Sluices = {},
		Potions = {},
		Totems = {},
		Others = {}
	}
	local purchRoot = workspace:FindFirstChild("Purchasable")
	if not purchRoot then
		return purchasable
	end
	for _, region in ipairs(purchRoot:GetChildren()) do
		for _, item in ipairs(region:GetChildren()) do
			local shopItem = item:FindFirstChild("ShopItem")
			local stats = shopItem and shopItem:FindFirstChild("Stats")
			if shopItem and stats then
				local isShardPrice = shopItem:GetAttribute("Price") == nil and shopItem:GetAttribute("ShardPrice") ~= nil
				local price = shopItem:GetAttribute(isShardPrice and "ShardPrice" or "Price")

				if price then
					local formattedEntry = item.Name .. " - " .. formatPrice(price, isShardPrice)
					if stats:GetAttribute("ShakeSpeed") then
						table.insert(purchasable.Pans, formattedEntry)
					elseif stats:GetAttribute("DigSpeed") then
						table.insert(purchasable.Shovels, formattedEntry)
					elseif stats:GetAttribute("SluiceSpeed") then
						table.insert(purchasable.Sluices, formattedEntry)
					elseif string.find(item.Name:lower(), "potion") then
						table.insert(purchasable.Potions, formattedEntry)
					elseif string.find(item.Name:lower(), "totem") then
						table.insert(purchasable.Totems, formattedEntry)
					else
						table.insert(purchasable.Others, formattedEntry)
					end
				end
			end
		end
	end
	return purchasable
end

local ConfirmationPrompt = {}
function ConfirmationPrompt.show(config)
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")

	if playerGui:FindFirstChild("ConfirmationPrompt") then
		return
	end

	local item = config.item or "Item"
	local price = config.price or "$0"
	local title = config.title or "Confirm Purchase"
	local subtitle = config.subtitle or "This action cannot be undone"
	local confirmText = config.confirmText or "Purchase"
	local cancelText = config.cancelText or "Cancel"
	local purchaseFunction = config.onPurchase or function()
	end
	local cancelFunction = config.onCancel or function()
	end
	local gui = Instance.new("ScreenGui")
	gui.Name = "ConfirmationPrompt"
	gui.DisplayOrder = 999
	gui.Parent = playerGui
	gui.IgnoreGuiInset = true
	local overlay = Instance.new("Frame")
	overlay.Size = UDim2.new(1, 0, 1, 0)
	overlay.BackgroundColor3 = Color3.new(0, 0, 0)
	overlay.BackgroundTransparency = 0.6
	overlay.Active = true
	overlay.Selectable = true
	overlay.BorderSizePixel = 0
	overlay.Parent = gui
	local dialog = Instance.new("Frame")
	dialog.Size = UDim2.new(0, 420, 0, 280)
	dialog.Position = UDim2.new(0.5, -210, 0.5, -140)
	dialog.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	dialog.BorderSizePixel = 0
	dialog.Parent = overlay
	local function corner(obj, r)
		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(0, r)
		c.Parent = obj
	end
	corner(dialog, 16)
	local header = Instance.new("Frame")
	header.Size = UDim2.new(1, 0, 0, 70)
	header.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	header.BorderSizePixel = 0
	header.Parent = dialog
	local headerCorner = Instance.new("UICorner")
	headerCorner.CornerRadius = UDim.new(0, 16)
	headerCorner.Parent = header
	local headerMask = Instance.new("Frame")
	headerMask.Size = UDim2.new(1, 0, 0, 16)
	headerMask.Position = UDim2.new(0, 0, 1, -16)
	headerMask.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	headerMask.BorderSizePixel = 0
	headerMask.Parent = header
	local icon = Instance.new("Frame")
	icon.Size = UDim2.new(0, 36, 0, 36)
	icon.Position = UDim2.new(0, 25, 0.5, -18)
	icon.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
	icon.BorderSizePixel = 0
	icon.Parent = header
	corner(icon, 18)
	local iconText = Instance.new("TextLabel")
	iconText.Size = UDim2.new(1, 0, 1, 0)
	iconText.BackgroundTransparency = 1
	iconText.Text = "⚠"
	iconText.TextColor3 = Color3.new(1, 1, 1)
	iconText.TextSize = 20
	iconText.Font = Enum.Font.GothamBold
	iconText.TextXAlignment = Enum.TextXAlignment.Center
	iconText.TextYAlignment = Enum.TextYAlignment.Center
	iconText.Parent = icon
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -85, 0, 25)
	titleLabel.Position = UDim2.new(0, 75, 0, 15)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = Color3.new(1, 1, 1)
	titleLabel.TextSize = 18
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextYAlignment = Enum.TextYAlignment.Center
	titleLabel.Parent = header
	local subtitleLabel = Instance.new("TextLabel")
	subtitleLabel.Size = UDim2.new(1, -85, 0, 20)
	subtitleLabel.Position = UDim2.new(0, 75, 0, 40)
	subtitleLabel.BackgroundTransparency = 1
	subtitleLabel.Text = subtitle
	subtitleLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
	subtitleLabel.TextSize = 12
	subtitleLabel.Font = Enum.Font.Gotham
	subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	subtitleLabel.TextYAlignment = Enum.TextYAlignment.Center
	subtitleLabel.Parent = header
	local itemFrame = Instance.new("Frame")
	itemFrame.Size = UDim2.new(1, -50, 0, 80)
	itemFrame.Position = UDim2.new(0, 25, 0, 90)
	itemFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	itemFrame.BorderSizePixel = 0
	itemFrame.Parent = dialog
	corner(itemFrame, 12)
	local itemName = Instance.new("TextLabel")
	itemName.Size = UDim2.new(1, -30, 0, 30)
	itemName.Position = UDim2.new(0, 15, 0, 15)
	itemName.BackgroundTransparency = 1
	itemName.Text = item
	itemName.TextColor3 = Color3.new(1, 1, 1)
	itemName.TextSize = 16
	itemName.Font = Enum.Font.GothamBold
	itemName.TextXAlignment = Enum.TextXAlignment.Left
	itemName.TextYAlignment = Enum.TextYAlignment.Center
	itemName.Parent = itemFrame
	local priceLabel = Instance.new("TextLabel")
	priceLabel.Size = UDim2.new(1, -30, 0, 25)
	priceLabel.Position = UDim2.new(0, 15, 0, 45)
	priceLabel.BackgroundTransparency = 1
	priceLabel.Text = price
	priceLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
	priceLabel.TextSize = 24
	priceLabel.Font = Enum.Font.GothamBold
	priceLabel.TextXAlignment = Enum.TextXAlignment.Left
	priceLabel.TextYAlignment = Enum.TextYAlignment.Center
	priceLabel.Parent = itemFrame
	local btnContainer = Instance.new("Frame")
	btnContainer.Size = UDim2.new(1, -50, 0, 50)
	btnContainer.Position = UDim2.new(0, 25, 1, -75)
	btnContainer.BackgroundTransparency = 1
	btnContainer.Parent = dialog
	local cancelBtn = Instance.new("TextButton")
	cancelBtn.Size = UDim2.new(0.45, 0, 1, 0)
	cancelBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
	cancelBtn.BorderSizePixel = 0
	cancelBtn.Text = cancelText
	cancelBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
	cancelBtn.TextSize = 14
	cancelBtn.Font = Enum.Font.GothamMedium
	cancelBtn.Parent = btnContainer
	corner(cancelBtn, 10)
	local confirmBtn = Instance.new("TextButton")
	confirmBtn.Size = UDim2.new(0.45, 0, 1, 0)
	confirmBtn.Position = UDim2.new(0.55, 0, 0, 0)
	confirmBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 85)
	confirmBtn.BorderSizePixel = 0
	confirmBtn.Text = confirmText
	confirmBtn.TextColor3 = Color3.new(1, 1, 1)
	confirmBtn.TextSize = 14
	confirmBtn.Font = Enum.Font.GothamBold
	confirmBtn.Parent = btnContainer
	corner(confirmBtn, 10)
	local function close()
		gui:Destroy()
	end
	cancelBtn.Activated:Connect(function()
		close()
		cancelFunction()
	end)
	confirmBtn.Activated:Connect(function()
		close()
		purchaseFunction()
	end)
	return gui
end

local selectedOptions = {
	pan = nil,
	shovel = nil,
	sluice = nil,
	potion = nil,
	totem = nil,
	other = nil,
}

local function findModelByName(name)
	for _, folder in pairs(workspace.Purchasable:GetChildren()) do
		if folder:IsA("Folder") then
			local model = folder:FindFirstChild(name)
			if model and model:IsA("Model") then
				return model
			end
		end
	end
	return nil
end

local function handlePurchase(itemType, selectedOption)
	if not selectedOption then
		createNotification("Please select a " .. itemType .. " first!", 5)
		return
	end
	local name, price = selectedOption:match("^(.+) %- ([ƒ%$].+)$")
	local remoteEvent = game:GetService("ReplicatedStorage").Remotes.Shop.BuyItem
	if name and price then
		ConfirmationPrompt.show({
			item = name,
			price = price,
			title = itemType:gsub("^%l", string.upper) .. " Purchase",
			confirmText = "Buy Now",
			cancelText = "Not Now",
			onPurchase = function()
				local model = findModelByName(name)
				local shopItem = model and model:FindFirstChild("ShopItem")
				if shopItem then
					createNotification("Triggered purchase for " .. name .. " for " .. price .. "!", 5)
					remoteEvent:InvokeServer(shopItem)
				else
					createNotification("Error: Could not find item or ShopItem in workspace!", 5)
				end
			end,
			onCancel = function()
				createNotification("Purchase cancelled", 5)
			end
		})
	else
		createNotification("Error: Invalid item format!", 5)
	end
end

local storedValues = {}

local function lockCharacterAt(targetCFrame)
	local player = Players.LocalPlayer
	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	hrp.CFrame = targetCFrame
	hrp.Velocity = Vector3.new(0, 0, 0)
	hrp.RotVelocity = Vector3.new(0, 0, 0)
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		storedValues[player.UserId] = {
			WalkSpeed = hum.WalkSpeed,
			JumpPower = hum.JumpPower
		}
		hum.WalkSpeed = 0
		hum.JumpPower = 0
		hum:ChangeState(Enum.HumanoidStateType.Seated)
	end
end

local function unlockCharacter()
	local player = Players.LocalPlayer
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		local values = storedValues[player.UserId] or { WalkSpeed = 16, JumpPower = 50 }
		hum.WalkSpeed = values.WalkSpeed
		hum.JumpPower = values.JumpPower
		hum:ChangeState(Enum.HumanoidStateType.GettingUp)
		storedValues[player.UserId] = nil
	end
end

createDropdown("SellTypeDropdown", "Sell Type", {
	"Threshold",
	"Time"
}, "Threshold", function(opt)
	SellSettings.type = opt
	createNotification("📌 Sell Type: " .. opt)
end, sellSection)

createTextBox("SellTextBox", "Enter Sell Int or Time", nil, function(value)
	local result, kind = validateSellValue(value)
	if result then
		if kind == "time" then
			SellDelay = result
			createNotification("✅ Sell delay set! The inventory will now be sold every " .. result .. " seconds!", 10)
		else
			SellThreshold = result
			createNotification("✅ Sell value set! The inventory will now be sold every " .. result .. " items", 10)
		end
	else
		createNotification(
			"❌ Invalid input. Use either Threshold from 10 to 900 items OR use Time from 30 seconds to 1 day.", 10)
	end
end, sellSection)

createButton("StartSellButton", "Sell all your valuables", function()
	if TaskManager:getMainTask() then
		return createNotification("Please wait for current task to complete", 5)
	end
	if not TaskManager:requestTask("ManualSell", 3) then
		return createNotification("Could not start sell task", 5)
	end
	task.spawn(function()
		if TaskManager:waitForTurn("ManualSell", 10) and TaskManager:startTask("ManualSell") then
			TaskManager:setCurrentTask("Selling")
			sellInventory({}, SellSettings.mode or "Teleport")
			TaskManager:finishTask("ManualSell")
		end
	end)
end, sellSection)

createToggleButton("AutoSellToggle", "Auto Sell", false, function(state)
	SellSettings.autoSell = state
	SellSettings._lastSell = SellSettings._lastSell or 0
	SellSettings._scheduledSell = false
	if state then
		task.spawn(function()
			while SellSettings.autoSell do
				if SellSettings.type == "Time" then
					local delay = tonumber(SellDelay) or 300
					if os.clock() - SellSettings._lastSell >= delay then
						SellSettings._scheduledSell = true
					end
				end
				--[[
if SellSettings.type == "Threshold" then
	local currentItems = getInventoryCount()
	local thresholdItems = SellSettings.threshold or 300
	if currentItems >= thresholdItems then
		sellInventory({}, "Teleport") -- Gotta schedule instead
	end
end
]] --
				task.wait(5)
			end
		end)
	end
	createNotification(state and "✅ Auto Sell Enabled" or "❌ Auto Sell Disabled")
end, sellSection)

createDropdown("FarmingModeDropdown", "Select Farming mode", {
	"Legit",
	"Instant"
}, "Instant", function(opt)
	AutoFarmState.actionMode = opt
	createNotification("📌 Farming Mode: " .. opt, 10)
	if opt == "Legit" then
		createNotification(
			"Hello there, this mode is currently NOT available, im trying to get it together but it's taking quite a lot of time to figure things out, thus Instant is the only usable mode as of now",
			10)
	end
end, autoFarmSection)

createDropdown("FarmingTravelDropdown", "Select Travel mode", {
	"Tween",
	"Teleport"
}, "Teleport", function(opt)
	AutoFarmState.travelMode = opt
	createNotification("📌 Farming Travel mode: " .. opt, 10)
end, autoFarmSection)

createButton("SetSandCframeButton", "Set Sand CFrame", function()
	if getRegion(HumanoidRootPart) == "Deposit" then
		AutoFarmState.sandCFrame = HumanoidRootPart.CFrame
		createNotification("✅ Sand CFrame set")
	else
		createNotification("❌ Must be at deposit")
	end
end, autoFarmSection)

createButton("SetWaterCframeButton", "Set Water CFrame", function()
	if getRegion(HumanoidRootPart) == "Water" then
		AutoFarmState.waterCFrame = HumanoidRootPart.CFrame
		createNotification("✅ Water CFrame set")
	else
		createNotification("❌ Must be at water")
	end
end, autoFarmSection)

createToggleButton("AutoFarmToggle", "Auto Farm", false, function(state)
	AutoFarmState.active = state
	AutoFarmState.interrupted = false
	if state then
		if not AutoFarmState.travelMode or AutoFarmState.travelMode == "" then
			createNotification("❌ Select travel mode!")
			AutoFarmState.active = false
			return
		end
		if not AutoFarmState.actionMode or AutoFarmState.actionMode == "" then
			createNotification("❌ Select farming mode!")
			AutoFarmState.active = false
			return
		end
		if not (AutoFarmState.sandCFrame and AutoFarmState.waterCFrame) then
			createNotification("❌ Set CFrames!")
			AutoFarmState.active = false
			return
		end
		createNotification("🚀 Starting!")
		task.spawn(function()
			while AutoFarmState.active do
				if not TaskManager:requestTask("AutoFarm", 1) then
					task.wait(0.1)
					continue
				end
				if not TaskManager:waitForTurn("AutoFarm", 5) then
					continue
				end
				if not TaskManager:startTask("AutoFarm") then
					task.wait(0.1)
					continue
				end

				local function moveToLocation(targetCFrame, locationName)
					local completed = false
					local success   = false
					local targetObj = { Position = targetCFrame.Position, CFrame = targetCFrame }

					if AutoFarmState.travelMode == "Tween" then
						tweenToTarget(targetObj, {
							CruiseHeight = 4,
							MinHeight = 1,
							MaxHeight = 6,
							LongDistanceThreshold = 100,
							DirectFlightThreshold = 30,
							AdaptiveHeight = false,
							UseDirectFlight = true,
							HoverDuration = 0,
							LandingDuration = 0.3,
							StopDistance = 5,
							OnComplete = function(moveSuccess)
								success = moveSuccess or false
								completed = true
							end
						})
					else
						teleportToTarget(targetObj.Position, {
							Mode = "Standard",
							OnComplete = function(moveSuccess)
								success = moveSuccess or false
								completed = true
							end
						})
					end

					local timeout = 45
					local elapsed = 0
					while not completed and elapsed < timeout and AutoFarmState.active do
						task.wait(0.05)
						elapsed = elapsed + 0.05
					end

					if success then
						lockCharacterAt(targetCFrame)
						AutoFarmState.locked = true
					end
					return success
				end

				local function doAction(actionType, expectedRegion)
					local success, result = pcall(function()
						local pan = equipPan()
						if not pan then
							createNotification("No pan?!")
							return false
						end

						local currentRegion = getRegion(HumanoidRootPart)
						if currentRegion ~= expectedRegion then return false end

						local killSwitch = function() return AutoFarmState.active end
						local actionResult = handlePanAction(AutoFarmState.actionMode, actionType, true, killSwitch)
						return actionResult ~= "MAX_RETRY_FAIL" and actionResult ~= "KILLED"
					end)
					return success and result
				end

				local function performTask(taskName, nextTask, targetCFrame, actionType, expectedRegion, locationName)
					TaskManager:setNextTask(nextTask)
					TaskManager:setCurrentTask(taskName)

					local startTime = os.clock()

					local reached = moveToLocation(targetCFrame, locationName)

					local duration = os.clock() - startTime
					warn(string.format("[AutoFarm] moveToLocation -> %s took %.2f seconds", locationName, duration))

					if reached then
						local actionStart = os.clock()
						task.wait(0.100)
						if doAction(actionType, expectedRegion) then
							local actionDuration = os.clock() - actionStart
							warn(string.format("[AutoFarm] doAction -> %s took %.2f seconds", actionType, actionDuration))

							TaskManager:setCurrentTask("AutoFarm")
							return true
						end
					end

					return false
				end

				local function checkAndDoSell()
					if not SellSettings.autoSell then return false end

					local shouldSell = false
					local type = SellSettings.type or "Threshold"
					if type == "Threshold" then
						shouldSell = getInventoryCount() >= (tonumber(SellThreshold) or 50)
					elseif type == "Time" then
						shouldSell = SellSettings._scheduledSell or
							(os.clock() - (SellSettings._lastSell or 0) >= (tonumber(SellDelay) or 300))
					end

					if shouldSell then
						local sellSuccess = sellInventory({}, SellSettings.mode or "Teleport")
						if sellSuccess then
							SellSettings._lastSell = os.clock()
							SellSettings._scheduledSell = false
							if Players.LocalPlayer and Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
								lockCharacterAt(Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
								AutoFarmState.locked = true
							end
							return true
						end
					end
					return false
				end

				while AutoFarmState.active and TaskManager:canRun("AutoFarm") do
					if AutoFarmState.interrupted then
						if AutoFarmState.locked then
							unlockCharacter()
							AutoFarmState.locked = false
						end
						while AutoFarmState.interrupted and AutoFarmState.active do
							task.wait(0.1)
						end
						continue
					end
					local success, errorMsg = pcall(function()
						if not (Players.LocalPlayer and Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
							AutoFarmState.active = false
							return
						end

						PanStatus = getPanStatus()
						if not PanStatus then
							task.wait(0.050)
							return
						end

						if PanStatus.isFull then
							if performTask("MovingToWater", "WashPan", AutoFarmState.waterCFrame, "Wash", "Water", "water") then
								checkAndDoSell()
							else
								AutoFarmState.active = false
							end
						elseif PanStatus.isEmpty or not PanStatus.isFull then
							if not performTask("MovingToSand", "DigSand", AutoFarmState.sandCFrame, "Dig", "Deposit", "sand deposit") then
								AutoFarmState.active = false
							end
						end
					end)


					if not success then
						if AutoFarmState.locked then
							unlockCharacter()
							AutoFarmState.locked = false
						end
						task.wait(0.050)
					end

					if AutoFarmState.active then
						task.wait(0.01)
					end
				end

				TaskManager:finishTask("AutoFarm")
			end
			if AutoFarmState.locked then
				unlockCharacter()
				AutoFarmState.locked = false
			end
			unlockCharacter()
			createNotification("🛑 Stopped")
		end)
	else
		TaskManager:clearSubTasks()
		if TaskManager:getMainTask() == "AutoFarm" then
			TaskManager:finishTask("AutoFarm")
		end
		if AutoFarmState.locked then
			unlockCharacter()
			AutoFarmState.locked = false
		end
	end
end, autoFarmSection)

createButton("UnlockCharacterAutoFarmButton", "Unstuck Character", function()
	unlockCharacter()
end, autoFarmSection)

createButton("CalibrateButton", "Calibrate Teleport", function(btn)
	if btn.Text == "Testing..." then
		return
	end
	btn.Text = "Testing..."
	btn.TextColor3 = Color3.fromRGB(255, 255, 100)
	task.spawn(function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")
		local hrp = character:WaitForChild("HumanoidRootPart")

		humanoid.PlatformStand = true
		humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		hrp.AssemblyLinearVelocity = Vector3.zero
		hrp.AssemblyAngularVelocity = Vector3.zero

		local homeBase = hrp.Position
		local rubberBands = 0
		local slips = 0
		local tests = 0

		for cycle = 1, 40 do
			local currentPos = hrp.Position

			local angle = math.random() * math.pi * 2
			local distance = math.random(120, 300)
			local teleportTarget = currentPos + Vector3.new(
				math.cos(angle) * distance, math.random(40, 150), math.sin(angle) * distance)

			hrp.CFrame = CFrame.new(teleportTarget)
			hrp.AssemblyLinearVelocity = Vector3.zero
			hrp.AssemblyAngularVelocity = Vector3.zero

			local teleportedTo = hrp.Position
			tests = tests + 1

			local gotRubberBanded = false
			for frame = 1, 25 do
				local nowPos = hrp.Position
				local movedFromTeleport = (nowPos - teleportedTo).Magnitude
				local backToStart = (nowPos - currentPos).Magnitude

				if movedFromTeleport > 20 or (backToStart < 35 and movedFromTeleport > 50) then
					gotRubberBanded = true
					break
				end
				task.wait(0.002)
			end

			if gotRubberBanded then
				rubberBands = rubberBands + 1
			else
				slips = slips + 1
			end

			task.wait(0.01)
		end

		humanoid.PlatformStand = false
		humanoid:ChangeState(Enum.HumanoidStateType.Running)

		local rbRate = rubberBands / tests

		if rbRate >= 0.9 then
			btn.Text = "PERFECT! (" .. rubberBands .. "/" .. tests .. ")"
			btn.TextColor3 = Color3.fromRGB(100, 255, 100)
		elseif rbRate >= 0.75 then
			btn.Text = "GOOD! (" .. rubberBands .. "/" .. tests .. ")"
			btn.TextColor3 = Color3.fromRGB(150, 255, 100)
		elseif rbRate >= 0.5 then
			btn.Text = "WEAK! (" .. rubberBands .. "/" .. tests .. ")"
			btn.TextColor3 = Color3.fromRGB(255, 200, 100)
		elseif rbRate >= 0.25 then
			btn.Text = "POOR! (" .. rubberBands .. "/" .. tests .. ")"
			btn.TextColor3 = Color3.fromRGB(255, 150, 100)
		else
			btn.Text = "NO SYNC! Compulsory re-run (" .. rubberBands .. "/" .. tests .. ")"
			btn.TextColor3 = Color3.fromRGB(255, 100, 100)
		end
		createNotification(
			"Calibration complete. (P.S. bad scores don't make you useless at all! teleport farming still works!)", 10)
		task.wait(5)
		btn.Text = "Calibrate Teleport"
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)
end, autoFarmSection, {
	2,
	1
})

createInfo2("AutoFarmCalibrateWarning", "Calibrate", "Please run calibrate once before using teleport for auto farm.",
	function()
		-- empty
	end, autoFarmSection, { 2, 1 })

local teleportDropdown = createDropdown("TeleportDownload", "Select Waypoint", {}, nil, function(opt)
	local waypoints = workspace.Map.Waypoints
	local player = game:GetService("Players").LocalPlayer
	local attr = player:GetAttribute("CurrentArea")
	local currentWaypoint = nil
	for _, w in pairs(waypoints:GetChildren()) do
		if string.find(string.lower(attr), string.lower(w.Name)) then
			currentWaypoint = w
			break
		end
	end
	currentWaypoint = currentWaypoint or waypoints["Museum"]
	local targetWaypoint = waypoints:FindFirstChild(opt)
	if currentWaypoint and targetWaypoint then
		game.ReplicatedStorage.Remotes.Misc.FastTravel:FireServer(currentWaypoint, targetWaypoint)
	end
end, teleportSection)

createButton("TeleportRefreshButton", "Refresh Waypoints", function()
	local waypointsTable = {}
	local waypointFolder = workspace.Map:FindFirstChild("Waypoints")
	if waypointFolder then
		for _, wp in pairs(waypointFolder:GetChildren()) do
			if wp:IsA("Model") then
				table.insert(waypointsTable, wp.Name)
			end
		end
	end
	teleportDropdown.AddChildren(waypointsTable)
end, teleportSection)

createButton("UnlockAllWaypointsButton", "Unlock all Waypoints", function()
	local hrp = Player.Character:WaitForChild("HumanoidRootPart")
	local waypoints = workspace.Map.Waypoints:GetChildren()

	local FastTravelDataRemote = ReplicatedStorage.Remotes.Misc.GetFastTravelData
	local unlocked = {}

	FastTravelDataRemote.OnClientEvent:Connect(function(data)
		unlocked = data
	end)

	FastTravelDataRemote:FireServer()

	local function unlock(model)
		local prompt = model:FindFirstChild("WaypointPrompt", true)
		if not prompt then
			return
		end
		while unlocked[model.Name] ~= true do
			hrp.CFrame = model:GetPivot() + Vector3.new(0, 5, 0)
			fireproximityprompt(prompt)
			RunService.Heartbeat:Wait()
		end
	end

	task.spawn(function()
		while true do
			for _, model in ipairs(waypoints) do
				if not unlocked[model.Name] then
					unlock(model)
				end
			end
			task.wait(1)
			FastTravelDataRemote:FireServer()
			if next(unlocked) and not table.find(unlocked, false) then
				break
			end
		end
	end)
end, teleportSection)

local equipmentNames = {}
local priceLabel = nil
local equipment
for _, child in ipairs(BackpackTwo:GetChildren()) do
	if child:GetAttribute("ItemType") == "Equipment" then
		table.insert(equipmentNames, child.Name)
	end
end
local reforgeDropdown = createDropdown("ReforgeEquipmentsDropdown", "Select Equipment", equipmentNames, nil,
	function(opt)
		for _, child in ipairs(BackpackTwo:GetChildren()) do
			if child.Name == opt and child:GetAttribute("ItemType") == "Equipment" then
				equipment = child
				break
			end
		end
		if equipment and priceLabel then
			local cost = game:GetService("ReplicatedStorage").Remotes.Crafting.GetReforgeCost:InvokeServer(equipment)
			task.wait()
			priceLabel.SetSubText("Price: " .. formatPrice(cost))
		end
	end, reforgeSection)

createButton("UpdateReforgeEquipmentsButton", "Refresh Equipments", function()
	equipmentNames = {}
	for _, child in ipairs(BackpackTwo:GetChildren()) do
		if child:GetAttribute("ItemType") == "Equipment" then
			table.insert(equipmentNames, child.Name)
		end
	end
	equipment = nil
	reforgeDropdown.ClearOptions()
	reforgeDropdown.AddChildren(equipmentNames)
	if priceLabel then
		priceLabel.SetSubText("Price: N/A")
	end
end, reforgeSection)

priceLabel = createInfo("ReforgePriceInfo", "Next Reforge Cost", "Price: N/A", function()
	-- empty
end, reforgeSection)

createButton("ReforgePriceSetterButton", "Get Price", function()
	if not equipment then
		createNotification("Select an Equipment to get the reforge price")
	elseif equipment and priceLabel then
		local cost = game:GetService("ReplicatedStorage").Remotes.Crafting.GetReforgeCost:InvokeServer(equipment)
		task.wait()
		priceLabel.SetSubText("Price: " .. formatPrice(cost))
	end
end, reforgeSection)

local CraftingRemotes = ReplicatedStorage.Remotes.Crafting
createButton("ReforgeButton", "Reforge!", function()
	if not equipment or equipment.Parent ~= BackpackTwo then
		createNotification("Select an Equipment from your Backpack first! Or if you're holding it, unequip it.")
		return
	end

	local selectedGUID = equipment:GetAttribute("GUID")

	local success, result = pcall(function()
		return CraftingRemotes.ReforgeEquipment:InvokeServer(equipment)
	end)

	if not success then
		createNotification("Reforge failed: " .. tostring(result))
		return
	end

	createNotification("Reforge successful!")

	local newEquipment
	local timeout = 2
	local startTime = os.clock()

	while os.clock() - startTime < timeout do
		for _, child in ipairs(BackpackTwo:GetChildren()) do
			if child:GetAttribute("GUID") == selectedGUID then
				newEquipment = child
				break
			end
		end
		if newEquipment then
			break
		end
		task.wait(0.1)
	end

	if not newEquipment then
		createNotification(
			"Reforge succeeded, but updated item not found in Backpack, re equip the item from the dropdown.")
		return
	end

	equipment = newEquipment

	local newCostSuccess, newCost = pcall(function()
		return CraftingRemotes.GetReforgeCost:InvokeServer(equipment)
	end)
	if newCostSuccess and newCost then
		priceLabel.SetSubText("Price: " .. formatPrice(newCost))
	else
		priceLabel.SetSubText("Price: ???")
	end

	equipmentNames = {}
	for _, child in ipairs(BackpackTwo:GetChildren()) do
		if child:GetAttribute("ItemType") == "Equipment" then
			table.insert(equipmentNames, child.Name)
		end
	end

	reforgeDropdown.ClearOptions()
	reforgeDropdown.AddChildren(equipmentNames)
	reforgeDropdown.SetSelected(equipment.Name)
end, reforgeSection)


createInfo2("ReforgeWarningInfo", "Action is instantaneous", "This cannot be undone once confirmed", function()
	-- empty
end, reforgeSection, {
	2,
	1
})

createGhostText(enchantSection, {
	Text = "Pan Enchants",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	Font = Enum.Font.SourceSansBold,
	TextSize = 20,
	TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Bottom,
})

local selectedMaterial = "Aurorite"
local selectedShovelModifier = "Iridescent"
local PanEnchantRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Crafting"):WaitForChild("Enchant")
local ShovelEnchantRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Crafting"):WaitForChild(
	"EnchantShovel")

local function findPanMaterial(material)
	return BackpackTwo:FindFirstChild(material)
end

local function findShovelMaterial(modifier)
	local BackpackTwo = Players.LocalPlayer.BackpackTwo
	for _, tool in pairs(BackpackTwo:GetChildren()) do
		if tool:IsA("Tool") and tool.Name == "Aetherite" then
			if tool.ItemData:GetAttribute("Modifier") == modifier then
				return tool
			end
		end
	end
	return nil
end

local function enchantItem(remote, item, itemType, itemName)
	local enchant = nil
	local ok, err = pcall(function()
		enchant = remote:InvokeServer(item)
	end)

	if ok then
		createNotification("Successfully enchanted with " .. enchant .. " using " .. itemName, 6)
		return enchant
	else
		createNotification("Error enchanting " .. itemName, 3)
		warn("Error enchanting " .. itemName .. ": " .. tostring(err))
		return nil
	end
end

local function performAutoEnchant(findItemFunc, remote, itemName, targetEnchant, autoEnchantingVar)
	spawn(function()
		while autoEnchantingVar[1] do
			local item = findItemFunc()
			if item then
				print(item)

				local enchant = enchantItem(remote, item, "auto", itemName)

				if enchant then
					if enchant == targetEnchant then
						autoEnchantingVar[1] = false
						createNotification("Got target enchant: " .. enchant, 5)
						break
					else
						createNotification("Got " .. enchant .. ", continuing...", 2)
					end
				end
			else
				autoEnchantingVar[1] = false
				createNotification("Item not found: " .. itemName, 3)
				break
			end

			wait(1.5)
		end
	end)
end

createDropdown("MaterialSelector", "Select Material", {
	"Aetherite",
	"Aurorite"
}, "Aurorite", function(opt)
	selectedMaterial = opt
	createNotification("Selected material: " .. opt, 2)
end, enchantSection)

createButton("EnchantButton", "Enchant Pan", function()
	local material = findPanMaterial(selectedMaterial)
	if material then
		createNotification("Enchanting using " .. selectedMaterial .. "...", 2)
		enchantItem(PanEnchantRemote, material, "pan", selectedMaterial)
	else
		createNotification("Material not found: " .. selectedMaterial, 3)
	end
end, enchantSection)

local targetEnchant = "Prismatic"
local targetShovelEnchant = "WellBalanced"
local autoEnchanting = { false }
local enchantsModule = require(ReplicatedStorage:WaitForChild("GameInfo"):WaitForChild("Enchants"))
local shovelEnchantsModule = require(ReplicatedStorage:WaitForChild("GameInfo"):WaitForChild("ShovelEnchants"))
local enchantNames = {}
local shovelEnchantNames = {}
for name, _ in pairs(enchantsModule) do
	table.insert(enchantNames, name)
end
for name, _ in pairs(shovelEnchantsModule) do
	table.insert(shovelEnchantNames, name)
end
table.sort(enchantNames)
table.sort(shovelEnchantNames)

createDropdown("EnchantSelector", "Target Enchant", enchantNames, "Prismatic", function(opt)
	targetEnchant = opt
	createNotification("Target pan enchant: " .. opt, 2)
end, enchantSection)

createButton("AutoEnchantButton", "Start Auto Enchant", function()
	if autoEnchanting[1] then
		autoEnchanting[1] = false
		createNotification("Stopped auto enchanting pan", 2)
		return
	end

	autoEnchanting[1] = true
	createNotification("Auto enchanting pan until " .. targetEnchant, 3)

	performAutoEnchant(
		function() return findPanMaterial(selectedMaterial) end,
		PanEnchantRemote,
		selectedMaterial,
		targetEnchant,
		autoEnchanting
	)
end, enchantSection)

createGhostText(enchantSection, {
	Text = "Shovel Enchants",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	Font = Enum.Font.SourceSansBold,
	TextSize = 20,
	TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Bottom,
})

createDropdown("ShovelEnchantSelector", "Target Enchant", shovelEnchantNames, "WellBalanced", function(opt)
	targetShovelEnchant = opt
	createNotification("Target shovel enchant: " .. opt, 2)
end, enchantSection)

createDropdown("ShovelModifierSelector", "Select Modifier", {
	"Iridescent",
	"Voidtorn",
	"Electrified"
}, "Iridescent", function(opt)
	selectedShovelModifier = opt
	createNotification("Selected shovel modifier: " .. opt, 2)
end, enchantSection)

createButton("EnchantShovelButton", "Enchant Shovel", function()
	local shovelMaterial = findShovelMaterial(selectedShovelModifier)
	if shovelMaterial then
		createNotification("Enchanting shovel using " .. selectedShovelModifier .. " Aetherite...", 2)
		enchantItem(ShovelEnchantRemote, shovelMaterial, "shovel", selectedShovelModifier .. " Aetherite")
	else
		createNotification("Shovel material not found: " .. selectedShovelModifier .. " Aetherite", 3)
	end
end, enchantSection)

local autoEnchantingShovel = { false }

createButton("AutoEnchantShovelButton", "Start Auto Enchant", function()
	if autoEnchantingShovel[1] then
		autoEnchantingShovel[1] = false
		createNotification("Stopped auto enchanting shovel", 2)
		return
	end

	autoEnchantingShovel[1] = true
	createNotification("Auto enchanting shovel until " .. targetShovelEnchant, 3)

	performAutoEnchant(
		function() return findShovelMaterial(selectedShovelModifier) end,
		ShovelEnchantRemote,
		selectedShovelModifier .. " Aetherite",
		targetShovelEnchant,
		autoEnchantingShovel
	)
end, enchantSection)

createButton("EmergencyStopButton", "Stop All Enchanting", function()
	autoEnchanting[1] = false
	autoEnchantingShovel[1] = false
	createNotification("EMERGENCY STOP - All auto enchanting terminated", 3)
end, enchantSection, { 2, 1 })

createDropdown("BuyPansDropdown", "Select Pan", buildPurchasableTable().Pans, nil, function(opt)
	selectedOptions.pan = opt
end, shopSection)

createButton("BuyPansDropdownButton", "Buy Pan", function()
	handlePurchase("pan", selectedOptions.pan)
end, shopSection)

createDropdown("BuyShovelDropdown", "Select Shovel", buildPurchasableTable().Shovels, nil, function(opt)
	selectedOptions.shovel = opt
end, shopSection)

createButton("BuyShovelDropdownButton", "Buy Shovel", function()
	handlePurchase("shovel", selectedOptions.shovel)
end, shopSection)

createDropdown("BuySluiceDropdown", "Select Sluice", buildPurchasableTable().Sluices, nil, function(opt)
	selectedOptions.sluice = opt
end, shopSection)

createButton("BuySluiceDropdownButton", "Buy Sluice", function()
	handlePurchase("sluice", selectedOptions.sluice)
end, shopSection)

createDropdown("BuyPotionDropdown", "Select Potion", buildPurchasableTable().Potions, nil, function(opt)
	selectedOptions.potion = opt
end, shopSection)

createButton("BuyPotioneDropdownButton", "Buy Potion", function()
	handlePurchase("potion", selectedOptions.potion)
end, shopSection)

createDropdown("BuyTotemDropdown", "Select Totem", buildPurchasableTable().Totems, nil, function(opt)
	selectedOptions.totem = opt
end, shopSection)

createButton("BuyTotemDropdownButton", "Buy Totem", function()
	handlePurchase("totem", selectedOptions.totem)
end, shopSection)

createDropdown("BuyOthersDropdown", "Select Others", buildPurchasableTable().Others, nil, function(opt)
	selectedOptions.totem = opt
end, shopSection)

createButton("BuyOthersDropdownButton", "Buy Others [IF ANY]", function()
	handlePurchase("others", selectedOptions.other)
end, shopSection)

createToggleButton("AntiAFKButton", "Anti-AFK", true, function(state)
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local GC = getconnections or get_signal_cons

	if state then
		-- Try the cleanest method first: disconnect idle detection
		if GC then
			for _, v in pairs(GC(LocalPlayer.Idled)) do
				if v.Disable then
					v.Disable(v)
				elseif v.Disconnect then
					v.Disconnect(v)
				end
			end
			print("Anti-AFK Enabled (disconnected idle events)")
		else
			-- Fallback: simulate input but it's risky, might have to change this later
			local VirtualUser = cloneref and cloneref(game:GetService("VirtualUser")) or game:GetService("VirtualUser")
			getgenv().AntiAFKConnection = LocalPlayer.Idled:Connect(function()
				VirtualUser:CaptureController()
				VirtualUser:ClickButton2(Vector2.new())
			end)
			print("Anti-AFK Enabled (VirtualUser fallback)")
		end
	else
		-- Disable Anti-AFK
		if getgenv().AntiAFKConnection then
			getgenv().AntiAFKConnection:Disconnect()
			getgenv().AntiAFKConnection = nil
		end
		print("Anti-AFK Disabled")
	end
end, utilitySection)


if UserInputService.TouchEnabled then
	local toggleButton = Instance.new("ImageButton")
	toggleButton.Name = "ToggleUIButton"
	toggleButton.Size = UDim2.new(0, 60, 0, 60)
	toggleButton.Position = UDim2.new(0, 10, 0.5, -30)
	toggleButton.BackgroundTransparency = 1
	toggleButton.Image = "rbxassetid://85554515603237"
	toggleButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
	toggleButton.Parent = gui

	toggleButton.Activated:Connect(function()
		if mainContainer.Visible then
			mainContainer.Visible = false
			toggleButton.Image = "rbxassetid://122746616080790"
		else
			mainContainer.Visible = true
			toggleButton.Image = "rbxassetid://85554515603237"
		end
		toggleButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
	end)
else
	createKeyBindButton("ToggleUIBind", "Toggle UI Visibility", nil, function(key)
		mainContainer.Visible = not mainContainer.Visible
		createNotification("UI visibility is toggled", 5)
	end, utilitySection)
end

createButton("RejoinServerButton", "Rejoin Server", function()
	if # Players:GetPlayers() <= 1 then
		LocalPlayer:Kick("\nRejoining...")
		task.wait()
		TeleportService:Teleport(PlaceId, LocalPlayer)
	else
		TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LocalPlayer)
	end
end, utilitySection)

createButton("ServerHopButton", "Server Hop", function()
	local servers = {}
	local req = game:HttpGet("https://games.roblox.com/v1/games/" ..
		PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
	local body = HttpService:JSONDecode(req)
	if body and body.data then
		for _, v in next, body.data do
			if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
				table.insert(servers, 1, v.id)
			end
		end
	end
	if # servers > 0 then
		TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, # servers)], LocalPlayer)
	end

	createNotification("Couldn't fetch servers to hop", 5)
end, utilitySection)

createButton("InstantCompleteFillButton", "[Instant] Fill Pan", function()
	if TaskManager:getMainTask() then
		return createNotification("Please wait for current task to complete", 5)
	end
	if TaskManager:requestTask("ManualAction", 3) then
		task.spawn(function()
			if TaskManager:waitForTurn("ManualAction", 5) and TaskManager:startTask("ManualAction") then
				handlePanAction("Instant", "Dig", true)
				TaskManager:finishTask("ManualAction")
			end
		end)
	end
end, manualSection)

createButton("LegitCompleteFillButton", "[Legit] Fill Pan", function()
	if TaskManager:getMainTask() then
		return createNotification("Please wait for current task to complete", 5)
	end
	if TaskManager:requestTask("ManualAction", 3) then
		task.spawn(function()
			if TaskManager:waitForTurn("ManualAction", 5) and TaskManager:startTask("ManualAction") then
				handlePanAction("Legit", "Dig", true)
				TaskManager:finishTask("ManualAction")
			end
		end)
	end
end, manualSection)

createButton("LegitCompleteEmptyButton", "[Legit] Empty Pan", function()
	if TaskManager:getMainTask() then
		return createNotification("Please wait for current task to complete", 5)
	end
	if TaskManager:requestTask("ManualAction", 3) then
		task.spawn(function()
			if TaskManager:waitForTurn("ManualAction", 5) and TaskManager:startTask("ManualAction") then
				handlePanAction("Legit", "Wash", true)
				TaskManager:finishTask("ManualAction")
			end
		end)
	end
end, manualSection)

createButton("InstantSoloFillButton", "[Instant] Shovel deposit", function()
	if TaskManager:getMainTask() then
		return createNotification("Please wait for current task to complete", 5)
	end
	if TaskManager:requestTask("ManualAction", 3) then
		task.spawn(function()
			if TaskManager:waitForTurn("ManualAction", 5) and TaskManager:startTask("ManualAction") then
				handlePanAction("Instant", "Dig")
				TaskManager:finishTask("ManualAction")
			end
		end)
	end
end, manualSection)

createButton("LegitSoloFillButton", "[Legit] Shovel deposit", function()
	if TaskManager:getMainTask() then
		return createNotification("Please wait for current task to complete", 5)
	end
	if TaskManager:requestTask("ManualAction", 3) then
		task.spawn(function()
			if TaskManager:waitForTurn("ManualAction", 5) and TaskManager:startTask("ManualAction") then
				handlePanAction("Legit", "Dig")
				TaskManager:finishTask("ManualAction")
			end
		end)
	end
end, manualSection)
