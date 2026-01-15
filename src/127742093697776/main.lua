local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

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

local data = storageRegistry[proxy]
local prereqs = data.Prereqs

if not prereqs or not next(prereqs) then
	error("Loader required")
end

local function getPrerequisite(name)
	for p in pairs(prereqs) do
		local info = moduleRegistry[p]
		if info and info.name == name then
			return info.module
		end
	end
	error("Missing: " .. name)
end

local LoopFramework = getPrerequisite("LoopFramework")
LoopFramework.start()

-- ======================== SIMPLE SCRIPTS ========================

local GuiName = "SimpleScripts"

local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local OldGui = PlayerGui:FindFirstChild(GuiName)

if OldGui then OldGui:Destroy() end

local SimpleScriptsGui = Instance.new("ScreenGui")
SimpleScriptsGui.Name = GuiName
SimpleScriptsGui.ResetOnSpawn = false
SimpleScriptsGui.Parent = PlayerGui

-- Some Important Variables
local openDropdowns = {}
local sharedTooltip
local viewportSize = workspace.CurrentCamera.ViewportSize
local DESIGN_HEIGHT = 981
local DESIGN_WIDTH = 1664
local ScaleX = viewportSize.X / DESIGN_WIDTH
local ScaleY = viewportSize.Y / DESIGN_HEIGHT
local DefaultUIProps = {
	CollapsibleContainer = {
		container = {
			backgroundColor = Color3.fromRGB(15, 15, 15),
			backgroundTransparency = 0.15,
			borderColor = Color3.fromRGB(255, 255, 255),
			borderThickness = 2,
			strokeThickness = nil,
			strokeTransparency = 0,
			cornerRadius = nil,
			paddingX = nil,
			paddingY = nil,
			zIndex = 7
		},
		header = {
			height = nil,
			backgroundColor = nil,
			backgroundTransparency = 1,
			dragEnabled = true,
			toggleButtonSize = 0.75,
			zIndex = 11
		},
		content = {
			backgroundColor = Color3.fromRGB(0, 0, 0),
			backgroundTransparency = 1,
			listPadding = nil,
			paddingTop = nil,
			paddingBottom = nil,
			paddingLeft = 0,
			paddingRight = 0,
			horizontalAlignment = Enum.HorizontalAlignment.Center,
			verticalAlignment = Enum.VerticalAlignment.Top,
			zIndex = 8
		},
		text = {
			color = Color3.fromRGB(255, 255, 255),
			size = 21,
			font = Enum.Font.SourceSansBold,
			transparency = 0,
			alignment = Enum.TextXAlignment.Left,
			yAlignment = Enum.TextYAlignment.Center
		},
		arrow = {
			size = nil,
			image = "rbxassetid://3926305904",
			imageRectOffset = Vector2.new(564, 284),
			imageRectSize = Vector2.new(36, 36),
			color = Color3.fromRGB(255, 255, 255),
			transparency = 0,
			rotationCollapsed = -90,
			rotationExpanded = 0
		},
		scroll = {
			barThickness = nil,
			barColor = Color3.fromRGB(255, 255, 255),
			barTransparency = 0,
			barVisibleTransparency = 0.3,
			barHiddenTransparency = 1
		},
		animation = {
			duration = 0.5,
			style = Enum.EasingStyle.Quart,
			direction = Enum.EasingDirection.Out,
			arrowDuration = 0.4
		}
	},
	Section = {
		container = {
			backgroundColor = Color3.fromRGB(0, 0, 0),
			backgroundTransparency = 1,
			clipDescendants = true,
			zIndex = 1
		},
		header = {
			height = 30,
			backgroundColor = Color3.fromRGB(0, 0, 0),
			backgroundTransparency = 1,
			separatorColor = Color3.fromRGB(255, 255, 255),
			separatorHeight = 2,
			separatorTransparency = 0,
			separatorOffsetX = 10,
			separatorPositionY = 25,
			zIndex = 10,
			buttonZIndex = 11
		},
		title = {
			color = Color3.fromRGB(255, 255, 255),
			size = 20,
			font = Enum.Font.SourceSansBold,
			transparency = 0,
			alignment = Enum.TextXAlignment.Left,
			yAlignment = Enum.TextYAlignment.Center,
			offsetX = 0,
			offsetY = 0,
			sizeOffsetX = -30,
			height = 25,
			zIndex = 12
		},
		arrow = {
			size = 20,
			image = "rbxassetid://3926305904",
			imageRectOffset = Vector2.new(564, 284),
			imageRectSize = Vector2.new(36, 36),
			color = Color3.fromRGB(255, 255, 255),
			colorHover = Color3.fromRGB(0, 200, 255),
			transparency = 0,
			rotationCollapsed = -90,
			rotationExpanded = 0,
			positionOffsetX = -35,
			positionOffsetY = 2.5,
			zIndex = 12
		},
		info = {
			color = Color3.fromRGB(30, 144, 255),
			size = nil,
			text = "?",
			fontSize = 13,
			font = Enum.Font.SourceSansBold,
			offsetX = 10,
			offsetY = 9,
			cornerRadius = 1,
			strokeThickness = 1,
			zIndex = 13
		},
		content = {
			backgroundColor = Color3.fromRGB(0, 0, 0),
			backgroundTransparency = 1,
			positionY = 35,
			paddingLeft = nil,
			paddingRight = nil,
			paddingTop = 0,
			paddingBottom = 0,
			initialHeight = 100,
			zIndex = 1
		},
		grid = {
			cellWidth = nil,
			cellHeight = nil,
			paddingX = nil,
			paddingY = nil,
			topOffset = 5,
			maxColumns = 2,
			maxRows = 6,
			minColumns = 0.5,
			minRows = 0.5
		},
		animation = {
			duration = 0.4,
			style = Enum.EasingStyle.Sine,
			direction = Enum.EasingDirection.Out,
			arrowStyle = Enum.EasingStyle.Back,
			arrowDirection = Enum.EasingDirection.Out,
			hoverDuration = 0.2,
			scrollDelay = 0.3,
			scrollOffset = 10,
			debounceTime = 0.1
		},
		behavior = {
			defaultExpanded = true,
			autoScroll = true,
			clipWhenCollapsed = false
		}
	}
}

-- ======================== HELPER FUNCTIONS ========================

local function getTextSize(size)
	local factor = 0.5
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
	Name = "NotificationFrame",
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 0, 0, 10),
	Size = UDim2.new(0, 300, 1, 0),
	BackgroundTransparency = 1,
	Parent = SimpleScriptsGui
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
		Thickness = 1,
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

local function deepMerge(default, override)
	if not override then
		return default
	end
	local result = {}
	for k, v in pairs(default) do
		if type(v) == "table" and type(override[k]) == "table" then
			result[k] = deepMerge(v, override[k])
		else
			result[k] = override[k] ~= nil and override[k] or v
		end
	end
	for k, v in pairs(override) do
		if result[k] == nil then
			result[k] = v
		end
	end
	return result
end

-- =============== MAIN COMPONENTS ================ --

local mainContainer = createElement("Frame", {
	Name = "MainContainer",
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -10, 0, -10),
	Size = UDim2.new(1, 0, 0, 0),
	BackgroundTransparency = 1,
	ClipsDescendants = false,
	Parent = SimpleScriptsGui
})

