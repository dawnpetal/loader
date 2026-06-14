--game/ServerScripts/GP/ProgrammerPanel.luau

local function getStorage()
    local registry = getgenv().__PrereqStorageRegistry
    if not registry then
        return nil
    end

    for k, v in pairs(getgenv()) do
        if type(k) == "userdata" and v == true and registry[k] then
            return k
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

local SimpleUI = getPrerequisite("SimpleUI")
local LoopFramework = getPrerequisite("LoopFramework")

SimpleUI:CreateNotification({
    Title = "Validated!",
    Type = "Success",
    Description = "Pre-requisites validated, script will start soon! Powered by SimpleUI",
    Duration = 3,
})

local Services = {
    Players = SimpleUI.Utility:GetService("Players"),
    ReplicatedStorage = SimpleUI.Utility:GetService("ReplicatedStorage"),
    Workspace = SimpleUI.Utility:GetService("Workspace"),
    Lighting = SimpleUI.Utility:GetService("Lighting"),
}

local Player = Services.Players.LocalPlayer
local Characters = Services.Workspace:WaitForChild("Characters")
local DroppedItems = Services.Workspace:WaitForChild("DroppedItems")
local Structures = Services.Workspace:WaitForChild("Structures")
local Map = Services.Workspace:WaitForChild("Map")
local MapTiles = Map:WaitForChild("Tiles")
local MapCrates = Map:WaitForChild("Crates")
local Survivors = Map:WaitForChild("Survivors")
local ReplicatedStorage = Services.ReplicatedStorage
local ReplicatedTools = ReplicatedStorage:WaitForChild("Tools")
local ReplicatedItems = ReplicatedStorage:WaitForChild("Items")
local PlayerGui = Player:WaitForChild("PlayerGui")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local InteractionRemotes = Remotes:WaitForChild("Interaction")
local PickUpItemRemote = InteractionRemotes:WaitForChild("PickUpItem")

local LocalCharacter, HumanoidRootPart

local function bindCharacter(char)
    LocalCharacter = Characters:WaitForChild(Player.Name)
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end

bindCharacter(Player.Character or Player.CharacterAdded:Wait())
Player.CharacterAdded:Connect(bindCharacter)

-- ========================
-- STATE
-- ========================

local SelectAllOption = "All"

local State = {
    AutoPickupAmmo = false,
    AutoPickupFood = false,
    AutoPickupFoodHunger = 70,
    AutoPickupAmmoSelected = {},
    AutoPickupAmmoLimits = {},
    AutoMelee = false,
    AutoMeleeZombies = true,
    AutoMeleePiles = true,
    AutoMeleeBarrels = true,
    AutoFuel = false,
    AutoShredder = false,
    AutoFood = false,
    AutoTeleportCooldown = 0.08,
    PickupLimit = 12,
    PickupRadius = 12,
    EspMasterRadius = 500,
    ObjectiveRadius = 0,
    FuelItemESP = false,
    FoodItemESP = false,
    MedicalItemESP = false,
    RangedItemESP = false,
    AmmoItemESP = false,
    MeleeItemESP = false,
    BackpackItemESP = false,
    ArmorItemESP = false,
    ThrowableItemESP = false,
    AbilityItemESP = false,
    WorldItemESP = false,
    ZombieESP = false,
    SurvivorESP = false,
    GeneratorESP = false,
    ScrapPileESP = false,
    RadioTowerESP = false,
    PowerPlantESP = false,
    CrateESP = false,
    BarrelESP = false,
    ZombieSelected = SelectAllOption,
    ZombieRadius = 0,
    SurvivorRadius = 0,
    BarrelRadius = 0,
    CrateRadius = 0,
    InstantProximityPrompt = false,
    EnvironmentFogEnd = math.clamp(Services.Lighting.FogEnd, 0, 100000),
    EnvironmentAtmosphereDensity = 0,
    EnvironmentClockTime = Services.Lighting.ClockTime,
    EnvironmentBrightness = math.clamp(Services.Lighting.Brightness, 0, 5),
    EnvironmentGlobalShadows = Services.Lighting.GlobalShadows,
}

do
    local atmosphere = Services.Lighting:FindFirstChildWhichIsA("Atmosphere")
    if atmosphere then
        State.EnvironmentAtmosphereDensity = math.clamp(atmosphere.Density, 0, 1)
    end
end

local ItemEspClasses = {
    Fuel = {
        Name = "Fuel",
        StateKey = "FuelItemESP",
        SelectedKey = "FuelItemSelected",
        RadiusKey = "FuelItemRadius",
        Folder = ReplicatedItems:WaitForChild("Fuel"),
        Radar = false,
        FillColor    = Color3.fromRGB(210, 140, 30),
        OutlineColor = Color3.fromRGB(255, 215, 100),
        TextColor    = Color3.fromRGB(255, 205, 75),
    },
    Food = {
        Name = "Food",
        StateKey = "FoodItemESP",
        SelectedKey = "FoodItemSelected",
        RadiusKey = "FoodItemRadius",
        Folder = ReplicatedItems:WaitForChild("Food"),
        Radar = true,
        FillColor    = Color3.fromRGB(50, 175, 55),
        OutlineColor = Color3.fromRGB(140, 255, 130),
        TextColor    = Color3.fromRGB(110, 255, 100),
    },
    Medical = {
        Name = "Medical",
        StateKey = "MedicalItemESP",
        SelectedKey = "MedicalItemSelected",
        RadiusKey = "MedicalItemRadius",
        Folder = ReplicatedTools:WaitForChild("Medical"),
        Radar = true,
        FillColor    = Color3.fromRGB(15, 155, 185),
        OutlineColor = Color3.fromRGB(90, 235, 255),
        TextColor    = Color3.fromRGB(70, 225, 255),
    },
    Ranged = {
        Name = "Guns",
        StateKey = "RangedItemESP",
        SelectedKey = "RangedItemSelected",
        RadiusKey = "RangedItemRadius",
        Folder = ReplicatedTools:WaitForChild("Guns"),
        Radar = true,
        FillColor    = Color3.fromRGB(205, 40, 60),
        OutlineColor = Color3.fromRGB(255, 95, 115),
        TextColor    = Color3.fromRGB(255, 110, 130),
    },
    Ammo = {
        Name = "Ammo",
        StateKey = "AmmoItemESP",
        SelectedKey = "AmmoItemSelected",
        RadiusKey = "AmmoItemRadius",
        Folder = ReplicatedItems:WaitForChild("Ammo"),
        Radar = true,
        FillColor    = Color3.fromRGB(215, 180, 35),
        OutlineColor = Color3.fromRGB(255, 238, 90),
        TextColor    = Color3.fromRGB(255, 232, 70),
    },
    Melee = {
        Name = "Melee",
        StateKey = "MeleeItemESP",
        SelectedKey = "MeleeItemSelected",
        RadiusKey = "MeleeItemRadius",
        Folder = ReplicatedTools:WaitForChild("Melee"),
        Radar = false,
        FillColor    = Color3.fromRGB(195, 95, 25),
        OutlineColor = Color3.fromRGB(255, 165, 70),
        TextColor    = Color3.fromRGB(255, 160, 55),
    },
    Backpack = {
        Name = "Backpack",
        StateKey = "BackpackItemESP",
        SelectedKey = "BackpackItemSelected",
        RadiusKey = "BackpackItemRadius",
        Folder = ReplicatedTools:WaitForChild("Backpacks"),
        Radar = false,
        FillColor    = Color3.fromRGB(25, 165, 75),
        OutlineColor = Color3.fromRGB(85, 255, 150),
        TextColor    = Color3.fromRGB(70, 255, 140),
    },
    Armor = {
        Name = "Armor",
        StateKey = "ArmorItemESP",
        SelectedKey = "ArmorItemSelected",
        RadiusKey = "ArmorItemRadius",
        Folder = ReplicatedItems:WaitForChild("Armor"),
        Radar = false,
        FillColor    = Color3.fromRGB(75, 110, 160),
        OutlineColor = Color3.fromRGB(155, 200, 250),
        TextColor    = Color3.fromRGB(165, 210, 255),
    },
    Throwables = {
        Name = "Throwables",
        StateKey = "ThrowableItemESP",
        SelectedKey = "ThrowableItemSelected",
        RadiusKey = "ThrowableItemRadius",
        Folder = ReplicatedTools:WaitForChild("Consumable"),
        Radar = true,
        FillColor    = Color3.fromRGB(170, 155, 25),
        OutlineColor = Color3.fromRGB(240, 228, 70),
        TextColor    = Color3.fromRGB(245, 228, 55),
    },
    Ability = {
        Name = "Ability",
        StateKey = "AbilityItemESP",
        SelectedKey = "AbilityItemSelected",
        RadiusKey = "AbilityItemRadius",
        Folder = ReplicatedTools:WaitForChild("Abilities"),
        Radar = false,
        FillColor    = Color3.fromRGB(145, 55, 210),
        OutlineColor = Color3.fromRGB(215, 135, 255),
        TextColor    = Color3.fromRGB(210, 125, 255),
    },
    World = {
        Name = "World Loot",
        StateKey = "WorldItemESP",
        SelectedKey = "WorldItemSelected",
        RadiusKey = "WorldItemRadius",
        Radar = false,
        FillColor    = Color3.fromRGB(50, 95, 210),
        OutlineColor = Color3.fromRGB(145, 190, 255),
        TextColor    = Color3.fromRGB(135, 185, 255),
    },
}

local ItemEspClassNames = {
    "Fuel",
    "Food",
    "Medical",
    "Ranged",
    "Ammo",
    "Melee",
    "Backpack",
    "Armor",
    "Throwables",
    "Ability",
}

for _, className in ipairs(ItemEspClassNames) do
    local itemClass = ItemEspClasses[className]
    State[itemClass.SelectedKey] = SelectAllOption
    State[itemClass.RadiusKey] = 0
