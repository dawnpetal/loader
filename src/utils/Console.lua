-- skidded from Infinite yield

local Console = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local outputFrame
local commandBox
local outputList
local autoScroll = false
local outputLimit = 200
local outputCount = 0
local commandHistory = {}
local historyIndex = 0
local isMinimized = false
local consoleContainer
local closeCallbacks = {}

local function createWindow()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "RemoteConsole"
	screenGui.Parent = playerGui
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	local main = Instance.new("Frame")
	main.Name = "Main"
	main.Parent = screenGui
	main.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
	main.BorderSizePixel = 0
	main.Position = UDim2.new(0.25, 0, 0.15, 0)
	main.Size = UDim2.new(0, 550, 0, 400)
	main.Active = true
	main.Draggable = true
	
	local titleBar = Instance.new("Frame")
	titleBar.Name = "TitleBar"
	titleBar.Parent = main
	titleBar.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
	titleBar.BorderSizePixel = 0
	titleBar.Size = UDim2.new(1, 0, 0, 20)
	
	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Parent = titleBar
	title.BackgroundTransparency = 1
	title.Position = UDim2.new(0, 10, 0, 0)
	title.Size = UDim2.new(1, -70, 1, 0)
	title.Font = Enum.Font.GothamSemibold
	title.Text = "Console"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 12
	title.TextXAlignment = Enum.TextXAlignment.Left
	
	local minimizeBtn = Instance.new("TextButton")
	minimizeBtn.Name = "MinimizeButton"
	minimizeBtn.Parent = titleBar
	minimizeBtn.BackgroundTransparency = 1
	minimizeBtn.Position = UDim2.new(1, -40, 0, 0)
	minimizeBtn.Size = UDim2.new(0, 20, 0, 20)
	minimizeBtn.Font = Enum.Font.SourceSans
	minimizeBtn.Text = "–"
	minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	minimizeBtn.TextSize = 18
	minimizeBtn.TextYAlignment = Enum.TextYAlignment.Center
	
	local closeBtn = Instance.new("TextButton")
	closeBtn.Name = "CloseButton"
	closeBtn.Parent = titleBar
	closeBtn.BackgroundTransparency = 1
	closeBtn.Position = UDim2.new(1, -20, 0, 0)
	closeBtn.Size = UDim2.new(0, 20, 0, 20)
	closeBtn.Font = Enum.Font.SourceSans
	closeBtn.Text = "×"
	closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeBtn.TextSize = 22
	closeBtn.MouseButton1Click:Connect(function()
		Console.close()
	end)
	
	consoleContainer = Instance.new("Frame")
	consoleContainer.Name = "ConsoleContainer"
	consoleContainer.Parent = main
	consoleContainer.BackgroundTransparency = 1
	consoleContainer.Position = UDim2.new(0, 0, 0, 20)
	consoleContainer.Size = UDim2.new(1, 0, 1, -20)
	consoleContainer.ClipsDescendants = true
	
	local toolbar = Instance.new("Frame")
	toolbar.Name = "Toolbar"
	toolbar.Parent = consoleContainer
	toolbar.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
	toolbar.BorderSizePixel = 0
	toolbar.Position = UDim2.new(0, 0, 0, 0)
	toolbar.Size = UDim2.new(1, 0, 0, 21)
	
	local clearBtn = Instance.new("TextButton")
	clearBtn.Name = "ClearButton"
	clearBtn.Parent = toolbar
	clearBtn.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
	clearBtn.Position = UDim2.new(0, 8, 0, 4)
	clearBtn.BorderSizePixel = 0
	clearBtn.Size = UDim2.new(0, 55, 0, 14)
	clearBtn.Font = Enum.Font.SourceSans
	clearBtn.Text = "Clear"
	clearBtn.TextColor3 = Color3.fromRGB(235, 235, 235)
	clearBtn.TextSize = 13
	
	local clearShadow = Instance.new("Frame")
	clearShadow.Name = "Shadow"
	clearShadow.Parent = clearBtn
	clearShadow.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	clearShadow.BorderSizePixel = 0
	clearShadow.Position = UDim2.new(0, 1, 1, 1)
	clearShadow.Size = UDim2.new(1, 0, 0, 1)
	clearShadow.ZIndex = clearBtn.ZIndex - 1
	
	local autoScrollBtn = Instance.new("TextButton")
	autoScrollBtn.Name = "AutoScrollButton"
	autoScrollBtn.Parent = toolbar
	autoScrollBtn.BackgroundColor3 = autoScroll and Color3.fromRGB(11, 90, 175) or Color3.fromRGB(57, 57, 57)
	autoScrollBtn.Position = UDim2.new(0, 68, 0, 4)
	autoScrollBtn.BorderSizePixel = 0
	autoScrollBtn.Size = UDim2.new(0, 55, 0, 14)
	autoScrollBtn.Font = Enum.Font.SourceSans
	autoScrollBtn.Text = "Auto Scroll"
	autoScrollBtn.TextColor3 = Color3.fromRGB(235, 235, 235)
	autoScrollBtn.TextSize = 13
	
	local scrollShadow = Instance.new("Frame")
	scrollShadow.Name = "Shadow"
	scrollShadow.Parent = autoScrollBtn
	scrollShadow.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	scrollShadow.BorderSizePixel = 0
	scrollShadow.Position = UDim2.new(0, 1, 1, 1)
	scrollShadow.Size = UDim2.new(1, 0, 0, 1)
	scrollShadow.ZIndex = autoScrollBtn.ZIndex - 1
	
	outputFrame = Instance.new("ScrollingFrame")
	outputFrame.Name = "Output"
	outputFrame.Parent = consoleContainer
	outputFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
	outputFrame.BorderSizePixel = 0
	outputFrame.Position = UDim2.new(0, 4, 0, 20)
	outputFrame.Size = UDim2.new(1, -8, 1, -50)
	outputFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	outputFrame.ScrollBarThickness = 10
	outputFrame.ScrollBarImageColor3 = Color3.fromRGB(70, 70, 70)
	outputFrame.ScrollBarImageTransparency = 0
	outputFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	outputFrame.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	outputFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	outputFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	
	outputList = Instance.new("UIListLayout")
	outputList.Parent = outputFrame
	outputList.SortOrder = Enum.SortOrder.LayoutOrder
	outputList.Padding = UDim.new(0, 1)
	
	local padding = Instance.new("UIPadding")
	padding.Parent = outputFrame
	padding.PaddingLeft = UDim.new(0, 6)
	padding.PaddingRight = UDim.new(0, 6)
	padding.PaddingTop = UDim.new(0, 4)
	padding.PaddingBottom = UDim.new(0, 4)
	
	local separator1 = Instance.new("Frame")
	separator1.Name = "Separator1"
	separator1.Parent = consoleContainer
	separator1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	separator1.BorderSizePixel = 0
	separator1.Position = UDim2.new(0, 0, 0, 0)
	separator1.Size = UDim2.new(1, 0, 0, 1)
	
	local commandFrame = Instance.new("Frame")
	commandFrame.Name = "CommandFrame"
	commandFrame.Parent = consoleContainer
	commandFrame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	commandFrame.BorderSizePixel = 1
	commandFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	commandFrame.Position = UDim2.new(0, 4, 1, -27)
	commandFrame.Size = UDim2.new(1, -8, 0, 22)
	
	commandBox = Instance.new("TextBox")
	commandBox.Name = "CommandBox"
	commandBox.Parent = commandFrame
	commandBox.BackgroundTransparency = 1
	commandBox.Position = UDim2.new(0, 8, 0, 0)
	commandBox.Size = UDim2.new(1, -16, 1, 0)
	commandBox.Font = Enum.Font.Code
	commandBox.PlaceholderText = "Enter Lua command... (↑/↓ for history)"
	commandBox.Text = ""
	commandBox.TextColor3 = Color3.fromRGB(211, 211, 211)
	commandBox.TextSize = 13
	commandBox.TextXAlignment = Enum.TextXAlignment.Left
	commandBox.ClearTextOnFocus = false
	
	local function toggleMinimize()
		isMinimized = not isMinimized
		local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		
		if isMinimized then
			local mainTween = TweenService:Create(main, tweenInfo, {
				Size = UDim2.new(0, 550, 0, 20)
			})
			local containerTween = TweenService:Create(consoleContainer, tweenInfo, {
				Size = UDim2.new(1, 0, 0, 0)
			})
			mainTween:Play()
			containerTween:Play()
			commandBox.Active = false
			commandBox.Visible = false
			minimizeBtn.Text = "+"
		else
			local mainTween = TweenService:Create(main, tweenInfo, {
				Size = UDim2.new(0, 550, 0, 400)
			})
			local containerTween = TweenService:Create(consoleContainer, tweenInfo, {
				Size = UDim2.new(1, 0, 1, -20)
			})
			mainTween:Play()
			containerTween:Play()
			commandBox.Active = true
			commandBox.Visible = true
			minimizeBtn.Text = "–"
		end
	end
	
	minimizeBtn.MouseButton1Click:Connect(toggleMinimize)
	
	clearBtn.MouseButton1Click:Connect(function()
		if not isMinimized then
			for _, child in ipairs(outputFrame:GetChildren()) do
				if child:IsA("Frame") then
					child:Destroy()
				end
			end
			outputCount = 0
		end
	end)
	
	autoScrollBtn.MouseButton1Click:Connect(function()
		if not isMinimized then
			autoScroll = not autoScroll
			autoScrollBtn.BackgroundColor3 = autoScroll and Color3.fromRGB(11, 90, 175) or Color3.fromRGB(57, 57, 57)
			if autoScroll then
				outputFrame.CanvasPosition = Vector2.new(0, outputFrame.AbsoluteCanvasSize.Y)
			end
		end
	end)
	
	commandBox.FocusLost:Connect(function(enterPressed)
		if enterPressed and commandBox.Text ~= "" and not isMinimized then
			local command = commandBox.Text
			table.insert(commandHistory, command)
			historyIndex = 0
			
			local success, result = pcall(function()
				return loadstring(command)()
			end)
			
			if success then
				if result ~= nil then
					Console.log("> " .. command .. "\n" .. tostring(result))
				else
					Console.log("> " .. command)
				end
			else
				Console.error("> " .. command .. "\n" .. result)
			end
			
			commandBox.Text = ""
		end
	end)
	
	UserInputService.InputBegan:Connect(function(input)
		if commandBox:IsFocused() and not isMinimized then
			if input.KeyCode == Enum.KeyCode.Up then
				if # commandHistory > 0 then
					historyIndex = historyIndex + 1
					if historyIndex > # commandHistory then
						historyIndex = # commandHistory
					end
					commandBox.Text = commandHistory[# commandHistory - historyIndex + 1]
				end
			elseif input.KeyCode == Enum.KeyCode.Down then
				if historyIndex > 0 then
					historyIndex = historyIndex - 1
					if historyIndex <= 0 then
						historyIndex = 0
						commandBox.Text = ""
					else
						commandBox.Text = commandHistory[# commandHistory - historyIndex + 1]
					end
				end
			end
			commandBox.CursorPosition = # commandBox.Text + 1
		end
	end)
	
	return screenGui
end

local function addOutput(text, textColor)
	if outputCount >= outputLimit then
		local oldest = outputFrame:GetChildren()[2]
		if oldest and oldest:IsA("Frame") then
			oldest:Destroy()
			outputCount = outputCount - 1
		end
	end
	
	local outputEntry = Instance.new("Frame")
	outputEntry.Name = "OutputEntry"
	outputEntry.Parent = outputFrame
	outputEntry.BackgroundTransparency = 1
	outputEntry.Size = UDim2.new(1, 0, 0, 0)
	outputEntry.AutomaticSize = Enum.AutomaticSize.Y
	outputEntry.LayoutOrder = outputCount
	
	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "Text"
	textLabel.Parent = outputEntry
	textLabel.BackgroundTransparency = 1
	textLabel.Position = UDim2.new(0, 0, 0, 0)
	textLabel.Size = UDim2.new(1, 0, 0, 0)
	textLabel.Font = Enum.Font.Code
	textLabel.Text = text
	textLabel.TextColor3 = textColor or Color3.fromRGB(211, 211, 211)
	textLabel.TextSize = 12
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.TextYAlignment = Enum.TextYAlignment.Top
	textLabel.TextWrapped = true
	textLabel.AutomaticSize = Enum.AutomaticSize.Y
	textLabel.RichText = true
	
	outputCount = outputCount + 1
	
	if autoScroll then
		RunService.Heartbeat:Wait()
		outputFrame.CanvasPosition = Vector2.new(0, outputFrame.AbsoluteCanvasSize.Y)
	end
end

function Console.onClose(callback)
	if type(callback) == "function" then
		table.insert(closeCallbacks, callback)
		Console.log("Close callback registered")
		return function()
			Console.removeCloseCallback(callback)
		end
	else
		Console.error("onClose expects a function")
	end
end

function Console.removeCloseCallback(callback)
	for i, cb in ipairs(closeCallbacks) do
		if cb == callback then
			table.remove(closeCallbacks, i)
			Console.log("Close callback removed")
			break
		end
	end
end

function Console.clearCloseCallbacks()
	closeCallbacks = {}
	Console.log("All close callbacks cleared")
end

function Console.close()
	Console.info("Console closing...")
	
	for i, callback in ipairs(closeCallbacks) do
		local success, err = pcall(callback)
		if not success then
			Console.error("Close callback " .. i .. " error: " .. tostring(err))
		end
	end
	
	closeCallbacks = {}
	
	local screenGui = playerGui:FindFirstChild("RemoteConsole")
	if screenGui then
		screenGui:Destroy()
	end
end

function Console.log(message)
	local timestamp = os.date("[%H:%M:%S] ")
	addOutput(timestamp .. tostring(message), Color3.fromRGB(204, 204, 204))
end

function Console.warn(message)
	local timestamp = os.date("[%H:%M:%S] ")
	addOutput(timestamp .. tostring(message), Color3.fromRGB(255, 142, 60))
end

function Console.error(message)
	local timestamp = os.date("[%H:%M:%S] ")
	addOutput(timestamp .. tostring(message), Color3.fromRGB(255, 68, 68))
end

function Console.info(message)
	addOutput(tostring(message), Color3.fromRGB(235, 235, 235))
end

function Console.print(...)
	local args = {
		...
	}
	local message = ""
	for i, v in ipairs(args) do
		if i > 1 then
			message = message .. " "
		end
		message = message .. tostring(v)
	end
	Console.log(message)
end

function Console.init()
	createWindow()
	
	local oldPrint = print
	_G.print = function(...)
		oldPrint(...)
		Console.print(...)
	end
	
	local oldWarn = warn
	_G.warn = function(...)
		oldWarn(...)
		Console.warn(table.concat({
			...
		}, " "))
	end
	
	Console.info("Console initialized")
	return Console
end

function Console.addOutput(text, color)
	addOutput(text, color)
end

return Console
