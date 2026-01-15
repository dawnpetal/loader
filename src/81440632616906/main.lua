local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local function getStorage()
	local registry = getgenv().__PrereqStorageRegistry
	if not registry then
		return nil
	end
	
	for k, v in pairs(getgenv()) do
		if type(k) == "userdata" and v == true then
			if registry[k] then
				return k
			end
		end
	end
	return nil
end

local proxy = getStorage()

if not proxy then
	error("Loader required")
end

local storageRegistry = getgenv().__PrereqStorageRegistry
local moduleRegistry = getgenv().__PrereqModuleRegistry

if not storageRegistry or not moduleRegistry then
	error("Loader required")
end

local guiName = "SimpleScriptsGUI"

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

local function createCollapsibleContainer(title, parent, width, height, minWidth, minHeight, maxWidth, maxHeight)
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
		BackgroundTransparency = 0.05,
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
		Text = title or "Simple Scripts",
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
		Font = Enum.Font.SourceSansBold,
		TextSize = 16,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 12,
		Parent = btn
	})
    truncateWithTooltip(label, text)
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

local childrenContainer = createCollapsibleContainer("Dig to Earth's Core", mainContainer, Width, Height, minWidth, minHeight, maxWidth, maxHeight)

local AutoFarmSection = createSection(childrenContainer, "Auto Farm", 1, true)
local MiscellaneousSection = createSection(childrenContainer, "Miscellaneous", 2, true)
local SpinWheelSection = createSection(childrenContainer, "Spin Wheel", 3, true)
local utilitySection = createSection(childrenContainer, "Utility", 4, false)


local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local CurrentWorld = Player:WaitForChild("CurrentWorld")
local Cash = Player:WaitForChild("Cash")
local PickaxesModule = require(ReplicatedStorage:WaitForChild("PickaxesModule"))
local BuyPickaxeEvent = ReplicatedStorage.Remotes:WaitForChild("BuyPickaxeEvent")
local EquipPickaxeEvent = ReplicatedStorage.Remotes:WaitForChild("EquipPickaxeEvent")

local PlaceId = game.PlaceId
local JobId = game.JobId
local AutoUpgradeEnabled = false
local AutoFarmWins = false

local function getCharacter()
    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    return char, hrp
end

local Character, HumanoidRootPart = getCharacter()

local function getHumanoidRootPart()
    if not HumanoidRootPart or not HumanoidRootPart.Parent then
        Character, HumanoidRootPart = getCharacter()
    end
    return HumanoidRootPart
end

local function getNextPickaxe(currentPickaxe)
    local all = PickaxesModule.GetAllFirstTabPickaxes()
    local data = {}
    for _, name in ipairs(all) do
        local info = PickaxesModule.GetData(name)
        if info and info.Normal then
            table.insert(data, {name = name, order = info.order, cost = info.cost})
        end
    end
    table.sort(data, function(a, b)
        return a.order < b.order
    end)
    for i, entry in ipairs(data) do
        if entry.name == currentPickaxe then
            return data[i + 1]
        end
    end
end

-- ============ AUTO FARM SECTION =============

createToggleButton("AutoFarmWins", "Automatically farm Wins / Shards", false, function(state)
    AutoFarmWins = state
    if state then
        task.spawn(function()
            while AutoFarmWins do
                local hrp = getHumanoidRootPart()
                local WorldName = "World" .. tostring(CurrentWorld.Value)
                local BottomPart = workspace:WaitForChild(WorldName):WaitForChild("Map"):WaitForChild("Bottom")
                local topCFrame = BottomPart.CFrame + Vector3.new(0, 40, 0)
                local bottomCFrame = BottomPart.CFrame - Vector3.new(0, 40, 0)

                local tweenUp = TweenService:Create(hrp, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {CFrame = topCFrame})
                tweenUp:Play()
                tweenUp.Completed:Wait()
                if not AutoFarmWins then break end

                local tweenDown = TweenService:Create(hrp, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {CFrame = bottomCFrame})
                tweenDown:Play()
                tweenDown.Completed:Wait()
            end
        end)
    else
        local hrp = getHumanoidRootPart()
        local WorldName = "World" .. tostring(CurrentWorld.Value)
        local SurfacePart = workspace:WaitForChild(WorldName):WaitForChild("SurfacePart")
        hrp.CFrame = SurfacePart.CFrame + Vector3.new(0, 5, 0)
    end
end, AutoFarmSection, {2, 1})

local TreasureEvent = game:GetService("ReplicatedStorage").Remotes:WaitForChild("TreasureEvent")

local AutoCollectTreasures = false
createToggleButton("AutoCollectTreasuresToggle", "Collect Treasures", false, function(state)
    AutoCollectTreasures = state
    task.spawn(function()
        while AutoCollectTreasures do
            local WorkspaceTreasure = workspace:WaitForChild("Treasure")
            for _, item in ipairs(WorkspaceTreasure:GetChildren()) do
                if item:IsA("Model") and item.Name ~= "Cage" then
                    TreasureEvent:FireServer(item.Name)
                    task.wait(1)
                end
            end
            task.wait()
        end
    end)
end, AutoFarmSection)