end

local UtilityModule = {}
do
    function UtilityModule.notify(title, description, notificationType)
        SimpleUI:CreateNotification({
            Title = title,
            Description = description,
            Type = notificationType or "Info",
            Duration = 3,
        })
    end

    function UtilityModule.getRootPart()
        if HumanoidRootPart and HumanoidRootPart.Parent then
            return HumanoidRootPart
        end
        local currentCharacter = Player.Character
        return currentCharacter and currentCharacter:FindFirstChild("HumanoidRootPart")
    end

    function UtilityModule.getItemBasePart(item)
        if not item then
            return nil
        end
        if item:IsA("BasePart") then
            return item
        end
        return item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart", true)
    end

    function UtilityModule.getItemPosition(item)
        local part = UtilityModule.getItemBasePart(item)
        return part and part.Position
    end

    function UtilityModule.getChildNames(folder)
        local names = { SelectAllOption }
        if folder then
            for _, child in ipairs(folder:GetChildren()) do
                names[#names + 1] = child.Name
            end
        end
        table.sort(names, function(a, b)
            if a == SelectAllOption then
                return true
            end
            if b == SelectAllOption then
                return false
            end
            return string.lower(a) < string.lower(b)
        end)
        return names
    end

    function UtilityModule.getAmmoAttributeName(itemName)
        if not itemName then
            return nil
        end
        if string.sub(itemName, -5) == " Ammo" then
            return string.sub(itemName, 1, -6)
        end
        return itemName
    end
end

local MainModule = {}
do
    local AutoTeleportProcessed = {}
    local AutoTeleportBusy = false
    local AutoPickupBusy = false
    local AutoMeleeBusy = false
    local LastAutoMeleeHit = 0

    -- Cached folder refs so we don't FindFirstChild on every tick
    local FolderAmmo     = ReplicatedItems:WaitForChild("Ammo")
    local FolderFuel     = ReplicatedItems:WaitForChild("Fuel")
    local FolderFood     = ReplicatedItems:WaitForChild("Food")
    local FolderResources = ReplicatedItems:FindFirstChild("Resources")

    -- Cached OverlapParams — creating one per tick was wasteful
    local TeleportOverlapParams = OverlapParams.new()

    -- Cached melee tool state; updated via events, not polled every tick
    local CachedMeleeTool = nil
    local CachedSwingRemote = nil
    local CachedHitRemote = nil

    local function onToolEquipped(tool)
        if not tool:IsA("Tool") then return end
        local hitRemote = tool:FindFirstChild("HitTargets")
        local swingRemote = tool:FindFirstChild("Swing")
        if hitRemote and swingRemote then
            CachedMeleeTool = tool
            CachedHitRemote = hitRemote
            CachedSwingRemote = swingRemote
        end
    end

    local function onToolUnequipped(tool)
        if tool == CachedMeleeTool then
            CachedMeleeTool = nil
            CachedHitRemote = nil
            CachedSwingRemote = nil
        end
    end

    local function bindMeleeToolEvents(character)
        CachedMeleeTool = nil
        CachedSwingRemote = nil
        CachedHitRemote = nil
        for _, child in ipairs(character:GetChildren()) do
            onToolEquipped(child)
        end
        character.ChildAdded:Connect(onToolEquipped)
        character.ChildRemoved:Connect(onToolUnequipped)
    end

    -- Wire up on existing character and future respawns
    local initialChar = Player.Character or LocalCharacter
    if initialChar then
        bindMeleeToolEvents(initialChar)
    end
    Player.CharacterAdded:Connect(bindMeleeToolEvents)

    local function getNetworkOwnershipRemote(item)
        local drag = item and item:FindFirstChild("ItemDrag")
        if not drag then
            return nil
        end
        return drag:FindFirstChild("RequestNetworkOwnership")
    end

    local function getStatNumber(stats, statName, fallback)
        local value = stats and stats:FindFirstChild(statName)
        if value then
            local ok, result = pcall(function()
                return value.Value
            end)
            if ok and type(result) == "number" then
                return result
            end
        end
        local attr = stats and stats:GetAttribute(statName)
        if type(attr) == "number" then
            return attr
        end
        return fallback
    end

    local function modelIsAliveTarget(model)
        if not model or not model:IsA("Model") then
            return false
        end
        if model == LocalCharacter or model.Name == Player.Name then
            return false
        end
        -- Humanoid is a direct child of character models, no deep search needed
        local humanoid = model:FindFirstChild("Humanoid")
        if humanoid and humanoid.Health <= 0 then
            return false
        end
        return true
    end

    local function addMeleeCandidate(candidates, seen, target, rootPosition, range)
        if not target or seen[target] then
            return
        end
        local position = UtilityModule.getItemPosition(target)
        if not position then
            return
        end
        local distance = (position - rootPosition).Magnitude
        if distance > range then
            return
        end
        seen[target] = true
        candidates[#candidates + 1] = {
            Model = target,
            Distance = distance,
        }
    end

    local function folderHasItemName(folder, itemName)
        return folder and itemName and folder:FindFirstChild(itemName) ~= nil
    end

    local function getPlayerAmmoAmount(ammoName)
        local ammoConfig = Player:FindFirstChild("Ammo")
        local attributeName = UtilityModule.getAmmoAttributeName(ammoName)
        if not ammoConfig or not attributeName then
            return 0
        end
        local amount = ammoConfig:GetAttribute(attributeName)
        if type(amount) == "number" then
            return amount
        end
        return 0
    end

    local function isAmmoAutoPickupAllowed(item)
        if not State.AutoPickupAmmo then
            return false
        end
        if not folderHasItemName(FolderAmmo, item.Name) or not State.AutoPickupAmmoSelected[item.Name] then
            return false
        end
        local limit = State.AutoPickupAmmoLimits[item.Name] or 0
        return getPlayerAmmoAmount(item.Name) <= limit
    end

    local function isFoodAutoPickupAllowed(item)
        if not State.AutoPickupFood then
            return false
        end
        if not folderHasItemName(FolderFood, item.Name) then
            return false
        end
        local character = Player.Character
        local hunger = character and character:GetAttribute("Hunger")
        return type(hunger) == "number" and hunger <= State.AutoPickupFoodHunger
    end

    local function getGeneratorPosition()
        local generator = Structures:FindFirstChild("Generator")
        local mainPart = generator and generator:FindFirstChild("MainPart")
        return mainPart and (mainPart.Position + Vector3.new(0, 5, 0)) or nil
    end

    local function getShredderPosition()
        local crafting = Services.Workspace:FindFirstChild("Crafting")
        local shredder = crafting and crafting:FindFirstChild("Shredder")
        local mainPart = shredder and shredder:FindFirstChild("MainPart")
        return mainPart and (mainPart.Position + Vector3.new(0, 5, 0)) or nil
    end

    local function getFoodDropPosition()
        local generator = Structures:FindFirstChild("Generator")
        local zoneVisual = generator and generator:FindFirstChild("ZoneVisual")
        return zoneVisual and (zoneVisual.Position + Vector3.new(-20, 0, 20)) or nil
    end

    local function getAutoTeleportDestination(item)
        if State.AutoFuel and folderHasItemName(FolderFuel, item.Name) then
            return getGeneratorPosition(), "Auto Fuel"
        end

        if State.AutoShredder and folderHasItemName(FolderResources, item.Name) then
            return getShredderPosition(), "Auto Shredder"
        end

        if State.AutoFood and folderHasItemName(FolderFood, item.Name) then
            if isFoodAutoPickupAllowed(item) then
                return nil, nil
            end
            return getFoodDropPosition(), "Auto Food"
        end

        return nil, nil
    end

    local function getRelayPosition(homePosition, playerPosition)
        local bestPosition = nil
        local bestHomeDistance = nil

        for _, tile in ipairs(MapTiles:GetChildren()) do
            if tile.Name == "StraightRoad" or tile.Name == "TSection" then
                local tilePosition = UtilityModule.getItemPosition(tile)
                if tilePosition and (tilePosition - playerPosition).Magnitude <= 500 then
                    local homeDistance = (tilePosition - homePosition).Magnitude
                    if not bestHomeDistance or homeDistance < bestHomeDistance then
                        bestHomeDistance = homeDistance
                        bestPosition = tilePosition + Vector3.new(0, 5, 0)
                    end
                end
            end
        end

        return bestPosition
    end

    local function resolveAutoTeleportPosition(homePosition, playerPosition)
        if (homePosition - playerPosition).Magnitude <= 500 then
            return homePosition
        end
        return getRelayPosition(homePosition, playerPosition)
    end

    function MainModule.processAutomaticPickups()
        if AutoPickupBusy or not (State.AutoPickupAmmo or State.AutoPickupFood) then
            return
        end

        local root = UtilityModule.getRootPart()
        if not root then
            return
        end

        local candidates = {}
        for _, item in ipairs(DroppedItems:GetChildren()) do
            local position = UtilityModule.getItemPosition(item)
            if position and (isAmmoAutoPickupAllowed(item) or isFoodAutoPickupAllowed(item)) then
                local distance = (position - root.Position).Magnitude
                if distance <= State.PickupRadius then
                    candidates[#candidates + 1] = { Item = item, Distance = distance }
                end
            end
        end

        if #candidates == 0 then
            return
        end

        table.sort(candidates, function(a, b)
            return a.Distance < b.Distance
        end)

        AutoPickupBusy = true
        task.spawn(function()
            local requested = 0
            for _, candidate in ipairs(candidates) do
                if requested >= State.PickupLimit then
                    break
                end
                if candidate.Item.Parent == DroppedItems
                    and (isAmmoAutoPickupAllowed(candidate.Item) or isFoodAutoPickupAllowed(candidate.Item))
                then
                    requested = requested + 1
                    PickUpItemRemote:FireServer(candidate.Item)
                    task.wait(0.05)
                end
            end
            AutoPickupBusy = false
        end)
    end

    function MainModule.processAutomaticTeleports()
        if AutoTeleportBusy or not (State.AutoFuel or State.AutoShredder or State.AutoFood) then
            return
        end

        local root = UtilityModule.getRootPart()
        if not root then
            return
        end

        local parts = Services.Workspace:GetPartBoundsInRadius(root.Position, State.PickupRadius, TeleportOverlapParams)
        local queued = {}
        local seen = {}

        for _, part in ipairs(parts) do
            local item = part:FindFirstAncestorWhichIsA("Model")
            if item and item.Parent == DroppedItems and not seen[item] and (not AutoTeleportProcessed[item] or os.clock() - AutoTeleportProcessed[item] > 5) then
                seen[item] = true
                local homePosition = getAutoTeleportDestination(item)
                local primary = UtilityModule.getItemBasePart(item)
                local remote = getNetworkOwnershipRemote(item)
                if homePosition and primary and remote then
                    local targetPosition = resolveAutoTeleportPosition(homePosition, root.Position)
                    if targetPosition then
                        queued[#queued + 1] = {
                            Item = item,
                            Primary = primary,
                            Remote = remote,
                            Position = targetPosition,
                        }
                    end
                end
            end
        end

        if #queued == 0 then
            return
        end

        AutoTeleportBusy = true
        task.spawn(function()
            for _, request in ipairs(queued) do
                if request.Item.Parent == DroppedItems and request.Primary.Parent and request.Remote.Parent then
                    pcall(function()
                        request.Remote:FireServer(request.Primary)
                    end)
                    task.wait(State.AutoTeleportCooldown)
                    if request.Primary.Parent then
                        request.Primary.CFrame = CFrame.new(request.Position)
                        AutoTeleportProcessed[request.Item] = os.clock()
                    end
                    task.wait(State.AutoTeleportCooldown)
                end
            end
            AutoTeleportBusy = false
        end)
    end

    function MainModule.processAutoMelee()
        if AutoMeleeBusy or not State.AutoMelee then
            return
        end

        -- No melee tool equipped — nothing to do
        local tool = CachedMeleeTool
        if not tool or not tool.Parent then
            return
        end

        local hitRemote = CachedHitRemote
        if not hitRemote or not hitRemote.Parent then
            -- Try re-resolving in case it was added after equip
            hitRemote = tool:FindFirstChild("HitTargets")
            CachedHitRemote = hitRemote
        end
        if not hitRemote then
            return
        end

        local root = UtilityModule.getRootPart()
        local stats = tool:FindFirstChild("Stats")
        if not root or not stats then
            return
        end

        local range = getStatNumber(stats, "Range", 0)
        local maxHit = math.floor(getStatNumber(stats, "MaxHit", 1))
        local animSpeed = getStatNumber(stats, "AnimSpeed", 1)
        if range <= 0 or maxHit <= 0 then
            return
        end

        local now = os.clock()
        local cooldown = math.max(0.12, 0.35 / math.max(animSpeed, 0.1))
        if now - LastAutoMeleeHit < cooldown then
            return
        end

        local candidates = {}
        local seen = {}
        local rootPosition = root.Position

        if State.AutoMeleeZombies then
            for _, character in ipairs(Characters:GetChildren()) do
                if modelIsAliveTarget(character) then
                    addMeleeCandidate(candidates, seen, character, rootPosition, range)
                end
            end
        end

        if State.AutoMeleePiles or State.AutoMeleeBarrels then
            for _, structure in ipairs(Structures:GetChildren()) do
                if State.AutoMeleePiles and structure.Name == "Scrap Pile" then
                    addMeleeCandidate(candidates, seen, structure, rootPosition, range)
                elseif State.AutoMeleeBarrels and structure.Name == "Barrel" then
                    addMeleeCandidate(candidates, seen, structure, rootPosition, range)
                end
            end
        end

        if #candidates == 0 then
            return
        end

        table.sort(candidates, function(a, b)
            return a.Distance < b.Distance
        end)

        local targets = {}
        for _, candidate in ipairs(candidates) do
            targets[#targets + 1] = candidate.Model
            if #targets >= maxHit then
                break
            end
        end

        if #targets == 0 then
            return
        end

        AutoMeleeBusy = true
        LastAutoMeleeHit = now
        task.spawn(function()
            for _, target in ipairs(targets) do
                pcall(function()
                    if CachedSwingRemote and CachedSwingRemote.Parent then
                        CachedSwingRemote:FireServer()
                    end
                end)
                task.wait(0.07)
                pcall(function()
                    hitRemote:FireServer({ target })
                end)
                task.wait(0.05)
            end
            AutoMeleeBusy = false
        end)
    end

    DroppedItems.ChildRemoved:Connect(function(item)
        AutoTeleportProcessed[item] = nil
    end)
end

local MiscModule = {}
do
    local originalPromptDurations = {}
    local promptConnections = {}
    local originalAtmosphere = Services.Lighting:FindFirstChildWhichIsA("Atmosphere")
    local createdAtmosphere = nil
    local originalEnvironment = {
        FogEnd = Services.Lighting.FogEnd,
        Brightness = Services.Lighting.Brightness,
        ClockTime = Services.Lighting.ClockTime,
        GlobalShadows = Services.Lighting.GlobalShadows,
        Atmosphere = originalAtmosphere,
        AtmosphereDensity = originalAtmosphere and originalAtmosphere.Density or nil,
    }

    local function trackConnection(connection)
        promptConnections[#promptConnections + 1] = connection
    end

    local function disconnectPromptConnections()
        for index = #promptConnections, 1, -1 do
            local connection = promptConnections[index]
            if connection then
                connection:Disconnect()
            end
            promptConnections[index] = nil
        end
    end

    local function applyInstantPrompt(prompt)
        if not prompt or not prompt:IsA("ProximityPrompt") then
            return
        end

        if originalPromptDurations[prompt] == nil then
            originalPromptDurations[prompt] = prompt.HoldDuration
        end

        prompt.HoldDuration = 0
    end

    local function scanContainer(container)
        if not container then
            return
        end

        for _, descendant in ipairs(container:GetDescendants()) do
            applyInstantPrompt(descendant)
        end
    end

    function MiscModule.refreshInstantProximityPrompts()
        scanContainer(Services.Workspace)
        scanContainer(PlayerGui)
    end

    function MiscModule.setInstantProximityPrompt(enabled)
        State.InstantProximityPrompt = enabled
        disconnectPromptConnections()

        if enabled then
            MiscModule.refreshInstantProximityPrompts()

            trackConnection(Services.Workspace.DescendantAdded:Connect(function(descendant)
                task.defer(function()
                    if State.InstantProximityPrompt then
                        applyInstantPrompt(descendant)
                        scanContainer(descendant)
                    end
                end)
            end))

            trackConnection(PlayerGui.DescendantAdded:Connect(function(descendant)
                task.defer(function()
                    if State.InstantProximityPrompt then
                        applyInstantPrompt(descendant)
                        scanContainer(descendant)
                    end
                end)
            end))

            UtilityModule.notify("Instant Prompts", "Proximity prompts now complete instantly.", "Success")
            return
        end

        for prompt, duration in pairs(originalPromptDurations) do
            if prompt and prompt.Parent then
                pcall(function()
                    prompt.HoldDuration = duration
                end)
            end
            originalPromptDurations[prompt] = nil
        end

        UtilityModule.notify("Instant Prompts", "Proximity prompt hold durations restored.", "Info")
    end

    local function getAtmosphere(createIfMissing)
        local atmosphere = Services.Lighting:FindFirstChildWhichIsA("Atmosphere")
        if not atmosphere and createIfMissing then
            atmosphere = Instance.new("Atmosphere")
            atmosphere.Name = "SimpleScriptsAtmosphere"
            atmosphere.Density = 0
            atmosphere.Parent = Services.Lighting
            createdAtmosphere = atmosphere
        end
        return atmosphere
    end

    function MiscModule.setFogDistance(value)
        State.EnvironmentFogEnd = value
        Services.Lighting.FogEnd = value
    end

    function MiscModule.setAtmosphereDensity(value)
        State.EnvironmentAtmosphereDensity = value
        local atmosphere = getAtmosphere(value > 0)
        if atmosphere then
            atmosphere.Density = math.clamp(value, 0, 1)
        end
    end

    function MiscModule.setClockTime(value)
        State.EnvironmentClockTime = value
        Services.Lighting.ClockTime = value
    end

    function MiscModule.setBrightness(value)
        State.EnvironmentBrightness = value
        Services.Lighting.Brightness = value
    end

    function MiscModule.setGlobalShadows(enabled)
        State.EnvironmentGlobalShadows = enabled
        Services.Lighting.GlobalShadows = enabled
    end

    function MiscModule.resetEnvironment()
        Services.Lighting.FogEnd = originalEnvironment.FogEnd
        Services.Lighting.Brightness = originalEnvironment.Brightness
        Services.Lighting.ClockTime = originalEnvironment.ClockTime
        Services.Lighting.GlobalShadows = originalEnvironment.GlobalShadows

        State.EnvironmentFogEnd = math.clamp(originalEnvironment.FogEnd, 0, 100000)
        State.EnvironmentBrightness = math.clamp(originalEnvironment.Brightness, 0, 5)
        State.EnvironmentClockTime = originalEnvironment.ClockTime
        State.EnvironmentGlobalShadows = originalEnvironment.GlobalShadows

        if originalEnvironment.Atmosphere and originalEnvironment.Atmosphere.Parent then
            originalEnvironment.Atmosphere.Density = originalEnvironment.AtmosphereDensity
            State.EnvironmentAtmosphereDensity = math.clamp(originalEnvironment.AtmosphereDensity or 0, 0, 1)
        elseif createdAtmosphere and createdAtmosphere.Parent then
            createdAtmosphere:Destroy()
            createdAtmosphere = nil
            State.EnvironmentAtmosphereDensity = 0
        end

        UtilityModule.notify("Environment", "Restored the original local lighting values.", "Info")
    end
end

local EspModule = {}
do
    local ItemHighlights = {}
    local CharacterHighlights = {}
    local SurvivorHighlights = {}
    local GeneratorHighlights = {}
    local ScrapPileHighlights = {}
    local RadioTowerHighlights = {}
    local PowerPlantHighlights = {}
    local BarrelHighlights = {}
    local CrateHighlights = {}

    -- item → itemClass: populated once on ChildAdded, never recomputed per-tick
    local ItemDataCache = {}

    local function randomInstanceName()
        local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        local len = math.random(8, 14)
        local t = table.create(len)
        for i = 1, len do
            local idx = math.random(1, #chars)
            t[i] = chars:sub(idx, idx)
        end
        return table.concat(t)
    end

    local function getDistanceFromRoot(target)
        local root = UtilityModule.getRootPart()
        local position = UtilityModule.getItemPosition(target)
        if not root or not position then
            return nil
        end
        return (position - root.Position).Magnitude
    end

    local function getEspRadius(radiusKey)
        local override = radiusKey and State[radiusKey] or 0
        if override and override > 0 then
            return override
        end
        return State.EspMasterRadius
    end

    local function isWithinEspRadius(target, radiusKey)
        local radius = getEspRadius(radiusKey)
        if not radius or radius <= 0 then
            return true
        end
        local distance = getDistanceFromRoot(target)
        return distance ~= nil and distance <= radius
    end

    local function selectedNameMatches(selectedKey, itemName)
        local selected = State[selectedKey]
        return not selected or selected == SelectAllOption or selected == itemName
    end

    local function getItemEspClass(item)
        for _, className in ipairs(ItemEspClassNames) do
            local itemClass = ItemEspClasses[className]
            if itemClass.Folder and itemClass.Folder:FindFirstChild(item.Name) then
                return itemClass
            end
        end
        return ItemEspClasses.World
    end

    local function itemClassIsActiveForName(itemClass, itemName)
        return State[itemClass.StateKey] and selectedNameMatches(itemClass.SelectedKey, itemName)
    end

    local function itemClassMatchesDroppedItem(itemClass, item)
        return itemClass.Folder
            and itemClass.Folder:FindFirstChild(item.Name)
            and itemClassIsActiveForName(itemClass, item.Name)
    end

    local function getDropValueName(valueObject)
        if not valueObject then
            return nil
        end
        local ok, value = pcall(function()
            return valueObject.Value
        end)
        if not ok or not value then
            return nil
        end
        if type(value) == "string" then
            return value
        end
        local okName, valueName = pcall(function()
            return value.Name
        end)
        if okName and valueName then
            return tostring(valueName)
        end
        return tostring(value)
    end

    local function getBarrelDropNames(barrel)
        local drops = barrel and barrel:FindFirstChild("Drops")
        local names = {}
        if not drops then
            return names
        end
        for _, child in ipairs(drops:GetChildren()) do
            local itemName = getDropValueName(child)
            if itemName then
                names[#names + 1] = itemName
            end
        end
        return names
    end

    local function getMatchingBarrelItemClass(barrel)
        for _, itemName in ipairs(getBarrelDropNames(barrel)) do
            for _, className in ipairs(ItemEspClassNames) do
                local itemClass = ItemEspClasses[className]
                if itemClass.Folder
                    and itemClass.Folder:FindFirstChild(itemName)
                    and itemClassIsActiveForName(itemClass, itemName)
                then
                    return itemClass, itemName
                end
            end
        end
        return nil, nil
    end

    local function isPowerPlant(model)
        if not model or not model:IsA("Model") then
            return false
        end
        return model:FindFirstChild("Power Box")
            and model:FindFirstChild("PowerPlantScript", true)
            and model:FindFirstChild("ProgressDisplay", true)
    end

    local function isRadioTower(model)
        return model
            and model:IsA("Model")
            and model.Name == "Radio Tower"
            and model:FindFirstChild("CircuitBox", true) ~= nil
    end

    local function removeHighlight(cache, target)
        local esp = cache[target]
        if not esp then
            return
        end
        if esp.Highlight then
            esp.Highlight:Destroy()
        end
        if esp.Label then
            esp.Label:Destroy()
        end
        cache[target] = nil
    end

    -- Labels are disabled beyond this distance to eliminate UI layout cost
    local LabelCullDistance = 100

    local function createEspLabel(target, text, textColor)
        local adornee = UtilityModule.getItemBasePart(target)
        if not adornee then return nil end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = randomInstanceName()
        billboard.Adornee = adornee
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.fromOffset(220, 20)
        billboard.StudsOffsetWorldSpace = Vector3.new(0, 3.2, 0)
        billboard.Parent = Services.Workspace.CurrentCamera

        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Size = UDim2.fromScale(1, 1)
        label.Font = Enum.Font.GothamBold
        label.Text = text
        label.TextColor3 = textColor
        label.TextSize = 14
        label.TextStrokeColor3 = Color3.fromRGB(15, 15, 15)
        label.TextStrokeTransparency = 0.08
        label.Parent = billboard

        return billboard
    end

    local function updateEspLabel(esp, target, text, textColor)
        if not esp.Label then
            esp.Label = createEspLabel(target, text, textColor)
            return
        end
        local label = esp.Label:FindFirstChildWhichIsA("TextLabel")
        if label then
            label.Text = text
            label.TextColor3 = textColor
        end
    end

    local function removeEspLabel(esp)
        if esp and esp.Label then
            esp.Label:Destroy()
            esp.Label = nil
        end
    end

    local function setHighlight(cache, target, enabled, fillColor, outlineColor, labelText, labelColor)
        if not enabled then
            removeHighlight(cache, target)
            return
        end

        local esp = cache[target]
        if esp then
            if esp.Highlight then
                esp.Highlight.FillColor = fillColor
                esp.Highlight.OutlineColor = outlineColor
            end
            if labelText then
                updateEspLabel(esp, target, labelText, labelColor)
            else
                removeEspLabel(esp)
            end
            return
        end

        local highlight = Instance.new("Highlight")
        highlight.Name = randomInstanceName()
        highlight.Adornee = target
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = fillColor
        highlight.FillTransparency = 0.65
        highlight.OutlineColor = outlineColor
        highlight.OutlineTransparency = 0
        highlight.Parent = Services.Workspace.CurrentCamera
        esp = { Highlight = highlight }
        cache[target] = esp
        if labelText then
            updateEspLabel(esp, target, labelText, labelColor)
        end
    end

    function EspModule.refreshItemHighlight(item)
        local itemClass = ItemDataCache[item] or getItemEspClass(item)
        ItemDataCache[item] = itemClass
        setHighlight(
            ItemHighlights,
            item,
            itemClassMatchesDroppedItem(itemClass, item)
            and isWithinEspRadius(item, itemClass.RadiusKey),
            itemClass.FillColor,
            itemClass.OutlineColor,
            item.Name,
            itemClass.TextColor
        )
    end

    function EspModule.refreshItemHighlights()
        local root = UtilityModule.getRootPart()
        local rootPos = root and root.Position

        for item, itemClass in pairs(ItemDataCache) do
            local enabled = item.Parent == DroppedItems
                and itemClassMatchesDroppedItem(itemClass, item)
                and isWithinEspRadius(item, itemClass.RadiusKey)
            setHighlight(ItemHighlights, item, enabled, itemClass.FillColor, itemClass.OutlineColor, item.Name, itemClass.TextColor)

            -- Cull label beyond LabelCullDistance — disables UI layout, keeps instance alive
            local esp = ItemHighlights[item]
            if esp and esp.Label and rootPos then
                local pos = UtilityModule.getItemPosition(item)
                esp.Label.Enabled = pos ~= nil and (pos - rootPos).Magnitude <= LabelCullDistance
            end
        end

        for item in pairs(ItemHighlights) do
            if not ItemDataCache[item] then
                removeHighlight(ItemHighlights, item)
            end
        end
    end

    function EspModule.refreshCharacterHighlight(character)
        local isOtherCharacter = character ~= LocalCharacter and character.Name ~= Player.Name
        setHighlight(
            CharacterHighlights,
            character,
            State.ZombieESP
            and isOtherCharacter
            and selectedNameMatches("ZombieSelected", character.Name)
            and isWithinEspRadius(character, "ZombieRadius"),
            Color3.fromRGB(190, 30, 50),
            Color3.fromRGB(255, 80, 100),
            character.Name,
            Color3.fromRGB(255, 100, 120)
        )
    end

    function EspModule.refreshCharacterHighlights()
        for _, character in ipairs(Characters:GetChildren()) do
            EspModule.refreshCharacterHighlight(character)
        end
        local root = UtilityModule.getRootPart()
        for character, esp in pairs(CharacterHighlights) do
            if not character.Parent
                or not State.ZombieESP
                or character == LocalCharacter
                or character.Name == Player.Name
                or not selectedNameMatches("ZombieSelected", character.Name)
                or not isWithinEspRadius(character, "ZombieRadius")
            then
                removeHighlight(CharacterHighlights, character)
            elseif esp.Label and root then
                local pos = UtilityModule.getItemPosition(character)
                esp.Label.Enabled = pos ~= nil and (pos - root.Position).Magnitude <= LabelCullDistance
            end
        end
    end

    function EspModule.refreshSurvivorHighlight(survivor)
        setHighlight(
            SurvivorHighlights,
            survivor,
            State.SurvivorESP and isWithinEspRadius(survivor, "SurvivorRadius"),
            Color3.fromRGB(20, 165, 230),
            Color3.fromRGB(95, 225, 255),
            survivor.Name,
            Color3.fromRGB(135, 235, 255)
        )
    end

    function EspModule.refreshSurvivorHighlights()
        for _, survivor in ipairs(Survivors:GetChildren()) do
            EspModule.refreshSurvivorHighlight(survivor)
        end
        local root = UtilityModule.getRootPart()
        for survivor, esp in pairs(SurvivorHighlights) do
            if not survivor.Parent or not State.SurvivorESP or not isWithinEspRadius(survivor, "SurvivorRadius") then
                removeHighlight(SurvivorHighlights, survivor)
            elseif esp.Label and root then
                local pos = UtilityModule.getItemPosition(survivor)
                esp.Label.Enabled = pos ~= nil and (pos - root.Position).Magnitude <= LabelCullDistance
            end
        end
    end

    function EspModule.refreshGeneratorHighlight(generator)
        setHighlight(
            GeneratorHighlights,
            generator,
            State.GeneratorESP and generator.Name == "Generator" and isWithinEspRadius(generator, "ObjectiveRadius"),
            Color3.fromRGB(55, 175, 255),
            Color3.fromRGB(175, 230, 255),
            "Generator",
            Color3.fromRGB(155, 225, 255)
        )
    end

    function EspModule.refreshGeneratorHighlights()
        for _, structure in ipairs(Structures:GetChildren()) do
            if structure.Name == "Generator" then
                EspModule.refreshGeneratorHighlight(structure)
            end
        end
        for generator in pairs(GeneratorHighlights) do
            if not generator.Parent
                or not State.GeneratorESP
                or generator.Name ~= "Generator"
                or not isWithinEspRadius(generator, "ObjectiveRadius")
            then
                removeHighlight(GeneratorHighlights, generator)
            end
        end
    end

    function EspModule.refreshScrapPileHighlight(scrapPile)
        setHighlight(
            ScrapPileHighlights,
            scrapPile,
            State.ScrapPileESP and scrapPile.Name == "Scrap Pile" and isWithinEspRadius(scrapPile, "ObjectiveRadius"),
            Color3.fromRGB(155, 100, 50),
            Color3.fromRGB(225, 175, 105),
            "Scrap Pile",
            Color3.fromRGB(235, 185, 115)
        )
    end

    function EspModule.refreshScrapPileHighlights()
        for _, structure in ipairs(Structures:GetChildren()) do
            if structure.Name == "Scrap Pile" then
                EspModule.refreshScrapPileHighlight(structure)
            end
        end
        for scrapPile in pairs(ScrapPileHighlights) do
            if not scrapPile.Parent
                or not State.ScrapPileESP
                or scrapPile.Name ~= "Scrap Pile"
                or not isWithinEspRadius(scrapPile, "ObjectiveRadius")
            then
                removeHighlight(ScrapPileHighlights, scrapPile)
            end
        end
    end

    function EspModule.refreshRadioTowerHighlight(tileModel)
        setHighlight(
            RadioTowerHighlights,
            tileModel,
            State.RadioTowerESP and isRadioTower(tileModel) and isWithinEspRadius(tileModel, "ObjectiveRadius"),
            Color3.fromRGB(110, 75, 240),
            Color3.fromRGB(190, 160, 255),
            "Radio Tower",
            Color3.fromRGB(195, 165, 255)
        )
    end

    function EspModule.refreshRadioTowerHighlights()
        for _, tileModel in ipairs(MapTiles:GetChildren()) do
            EspModule.refreshRadioTowerHighlight(tileModel)
        end
        for tileModel in pairs(RadioTowerHighlights) do
            if not tileModel.Parent
                or not State.RadioTowerESP
                or not isRadioTower(tileModel)
                or not isWithinEspRadius(tileModel, "ObjectiveRadius")
            then
                removeHighlight(RadioTowerHighlights, tileModel)
            end
        end
    end

    function EspModule.refreshPowerPlantHighlight(tileModel)
        setHighlight(
            PowerPlantHighlights,
            tileModel,
            State.PowerPlantESP and isPowerPlant(tileModel) and isWithinEspRadius(tileModel, "ObjectiveRadius"),
            Color3.fromRGB(210, 160, 0),
            Color3.fromRGB(255, 225, 55),
            "Power Plant",
            Color3.fromRGB(255, 230, 90)
        )
    end

    function EspModule.refreshPowerPlantHighlights()
        for _, tileModel in ipairs(MapTiles:GetChildren()) do
            EspModule.refreshPowerPlantHighlight(tileModel)
        end
        for tileModel in pairs(PowerPlantHighlights) do
            if not tileModel.Parent
                or not State.PowerPlantESP
                or not isPowerPlant(tileModel)
                or not isWithinEspRadius(tileModel, "ObjectiveRadius")
            then
                removeHighlight(PowerPlantHighlights, tileModel)
            end
        end
    end

    function EspModule.refreshBarrelHighlight(barrel)
        local itemClass, itemName = getMatchingBarrelItemClass(barrel)
        local showFromContents = itemClass ~= nil
        local enabled = barrel.Name == "Barrel"
            and (State.BarrelESP or showFromContents)
            and isWithinEspRadius(barrel, "BarrelRadius")

        local labelText = "Barrel"
        local labelColor = Color3.fromRGB(255, 150, 80)
        if itemClass and itemName then
            labelText = itemName
            labelColor = itemClass.TextColor
        end

        setHighlight(
            BarrelHighlights,
            barrel,
            enabled,
            itemClass and itemClass.FillColor or Color3.fromRGB(185, 70, 28),
            itemClass and itemClass.OutlineColor or Color3.fromRGB(255, 140, 70),
            labelText,
            labelColor
        )
    end

    function EspModule.refreshBarrelHighlights()
        for _, structure in ipairs(Structures:GetChildren()) do
            if structure.Name == "Barrel" then
                EspModule.refreshBarrelHighlight(structure)
            end
        end
        for barrel in pairs(BarrelHighlights) do
            local itemClass = getMatchingBarrelItemClass(barrel)
            if not barrel.Parent
                or barrel.Name ~= "Barrel"
                or not (State.BarrelESP or itemClass)
                or not isWithinEspRadius(barrel, "BarrelRadius")
            then
                removeHighlight(BarrelHighlights, barrel)
            end
        end
    end

    function EspModule.refreshCrateHighlight(crate)
        setHighlight(
            CrateHighlights,
            crate,
            State.CrateESP and crate.Name == "Default" and isWithinEspRadius(crate, "CrateRadius"),
            Color3.fromRGB(120, 88, 55),
            Color3.fromRGB(205, 165, 105),
            "Crate",
            Color3.fromRGB(220, 180, 120)
        )
    end

    function EspModule.refreshCrateHighlights()
        for _, crate in ipairs(MapCrates:GetChildren()) do
            EspModule.refreshCrateHighlight(crate)
        end
        for crate in pairs(CrateHighlights) do
            if not crate.Parent
                or not State.CrateESP
                or crate.Name ~= "Default"
                or not isWithinEspRadius(crate, "CrateRadius")
            then
                removeHighlight(CrateHighlights, crate)
            end
        end
    end

    function EspModule.refreshStructureHighlights()
        EspModule.refreshGeneratorHighlights()
        EspModule.refreshScrapPileHighlights()
        EspModule.refreshRadioTowerHighlights()
        EspModule.refreshBarrelHighlights()
        EspModule.refreshPowerPlantHighlights()
        EspModule.refreshCrateHighlights()
    end

    function EspModule.refreshAll()
        EspModule.refreshItemHighlights()
        EspModule.refreshCharacterHighlights()
        EspModule.refreshSurvivorHighlights()
        EspModule.refreshStructureHighlights()
    end

    -- Seed cache for items already in the world at script load
    for _, item in ipairs(DroppedItems:GetChildren()) do
        ItemDataCache[item] = getItemEspClass(item)
    end

    DroppedItems.ChildAdded:Connect(function(item)
        task.defer(function()
            ItemDataCache[item] = getItemEspClass(item)
            EspModule.refreshItemHighlight(item)
        end)
    end)
    DroppedItems.ChildRemoved:Connect(function(item)
        ItemDataCache[item] = nil
        removeHighlight(ItemHighlights, item)
    end)

    Characters.ChildAdded:Connect(function(character)
        task.defer(EspModule.refreshCharacterHighlight, character)
    end)
    Characters.ChildRemoved:Connect(function(character)
        removeHighlight(CharacterHighlights, character)
    end)

    Structures.ChildAdded:Connect(function(structure)
        task.defer(EspModule.refreshBarrelHighlight, structure)
        task.defer(EspModule.refreshGeneratorHighlight, structure)
        task.defer(EspModule.refreshScrapPileHighlight, structure)
    end)
    Structures.ChildRemoved:Connect(function(structure)
        removeHighlight(BarrelHighlights, structure)
        removeHighlight(GeneratorHighlights, structure)
        removeHighlight(ScrapPileHighlights, structure)
    end)

    MapTiles.ChildAdded:Connect(function(tileModel)
        task.defer(EspModule.refreshPowerPlantHighlight, tileModel)
        task.defer(EspModule.refreshRadioTowerHighlight, tileModel)
    end)
    MapTiles.ChildRemoved:Connect(function(tileModel)
        removeHighlight(PowerPlantHighlights, tileModel)
        removeHighlight(RadioTowerHighlights, tileModel)
    end)

    MapCrates.ChildAdded:Connect(function(crate)
        task.defer(EspModule.refreshCrateHighlight, crate)
    end)
    MapCrates.ChildRemoved:Connect(function(crate)
        removeHighlight(CrateHighlights, crate)
    end)

    Survivors.ChildAdded:Connect(function(survivor)
        task.defer(EspModule.refreshSurvivorHighlight, survivor)
    end)
    Survivors.ChildRemoved:Connect(function(survivor)
        removeHighlight(SurvivorHighlights, survivor)
    end)
end

local MobileUIModule = {}
do
    function MobileUIModule.createToggleButton(window, forceMobile)
        if not forceMobile and not SimpleUI.Utility:IsMobile() then
            return
        end

        local TweenService = SimpleUI.Utility:GetService("TweenService")
        local UserInputService = SimpleUI.Utility:GetService("UserInputService")

        local folderName = "SimpleScripts"
        local fileName = folderName .. "/logo.png"
        local iconUrl = "https://raw.githubusercontent.com/dawnpetal/website/refs/heads/main/assets/images/logo.png"
        local logoAsset

        local canUseFilesystem = makefolder and isfolder and listfiles and isfile and delfile and writefile and
            getcustomasset

        if canUseFilesystem then
            if not isfolder(folderName) then
                makefolder(folderName)
            end

            for _, file in ipairs(listfiles("")) do
                local cleanFile = file:gsub("^/", "")
                if cleanFile:lower():find("simpleui") and isfile(cleanFile) then
                    delfile(cleanFile)
                end
            end

            if not isfile(fileName) then
                local success, imageData = pcall(function()
                    return game:HttpGet(iconUrl)
                end)
                if success and imageData then
                    writefile(fileName, imageData)
                end
            end

            logoAsset = getcustomasset(fileName)
        end

        local toggleButton = Instance.new("ImageButton")
        toggleButton.Name = "ToggleUIButton"
        toggleButton.Size = UDim2.new(0, 40, 0, 40)
        toggleButton.Position = UDim2.new(0, 30, 0.5, -20)
        toggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
        toggleButton.BackgroundTransparency = 1
        toggleButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.ScaleType = Enum.ScaleType.Fit
        toggleButton.Active = true
        toggleButton.Image = logoAsset or "rbxassetid://10734900011"
        toggleButton.Parent = window.Elements.ScreenGui

        local dragging = false
        local dragStart, startPos
        local hasMoved = false
        local normalSize = UDim2.new(0, 40, 0, 40)
        local pressSize = UDim2.new(0, 50, 0, 50)
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

        if toggleButton and TweenService then
            toggleButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType ==
                    Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = toggleButton.Position
                    hasMoved = false
                    TweenService:Create(toggleButton, tweenInfo, {
                        Size = pressSize
                    }):Play()
                end
            end)

            toggleButton.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType ==
                    Enum.UserInputType.Touch then
                    dragging = false
                    TweenService:Create(toggleButton, tweenInfo, {
                        Size = normalSize
                    }):Play()
                    if not hasMoved then
                        if window.IsVisible() then
                            window.Hide()
                        else
                            window.Show()
                        end
                    end
                end
            end)
        end

        if UserInputService then
            UserInputService.InputChanged:Connect(function(input)
                if dragging and
                    (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType ==
                        Enum.UserInputType.Touch) then
                    local delta = input.Position - dragStart
                    if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
                        hasMoved = true
                        toggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                    end
                end
            end)
        end
    end
end

-- ========================
-- WINDOW
-- ========================

local window = SimpleUI:CreateWindow({
    Brand = {
        Name = "SimpleScripts",
    },
    DefaultScale = SimpleUI.Utility:IsMobile() and 0.50 or 0.75,
    TabMode = "Dynamic",
    CanResize = true,
    Footer = true,
    FooterItems = {
        {
            Type = "Text",
            Text = "SimpleUI v" .. SimpleUI.Version .. " - discord.gg/5BUTb4vYm3",
            ColorTier = "TextSecondary",
            Order = 1,
        },
    },
    StartHidden = false,
    IgnoreGuiInset = false,
    DisplayOrder = 1,
})

-- ========================
-- TABS
-- ========================

local Tabs = {
    Main = SimpleUI:CreateTab(window, "Main", {
        Description = "Auto farm",
        Icon = {
            Image = "rbxassetid://10734975692",
            Size = UDim2.new(0, 16, 0, 16),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        },
        DualScroll = true,
    }),
    Items = SimpleUI:CreateTab(window, "Items", {
        Description = "Item automation",
        Icon = {
            Image = "rbxassetid://16898613044",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(771, 955),
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        },
        DualScroll = true,
    }),
    ESP = SimpleUI:CreateTab(window, "ESP", {
        Description = "Important world and character highlights",
        Icon = {
            Image = "rbxassetid://10734963191",
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        },
        DualScroll = true,
    }),
    Miscellaneous = SimpleUI:CreateTab(window, "Miscellaneous", {
        Description = "Interaction and environment controls",
        Icon = {
            Image = "rbxassetid://16898613869",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(820, 906),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        },
        DualScroll = true,
    }),
    Settings = SimpleUI:CreateTab(window, "Settings", {
        Description = "Interface customization and control configuration",
        Icon = {
            Image = "rbxassetid://16898613777",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(771, 257),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        },
    }),
}

-- ========================
-- MAIN TAB
-- ========================

local function initializeMainTab()
    local page = Tabs.Main.Page.Left

    SimpleUI:CreateSection(page, "Auto Melee")

    SimpleUI:CreateToggle(page, "Auto Melee", false, function(enabled)
        State.AutoMelee = enabled
    end, {
        Description = "Attacks nearby selected models with the equipped melee tool.",
        Save = {
            Key = "sta.main.auto_melee.enabled",
        },
    })

    SimpleUI:CreateToggle(page, "Melee Zombies", State.AutoMeleeZombies, function(enabled)
        State.AutoMeleeZombies = enabled
    end, {
        Description = "Includes hostile character models in Auto Melee targets.",
        Save = {
            Key = "sta.main.auto_melee.zombies",
        },
    })

    SimpleUI:CreateToggle(page, "Melee Scrap Piles", State.AutoMeleePiles, function(enabled)
        State.AutoMeleePiles = enabled
    end, {
        Description = "Includes scrap piles in Auto Melee targets.",
        Save = {
            Key = "sta.main.auto_melee.piles",
        },
    })

    SimpleUI:CreateToggle(page, "Melee Barrels", State.AutoMeleeBarrels, function(enabled)
        State.AutoMeleeBarrels = enabled
    end, {
        Description = "Includes barrels in Auto Melee targets.",
        Save = {
            Key = "sta.main.auto_melee.barrels",
        },
    })
end

-- ========================
-- ITEMS TAB
-- ========================

local function initializeItemsTab()
    local page = Tabs.Items.Page.Left
    local serverPage = Tabs.Items.Page.Right

    SimpleUI:CreateSection(page, "Auto Consume")

    local ammoSliderControls = {}
    local ammoOptions = UtilityModule.getChildNames(ItemEspClasses.Ammo.Folder)
    for index = #ammoOptions, 1, -1 do
        if ammoOptions[index] == SelectAllOption then
            table.remove(ammoOptions, index)
        end
    end

    local function refreshAmmoLimitSliders()
        for ammoName, slider in pairs(ammoSliderControls) do
            local elements = slider.GetElements and slider:GetElements()
            if elements and elements.Container then
                elements.Container.Visible = State.AutoPickupAmmoSelected[ammoName] == true
            end
        end
    end

    SimpleUI:CreateToggle(page, "Auto Consume Food", false, function(enabled)
        State.AutoPickupFood = enabled
    end, {
        Description = "Consumes nearby food when hunger is at or below the threshold.",
        Save = {
            Key = "sta.main.auto_pickup_food",
        },
    })

    SimpleUI:CreateSlider(page, "Food Hunger Threshold", 30, 100, State.AutoPickupFoodHunger, function(value)
        State.AutoPickupFoodHunger = value
    end, {
        Increment = 1,
        Description = "Food consumption starts when your character Hunger attribute is at or below this value.",
        Save = {
            Key = "sta.main.auto_pickup_food_hunger",
        },
    })

    SimpleUI:CreateToggle(page, "Auto Pickup Ammo", false, function(enabled)
        State.AutoPickupAmmo = enabled
    end, {
        Description = "Picks up selected nearby ammo while your current amount is at or below its limit.",
        Save = {
            Key = "sta.main.auto_pickup_ammo",
        },
    })

    SimpleUI:CreateDropdown(
        page,
        "Ammo Types",
        ammoOptions,
        {},
        function(values)
            State.AutoPickupAmmoSelected = {}
            if type(values) == "table" then
                for _, value in ipairs(values) do
                    State.AutoPickupAmmoSelected[tostring(value)] = true
                end
            end
            refreshAmmoLimitSliders()
        end,
        {
            MultiSelect = true,
            Description = "Choose which ammo drops should be picked up automatically.",
            Save = {
                Key = "sta.main.auto_pickup_ammo_types",
            },
        }
    )

    for _, ammoName in ipairs(ammoOptions) do
        State.AutoPickupAmmoLimits[ammoName] = State.AutoPickupAmmoLimits[ammoName] or 100
        ammoSliderControls[ammoName] = SimpleUI:CreateSlider(
            page,
            ammoName .. " Max Ammo",
            100,
            2000,
            State.AutoPickupAmmoLimits[ammoName],
            function(value)
                State.AutoPickupAmmoLimits[ammoName] = value
            end,
            {
                Increment = 1,
                Description = "Stops pickup once your current " .. UtilityModule.getAmmoAttributeName(ammoName) .. " ammo is above this value.",
                Save = {
                    Key = "sta.main.auto_pickup_ammo_limit." .. ammoName,
                },
            }
        )
    end
    refreshAmmoLimitSliders()

    SimpleUI:CreateSection(serverPage, "Automatic TP")

    SimpleUI:CreateToggle(serverPage, "Auto Fuel", false, function(enabled)
        State.AutoFuel = enabled
    end, {
        Description = "Moves nearby dropped fuel items to the generator or a valid road relay point.",
        Save = {
            Key = "sta.main.auto_fuel",
        },
    })

    SimpleUI:CreateToggle(serverPage, "Auto Shredder", false, function(enabled)
        State.AutoShredder = enabled
    end, {
        Description = "Moves nearby dropped resource items to the shredder or a valid road relay point.",
        Save = {
            Key = "sta.main.auto_shredder",
        },
    })

    SimpleUI:CreateToggle(serverPage, "Auto Food", false, function(enabled)
        State.AutoFood = enabled
    end, {
        Description = "Moves nearby dropped food items to the generator-side food drop or a valid road relay point.",
        Save = {
            Key = "sta.main.auto_food",
        },
    })
end

-- ========================
-- ESP TAB
-- ========================

local function initializeEspTab()
    local page = Tabs.ESP.Page.Left
    local worldPage = Tabs.ESP.Page.Right

    local radiusSection = SimpleUI:CreateSection(page, "ESP Radius", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://16898613699",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(257, 967)
        }
    })

    SimpleUI:CreateSlider(radiusSection.Container, "Master ESP Radius", 0, 2500, State.EspMasterRadius, function(value)
        State.EspMasterRadius = value
        EspModule.refreshAll()
    end, {
        Increment = 25,
        Description = "Global ESP range. Set to 0 for unlimited range.",
        Save = {
            Key = "sta.esp.master_radius",
        },
    })

    SimpleUI:CreateSlider(radiusSection.Container, "Objective ESP Radius Override", 0, 2500, State.ObjectiveRadius, function(value)
        State.ObjectiveRadius = value
        EspModule.refreshStructureHighlights()
    end, {
        Increment = 25,
        Description = "Set above 0 to use a separate range for generator, power, scrap, and radio objectives.",
        Save = {
            Key = "sta.esp.objective_radius",
        },
    })

    SimpleUI:CreateButton(radiusSection.Container, "Refresh ESP", EspModule.refreshAll, {
        Description = "Rebuilds all active ESP labels after world, dropdown, or radius changes.",
    })

    local fuelFoodSection = SimpleUI:CreateSection(page, "Fuel & Food", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://16898613353",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(196, 967)
        }
    })

    SimpleUI:CreateToggle(fuelFoodSection.Container, "Fuel ESP", false, function(enabled)
        State.FuelItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks fuel and refuel items so they are easier to spot while looting.",
        Save = {
            Key = "sta.esp.fuel.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        fuelFoodSection.Container,
        "Fuel ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Fuel.Folder),
        State.FuelItemSelected,
        function(value)
            State.FuelItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one fuel item to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.fuel.selected",
            },
        })

    SimpleUI:CreateToggle(fuelFoodSection.Container, "Food ESP", false, function(enabled)
        State.FoodItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks edible loot for quick health and hunger recovery runs.",
        Save = {
            Key = "sta.esp.food.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        fuelFoodSection.Container,
        "Food ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Food.Folder),
        State.FoodItemSelected,
        function(value)
            State.FoodItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one food item to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.food.selected",
            },
        })

    SimpleUI:CreateSlider(
        fuelFoodSection.Container,
        "Food ESP Radius Override",
        0,
        1500,
        State.FoodItemRadius,
        function(value)
            State.FoodItemRadius = value
            EspModule.refreshItemHighlights()
        end,
        { Increment = 25, Description =
        "Set above 0 to override the master ESP radius for this radar-supported category.",
            Save = {
                Key = "sta.esp.food.radius",
            },
        })

    local medicalSection = SimpleUI:CreateSection(page, "Medical Consumables", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://16898612819",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(820, 404)
        },
    })

    SimpleUI:CreateToggle(medicalSection.Container, "Medical ESP", false, function(enabled)
        State.MedicalItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks healing tools and medical supplies before you get close.",
        Save = {
            Key = "sta.esp.medical.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        medicalSection.Container,
        "Medical ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Medical.Folder),
        State.MedicalItemSelected,
        function(value)
            State.MedicalItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one medical item to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.medical.selected",
            },
        })

    SimpleUI:CreateSlider(
        medicalSection.Container,
        "Medical ESP Radius Override",
        0,
        1500,
        State.MedicalItemRadius,
        function(value)
            State.MedicalItemRadius = value
            EspModule.refreshItemHighlights()
        end,
        { Increment = 25, Description =
        "Set above 0 to override the master ESP radius for this radar-supported category.",
            Save = {
                Key = "sta.esp.medical.radius",
            },
        })

    local gunsAmmoSection = SimpleUI:CreateSection(page, "Guns & Ammo", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://80521479530593",
            Size = UDim2.new(0, 16, 0, 16),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        }
    })

    SimpleUI:CreateToggle(gunsAmmoSection.Container, "Gun ESP", false, function(enabled)
        State.RangedItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks ranged weapons so upgrades are easier to compare at a distance.",
        Save = {
            Key = "sta.esp.guns.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        gunsAmmoSection.Container,
        "Gun ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Ranged.Folder),
        State.RangedItemSelected,
        function(value)
            State.RangedItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one gun to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.guns.selected",
            },
        })

    SimpleUI:CreateSlider(
        gunsAmmoSection.Container,
        "Gun ESP Radius Override",
        0,
        1500,
        State.RangedItemRadius,
        function(value)
            State.RangedItemRadius = value
            EspModule.refreshItemHighlights()
        end,
        { Increment = 25, Description =
        "Set above 0 to override the master ESP radius for this radar-supported category.",
            Save = {
                Key = "sta.esp.guns.radius",
            },
        })

    SimpleUI:CreateToggle(gunsAmmoSection.Container, "Ammo ESP", false, function(enabled)
        State.AmmoItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks ammunition drops so you can restock without checking every item.",
        Save = {
            Key = "sta.esp.ammo.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        gunsAmmoSection.Container,
        "Ammo ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Ammo.Folder),
        State.AmmoItemSelected,
        function(value)
            State.AmmoItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one ammo type to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.ammo.selected",
            },
        })

    SimpleUI:CreateSlider(
        gunsAmmoSection.Container,
        "Ammo ESP Radius Override",
        0,
        1500,
        State.AmmoItemRadius,
        function(value)
            State.AmmoItemRadius = value
            EspModule.refreshItemHighlights()
        end,
        { Increment = 25, Description =
        "Set above 0 to override the master ESP radius for this radar-supported category.",
            Save = {
                Key = "sta.esp.ammo.radius",
            },
        })

    local extraToolsSection = SimpleUI:CreateSection(page, "Extra Tools", {
        Style = "box",
        DefaultExpanded = false,
    })

    SimpleUI:CreateToggle(extraToolsSection.Container, "Melee ESP", false, function(enabled)
        State.MeleeItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks melee weapons and barrels that can drop the selected melee item.",
        Save = {
            Key = "sta.esp.melee.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        extraToolsSection.Container,
        "Melee ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Melee.Folder),
        State.MeleeItemSelected,
        function(value)
            State.MeleeItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one melee weapon to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.melee.selected",
            },
        })

    SimpleUI:CreateToggle(extraToolsSection.Container, "Backpack ESP", false, function(enabled)
        State.BackpackItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks backpack drops so storage upgrades stand out.",
        Save = {
            Key = "sta.esp.backpack.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        extraToolsSection.Container,
        "Backpack ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Backpack.Folder),
        State.BackpackItemSelected,
        function(value)
            State.BackpackItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one backpack to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.backpack.selected",
            },
        })

    SimpleUI:CreateToggle(extraToolsSection.Container, "Ability ESP", false, function(enabled)
        State.AbilityItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks ability tools so rare utility drops are easier to notice.",
        Save = {
            Key = "sta.esp.ability.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        extraToolsSection.Container,
        "Ability ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Ability.Folder),
        State.AbilityItemSelected,
        function(value)
            State.AbilityItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one ability tool to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.ability.selected",
            },
        })

    local armorThrowablesSection = SimpleUI:CreateSection(worldPage, "Armor & Throwables", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://16898613777",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(869, 0)
        }
    })

    SimpleUI:CreateToggle(armorThrowablesSection.Container, "Armor ESP", false, function(enabled)
        State.ArmorItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks armor drops so defensive upgrades are easier to grab.",
        Save = {
            Key = "sta.esp.armor.enabled",
        },
    })

    SimpleUI:CreateToggle(armorThrowablesSection.Container, "Throwable ESP", false, function(enabled)
        State.ThrowableItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks throwable consumables for combat and utility planning.",
        Save = {
            Key = "sta.esp.throwable.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        armorThrowablesSection.Container,
        "Throwable ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Throwables.Folder),
        State.ThrowableItemSelected,
        function(value)
            State.ThrowableItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one throwable to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.throwable.selected",
            },
        })

    SimpleUI:CreateSlider(
        armorThrowablesSection.Container,
        "Throwable ESP Radius Override",
        0,
        1500,
        State.ThrowableItemRadius,
        function(value)
            State.ThrowableItemRadius = value
            EspModule.refreshItemHighlights()
        end,
        { Increment = 25, Description =
        "Set above 0 to override the master ESP radius for this radar-supported category.",
            Save = {
                Key = "sta.esp.throwable.radius",
            },
        })

    local characterSection = SimpleUI:CreateSection(worldPage, "Zombies & Survivors", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://140171186759671",
            Size = UDim2.new(0, 16, 0, 16),
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        },
    })

    SimpleUI:CreateToggle(characterSection.Container, "Zombie ESP", false, function(enabled)
        State.ZombieESP = enabled
        EspModule.refreshCharacterHighlights()
    end, {
        Description = "Marks nearby hostile character models before they reach you.",
        Save = {
            Key = "sta.esp.zombie.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        characterSection.Container,
        "Zombie Selection",
        UtilityModule.getChildNames(Characters),
        State.ZombieSelected,
        function(value)
            State.ZombieSelected = value or SelectAllOption
            EspModule.refreshCharacterHighlights()
        end, {
            Description = "Choose one zombie name to highlight, or keep All for every match.",
            Save = {
                Key = "sta.esp.zombie.selected",
            },
        })

    SimpleUI:CreateSlider(
        characterSection.Container,
        "Zombie Radius Override",
        0,
        1500,
        State.ZombieRadius,
        function(value)
        State.ZombieRadius = value
        EspModule.refreshCharacterHighlights()
    end, {
        Increment = 25,
        Description = "Set above 0 to override the master ESP radius for zombies.",
        Save = {
            Key = "sta.esp.zombie.radius",
        },
    })

    SimpleUI:CreateToggle(characterSection.Container, "Survivor ESP", false, function(enabled)
        State.SurvivorESP = enabled
        EspModule.refreshSurvivorHighlights()
    end, {
        Description = "Marks survivor NPCs so escort and rescue targets are easier to track.",
        Save = {
            Key = "sta.esp.survivor.enabled",
        },
    })

    SimpleUI:CreateSlider(
        characterSection.Container,
        "Survivor Radius Override",
        0,
        1500,
        State.SurvivorRadius,
        function(value)
        State.SurvivorRadius = value
        EspModule.refreshSurvivorHighlights()
    end, {
        Increment = 25,
        Description = "Set above 0 to override the master ESP radius for survivors.",
        Save = {
            Key = "sta.esp.survivor.radius",
        },
    })

    local structuresSection = SimpleUI:CreateSection(worldPage, "Objectives & Structures", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://16898613044",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(355, 967)
        }
    })

    SimpleUI:CreateToggle(structuresSection.Container, "Generator ESP", false, function(enabled)
        State.GeneratorESP = enabled
        EspModule.refreshGeneratorHighlights()
    end, {
        Description = "Marks the active generator and repair prompt area.",
        Save = {
            Key = "sta.esp.generator.enabled",
        },
    })

    SimpleUI:CreateToggle(structuresSection.Container, "Scrap Pile ESP", false, function(enabled)
        State.ScrapPileESP = enabled
        EspModule.refreshScrapPileHighlights()
    end, {
        Description = "Marks scrap piles so repair materials are easier to farm.",
        Save = {
            Key = "sta.esp.scrap_pile.enabled",
        },
    })

    SimpleUI:CreateToggle(structuresSection.Container, "Radio Tower ESP", false, function(enabled)
        State.RadioTowerESP = enabled
        EspModule.refreshRadioTowerHighlights()
    end, {
        Description = "Marks the radio tower objective and circuit box location.",
        Save = {
            Key = "sta.esp.radio_tower.enabled",
        },
    })

    SimpleUI:CreateToggle(structuresSection.Container, "Barrel ESP", false, function(enabled)
        State.BarrelESP = enabled
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks barrels, including barrels that can contain selected highlighted loot.",
        Save = {
            Key = "sta.esp.barrel.enabled",
        },
    })

    SimpleUI:CreateSlider(
        structuresSection.Container,
        "Barrel Radius Override",
        0,
        1500,
        State.BarrelRadius,
        function(value)
        State.BarrelRadius = value
        EspModule.refreshBarrelHighlights()
    end, {
        Increment = 25,
        Description = "Set above 0 to override the master ESP radius for barrels.",
        Save = {
            Key = "sta.esp.barrel.radius",
        },
    })

    SimpleUI:CreateToggle(structuresSection.Container, "Power Plant ESP", false, function(enabled)
        State.PowerPlantESP = enabled
        EspModule.refreshPowerPlantHighlights()
    end, {
        Description = "Marks power plant objectives and repair points.",
        Save = {
            Key = "sta.esp.power_plant.enabled",
        },
    })

    SimpleUI:CreateToggle(structuresSection.Container, "Crate ESP", false, function(enabled)
        State.CrateESP = enabled
        EspModule.refreshCrateHighlights()
    end, {
        Description = "Marks loot crates so unopened supply points stand out.",
        Save = {
            Key = "sta.esp.crate.enabled",
        },
    })

    SimpleUI:CreateSlider(
        structuresSection.Container,
        "Crate Radius Override",
        0,
        1500,
        State.CrateRadius,
        function(value)
        State.CrateRadius = value
        EspModule.refreshCrateHighlights()
    end, {
        Increment = 25,
        Description = "Set above 0 to override the master ESP radius for crates.",
        Save = {
            Key = "sta.esp.crate.radius",
        },
    })