local function createCollapsibleContainer(title, parent, width, height, minWidth, minHeight, maxWidth, maxHeight, uiProps)
	width = width or viewportSize.X * 0.25
	height = height or viewportSize.Y * 0.70
	minWidth = minWidth or math.clamp(300 * ScaleX, 250, 400)
	minHeight = minHeight or math.clamp(500 * ScaleY, 400, 650)
	maxWidth = maxWidth or math.clamp(425 * ScaleX, 350, 550)
	maxHeight = maxHeight or math.clamp(800 * ScaleY, 650, 1000)

	local props = deepMerge(DefaultUIProps.CollapsibleContainer, uiProps or {})

	local container = props.container
	local header = props.header
	local content = props.content
	local text = props.text
	local arrow = props.arrow
	local scroll = props.scroll
	local animation = props.animation

	local headerHeight = header.height or math.clamp(40 * ScaleY, 32, 50)
	local paddingX = container.paddingX or math.clamp(10 * ScaleX, 8, 15)
	local paddingY = container.paddingY or math.clamp(15 * ScaleY, 10, 20)
	local strokeThickness = container.strokeThickness or
		math.clamp(container.borderThickness * math.min(ScaleX, ScaleY), 1, 3)
	local cornerRadius = container.cornerRadius or math.clamp(8 * math.min(ScaleX, ScaleY), 6, 12)
	local scrollBarThickness = scroll.barThickness or math.clamp(3 * math.min(ScaleX, ScaleY), 2, 5)
	local arrowSize = arrow.size or math.clamp(20 * math.min(ScaleX, ScaleY), 16, 26)

	local bgColor = container.backgroundColor
	local bgTransparency = container.backgroundTransparency
	local borderColor = container.borderColor
	local textColor = text.color
	local textSize = text.size
	local textFont = text.font
	local textAlignment = text.alignment

	local headerBgColor = header.backgroundColor or bgColor
	local headerBgTransparency = header.backgroundTransparency
	local contentBgColor = content.backgroundColor
	local contentBgTransparency = content.backgroundTransparency

	local arrowRotationCollapsed = arrow.rotationCollapsed
	local arrowRotationExpanded = arrow.rotationExpanded
	local arrowImage = arrow.image
	local arrowImageRectOffset = arrow.imageRectOffset
	local arrowImageRectSize = arrow.imageRectSize
	local arrowColor = arrow.color
	local arrowTransparency = arrow.transparency

	local scrollBarColor = scroll.barColor
	local scrollBarTransparency = scroll.barTransparency
	local scrollBarVisibleTransparency = scroll.barVisibleTransparency
	local scrollBarHiddenTransparency = scroll.barHiddenTransparency

	local listPadding = content.listPadding or math.clamp(5 * ScaleY, 3, 8)
	local contentPaddingTop = content.paddingTop or math.clamp(5 * ScaleY, 3, 8)
	local contentPaddingBottom = content.paddingBottom or paddingY

	local animationDuration = animation.duration
	local animationStyle = animation.style
	local animationDirection = animation.direction
	local arrowAnimationDuration = animation.arrowDuration

	local zIndexContainer = container.zIndex
	local zIndexContent = content.zIndex
	local zIndexHeader = header.zIndex

	local dragEnabled = header.dragEnabled
	local toggleButtonSize = header.toggleButtonSize

	local isFirstExpansion = true
	local containerFrame = createElement("Frame", {
		Name = "CollapsibleContainer",
		Size = UDim2.new(1, 0, 0, headerHeight),
		BackgroundColor3 = bgColor,
		BackgroundTransparency = bgTransparency,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = zIndexContainer,
		Parent = parent
	})
	createElement("UIStroke", {
		Thickness = strokeThickness,
		Color = borderColor,
		Transparency = container.strokeTransparency,
		Parent = containerFrame
	})
	createElement("UICorner", {
		CornerRadius = UDim.new(0, cornerRadius),
		Parent = containerFrame
	})
	local dragArea = createElement("Frame", {
		Size = UDim2.new(1, -headerHeight * toggleButtonSize, 0, headerHeight),
		BackgroundColor3 = headerBgColor,
		BackgroundTransparency = headerBgTransparency,
		BorderSizePixel = 0,
		ZIndex = zIndexHeader,
		Parent = containerFrame
	})
	local toggleBtn = createElement("TextButton", {
		Size = UDim2.new(0, headerHeight * toggleButtonSize, 0, headerHeight),
		Position = UDim2.new(1, -headerHeight * toggleButtonSize, 0, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = zIndexHeader,
		Parent = containerFrame
	})
	local label = createElement("TextLabel", {
		Size = UDim2.new(1, -paddingX, 1, 0),
		Position = UDim2.new(0, paddingX, 0, 0),
		BackgroundTransparency = 1,
		Text = title or "Simple Scripts",
		Font = textFont,
		TextSize = textSize,
		TextColor3 = textColor,
		TextTransparency = text.transparency,
		TextXAlignment = textAlignment,
		TextYAlignment = text.yAlignment,
		ZIndex = zIndexHeader,
		Parent = dragArea
	})
	local arrowImageLabel = createElement("ImageLabel", {
		Size = UDim2.new(0, arrowSize, 0, arrowSize),
		Position = UDim2.new(0.5, -arrowSize * 0.5, 0.5, -arrowSize * 0.5),
		BackgroundTransparency = 1,
		Image = arrowImage,
		ImageRectOffset = arrowImageRectOffset,
		ImageRectSize = arrowImageRectSize,
		ImageColor3 = arrowColor,
		ImageTransparency = arrowTransparency,
		Rotation = arrowRotationCollapsed,
		ZIndex = zIndexHeader,
		Parent = toggleBtn
	})
	local contentFrame = createElement("ScrollingFrame", {
		Size = UDim2.new(1, -paddingX * 2, 0, 0),
		Position = UDim2.new(0, paddingX, 0, headerHeight),
		BackgroundColor3 = contentBgColor,
		BackgroundTransparency = contentBgTransparency,
		BorderSizePixel = 0,
		ScrollBarThickness = scrollBarThickness,
		ScrollBarImageColor3 = scrollBarColor,
		ScrollBarImageTransparency = scrollBarTransparency,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollingEnabled = false,
		Selectable = false,
		ClipsDescendants = true,
		ZIndex = zIndexContent,
		Parent = containerFrame
	})
	createElement("UIPadding", {
		PaddingTop = UDim.new(0, contentPaddingTop),
		PaddingBottom = UDim.new(0, contentPaddingBottom),
		PaddingLeft = UDim.new(0, content.paddingLeft),
		PaddingRight = UDim.new(0, content.paddingRight),
		Parent = contentFrame
	})
	local list = createElement("UIListLayout", {
		Padding = UDim.new(0, listPadding),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = content.horizontalAlignment,
		VerticalAlignment = content.verticalAlignment,
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

	if dragEnabled then
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
	end

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
		contentFrame.ScrollBarImageTransparency = needsScrolling and scrollBarVisibleTransparency or
			scrollBarHiddenTransparency

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
		local info = TweenInfo.new(animationDuration, animationStyle, animationDirection)
		if immediate then
			containerFrame.Size = UDim2.new(1, 0, 0, containerH)
			parent.Size = UDim2.new(0, finalWidth, 0, containerH)
		else
			TweenService:Create(containerFrame, info, {
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
		TweenService:Create(arrowImageLabel, TweenInfo.new(arrowAnimationDuration, animationStyle, animationDirection), {
			Rotation = isExpanded and arrowRotationExpanded or arrowRotationCollapsed
		}):Play()
		applyHeights(false)
		task.delay(animationDuration, function()
			isAnimating = false
		end)
	end

	toggleBtn.Activated:Connect(toggleContainer)
	applyHeights(true)
	return contentFrame
end

local function createSection(parent, title, layoutOrder, defaultExpanded, infoText, uiProps)
	local props = deepMerge(DefaultUIProps.Section, uiProps or {})

	defaultExpanded = defaultExpanded ~= nil and defaultExpanded or props.behavior.defaultExpanded

	local container = props.container
	local header = props.header
	local titleProps = props.title
	local arrow = props.arrow
	local info = props.info
	local content = props.content
	local grid = props.grid
	local animation = props.animation
	local behavior = props.behavior

	local section = createElement("Frame", {
		Name = title .. "Section",
		Size = UDim2.new(1, 0, 0, 35),
		BackgroundColor3 = container.backgroundColor,
		BackgroundTransparency = container.backgroundTransparency,
		ClipsDescendants = container.clipDescendants,
		LayoutOrder = layoutOrder or 0,
		ZIndex = container.zIndex,
		Parent = parent
	})

	local headerFrame = createElement("Frame", {
		Size = UDim2.new(1, 0, 0, header.height),
		BackgroundColor3 = header.backgroundColor,
		BackgroundTransparency = header.backgroundTransparency,
		ZIndex = header.zIndex,
		Parent = section
	})

	local headerButton = createElement("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = header.buttonZIndex,
		Parent = headerFrame
	})

	local titleLabel = createElement("TextLabel", {
		Size = UDim2.new(1, titleProps.sizeOffsetX, 0, titleProps.height),
		Position = UDim2.new(0, titleProps.offsetX, 0, titleProps.offsetY),
		BackgroundTransparency = 1,
		Text = title,
		Font = titleProps.font,
		TextSize = titleProps.size,
		TextColor3 = titleProps.color,
		TextTransparency = titleProps.transparency,
		TextXAlignment = titleProps.alignment,
		TextYAlignment = titleProps.yAlignment,
		ZIndex = titleProps.zIndex,
		Parent = headerFrame
	})

	local arrowImage = createElement("ImageLabel", {
		Size = UDim2.new(0, arrow.size, 0, arrow.size),
		Position = UDim2.new(1, arrow.positionOffsetX, 0, arrow.positionOffsetY),
		BackgroundTransparency = 1,
		Image = arrow.image,
		ImageRectOffset = arrow.imageRectOffset,
		ImageRectSize = arrow.imageRectSize,
		ImageColor3 = arrow.color,
		ImageTransparency = arrow.transparency,
		Rotation = defaultExpanded and arrow.rotationExpanded or arrow.rotationCollapsed,
		ZIndex = arrow.zIndex,
		Parent = headerFrame
	})

	if infoText then
		local infoSize = info.size or math.clamp(10 * ScaleY, 7, 15)
		local infoIcon = createElement("TextLabel", {
			Size = UDim2.new(0, infoSize, 0, infoSize),
			Position = UDim2.new(0, titleLabel.TextBounds.X + info.offsetX, 0, info.offsetY),
			BackgroundTransparency = 1,
			Text = info.text,
			Font = info.font,
			TextSize = info.fontSize,
			TextColor3 = info.color,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			ZIndex = info.zIndex,
			Parent = headerFrame
		})

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(info.cornerRadius, 0)
		corner.Parent = infoIcon

		local stroke = Instance.new("UIStroke")
		stroke.Thickness = info.strokeThickness
		stroke.Color = info.color
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		stroke.Parent = infoIcon

		truncateWithTooltip(infoIcon, infoText, nil, info.text)
	end

	createElement("Frame", {
		Size = UDim2.new(1, -header.separatorOffsetX, 0, header.separatorHeight),
		Position = UDim2.new(0, 0, 0, header.separatorPositionY),
		BackgroundColor3 = header.separatorColor,
		BackgroundTransparency = header.separatorTransparency,
		BorderSizePixel = 0,
		ZIndex = header.zIndex,
		Parent = headerFrame
	})

	local sectionContent = createElement("Frame", {
		Name = title .. "Content",
		Size = UDim2.new(1, 0, 0, defaultExpanded and content.initialHeight or 0),
		Position = UDim2.new(0, 0, 0, content.positionY),
		BackgroundColor3 = content.backgroundColor,
		BackgroundTransparency = content.backgroundTransparency,
		ClipsDescendants = not defaultExpanded or behavior.clipWhenCollapsed,
		ZIndex = content.zIndex,
		Parent = section
	})

	local gridComponents = {}
	local gridRows = {}
	local currentRow = 1
	local currentColumn = 1

	local function validateGridPosition(columns, rows)
		if not columns or columns < grid.minColumns or columns > grid.maxColumns then
			return false
		end
		if not rows or rows < grid.minRows or rows > grid.maxRows then
			return false
		end
		return true
	end

	local function findNextAvailablePosition(reqColumns, reqRows)
		while true do
			if currentColumn + reqColumns - 1 > grid.maxColumns then
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

	local cellWidth = grid.cellWidth or (parent.AbsoluteSize.X * 0.45)
	local cellHeight = grid.cellHeight or math.clamp(viewportSize.Y * 0.042, 31, 55)
	local paddingX = grid.paddingX or math.clamp(12 * ScaleX, 8, 14)
	local paddingY = grid.paddingY or math.clamp(12 * ScaleY, 8, 15)

	local function positionComponent(component, gridRow, gridCol, columns, rows)
		local width = (cellWidth * columns) + (paddingX * (columns - 1))
		local height = (cellHeight * rows) + (paddingY * (rows - 1))

		local xPos = (gridCol - 1) * (cellWidth + paddingX)
		local yPos = (gridRow - 1) * (cellHeight + paddingY) + grid.topOffset

		component.Size = UDim2.new(0, width, 0, height)
		component.Position = UDim2.new(0, xPos, 0, yPos)
	end

	local function updateGridLayout()
		for _, componentData in pairs(gridComponents) do
			positionComponent(componentData.component, componentData.row, componentData.col, componentData.columns,
				componentData.rows)
		end
	end

	local paddingLeft = content.paddingLeft or (8 * ScaleX)
	local paddingRight = content.paddingRight or (8 * ScaleX)

	createElement("UIPadding", {
		PaddingLeft = UDim.new(0, paddingLeft),
		PaddingRight = UDim.new(0, paddingRight),
		PaddingTop = UDim.new(0, content.paddingTop),
		PaddingBottom = UDim.new(0, content.paddingBottom),
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
		if not behavior.autoScroll then
			return
		end
		task.spawn(function()
			task.wait(animation.scrollDelay)
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
					targetCanvasPosition = sectionTop - animation.scrollOffset
				end
			end

			local maxCanvasPosition = math.max(0, scrollingFrame.CanvasSize.Y.Offset - scrollingFrame.AbsoluteSize.Y)
			targetCanvasPosition = math.min(targetCanvasPosition, maxCanvasPosition)

			createTween(scrollingFrame, animation.duration, {
				CanvasPosition = Vector2.new(scrollingFrame.CanvasPosition.X, targetCanvasPosition)
			}, animation.style, animation.direction):Play()
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
			sectionContent.ClipsDescendants = not isExpanded or behavior.clipWhenCollapsed
			createTween(sectionContent, animation.duration, {
				Size = UDim2.new(1, 0, 0, targetContentHeight)
			}, animation.style, animation.direction):Play()
			createTween(section, animation.duration, {
				Size = UDim2.new(1, 0, 0, targetSectionHeight)
			}, animation.style, animation.direction):Play()

			autoScrollToSection(isExpanded)
		else
			sectionContent.Size = UDim2.new(1, 0, 0, targetContentHeight)
			section.Size = UDim2.new(1, 0, 0, targetSectionHeight)
			sectionContent.ClipsDescendants = not isExpanded or behavior.clipWhenCollapsed
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
		createTween(arrowImage, animation.duration, {
			Rotation = isExpanded and arrow.rotationExpanded or arrow.rotationCollapsed
		}, animation.arrowStyle, animation.arrowDirection):Play()
		updateSectionSize(true)
		task.delay(animation.duration, function()
			isAnimating = false
		end)
	end

	headerButton.Activated:Connect(toggleSection)
	headerButton.MouseEnter:Connect(function()
		createTween(arrowImage, animation.hoverDuration, {
			ImageColor3 = arrow.colorHover
		}):Play()
	end)
	headerButton.MouseLeave:Connect(function()
		createTween(arrowImage, animation.hoverDuration, {
			ImageColor3 = arrow.color
		}):Play()
	end)

	local updateDebounce = false
	local function debouncedUpdate()
		if updateDebounce then
			return
		end
		updateDebounce = true
		task.wait(animation.debounceTime)
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

		if gridPosition and #gridPosition >= 1 then
			columns = gridPosition[1] or 1
			rows = gridPosition[2] or 1
		end

		if not validateGridPosition(columns, rows) then
			columns = 1
			rows = 1
		end

		component.Parent = sectionContent

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

		component:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			if isExpanded then
				updateSectionSize(true)
			end
		end)

		if gridCol + columns - 1 >= grid.maxColumns then
			currentColumn = 1
			currentRow = gridRow + rows
		else
			currentColumn = gridCol + columns
			currentRow = gridRow
		end

		updateSectionSize(true)
		return component
	end

	sectionContent.ChildAdded:Connect(function(child)
		updateGridLayout()
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

local function createDropdown(name, title, options, defaultOption, callback, parentFrame, isMulti, gridPosition)
	isMulti = isMulti or false
	local selectedOptions = {}
	local currentOptions = {}
	local optionValues = {}

	local dropdown = createElement("Frame", {
		Name = name,
		Size = UDim2.new(0, 180, 0, 40),
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
		Thickness = 1,
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
		Thickness = 0.8,
		Color = Color3.fromRGB(180, 180, 180),
		Transparency = 0,
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
				if isMulti and callback then
					callback(selectedOptions)
				end
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
				if not selectedOptions[opt] then
					createTween(optBtn, 0.15,
						{ BackgroundTransparency = 0.7, BackgroundColor3 = Color3.fromRGB(80, 120, 255) }):Play()
				end
			end)

			optBtn.MouseLeave:Connect(function()
				if not selectedOptions[opt] then
					createTween(optBtn, 0.15,
						{ BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(60, 60, 60) })
						:Play()
				end
			end)


			optBtn.MouseButton1Down:Connect(function()
				if isMulti then
					if selectedOptions[opt] then
						selectedOptions[opt] = nil
						createTween(optBtn, 0.15,
							{ BackgroundColor3 = Color3.fromRGB(60, 60, 60), BackgroundTransparency = 1 }):Play()
					else
						selectedOptions[opt] = optionValues[opt] or opt
						createTween(optBtn, 0.15,
							{ BackgroundColor3 = Color3.fromRGB(80, 120, 255), BackgroundTransparency = 0 }):Play()
					end
					local display = table.concat((function()
						local t = {}
						for k, _ in pairs(selectedOptions) do table.insert(t, k) end
						return t
					end)(), ", ")
					selectedLabel.Text = display ~= "" and "Selected: " .. display or "Selected: None"
				else
					for _, otherChild in ipairs(optionsMenu:GetChildren()) do
						if otherChild:IsA("Frame") then
							local btn = otherChild:FindFirstChildWhichIsA("TextButton")
							if btn then
								btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
								btn.BackgroundTransparency = 1
							end
						end
					end
					selectedOptions = { [opt] = optionValues[opt] or opt }
					selectedLabel.Text = "Selected: " .. opt
					createTween(optBtn, 0.15,
						{ BackgroundColor3 = Color3.fromRGB(80, 120, 255), BackgroundTransparency = 0 }):Play()
					closeDropdown()
				end

				truncateWithTooltip(selectedLabel, selectedLabel.Text)

				if callback and not isMulti then
					callback(optionValues[opt] or opt, opt)
				end
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
				if not isMulti then
					closeDropdown()
				end
			end
		end)
	end

	currentOptions, optionValues = parseOptions(options)
	createOptionButtons()

	if defaultOption then
		if isMulti and type(defaultOption) == "table" then
			for _, opt in ipairs(defaultOption) do
				if optionValues[opt] or table.find(currentOptions, opt) then
					selectedOptions[opt] = optionValues[opt] or opt
				end
			end
			local display = table.concat((function()
				local t = {}
				for k, _ in pairs(selectedOptions) do table.insert(t, k) end
				return t
			end)(), ", ")
			selectedLabel.Text = display ~= "" and "Selected: " .. display or "Selected: None"
			truncateWithTooltip(selectedLabel, selectedLabel.Text)
		else
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
	end


	local toggleDebounce = false
	toggleBtn.MouseButton1Click:Connect(function()
		if toggleDebounce then return end
		toggleDebounce = true

		if isOpen then
			closeDropdown()
		else
			openDropdown()
		end

		task.delay(0.1, function()
			toggleDebounce = false
		end)
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
			if isMulti then
				return selectedOptions
			else
				local text = selectedLabel.Text
				if text:match("^Selected: (.+)") then
					local selectedText = text:match("^Selected: (.+)")
					return optionValues[selectedText] or selectedText, selectedText
				end
				return nil, nil
			end
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
		dropdownWrapper.Frame.Parent = parentFrame
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
		Thickness = 1,
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

local function createTextBox(name, mainText, defaultSubText, callback, parentFrame, gridPosition)
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
		Thickness = 1,
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
		Text = mainText or "Label",
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
		Text = defaultSubText and ("Input: " .. defaultSubText) or "Input: ",
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ZIndex = 11,
		Parent = infoFrame
	})

	local textBox = createElement("TextBox", {
		Name = name .. "_Input",
		Size = UDim2.new(1, 0, 0, 36),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1,
		Text = "",
		Font = Enum.Font.SourceSans,
		TextSize = 16,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTransparency = 1,
		TextStrokeTransparency = 1,
		ClearTextOnFocus = false,
		ZIndex = 12,
		Parent = infoFrame
	})

	textBox.Focused:Connect(function()
		subLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)

	textBox:GetPropertyChangedSignal("Text"):Connect(function()
		subLabel.Text = "Input: " .. textBox.Text
	end)

	textBox.FocusLost:Connect(function()
		subLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		if callback then
			callback(textBox.Text)
		end
	end)

	infoFrame.MouseButton1Click:Connect(function()
		textBox:CaptureFocus()
	end)

	local wrapper = {
		Frame = infoFrame,
		MainLabel = mainLabel,
		SubLabel = subLabel,
		TextBox = textBox,
		SetText = function(newText)
			textBox.Text = newText
			subLabel.Text = "Input: " .. newText
		end,
		GetText = function()
			return textBox.Text
		end
	}

	if parentFrame and parentFrame.AddComponent then
		parentFrame.AddComponent(wrapper.Frame, gridPosition)
		return wrapper
	elseif parentFrame and parentFrame.Frame then
		wrapper.Frame.Parent = parentFrame.Frame
		return wrapper
	else
		wrapper.Frame.Parent = parentFrame
		return wrapper
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
		Thickness = 1,
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
		wrapper.Frame.Parent = parentFrame
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
		wrapper.Frame.Parent = parentFrame
		return wrapper
	end
end

local function createInfo3(name, mainText, subText, callback, parentFrame, gridPosition)
	local infoFrame = createElement("Frame", {
		Name = name,
		Size = UDim2.new(0.35, 0, 0.12, 0),
		BackgroundTransparency = 0.85,
		ZIndex = 10,
	})

	createElement("UIStroke", {
		Thickness = 1,
		Color = Color3.fromRGB(140, 140, 140),
		Transparency = 0.4,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = infoFrame
	})

	createElement("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = infoFrame
	})

	createElement("UIPadding", {
		PaddingTop = UDim.new(0.01, 0),
		PaddingBottom = UDim.new(0.03, 0),
		PaddingLeft = UDim.new(0.02, 0),
		PaddingRight = UDim.new(0.02, 0),
		Parent = infoFrame
	})

	local layout = createElement("UIListLayout", {
		Parent = infoFrame,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 2)
	})

	local mainLabel = createElement("TextButton", {
		Name = "MainText",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(235, 235, 235),
		Font = Enum.Font.SourceSansBold,
		TextWrapped = true,
		TextSize = 18,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Text = mainText or "Information",
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ZIndex = 11,
		Parent = infoFrame,
		LayoutOrder = 1
	})

	createElement("UIPadding", {
		PaddingTop = UDim.new(0, 4),
		PaddingBottom = UDim.new(0, 4),
		Parent = mainLabel
	})

	local subLabel = createElement("TextLabel", {
		Name = "SubText",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(220, 220, 220),
		Font = Enum.Font.Gotham,
		TextWrapped = true,
		TextSize = 13,
		Text = subText or "",
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ZIndex = 11,
		Parent = infoFrame,
		LayoutOrder = 2
	})

	local wrapper = {
		Frame = infoFrame,
		MainLabel = mainLabel,
		SubLabel = subLabel,
	}

	local function formatSubText(txt)
		if not txt or txt == "" then return "" end
		local lines = string.split(txt, "\n")
		for i, line in ipairs(lines) do
			line = (i == 1 and line or "• " .. line)
			line = line:gsub("%*%*(.-)%*%*", "<b>%1</b>")
			line = line:gsub("%*(.-)%*", "<i>%1</i>")
			line = line:gsub("%_(.-)%_", "<u>%1</u>")
			lines[i] = line
		end
		return table.concat(lines, "\n")
	end

	function wrapper.SetText(newMainText, newSubText)
		local oldMainText = mainLabel.Text
		local oldSubText = subLabel.Text
		if newMainText ~= nil then mainLabel.Text = newMainText end
		if newSubText ~= nil then subLabel.Text = formatSubText(newSubText) end
		if callback and (oldMainText ~= mainLabel.Text or oldSubText ~= subLabel.Text) then
			callback(mainLabel.Text, subLabel.Text)
		end
	end

	function wrapper.SetMainText(newText)
		local oldText = mainLabel.Text
		mainLabel.Text = newText or "Information"
		if callback and oldText ~= mainLabel.Text then
			callback(mainLabel.Text, subLabel.Text)
		end
	end

	function wrapper.SetSubText(newText)
		local oldText = subLabel.Text
		subLabel.Text = formatSubText(newText)
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

	local expanded = true

	mainLabel.Activated:Connect(function()
		-- Height change logic goes here
	end)


	if parentFrame and parentFrame.AddComponent then
		parentFrame.AddComponent(wrapper.Frame, gridPosition)
		return wrapper
	elseif parentFrame and parentFrame.Frame then
		wrapper.Frame.Parent = parentFrame.Frame
		return wrapper
	else
		wrapper.Frame.Parent = parentFrame
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
		Thickness = 1,
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
		Thickness = 1,
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
		toggle.Parent = parentFrame
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
		Thickness = 1,
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
		wrapper.Frame.Parent = parentFrame
		return wrapper
	end
end

local function createGhostText(parentSection, options, gridPosition)
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

	local gridPos = gridPosition or { 2, 0.6 }

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

local childrenContainer = createCollapsibleContainer("Plants Vs Brainrots - Alpha 0.12.1", mainContainer, Width, Height,
	minWidth, minHeight, maxWidth, maxHeight, { container = { backgroundTransparency = 0.10 } })
local MiscellaneousSection = createSection(childrenContainer, "Miscellaneous")
local AutoFarmSection = createSection(childrenContainer, "Auto Farm")
local AutoBuySection = createSection(childrenContainer, "Auto Buy")
local AutoSellSection = createSection(childrenContainer, "Auto Sell")
local UtilitySection = createSection(childrenContainer, "Utility")


-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Locals
local LocalPlayer = Players.LocalPlayer
local Plots = workspace:WaitForChild("Plots")
local MainFrame = PlayerGui:WaitForChild("Main")
local LeftPanel = MainFrame:WaitForChild("Left")
local RightPanel = MainFrame:WaitForChild("Right")
local NotificationsPanel = PlayerGui:WaitForChild("Notifications")
local BrainrotsFolder = workspace:WaitForChild("ScriptedMap"):WaitForChild("Brainrots")


-- Remotes
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local BuySeedRemote = Remotes:WaitForChild("BuyItem")
local BuyGearRemote = Remotes:WaitForChild("BuyGear")
local ItemSellRemote = Remotes:WaitForChild("ItemSell")
local UseItem = Remotes:WaitForChild("UseItem")

-- Modules
local BrainrotMutations = require(game:GetService("ReplicatedStorage").Modules.Library.BrainrotMutations).Colors
local PlantMutations = require(game:GetService("ReplicatedStorage").Modules.Library.PlantMutations).Colors
local Rarities = require(game:GetService("ReplicatedStorage").Modules.Library.Chances)
local PlayerData = require(ReplicatedStorage.PlayerData)
local GeneralData = require(game:GetService("ReplicatedStorage").Modules.Library.General)
local CodesModule = require(ReplicatedStorage.Modules.Library:WaitForChild("Codes"))
local FuseCombinations = require(ReplicatedStorage.Modules.Library.FuseCombinations)
local BrainrotRegistry = require(ReplicatedStorage.Modules.Registries.BrainrotRegistry)
local PlantRegistry = require(ReplicatedStorage.Modules.Registries.PlantRegistry)


-- ========= HELPER FUNCTIONS ==========
local function getPlayerPlot()
	for _, plot in ipairs(Plots:GetDescendants()) do
		if plot:GetAttribute("Owner") == LocalPlayer.Name then
			return plot
		end
	end
end

local function getPlotPlants()
	local plot = getPlayerPlot()
	local folder = plot and plot:FindFirstChild("Plants")
	if not folder then return {} end

	local valid = {}
	for _, obj in ipairs(folder:GetChildren()) do
		if obj:GetAttribute("ID") then
			valid[#valid + 1] = obj
		end
	end
	return valid
end

local function getPlotRows()
	local plot = getPlayerPlot()
	if not plot then return end

	local unlockedRows = {}
	for _, row in ipairs(plot.Rows:GetChildren()) do
		if row:GetAttribute("Enabled") then
			table.insert(unlockedRows, row)
		end
	end

	return unlockedRows
end

local function removeItem(brainrotID)
	game:GetService("ReplicatedStorage").Remotes.RemoveItem:FireServer(brainrotID)
end

local function placeItem(args)
	game:GetService("ReplicatedStorage").Remotes.PlaceItem:FireServer(args)
end

local function getPlayerInventory(raw)
	local backpack = game:GetService("Players").LocalPlayer:WaitForChild("Backpack")
	return raw and backpack or backpack:GetChildren()
end

local function getPlayerInventoryPlants()
	local backpackItems = getPlayerInventory()
	local plants = {}

	for _, item in ipairs(backpackItems) do
		if item:GetAttribute("IsPlant") == item:GetAttribute("ItemName") then
			table.insert(plants, item)
		end
	end

	return plants
end

local function getAvailableItems(itemType)
	local scrollingFrame = game:GetService("Players").LocalPlayer.PlayerGui.Main[itemType].Frame.ScrollingFrame
	local targetColor = Color3.fromRGB(0, 255, 17)
	local results = {}

	for _, item in pairs(scrollingFrame:GetChildren()) do
		local buyButton = item:FindFirstChild("Buttons")
			and item.Buttons:FindFirstChild("Buy")
			and item.Buttons.Buy:FindFirstChild("TextButton")

		if buyButton and buyButton.ImageColor3 == targetColor then
			table.insert(results, {
				Name = item:FindFirstChild("Title") and item.Title.Text or item.Name,
				Rarity = item:FindFirstChild("Rarity") and item.Rarity.Text or "Unknown",
				Stock = item:FindFirstChild("Stock") and item.Stock.Text or "Unknown",
				Price = item:FindFirstChild("Buttons") and item.Buttons.Buy:FindFirstChild("TextLabel") and
					item.Buttons.Buy.TextLabel.Text or "Unknown"
			})
		end
	end

	return results
end

local function getAvailableSeeds()
	return getAvailableItems("Seeds")
end

local function getAvailableGears()
	return getAvailableItems("Gears")
end

local function makeToolTable(folder)
	local t = {}
	for _, v in pairs(folder:GetChildren()) do
		if v:GetAttribute("Stock") then t[v.Name] = v:GetAttribute("Price") end
	end
	return t
end

local function buyItem(item, itemType)
	local itemName
	if type(item) == "string" then
		itemName = item
	elseif type(item) == "table" and item.Name then
		itemName = item.Name
	else
		return
	end
	if itemType then BuyGearRemote:FireServer(itemName) else BuySeedRemote:FireServer(itemName) end
end

local function sellItems(sellType)
	if sellType == "Brainrots" then
		ItemSellRemote:FireServer(nil, nil, true)
	elseif sellType == "Plants" then
		ItemSellRemote:FireServer(nil, true)
	elseif sellType == "This" then
		ItemSellRemote:FireServer(true)
	else
		createNotification("[sellItems] Invalid sellType: " .. sellType)
	end
end

local function getMaxInventorySize()
	return require(game:GetService("ReplicatedStorage").Modules.Utility.Util).GetMaxInventorySpace(_, LocalPlayer) or 250
end

local function isItemFavorite(tool)
	local inventory = LocalPlayer.PlayerGui.BackpackGui.Backpack.Inventory.ScrollingFrame.UIGridFrame

	for _, itemIcon in ipairs(inventory:GetChildren()) do
		local itemIconID = itemIcon:GetAttribute("ID")
		local ToolID = tool:GetAttribute("ID")
		if itemIconID and itemIconID == ToolID then
			return itemIcon:FindFirstChild("HeartIcon") ~= nil
		end
	end

	return false
end

local function favouriteItem(itemID)
	pcall(function()
		Remotes.FavoriteItem:FireServer(itemID)
	end)
end

local function massFavouriteItemsAndCheck(IdArray)
	spawn(function()
		for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
			local toolID = tool:GetAttribute("ID")
			if toolID and table.find(IdArray, toolID) then
				if not isItemFavorite(tool) then
					favouriteItem(toolID)
				end
			end
		end
	end)
end

local function getKeys(tbl)
	local keys = {}
	for k, _ in pairs(tbl) do
		table.insert(keys, k)
	end
	return keys
end

local function clearGarden(Humanoid)
	if not Humanoid then
		AutoequipRunning = false
		return false, "ERR_NO_HUMANOID"
	end

	local plot = getPlayerPlot()
	if not plot then
		AutoequipRunning = false
		return false, "ERR_NO_PLOT"
	end

	local plotPlants = getPlotPlants()
	local requiredSpace = #plotPlants + 5

	local inventory = getPlayerInventory()
	if getMaxInventorySize() - #inventory < requiredSpace then
		createNotification("Not enough space in inventory, sell first")
		AutoequipRunning = false
		return false, "ERR_INVENTORY_FULL"
	end

	if #plotPlants > 0 then
		local removeCount = 0
		for _, plant in ipairs(plotPlants) do
			removeItem(plant:GetAttribute("ID"))
			removeCount += 1
		end
	end

	repeat task.wait(1) until #getPlotPlants() == 0

	return true, "SUCCESS"
end

local function getStrongestBrainrot(inGrassOnly)
	local plot = getPlayerPlot()
	if not plot then return nil end
	local maxDPS = 0
	for _, row in ipairs(plot.Rows:GetChildren()) do
		local dps = row:GetAttribute("TotalDPS") or 0
		if dps > maxDPS then maxDPS = dps end
	end
	local threshold = maxDPS * 15
	local strongest, maxHealth = nil, -math.huge
	for _, br in ipairs(BrainrotsFolder:GetChildren()) do
		if br:IsA("Model") and tostring(br:GetAttribute("Plot")) == plot.Name then
			local progress = br:GetAttribute("Progress") or 0
			if (not inGrassOnly or progress >= 0.6) then
				local health = br:GetAttribute("MaxHealth") or 0
				if health > maxHealth and health > threshold then
					maxHealth = health
					strongest = br
				end
			end
		end
	end
	return strongest
end

local function findFrostGrenade()
	local char = LocalPlayer.Character
	if not char then return nil end
	for _, tool in ipairs(char:GetChildren()) do
		if tool:IsA("Tool") and tool:GetAttribute("Name") == "Frost Grenade" then
			return tool
		end
	end
end

local function getRowWithLowestDPS()
	local plot = getPlayerPlot()
	if not plot then return nil, 0 end
	local lowest, rowRef = math.huge, nil
	for _, row in ipairs(plot.Rows:GetChildren()) do
		local dps = row:GetAttribute("TotalDPS") or 0
		if dps < lowest then
			lowest = dps
			rowRef = row
		end
	end
	return rowRef, lowest
end

local function computeTimeToKill(brainrot, rowDPS)
	local health = brainrot:GetAttribute("MaxHealth") or 0
	if rowDPS <= 0 then return math.huge end
	return health / rowDPS
end

local function clearAndPlaceBestPlants(row)
	local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	local Backpack = LocalPlayer:WaitForChild("Backpack")
	local items = {}
	for _, tool in ipairs(Backpack:GetChildren()) do
		if tool:IsA("Tool") and tool:GetAttribute("Damage") and tool:GetAttribute("Cooldown") and tool:GetAttribute("Cooldown") > 0 then
			table.insert(items, {
				Tool = tool,
				Damage = tool:GetAttribute("Damage"),
				Cooldown = tool:GetAttribute("Cooldown"),
				DPS = tool:GetAttribute("Damage") / tool:GetAttribute("Cooldown")
			})
		end
	end
	table.sort(items, function(a, b) return a.DPS > b.DPS end)
	local GrassParts = row.Grass:GetChildren()
	for i, plantData in ipairs(items) do
		if i > #GrassParts then break end
		local grass = GrassParts[i]
		pcall(function() Humanoid:EquipTool(plantData.Tool) end)
		task.wait(0.05)
		placeItem({
			ID = plantData.Tool:GetAttribute("ID"),
			CFrame = grass.CFrame,
			Item = plantData.Tool
				:GetAttribute("ItemName"),
			Floor = grass
		})
		task.wait(0.05)
		pcall(function() Humanoid:UnequipTools() end)
	end
end

-- Calculates the DPS (Damage Per Second) of a plant
-- @param plant: Instance - The plant tool/item to calculate DPS for
-- @return number|nil - The DPS value, or nil if calculation fails
local function getPlantDPS(plant)
	local damage = plant:GetAttribute("Damage")
	local model = plant:FindFirstChildWhichIsA("Model")
	local cooldown = model and model:GetAttribute("Cooldown")
	if damage and cooldown and cooldown > 0 then
		return damage / cooldown
	end
	return nil
end

-- Returns the top N plants sorted by DPS (Damage Per Second)
-- @param n: number - Maximum number of plants to return
-- @return table - Array of plant data tables containing ID, Name, Damage, Cooldown, and DPS
local function getTopNPlants(n)
	local items = getPlayerInventoryPlants()
	local sorted = {}
	for _, item in ipairs(items) do
		local id = item:GetAttribute("ID")
		local damage = item:GetAttribute("Damage")
		local model = item:FindFirstChildWhichIsA("Model")
		local cooldown = model and model:GetAttribute("Cooldown")
		if id and damage and cooldown and cooldown > 0 then
			table.insert(sorted, {
				ID = id,
				Name = item:GetAttribute("ItemName"),
				Damage = damage,
				Cooldown = cooldown,
				DPS = damage / cooldown,
			})
		end
	end
	table.sort(sorted, function(a, b) return a.DPS > b.DPS end)
	local result = {}
	for i = 1, math.min(#sorted, n) do
		table.insert(result, sorted[i])
	end
	return result
end

-- Retrieves all grass parts from each row for plant placement
-- @param rows: table - Array of row instances
-- @return table - Indexed table where each index corresponds to a row's grass children
local function getRowGrass(rows)
	local grass = {}
	for i, row in ipairs(rows) do
		local g = row:FindFirstChild("Grass")
		grass[i] = g and g:GetChildren() or {}
	end
	return grass
end

-- Calculates the total DPS for a given row
-- @param rowData: table - Row data table containing totalDamage field
-- @return number - Total damage/DPS for the row
local function getRowDPS(rowData)
	return rowData.totalDamage
end

-- Places multiple plants sequentially with verification delays
-- @param plantConfigs: table - Array of config tables, each containing plantData and grassPart
-- @param humanoid: Humanoid - Player's humanoid instance for equipping tools
-- @param inventoryItems: table - Array of inventory items to match plant IDs against
local function placePlants(plantConfigs, humanoid, inventoryItems)
	for _, config in ipairs(plantConfigs) do
		local matchedItem
		for _, invItem in ipairs(inventoryItems) do
			if invItem:GetAttribute("ID") == config.plantData.ID then
				matchedItem = invItem
				break
			end
		end
		if matchedItem then
			pcall(function() humanoid:EquipTool(matchedItem) end)
			task.wait(0.1)
			placeItem({
				ID = matchedItem:GetAttribute("ID"),
				CFrame = config.grassPart.CFrame,
				Item = matchedItem:GetAttribute("ItemName"),
				Floor = config.grassPart
			})
			local plotPlants = getPlayerPlot().Plants
			local startTime = os.clock()
			while os.clock() - startTime < 10 do
				local placed = false
				for _, planted in ipairs(plotPlants:GetChildren()) do
					if planted:GetAttribute("ID") == matchedItem:GetAttribute("ID") then
						placed = true
						break
					end
				end
				if placed then break end
				task.wait(0.05)
			end
			pcall(function() humanoid:UnequipTools() end)
			task.wait(0.1)
		end
	end
end

-- Uses frost grenade on a target with continuous application
-- @param target: Instance - The target to apply frost grenade on
-- @param duration: number - How long to keep applying frost (in seconds)
-- @param interval: number - Time between each frost application (default: 0.1)
-- @return boolean - Returns true if frost grenade was found and used, false otherwise
local function useFrostGrenadeOnTarget(target, duration, interval)
	interval = interval or 0.1
	local tool = findFrostGrenade()
	if not tool then return false end

	local RunService = game:GetService("RunService")
	local timer = 0
	local conn
	conn = RunService.Heartbeat:Connect(function(dt)
		if not target.Parent then
			conn:Disconnect()
			return
		end
		timer += dt
		if timer >= interval then
			UseItem:FireServer({
				Toggle = true,
				Time = 1,
				Tool = tool,
				Pos = target:GetPivot().Position
			})
			timer = 0
		end
	end)

	task.delay(duration, function()
		conn:Disconnect()
	end)

	return true
end

local OriginalSizes = {}
local Stored = false
local function StoreOriginalSizes(Container)
	for _, obj in ipairs(Container:GetDescendants()) do
		if obj:IsA("Frame") then
			OriginalSizes[obj] = obj.Size
		end
	end
end

local function debugLogTable(tbl, indentLevel)
	indentLevel = indentLevel or 0
	local seen = {}

	local function serialize(value, level)
		local t = typeof(value)
		local indent = string.rep("  ", level)
		local nextIndent = string.rep("  ", level + 1)
		if t == "table" then
			if seen[value] then
				return '"<cycle>"'
			end
			seen[value] = true
			local isArray = true
			local n = 0
			for k in pairs(value) do
				if type(k) ~= "number" then
					isArray = false
					break
				else
					n = math.max(n, k)
				end
			end
			local parts = {}
			if isArray then
				for i = 1, n do
					table.insert(parts, serialize(value[i], level + 1))
				end
				return "[\n" .. nextIndent .. table.concat(parts, ",\n" .. nextIndent) .. "\n" .. indent .. "]"
			else
				for k, v in pairs(value) do
					local key
					if type(k) == "string" then
						key = '"' .. k .. '"'
					else
						key = '"[' .. tostring(k) .. ']"'
					end
					table.insert(parts, key .. ": " .. serialize(v, level + 1))
				end
				return "{\n" .. nextIndent .. table.concat(parts, ",\n" .. nextIndent) .. "\n" .. indent .. "}"
			end
		elseif t == "string" then
			return '"' .. value:gsub('"', '\\"') .. '"'
		elseif t == "number" or t == "boolean" then
			return tostring(value)
		elseif t == "Color3" then
			return '"' .. string.format("#%02X%02X%02X", value.R * 255, value.G * 255, value.B * 255) .. '"'
		elseif t == "Vector3" then
			return '"' .. string.format("Vector3(%f,%f,%f)", value.X, value.Y, value.Z) .. '"'
		elseif t == "Vector2" then
			return '"' .. string.format("Vector2(%f,%f)", value.X, value.Y) .. '"'
		elseif t == "UDim2" then
			return '"' ..
				string.format("UDim2(%f,%d,%f,%d)", value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset) .. '"'
		elseif t == "EnumItem" then
			return '"' .. tostring(value) .. '"'
		elseif t == "Instance" then
			return '"' .. value:GetFullName() .. '"'
		else
			return '"<' .. t .. '>"'
		end
	end

	print(serialize(tbl, indentLevel))
end

-- Common Labels
local SelectedSeeds = {}
local SelectedGears = {}
local AutoBuySeedEnabled = false
local AutoBuyGearEnabled = false
local AutoSellBrainrotEnabled = true
local AutoEquipBestBrainrot = true
local AutoSellPlantsEnabled = true
local AutoHandleHeavyBrainrots = false
local AutoUseFrostGrenade = false
local PlaceId = game.PlaceId
local JobId = game.JobId
local SelectedBrainrotRarityFilter = {}
local SelectedBrainrotModifierFilter = {}
local SelectedBrainrotWeightFilter = {}
local SelectedPlantsRarityFilter = {}
local SelectedPlantsWeightFilter = {}
local FilterCombination = nil
local MaxPlantsPerRow = GeneralData.MaxPlantsPerRow or 5
local AutoequipRunning = false
local SeedsTable = makeToolTable(game:GetService("ReplicatedStorage").Assets.Seeds)
local GearsTable = makeToolTable(game:GetService("ReplicatedStorage").Assets.Gears)


-- ========= MISCELLANEOUS SECTION ==========

createButton("ClearGardenButton", "Clear Garden", function()
	local LocalPlayer = game:GetService("Players").LocalPlayer
	local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	local success, code = clearGarden(Humanoid)

	if not success then
		createNotification("Failed to clear garden, try again later. ERROR CODE: " .. code.tostring())
	end
end, MiscellaneousSection)

createButton("RedeemCodesbutton", "Redeem All Codes", function()
	for codeName, _ in pairs(CodesModule) do
		ReplicatedStorage.Remotes.ClaimCode:FireServer(codeName)
	end
end, MiscellaneousSection)

createButton("CheckRecipesButton", "Show Recipes", function()
	local existingGui = PlayerGui:FindFirstChild("FusionRecipeGui")
	if existingGui then
		existingGui.Enabled = not existingGui.Enabled
		return
	end
	local Assets = ReplicatedStorage.Assets

	local function getIcon(name)
		if BrainrotRegistry[name] and BrainrotRegistry[name].Icon then return BrainrotRegistry[name].Icon end
		if PlantRegistry[name] and PlantRegistry[name].Icon then return PlantRegistry[name].Icon end
		local plantFolder = Assets.Plants:FindFirstChild(name)
		if plantFolder and plantFolder:IsA("Folder") then
			local iconValue = plantFolder:FindFirstChild("Icon")
			if iconValue then return iconValue.Value end
		end
		return ""
	end

	local function corner(p, r)
		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(0, r)
		c.Parent = p
	end

	local function stroke(p, col, t)
		local s = Instance.new("UIStroke")
		s.Color = col
		s.Thickness = t
		s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		s.Parent = p
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "FusionRecipeGui"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.Parent = PlayerGui

	local Backdrop = Instance.new("Frame")
	Backdrop.Size = UDim2.new(1, 0, 1, 0)
	Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Backdrop.BackgroundTransparency = 0.5
	Backdrop.BorderSizePixel = 0
	Backdrop.Parent = ScreenGui

	local MainFrame = Instance.new("Frame")
	MainFrame.Size = UDim2.new(0.30, 0, 0.7, 0)
	MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	MainFrame.BorderSizePixel = 0
	MainFrame.Active = true
	MainFrame.Draggable = true
	MainFrame.Parent = ScreenGui
	corner(MainFrame, 16)
	stroke(MainFrame, Color3.fromRGB(45, 45, 52), 2)

	local TopBar = Instance.new("Frame")
	TopBar.Size = UDim2.new(1, 0, 0, 60)
	TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
	TopBar.BorderSizePixel = 0
	TopBar.Parent = MainFrame
	corner(TopBar, 16)
	stroke(TopBar, Color3.fromRGB(45, 45, 52), 1)

	local BarBottom = Instance.new("Frame")
	BarBottom.Size = UDim2.new(1, 0, 0, 16)
	BarBottom.Position = UDim2.new(0, 0, 1, -16)
	BarBottom.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
	BarBottom.BorderSizePixel = 0
	BarBottom.Parent = TopBar

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, -80, 1, 0)
	Title.Position = UDim2.new(0, 24, 0, 0)
	Title.Text = "Fusion Recipes"
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 20
	Title.TextColor3 = Color3.fromRGB(240, 240, 245)
	Title.BackgroundTransparency = 1
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = TopBar

	local CloseButton = Instance.new("TextButton")
	CloseButton.Size = UDim2.new(0, 40, 0, 40)
	CloseButton.Position = UDim2.new(1, -52, 0.5, -20)
	CloseButton.Text = "x"
	CloseButton.Font = Enum.Font.GothamBold
	CloseButton.TextSize = 20
	CloseButton.TextColor3 = Color3.fromRGB(180, 180, 190)
	CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
	CloseButton.Parent = TopBar
	corner(CloseButton, 8)

	CloseButton.MouseEnter:Connect(function()
		CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
		CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)
	CloseButton.MouseLeave:Connect(function()
		CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
		CloseButton.TextColor3 = Color3.fromRGB(180, 180, 190)
	end)
	CloseButton.MouseButton1Click:Connect(function()
		ScreenGui.Enabled = false
	end)

	local ScrollContainer = Instance.new("Frame")
	ScrollContainer.Size = UDim2.new(1, -32, 1, -76)
	ScrollContainer.Position = UDim2.new(0, 16, 0, 68)
	ScrollContainer.BackgroundTransparency = 1
	ScrollContainer.Parent = MainFrame

	local Scroll = Instance.new("ScrollingFrame")
	Scroll.Size = UDim2.new(1, 0, 1, 0)
	Scroll.BackgroundTransparency = 1
	Scroll.BorderSizePixel = 0
	Scroll.ScrollBarThickness = 1
	Scroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
	Scroll.Parent = ScrollContainer
	corner(Scroll, 8)

	local ListLayout = Instance.new("UIListLayout")
	ListLayout.Padding = UDim.new(0, 12)
	ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ListLayout.Parent = Scroll

	local function createRecipeRow(plantName, brainrotName, resultName)
		local Row = Instance.new("Frame")
		Row.Size = UDim2.new(1, -16, 0, 110)
		Row.BackgroundTransparency = 1
		Row.BorderSizePixel = 0
		Row.Parent = Scroll

		local InnerContainer = Instance.new("Frame")
		InnerContainer.Size = UDim2.new(1, -24, 1, -12)
		InnerContainer.Position = UDim2.new(0, 12, 0, 6)
		InnerContainer.BackgroundTransparency = 1
		InnerContainer.Parent = Row

		local cardWidth = 85
		local operatorWidth = 35
		local spacing = 25

		local function createItemCard(name, posX)
			local CardFrame = Instance.new("Frame")
			CardFrame.Size = UDim2.new(0, cardWidth, 1, 0)
			CardFrame.Position = UDim2.new(0, posX, 0, 0)
			CardFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
			CardFrame.BorderSizePixel = 0
			CardFrame.Parent = InnerContainer
			corner(CardFrame, 10)
			stroke(CardFrame, Color3.fromRGB(50, 50, 60), 1.5)

			local IconFrame = Instance.new("Frame")
			IconFrame.Size = UDim2.new(1, -12, 1, -30)
			IconFrame.Position = UDim2.new(0, 6, 0, 6)
			IconFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
			IconFrame.BorderSizePixel = 0
			IconFrame.Parent = CardFrame
			corner(IconFrame, 8)

			local Icon = Instance.new("ImageLabel")
			Icon.Size = UDim2.new(1, -4, 1, -4)
			Icon.Position = UDim2.new(0, 2, 0, 2)
			Icon.Image = getIcon(name)
			Icon.BackgroundTransparency = 1
			Icon.BorderSizePixel = 0
			Icon.Parent = IconFrame

			local NameLabel = Instance.new("TextLabel")
			NameLabel.Size = UDim2.new(1, -8, 0, 18)
			NameLabel.Position = UDim2.new(0, 4, 1, -22)
			NameLabel.Text = name
			NameLabel.Font = Enum.Font.GothamMedium
			NameLabel.TextSize = 9
			NameLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
			NameLabel.BackgroundTransparency = 1
			NameLabel.TextWrapped = true
			NameLabel.TextScaled = true
			NameLabel.TextXAlignment = Enum.TextXAlignment.Center
			NameLabel.Parent = CardFrame

			return CardFrame
		end

		local function createOperator(symbol, posX)
			local OpLabel = Instance.new("TextLabel")
			OpLabel.Size = UDim2.new(0, operatorWidth, 0, 36)
			OpLabel.Position = UDim2.new(0, posX, 0.5, -18)
			OpLabel.Text = symbol
			OpLabel.Font = Enum.Font.GothamBold
			OpLabel.TextSize = 28
			OpLabel.TextColor3 = Color3.fromRGB(120, 120, 140)
			OpLabel.BackgroundTransparency = 1
			OpLabel.TextXAlignment = Enum.TextXAlignment.Center
			OpLabel.Parent = InnerContainer
			return OpLabel
		end

		local pos1 = 0
		createItemCard(plantName, pos1)

		local pos2 = pos1 + cardWidth + spacing
		createOperator("+", pos2)

		local pos3 = pos2 + operatorWidth + spacing
		createItemCard(brainrotName, pos3)

		local pos4 = pos3 + cardWidth + spacing
		createOperator("→", pos4)

		local pos5 = pos4 + operatorWidth + spacing
		createItemCard(resultName, pos5)

		local totalWidth = pos5 + cardWidth

		local function updateScale()
			local availableWidth = InnerContainer.AbsoluteSize.X
			if totalWidth > availableWidth then
				local scale = availableWidth / totalWidth
				InnerContainer.Size = UDim2.new(1, -24, scale, 0)
				InnerContainer.Position = UDim2.new(0, 12, 0.5, -(InnerContainer.AbsoluteSize.Y / 2))
			end
		end

		task.wait()
		updateScale()
		InnerContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateScale)
		Row:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateScale)
	end

	for plantName, data in pairs(FuseCombinations) do
		createRecipeRow(plantName, data.Brainrot, data.Result)
	end

	Scroll.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 12)
	ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Scroll.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 12)
	end)
end, MiscellaneousSection)

createGhostText(MiscellaneousSection, {
	Text = "User Interface",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	Font = Enum.Font.SourceSansBold,
	TextSize = 20,
	TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Bottom,
})

createButton("SeedsUIButton", "Seeds UI", function()
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("OpenUI"):Fire(
		game:GetService("Players").LocalPlayer.PlayerGui.Main.Seeds, true)
end, MiscellaneousSection)

createButton("GearsUIButton", "Gears UI", function()
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("OpenUI"):Fire(
		game:GetService("Players").LocalPlayer.PlayerGui.Main.Gears, true)
end, MiscellaneousSection)

createToggleButton("BetterUiToggleButton", "Better Sizes", false, function(state)
	if not Stored then
		StoreOriginalSizes(LeftPanel)
		StoreOriginalSizes(RightPanel)
		StoreOriginalSizes(NotificationsPanel)
		Stored = true
	end

	local Containers = { LeftPanel, RightPanel, NotificationsPanel }
	local ScaleFactors = { 0.7, 0.7, 0.55 }

	if state then
		for i, container in ipairs(Containers) do
			local factor = ScaleFactors[i]
			for _, obj in ipairs(container:GetDescendants()) do
				if obj:IsA("Frame") and OriginalSizes[obj] then
					local s = OriginalSizes[obj]
					obj.Size = UDim2.new(s.X.Scale * factor, s.X.Offset * factor, s.Y.Scale * factor, s.Y.Offset * factor)
				end
			end
		end

		local GardenButton = RightPanel:FindFirstChild("Garden")
		if GardenButton and not RightPanel:FindFirstChild("IslandButton") then
			local IslandButton = Instance.new("Frame")
			IslandButton.Name = "IslandButton"
			IslandButton.Size = GardenButton.Size
			IslandButton.Position = GardenButton.Position
			IslandButton.AnchorPoint = GardenButton.AnchorPoint
			IslandButton.BackgroundTransparency = GardenButton.BackgroundTransparency
			IslandButton.BackgroundColor3 = GardenButton.BackgroundColor3
			IslandButton.BorderSizePixel = GardenButton.BorderSizePixel
			IslandButton.ClipsDescendants = GardenButton.ClipsDescendants
			IslandButton.ZIndex = GardenButton.ZIndex
			IslandButton.Rotation = GardenButton.Rotation
			IslandButton.LayoutOrder = GardenButton.LayoutOrder
			IslandButton.Visible = GardenButton.Visible
			IslandButton.Parent = RightPanel

			local function cloneChild(orig, parent)
				for _, child in ipairs(orig:GetChildren()) do
					local newChild = child:Clone()
					newChild.Parent = parent
					if newChild:IsA("GuiObject") then
						newChild.ZIndex = child.ZIndex
						newChild.ClipsDescendants = child.ClipsDescendants
					end
					cloneChild(child, newChild)
				end
			end
			cloneChild(GardenButton, IslandButton)

			local Glow = IslandButton:FindFirstChild("Glow", true)
			if Glow and Glow:IsA("ImageLabel") then
				Glow.ImageColor3 = Color3.fromRGB(255, 255, 0)
			end

			local TextButton = IslandButton:FindFirstChild("TextButton", true)
			if TextButton and TextButton:IsA("ImageButton") then
				local Gradient = TextButton:FindFirstChild("UIGradient")
				if Gradient then
					Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 0))
				end
				TextButton.MouseButton1Click:Connect(function()
					local Central = workspace:WaitForChild("Map"):WaitForChild("CentralIsland"):FindFirstChild("Union")
					if Central and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						LocalPlayer.Character.HumanoidRootPart.CFrame = Central.CFrame + Vector3.new(0, 10, 0)
					end
				end)
			end

			local TextLabel = IslandButton:FindFirstChild("TextLabel", true)
			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.Text = "Island"
			end
		end
	else
		for obj, size in pairs(OriginalSizes) do
			if obj then
				obj.Size = size
			end
		end
		local IslandButton = RightPanel:FindFirstChild("IslandButton")
		if IslandButton then
			IslandButton:Destroy()
		end
	end