local AutoCollectCages = false
createToggleButton("AutoCollectCagesToggle", "Collect Cages", false, function(state)
    AutoCollectCages = state
    task.spawn(function()
        while AutoCollectCages do
            local WorkspaceTreasure = workspace:WaitForChild("Treasure")
            for _, item in ipairs(WorkspaceTreasure:GetChildren()) do
                if item:IsA("Model") and item.Name == "Cage" then
                    TreasureEvent:FireServer(item.Name)
                    task.wait(1)
                end
            end
            task.wait()
        end
    end)
end, AutoFarmSection)

-- ============ MISCELLANEOUS SECTION =============
local PromptButtonHoldBegan = nil

createToggleButton("InstantProximityPromptsToggle", "Instant open cage", false, function(state)
    if state then
        if fireproximityprompt then
            if PromptButtonHoldBegan then
                PromptButtonHoldBegan:Disconnect()
                PromptButtonHoldBegan = nil
            end
            PromptButtonHoldBegan = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
                fireproximityprompt(prompt)
            end)
        else
            createNotification('Incompatible Exploit! Your exploit does not support this feature (missing fireproximityprompt)')
        end
    else
        if PromptButtonHoldBegan then
            PromptButtonHoldBegan:Disconnect()
            PromptButtonHoldBegan = nil
        end
    end
end, MiscellaneousSection, {2, 1})

createToggleButton("AutoUpgradePickaxeToggle", "Auto BestPick", false, function(state)
    AutoUpgradeEnabled = state
    if state then
        task.spawn(function()
            while AutoUpgradeEnabled do
                local current = PickaxesModule.GetBestPickaxeName(Player)
                local nextPickaxe = getNextPickaxe(current)
                if not nextPickaxe then break end
                if Cash.Value >= nextPickaxe.cost then
                    BuyPickaxeEvent:FireServer(nextPickaxe.name)
                    EquipPickaxeEvent:FireServer(nextPickaxe.name)
                end
                task.wait(2)
            end
        end)
    end
end, MiscellaneousSection)

createToggleButton("InstantDigToggle", "Instant dig", false, function(state)
    Player:SetAttribute("InstantDig", state)
end, MiscellaneousSection)

createToggleButton("InfiniteFuelToggle", "Infinite fuel", false, function(state)
    Player:SetAttribute("InfiniteFuel", state)
end, MiscellaneousSection)

createButton("BestPickaxeToggle", "Equip Singularity", function(state)
    Player:SetAttribute("SelectedPickaxe", CurrentWorld.Value == "1" and "Riftbreaker" or "Singularity")
end, MiscellaneousSection)

createButton("BestPickaxeToggle", "Equip VoidJetpack", function(state)
    Player:SetAttribute("SelectedJetpack", "Void")
end, MiscellaneousSection)

-- ============ SPIN WHEEL SECTION =============

local RewardsModule = require(game:GetService("ReplicatedStorage"):WaitForChild("SpinWheelRewardsModule"))

local SpinWheelRewardsList = {}
for i, reward in ipairs(RewardsModule.BaseRewards) do
    local display
    if reward.type == "cash" then
        display = "💰 " .. reward.amount .. " Cash"
    elseif reward.type == "gems" then
        display = "💎 " .. reward.amount .. " Gems"
    elseif reward.type == "spins" then
        display = (reward.amount == 1 and "🎰 1 Spin" or "🎰 " .. reward.amount .. " Spins")
    elseif reward.type == "cashmulti" then
        display = "💸 x" .. reward.amount .. " Cash"
    elseif reward.type == "pet" then
        display = "🐾 " .. reward.name
    else
        display = "Unknown Reward"
    end
    table.insert(SpinWheelRewardsList, {reward = reward, display = display})
end

local SpinWheelPrizeDropdown = createDropdown(
    "SpinWheelPrizeDropdown",
    "Select Spin Wheel Prize",
    (function()
        local options = {}
        for _, entry in ipairs(SpinWheelRewardsList) do
            table.insert(options, entry.display)
        end
        return options
    end)(),
    nil,
    function(selectedDisplay)
        for _, entry in ipairs(SpinWheelRewardsList) do
            if entry.display == selectedDisplay then
                SpinWheelPrize = entry.reward
                break
            end
        end
    end,
    SpinWheelSection,
    nil,
    {2, 1}
)

local SpinWheelActive = false

createToggleButton("AutoSpinWheel", "Automatically Spin Selected Prize", false, function(state)
    SpinWheelActive = state
    if state then
        task.spawn(function()
            while SpinWheelActive do
                local prizeIndex
                for i, entry in ipairs(SpinWheelRewardsList) do
                    if entry.reward == SpinWheelPrize then
                        prizeIndex = i
                        break
                    end
                end
                if prizeIndex then
                    game:GetService("ReplicatedStorage").Remotes.SpinPrizeEvent:FireServer(prizeIndex)
                end
                task.wait()
            end
        end)
    end
end, SpinWheelSection, {2, 1})


-- ========= UTILITY SECTION ==========
createToggleButton("AntiAFKButton", "Anti-AFK", true, function(state)
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local GC = getconnections or get_signal_cons

	if state then
		-- Try the cleanest method first: disconnect idle detection
		if GC then
			for _, v in pairs(GC(Player.Idled)) do
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