end

-- ========================
-- MISCELLANEOUS TAB
-- ========================

local function initializeMiscellaneousTab()
    local page = Tabs.Miscellaneous.Page
    local interactionPage = page.Left
    local utilityPage = page.Right

    local interactionSection = SimpleUI:CreateSection(interactionPage, "Interaction", {
        Style = "box",
        DefaultExpanded = true,
        Icon = {
            Image = "rbxassetid://16898613613",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(771, 710),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        },
    })

    SimpleUI:CreateToggle(interactionSection.Container, "Instant Proximity Prompt", false, function(enabled)
        MiscModule.setInstantProximityPrompt(enabled)
    end, {
        Description = "Makes hold prompts complete immediately while enabled.",
        Save = {
            Key = "sta.misc.instant_proximity_prompt",
        },
    })

    local environmentSection = SimpleUI:CreateSection(utilityPage, "Environment", {
        Style = "box",
        DefaultExpanded = true,
        Icon = {
            Image = "rbxassetid://16898613044",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(514, 918),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        },
    })

    SimpleUI:CreateSlider(
        environmentSection.Container,
        "Fog Distance",
        0,
        100000,
        State.EnvironmentFogEnd,
        MiscModule.setFogDistance,
        {
            Increment = 500,
            Description = "Controls how far local fog reaches before the world fades out.",
            Save = {
                Key = "sta.misc.environment.fog_distance",
            },
        }
    )

    SimpleUI:CreateSlider(
        environmentSection.Container,
        "Atmosphere Density",
        0,
        1,
        State.EnvironmentAtmosphereDensity,
        MiscModule.setAtmosphereDensity,
        {
            Increment = 0.01,
            Description = "Adjusts haze thickness for clearer or heavier weather.",
            Save = {
                Key = "sta.misc.environment.atmosphere_density",
            },
        }
    )

    SimpleUI:CreateSlider(
        environmentSection.Container,
        "Time of Day",
        0,
        24,
        State.EnvironmentClockTime,
        MiscModule.setClockTime,
        {
            Increment = 0.25,
            Description = "Changes local lighting time without touching game progress.",
            Save = {
                Key = "sta.misc.environment.time_of_day",
            },
        }
    )

    SimpleUI:CreateSlider(
        environmentSection.Container,
        "Brightness",
        0,
        5,
        State.EnvironmentBrightness,
        MiscModule.setBrightness,
        {
            Increment = 0.1,
            Description = "Adjusts scene brightness for dark interiors and night areas.",
            Save = {
                Key = "sta.misc.environment.brightness",
            },
        }
    )

    SimpleUI:CreateToggle(environmentSection.Container, "Global Shadows", State.EnvironmentGlobalShadows, function(enabled)
        MiscModule.setGlobalShadows(enabled)
    end, {
        Description = "Toggles local world shadows for cleaner visibility.",
        Save = {
            Key = "sta.misc.environment.global_shadows",
        },
    })

    SimpleUI:CreateButton(environmentSection.Container, "Reset Local Environment", MiscModule.resetEnvironment, {
        Description = "Restores the lighting values from when the script started.",
    })

