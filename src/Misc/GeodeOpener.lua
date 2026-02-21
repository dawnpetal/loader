local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local VirtualUser = game:GetService("VirtualUser")
local BackpackTwo = player:WaitForChild("BackpackTwo")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GeodeGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local textButton = Instance.new("TextButton")
textButton.Name = "Geode Button"
textButton.Size = UDim2.new(0, 200, 0, 50)
textButton.Position = UDim2.new(0.5, -100, 0.5, -25)
textButton.BackgroundColor3 = Color3.fromRGB(100, 200, 0)
textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton.TextSize = 18
textButton.Font = Enum.Font.GothamBold
textButton.Text = "Open Geodes"
textButton.Parent = screenGui

local isOpening = false

local function findGeodeInBackpack()
	for _, v in ipairs(BackpackTwo:GetChildren()) do
		if v.Name == "Geode" then
			return v
		end
	end
	return nil
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function waitForGeodeInCharacter()
	local character = player.Character
	if not character then return false end
	
	local timeout = 0
	while timeout < 50 do
		for _, v in ipairs(character:GetChildren()) do
			if v:GetAttribute("ItemType") == "Geode" then
				return true
			end
		end
		task.wait(0.01)
		timeout = timeout + 1
	end
	return false
end

local function isGeodeDepleted()
	local character = player.Character
	if not character then return true end
	
	for _, v in ipairs(character:GetChildren()) do
		if v:GetAttribute("ItemType") == "Geode" then
			local stacks = v:GetAttribute("Stacks")
			if stacks and stacks > 0 then
				return false
			end
		end
	end
	return true
end

local function onButtonClicked()
	if isOpening then
		isOpening = false
		textButton.Text = "Open Geodes"
		return
	end

	isOpening = true
	textButton.Text = "Opening..."

	while isOpening do
		local geodeBackpack = findGeodeInBackpack()
		if not geodeBackpack then break end

		pcall(function()
			ReplicatedStorage.Remotes.CustomBackpack.EquipRemote:FireServer(geodeBackpack)
		end)
		
		if not waitForGeodeInCharacter() then
			break
		end

		while isOpening do
			if isGeodeDepleted() then
				break
			end
			VirtualUser:ClickButton1(Vector2.new(math.random(100, 900), math.random(100, 700)))
			task.wait(0.01)
		end
	end

	isOpening = false
	textButton.Text = "Open Geodes"
end

textButton.MouseButton1Click:Connect(onButtonClicked)