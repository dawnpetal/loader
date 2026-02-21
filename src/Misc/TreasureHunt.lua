local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local backpackTwo = player:WaitForChild("BackpackTwo")
local gui = Instance.new("ScreenGui")
gui.Name = "TreasureGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local btn = Instance.new("TextButton")
btn.Name = "HuntBtn"
btn.Size = UDim2.new(0, 200, 0, 50)
btn.Position = UDim2.new(0.5, -100, 0.5, -25)
btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextSize = 18
btn.Font = Enum.Font.GothamBold
btn.Text = "Start Hunt"
btn.Parent = gui

local hunting = false

local function getMapAndPan()
	local map
	for _, v in ipairs(backpackTwo:GetChildren()) do
		if v:GetAttribute("ItemType") == "TreasureMap" then
			map = v
			break
		end
	end
	
	if not map then return end
	
	local pan
	for _, v in ipairs(player.Character:GetChildren()) do
		if v:GetAttribute("ItemType") == "Pan" then
			pan = v
			break
		end
	end
	
	if not pan then
		for _, v in ipairs(player.Backpack:GetChildren()) do
			if v:GetAttribute("ItemType") == "Pan" then
				pan = v
				RS.Remotes.CustomBackpack.EquipRemote:FireServer(v)
				task.wait(0.2)
				break
			end
		end
	end
	
	if not pan then
		for _, v in ipairs(backpackTwo:GetChildren()) do
			if v:GetAttribute("ItemType") == "Pan" then
				pan = v
				RS.Remotes.CustomBackpack.EquipRemote:FireServer(v)
				task.wait(0.2)
				break
			end
		end
	end
	
	return map, pan
end

btn.MouseButton1Click:Connect(function()
	if hunting then
		hunting = false
		btn.Text = "Start Hunt"
		return
	end
	
	hunting = true
	btn.Text = "Hunting..."
	
	local map, pan = getMapAndPan()
	if not map or not pan then
		hunting = false
		btn.Text = "Start Hunt"
		return
	end
	
	local location = map:GetAttribute("Location")
	if not location then
		hunting = false
		btn.Text = "Start Hunt"
		return
	end
	
	local targetCFrame = typeof(location) == "CFrame" and location or CFrame.new(location)
	local collect = pan:FindFirstChild("Scripts") and pan.Scripts:FindFirstChild("Collect")
	
	while hunting do
		if not backpackTwo:FindFirstChild("Treasure Map") then
			break
		end
		
		if backpackTwo:FindFirstChild("Treasure Chest") then
			break
		end
		
		player.Character.HumanoidRootPart.CFrame = targetCFrame
		
		if collect then
			pcall(function()
				collect:InvokeServer(0)
			end)
		end
		
		task.wait(0.1)
	end
	
	hunting = false
	btn.Text = "Start Hunt"
end)