end, MiscellaneousSection)

local ExtraInfoActive = false

createButton("AddAdditionalInformation", "Show Extra Info", function()
	if ExtraInfoActive then return end
	ExtraInfoActive = true

	local BackpackGUI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("BackpackGui")
	local InventoryFrame = BackpackGUI.Backpack.Inventory
	local GridFrame = InventoryFrame.ScrollingFrame.UIGridFrame
	local Backpack = LocalPlayer:WaitForChild("Backpack")

	local Categories = InventoryFrame:FindFirstChild("Categories")
	if Categories then
		Categories.Position = UDim2.new(0.95, 0, Categories.Position.Y.Scale, Categories.Position.Y.Offset)
	end

	local InventoryCounter = InventoryFrame:FindFirstChild("InventoryCounter")
	if not InventoryCounter then
		InventoryCounter = Instance.new("TextLabel")
		InventoryCounter.Name = "InventoryCounter"
		InventoryCounter.AnchorPoint = Vector2.new(0, 0)
		InventoryCounter.Position = UDim2.new(0.45, 0, 0, 0)
		InventoryCounter.Size = UDim2.new(0, 160, 0, 22)
		InventoryCounter.BackgroundTransparency = 1
		InventoryCounter.Font = Enum.Font.GothamBold
		InventoryCounter.TextColor3 = Color3.fromRGB(255, 255, 255)
		InventoryCounter.TextScaled = true
		InventoryCounter.TextXAlignment = Enum.TextXAlignment.Left
		InventoryCounter.ZIndex = 20
		InventoryCounter.Parent = InventoryFrame
	end

	local function FormatValue(value)
		if value >= 1e9 then
			return string.format("$%.2fB/s", value / 1e9)
		elseif value >= 1e6 then
			return string.format("$%.2fM/s", value / 1e6)
		elseif value >= 1e3 then
			return string.format("$%.2fK/s", value / 1e3)
		else
			return string.format("$%.0f/s", value)
		end
	end

	local function FormatDPS(value)
		if value >= 1e9 then
			return string.format("%.2fB", value / 1e9)
		elseif value >= 1e6 then
			return string.format("%.2fM", value / 1e6)
		elseif value >= 1e3 then
			return string.format("%.1fK", value / 1e3)
		else
			return string.format("%.0f", value)
		end
	end

	local function FindToolByID(slotID)
		for _, tool in ipairs(Backpack:GetChildren()) do
			if tool:IsA("Tool") and tool:GetAttribute("ID") == slotID then return tool end
		end
		for _, tool in ipairs(LocalPlayer.Character:GetChildren()) do
			if tool:IsA("Tool") and tool:GetAttribute("ID") == slotID then return tool end
		end
		return nil
	end

	local function UpdateSlotOverlay(slot)
		if not slot:IsA("TextButton") then return end
		local slotID = slot:GetAttribute("ID")
		local slotCategory = slot:GetAttribute("Category")
		if not slotID or not slotCategory then return end
		if slotCategory ~= "Plants" and slotCategory ~= "Brainrots" then return end

		local toolItem = FindToolByID(slotID)
		if not toolItem then return end

		local overlay = slot:FindFirstChild("ExtraInfoOverlay")
		if not overlay then
			overlay = Instance.new("TextLabel")
			overlay.Name = "ExtraInfoOverlay"
			overlay.AnchorPoint = Vector2.new(0.5, 0)
			overlay.Size = UDim2.new(1, 0, 0, 18)
			overlay.Position = UDim2.new(0.5, 0, 0, 0)
			overlay.BackgroundTransparency = 0.35
			overlay.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			overlay.TextStrokeTransparency = 0.5
			overlay.Font = Enum.Font.GothamBold
			overlay.TextScaled = true
			overlay.TextYAlignment = Enum.TextYAlignment.Top
			overlay.ZIndex = 10
			overlay.Parent = slot

			local slotLabel = slot:FindFirstChildOfClass("TextLabel")
			if slotLabel then
				slotLabel.Position = slotLabel.Position + UDim2.new(0, 0, 0.18, 0)
			end
		end

		if slotCategory == "Plants" then
			local damage = toolItem:GetAttribute("Damage") or 0
			local itemName = toolItem:GetAttribute("ItemName")
			local model = toolItem:FindFirstChild(itemName)
			local cooldown = model and model:GetAttribute("Cooldown") or 1
			local dps = damage / cooldown
			overlay.Text = "DPS: " .. FormatDPS(dps)
			overlay.TextColor3 = Color3.fromRGB(0, 255, 100)
		elseif slotCategory == "Brainrots" then
			local worth = toolItem:GetAttribute("Worth") or 0
			overlay.Text = FormatValue(worth)
			overlay.TextColor3 = Color3.fromRGB(255, 220, 0)
		end
		overlay.Visible = true
	end

	local function RemoveSlotOverlay(slot)
		local overlay = slot:FindFirstChild("ExtraInfoOverlay")
		if overlay then
			local slotLabel = slot:FindFirstChildOfClass("TextLabel")
			if slotLabel then slotLabel.Position = slotLabel.Position - UDim2.new(0, 0, 0.18, 0) end
			overlay:Destroy()
		end
	end

	local function UpdateInventoryCounter()
		InventoryCounter.Text = string.format("Inventory: %d", #Backpack:GetChildren())
	end

	for _, slot in ipairs(GridFrame:GetChildren()) do
		UpdateSlotOverlay(slot)
	end

	GridFrame.ChildAdded:Connect(UpdateSlotOverlay)
	GridFrame.ChildRemoved:Connect(RemoveSlotOverlay)
	Backpack.ChildAdded:Connect(UpdateInventoryCounter)
	Backpack.ChildRemoved:Connect(UpdateInventoryCounter)
	UpdateInventoryCounter()

	local startX = -0.21
	local startY = 0.05
	local spacing = 0.1

	local heading = Instance.new("TextLabel")
	heading.Name = "SortHeading"
	heading.Text = "Sort By:"
	heading.AnchorPoint = Vector2.new(0, 0)
	heading.Position = UDim2.new(startX, -60, startY - spacing, 0)
	heading.Size = UDim2.new(0.35, 0, 0.12, 0)
	heading.BackgroundTransparency = 1
	heading.Font = Enum.Font.GothamBlack
	heading.TextColor3 = Color3.fromRGB(255, 255, 255)
	heading.TextStrokeTransparency = 0.4
	heading.TextScaled = false
	heading.TextSize = 22
	heading.Parent = InventoryFrame

	local buttonData = {
		{ Id = "SortByDPS", Text = "Damage/s" },
		{ Id = "SortByMPS", Text = "Money/s" }
	}

	for i, data in ipairs(buttonData) do
		local btn = Instance.new("TextButton")
		btn.Name = data.Id
		btn.Text = data.Text
		btn.AnchorPoint = Vector2.new(0, 0)
		btn.Position = UDim2.new(startX, -20, startY + (i - 1) * spacing, 0)
		btn.Size = UDim2.new(0.22, 0, 0.08, 0)
		btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		btn.BorderSizePixel = 0
		btn.AutoButtonColor = false
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.Font = Enum.Font.GothamBold
		btn.TextScaled = false
		btn.TextSize = 18
		btn.ZIndex = 20
		btn.Parent = InventoryFrame

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 6)
		corner.Parent = btn

		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.fromRGB(80, 80, 80)
		stroke.Thickness = 1
		stroke.Parent = btn

		btn.MouseEnter:Connect(function()
			btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			stroke.Color = Color3.fromRGB(120, 120, 120)
		end)

		btn.MouseLeave:Connect(function()
			btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			stroke.Color = Color3.fromRGB(80, 80, 80)
		end)

		btn.MouseButton1Click:Connect(function()
			local slots = {}
			for _, slot in ipairs(GridFrame:GetChildren()) do
				if slot:IsA("TextButton") then
					local category = slot:GetAttribute("Category")
					if data.Id == "SortByDPS" and category == "Plants" then
						local tool = FindToolByID(slot:GetAttribute("ID"))
						if tool then
							local dmg = tool:GetAttribute("Damage") or 0
							local model = tool:FindFirstChild(tool:GetAttribute("ItemName"))
							local cd = model and model:GetAttribute("Cooldown") or 1
							slot:SetAttribute("SortValue", dmg / cd)
							table.insert(slots, slot)
						end
					elseif data.Id == "SortByMPS" and category == "Brainrots" then
						local tool = FindToolByID(slot:GetAttribute("ID"))
						if tool then
							local worth = tool:GetAttribute("Worth") or 0
							slot:SetAttribute("SortValue", worth)
							table.insert(slots, slot)
						end
					end
				end
			end

			table.sort(slots, function(a, b)
				return (a:GetAttribute("SortValue") or 0) > (b:GetAttribute("SortValue") or 0)
			end)

			for i, slot in ipairs(slots) do
				slot.LayoutOrder = i
			end
		end)
	end
end, MiscellaneousSection)