end

-- ========================
-- SETTINGS TAB
-- ========================

local function initializeSettingsTab()
    local page = Tabs.Settings.Page

    SimpleUI:CreateSection(page, "Interface Customization")

    SimpleUI:CreateSlider(page, "Interface Scale", 0.5, 2, window.GetScale(), function(value)
        window:SetScale(value, true)
    end, {
        Increment = 0.001,
        Save = {
            Key = "sta.settings.interface_scale",
        },
    })

    local themes = {}
    for name in pairs(SimpleUI.Themes) do
        themes[#themes + 1] = name
    end

    SimpleUI:CreateDropdown(page, "Select Color Theme", themes, nil, function(val)
        window:SetTheme(val, true)
    end, {
        Description = "Choose from " .. (#themes > 0 and #themes or "a variety of") .. " available themes.",
        Save = {
            Key = "sta.settings.theme",
        },
    })

    if not SimpleUI.Utility:IsMobile() then
        SimpleUI:CreateKeybind(page, "Toggle Interface Visibility", Enum.KeyCode.Q, function(key)
            window.Toggle()
        end, {
            Save = {
                Key = "sta.settings.toggle_keybind",
            },
        })
    end
end

-- ========================
-- RUNTIME
-- ========================

LoopFramework:registerTask("ESP Refresh", 1, EspModule.refreshAll, 1)

LoopFramework:registerTask("Nearby Pickup", 0.25, function()
    if not (State.AutoPickupAmmo or State.AutoPickupFood) then
        return
    end

    MainModule.processAutomaticPickups()
end, 2)

LoopFramework:registerTask("Automatic TP", 0.1, MainModule.processAutomaticTeleports, 3)
LoopFramework:registerTask("Auto Melee", 0.08, MainModule.processAutoMelee, 4)
LoopFramework:start(0.05)

initializeMainTab()
initializeItemsTab()
initializeEspTab()
initializeMiscellaneousTab()
initializeSettingsTab()

if SimpleUI.Utility:IsMobile() and MobileUIModule and MobileUIModule.createToggleButton then
    MobileUIModule.createToggleButton(window)
end