-- ========= AUTO FARM SECTION ==========

createInfo3("WIPAutoFarm", "Work in progress!",
	"Payme 1 millon dolla to speed this up, will support auto frost grenade and auto handle high $$/s brainrot",
function() end, AutoFarmSection, { 2, 1.3 })


createButton("AutoEquipBestPlants", "Equip Best Plants", function()
	if AutoequipRunning then
		return createNotification("Auto Equip already running — please wait.")
	end
	AutoequipRunning = true

	task.spawn(function()
		local LocalPlayer = game:GetService("Players").LocalPlayer
		local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		local success, code = clearGarden(Humanoid)
		if not success then
			AutoequipRunning = false
			createNotification("Failed to clear garden, try again later. ERROR CODE: " .. code)
			return
		end

		local Rows = getPlotRows()
		if not Rows or #Rows == 0 then
			AutoequipRunning = false
			return
		end

		local totalRows = #Rows
		local maxPlants = totalRows * MaxPlantsPerRow
		local Plants = getTopNPlants(maxPlants)

		local RowData = {}
		for i = 1, totalRows do
			RowData[i] = { name = Rows[i].Name or ("Row" .. i), totalDamage = 0, plants = {} }
		end

		for _, plant in ipairs(Plants) do
			local bestRow, lowestDamage = nil, math.huge
			for i, col in ipairs(RowData) do
				if #col.plants < MaxPlantsPerRow and col.totalDamage < lowestDamage then
					bestRow = col
					lowestDamage = col.totalDamage
				end
			end
			if bestRow then
				table.insert(bestRow.plants, plant)
				bestRow.totalDamage += plant.Damage
			end
		end

		local RowGrass = getRowGrass(Rows)
		local items = getPlayerInventoryPlants()

		print("\n==== PLANT DISTRIBUTION TABLE ====")
		for i, col in ipairs(RowData) do
			print("\n" .. col.name .. ": {")
			for _, plant in ipairs(col.plants) do
				local matchedItem
				for _, invItem in ipairs(items) do
					if invItem:GetAttribute("ID") == plant.ID then
						matchedItem = invItem
						break
					end
				end
				local itemName = matchedItem and matchedItem:GetAttribute("ItemName") or "Unknown"
				print("   ID:", plant.ID, "| Name:", itemName, "| Damage:", plant.Damage)
			end
			print("   Total Damage =", col.totalDamage, "}")
		end

		local minDmg, maxDmg = math.huge, 0
		for RowIndex = 1, totalRows do
			local grassParts = RowGrass[RowIndex]
			if grassParts and #grassParts > 0 then
				local configs = {}
				for slot = 1, MaxPlantsPerRow do
					local plantData = RowData[RowIndex].plants[slot]
					if plantData then
						local grassPart = grassParts[((slot - 1) % #grassParts) + 1]
						table.insert(configs, { plantData = plantData, grassPart = grassPart })
					end
				end
				placePlants(configs, Humanoid, items)
				local dmg = getRowDPS(RowData[RowIndex])
				if dmg < minDmg then minDmg = dmg end
				if dmg > maxDmg then maxDmg = dmg end
			end
		end

		print("\nDamage spread:", maxDmg - minDmg)
		AutoequipRunning = false
	end)
end, AutoFarmSection, { 0.9, 1 })

LoopFramework:registerTask("AutoEquipBestBrainrot", 5, function()
	if AutoSellBrainrotEnabled or not AutoEquipBestBrainrot then return end
	Remotes.EquipBestBrainrots:FireServer()
end)
createToggleButton("AutoEquipSetBrainrot", "Equip Brainrots", false, function(state)
	AutoEquipBestBrainrot = state
	LoopFramework:setTaskEnabled("AutoEquipBestBrainrot", state)
end, AutoFarmSection, { 1.1, 1 })

--[[
createToggleButton("AutoDailyToggle", "Auto Daily", false, function()
	if AutoequipRunning then return end
end, AutoFarmSection)

createGhostText(AutoFarmSection, {
	Text = "Advanced AutoFarm",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	Font = Enum.Font.SourceSansBold,
	TextSize = 20,
	TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Bottom,
})

local AutoUseFrostGrenade = false

createToggleButton("AutoUseFrostGrenade", "Auto use Frost-Grenade", false, function(state)
	AutoUseFrostGrenade = state
end, AutoFarmSection, { 2, 1 })

LoopFramework:registerTask("AutoHandleGoodBrainrots", 0.25, function()
end)
createToggleButton("AutoHandleGoodBrainrots", "Auto handle heavy brainrots", false, function(state)
	AutoHandleHeavyBrainrots = state
	LoopFramework:setTaskEnabled("AutoHandleGoodBrainrots", state)
end, AutoFarmSection, { 2, 1 })

createInfo3("AutoFrostGrenadeWarning", "Resource Intensive Toggle!",
	"Auto FrostGrenade requires a large supply of frost grenades. For example, a typical 5 million HP brainrot eats about 24 frost grenades when the Row's DPS is 100k, this may vary depending on your setup. But, it's the best thing to exist for you to even have a chance.\n\nWhile we do calculate whether grenades will be effective before using them, and they usually are, but if you're up against Zeus, you're cooked.\n\nAdditionally, you do need to have a high bandwidth internet connection for it to work effectively",
function() end, AutoFarmSection, { 2, 3.8 })

]]

-- ========= AUTO BUY SECTION ==========
createGhostText(AutoBuySection, {
	Text = "Seeds",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	Font = Enum.Font.SourceSansBold,
	TextSize = 20,
	TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Bottom,
})

createDropdown("AutoBuySeedsDropdown", "Select Seed(s)", SeedsTable, nil, function(selection)
	table.clear(SelectedSeeds)
	for name, value in pairs(selection) do
		SelectedSeeds[name] = value
	end
end, AutoBuySection, true, { 2, 1 })

-- BUY ALL SEEDS
LoopFramework:registerTask("AutoBuyAllSeedLoop", 0.5, function()
	if AutoBuySeedEnabled then
		local AllSeedsTable = getAvailableSeeds()
		for _, item in pairs(AllSeedsTable) do
			buyItem(item)
		end
	end
end)
createToggleButton("AutoBuySeedBuyAllButton", "Buy All", false, function(state)
	AutoBuySeedEnabled = state
	LoopFramework:setTaskEnabled("AutoBuyAllSeedLoop", state)
end, AutoBuySection)

-- BUY SELECTED SEEDS
LoopFramework:registerTask("AutoBuySelectedSeedLoop", 0.5, function()
	if AutoBuySeedEnabled then
		for seed, _ in pairs(SelectedSeeds) do
			buyItem(seed)
		end
	end
end)
createToggleButton("AutoBuySeedBuySelectedButton", "Buy Selected", false, function(state)
	AutoBuySeedEnabled = state
	LoopFramework:setTaskEnabled("AutoBuySelectedSeedLoop", state)
end, AutoBuySection)

createGhostText(AutoBuySection, {
	Text = "Gears",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	Font = Enum.Font.SourceSansBold,
	TextSize = 20,
	TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Bottom,
})

createDropdown("AutoBuyGearsDropdown", "Select Gear(s)", GearsTable, nil, function(selection)
	table.clear(SelectedGears)
	for name, value in pairs(selection) do
		SelectedGears[name] = value
	end
end, AutoBuySection, true, { 2, 1 })

-- BUY ALL GEAR
LoopFramework:registerTask("AutoBuyAllGearLoop", 0.5, function()
	if AutoBuyGearEnabled then
		local AllGearsTable = getAvailableGears()
		for _, item in pairs(AllGearsTable) do
			buyItem(item, true)
		end
	end
end)
createToggleButton("AutoBuyGearBuyAllButton", "Buy All", false, function(state)
	AutoBuyGearEnabled = state
	LoopFramework:setTaskEnabled("AutoBuyAllGearLoop", state)
end, AutoBuySection)

-- BUY SELECTED GEAR
LoopFramework:registerTask("AutoBuySelectedGearLoop", 0.5, function()
	if AutoBuyGearEnabled then
		for gear, _ in pairs(SelectedGears) do
			buyItem(gear, true)
		end
	end
end)
createToggleButton("AutoBuyGearBuySelectedButton", "Buy Selected", false, function(state)
	AutoBuyGearEnabled = state
	LoopFramework:setTaskEnabled("AutoBuySelectedGearLoop", state)
end, AutoBuySection)

-- ========= AUTO SELL SECTION ==========

createGhostText(AutoSellSection, {
	Text = "Brainrots Sell Config",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	Font = Enum.Font.SourceSansBold,
	TextSize = 20,
	TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Bottom,
})

local function extractWeightFromName(name)
	local w = name:match("(%d+%.?%d*)%s*[kK][gG]")
	return w and tonumber(w) or 0
end

LoopFramework:registerTask("AutoSellBrainrotLoop", 5, function()
	if not AutoSellBrainrotEnabled then return end

	local inventory = getPlayerInventory() or {}
	local maxSize = getMaxInventorySize() or 0
	if #inventory < maxSize - 30 then return end

	local brainrotsToSell, brainrotsToFavorite = {}, {}
	local rarityFilter = SelectedBrainrotRarityFilter or {}
	local modifierFilter = SelectedBrainrotModifierFilter or {}
	local weightFilter = SelectedBrainrotWeightFilter or { Weight = 0, Direction = "Above" }

	local processed, sellCount, favoriteCount = 0, 0, 0

	for _, item in ipairs(inventory) do
		local itemName, brainrotCheck = item:GetAttribute("ItemName"), item:GetAttribute("Brainrot")
		if itemName and brainrotCheck and brainrotCheck == itemName then
			local weight = extractWeightFromName(item.Name)
			print(weight, typeof(weight), weightFilter.Weight or "nil", typeof(weightFilter.Weight or 1))
			local mutationString = item:GetAttribute("MutationString") or ""
			local modifier = (mutationString ~= "" and mutationString ~= itemName)
				and mutationString:gsub(itemName, ""):match("^%s*(.-)%s*$") or nil

			local rarity = "Unknown"
			local firstChild = item:FindFirstChildWhichIsA("Model") or item:FindFirstChildWhichIsA("Instance")
			if firstChild and firstChild:GetAttribute("Rarity") then
				rarity = firstChild:GetAttribute("Rarity")
			end

			processed += 1

			local matchesFilter =
				(next(rarityFilter) and table.find(rarityFilter, rarity))
				or (modifier and next(modifierFilter) and table.find(modifierFilter, modifier))
				or (weightFilter.Weight and weightFilter.Weight > 0 and (
					(weightFilter.Direction == "Above" and weight > weightFilter.Weight)
					or (weightFilter.Direction == "Below" and weight < weightFilter.Weight)
				))

			if matchesFilter then
				local id = item:GetAttribute("ID")
				print(id)
				if id then table.insert(brainrotsToFavorite, id) end
				favoriteCount += 1
				print(string.format("[AutoSell] FAVORITE -> %s | Rarity: %s | Modifier: %s | Weight: %.3f",
					itemName, rarity, modifier or "nil", weight))
			else
				table.insert(brainrotsToSell, item)
				sellCount += 1
				print(string.format("[AutoSell] SELL -> %s | Rarity: %s | Modifier: %s | Weight: %.3f",
					itemName, rarity, modifier or "nil", weight))
			end
		end
	end

	if #brainrotsToFavorite > 0 then
		print(string.format("[AutoSell] Favoriting %d brainrots...", #brainrotsToFavorite))
		massFavouriteItemsAndCheck(brainrotsToFavorite)
	end

	task.wait(5)

	if #brainrotsToSell > 0 then
		print(string.format("[AutoSell] Selling %d brainrots...", #brainrotsToSell))

		if AutoEquipBestBrainrot then
			Remotes.EquipBestBrainrots:FireServer()
			print(string.format("[AutoSell] Equipping best brainrots before selling...."))
		end

		task.wait(2)

		sellItems("Brainrots")
	end

	print(string.format("[AutoSell] Processed %d | To Sell: %d | To Favorite: %d", processed, sellCount, favoriteCount))
end)
createToggleButton("AutoSellInventoryWhenFullButton", "Sell Brainrots", false, function(state)
	AutoSellBrainrotEnabled = state
	LoopFramework:setTaskEnabled("AutoSellBrainrotLoop", state)
end, AutoSellSection)

createDropdown("AutoSellIgnoreBrainrotRarity", "Ignore Rarity", getKeys(Rarities), nil, function(selected)
	debugLogTable(selected)
	SelectedBrainrotRarityFilter = {}
	for k, _ in pairs(selected) do
		table.insert(SelectedBrainrotRarityFilter, k)
	end
end, AutoSellSection, true)

createDropdown("AutoSellIgnoreBrainrotModifier", "Ignore Modifier", getKeys(BrainrotMutations), nil, function(selected)
	debugLogTable(selected)
	SelectedBrainrotModifierFilter = {}
	for k, _ in pairs(selected) do
		table.insert(SelectedBrainrotModifierFilter, k)
	end
end, AutoSellSection, true)

--[[
createDropdown("AutoSellIgnoreBrainrotNames", "Ignore Specific", getKeys(BrainrotRegistry), nil, function ()

end, AutoSellSection, true)
]]

createDropdown("AutoSellIgnoreBrainrotWeight", "Weight Threshold", { "Above", "Below" }, nil, function(selected)
	SelectedBrainrotWeightFilter = SelectedBrainrotWeightFilter or {}
	SelectedBrainrotWeightFilter.Direction = selected
end, AutoSellSection)

createTextBox("AutoSellBrainrotWeightTextBox", "Weight Filter", "Enter Weight", function(text)
	SelectedBrainrotWeightFilter = SelectedBrainrotWeightFilter or {}
	SelectedBrainrotWeightFilter.Weight = tonumber(text) or 0
end, AutoSellSection)


-- Ugh, risky business, won't do it
--[[
createDropdown("AutoSellCombineFilters", "Combine Filters",
	{ "Rarity + Modifier", "Rarity + Weight", "Modifier + Weight" }, nil, function()
	end, AutoSellSection, nil, { 2, 1 })

createGhostText(AutoSellSection, {
	Text = "Plants Sell Config",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	Font = Enum.Font.SourceSansBold,
	TextSize = 20,
	TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Bottom,
})

createToggleButton("AutoSellPlantsWhenFullButton", "Sell Plants", false, function(state)
	AutoSellInventoryEnabled = state
	if not state then return end
	createNotification("This feature is not available yet..", 10)
end, AutoSellSection)

createDropdown("AutoSellIgnorePlantsWeight", "Weight Threshold", { "Above", "Below" }, nil, function(selected)
	SelectedPlantWeightFilter = SelectedPlantWeightFilter or {}
	SelectedPlantWeightFilter.Direction = { selected }
end, AutoSellSection, true)

createTextBox("AutoSellPlantWeightTextBox", "Enter Weight", nil, function(text)
	SelectedPlantWeightFilter = SelectedPlantWeightFilter or {}
	SelectedPlantWeightFilter.Weight = tonumber(text) or 0
end, AutoSellSection)
]]

-- ========= UTILITY SECTION ==========

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
end, UtilitySection)

if UserInputService.TouchEnabled then
	local toggleButton = Instance.new("ImageButton")
	toggleButton.Name = "ToggleUIButton"
	toggleButton.Size = UDim2.new(0, 60, 0, 60)
	toggleButton.Position = UDim2.new(0, 10, 0.5, -30)
	toggleButton.BackgroundTransparency = 1
	toggleButton.Image = "rbxassetid://85554515603237"
	toggleButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
	toggleButton.Parent = SimpleScriptsGui

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
	end, UtilitySection)
end

createButton("RejoinServerButton", "Rejoin Server", function()
	if # Players:GetPlayers() <= 1 then
		LocalPlayer:Kick("\nRejoining...")
		task.wait()
		TeleportService:Teleport(PlaceId, LocalPlayer)
	else
		TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LocalPlayer)
	end
end, UtilitySection)

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
end, UtilitySection)

-- Temporary Fix
task.spawn(function()
	local inventory = getPlayerInventory(true)
	if not (inventory and inventory.ChildAdded) then return end

	inventory.ChildAdded:Connect(function(item)
		task.wait(0.5)
		local rarityFilter = SelectedBrainrotRarityFilter or {}
		if #rarityFilter <= 1 then return end

		local name, brainrot = item.Name, item:GetAttribute("Brainrot")
		if brainrot ~= name then return end

		for _, child in ipairs(item:GetChildren()) do
			if (child:GetAttribute("ItemName") or child.Name) == name then
				local rarity = child:GetAttribute("Rarity")
				if rarity and table.find(rarityFilter, rarity) then
					local id = item:GetAttribute("ID")
					if id then massFavouriteItemsAndCheck({ id }) end
				end
				break
			end
		end
	end)
end)
