-- ========================= VALIDATION =========================
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

local SimpleUI = getPrerequisite("SimpleUI")
local TaskManager = getPrerequisite("TaskManager")
local ShoppingMart = getPrerequisite("ShoppingMart")
local amazong = ShoppingMart.new(SimpleUI:isMobile() and 0.5 or 0.90)

SimpleUI:createNotification({
    Title = "Validated!",
    Type = "Success",
    Description = "Pre-requisites validated, script will start soon! Powered by SimpleUI",
    Duration = 3
})

SimpleUI:createNotification({
    Title = "UI keybind",
    Type = "Info",
    Description = "Default UI visibility toggle is the Q button on PC",
    Duration = 10
})

local window = SimpleUI:createWindow({
    TitleLabel = {
        Properties = {
            Text = "Prospecting!"
        }
    },
    Subtitle = "by SimpleScripts",
    defaultScale = SimpleUI:isMobile() and 0.750 or 1
})
-- ========================= STATES / VARS =========================

local Players = SimpleUI:getService("Players")
local ReplicatedStorage = SimpleUI:getService("ReplicatedStorage")
local PathfindingService = SimpleUI:getService("PathfindingService")
local TeleportService = SimpleUI:getService("TeleportService")
local Workspace = SimpleUI:getService("Workspace")
local RunService = SimpleUI:getService("RunService")
local HttpService = SimpleUI:getService("HttpService")
local Lighting = SimpleUI:getService("Lighting")

local Player = Players.LocalPlayer
local LocalPlayer = Player
local Camera = Workspace.CurrentCamera
local Characters = Workspace:WaitForChild("Characters")

local Character
local LocalCharacter
local HumanoidRootPart
local Humanoid
local Animator
local WashAnimation
local equipmentNames = {}
local fireflyAmount = 1
local priceLabel = nil
local equipment
local GEODE_AUTO_LOOP_DELAY = 0.01
local currentGeodeIndex = 1
local geodeAutoLoopEnabled = false
local lastGeodeTeleportTime = 0
local geodeTeleportConnection
local currentRuneIndex = 0
local runeAutoLoopEnabled = false
local runeTeleportConnection = nil
local lastRuneTeleportTime = 0
local RUNE_AUTO_LOOP_DELAY = 1

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local BackpackTwo = Player:WaitForChild("BackpackTwo")
local Map = Workspace:WaitForChild("Map")
local waypointFolder = Map:FindFirstChild("Waypoints")

local PanningAnimations = ReplicatedStorage.Assets.Animations.Panning
local Excavations = require(ReplicatedStorage.GameInfo.Excavations)
local CraftingRemotes = ReplicatedStorage.Remotes.Crafting
local StartRemote = ReplicatedStorage.Remotes.Excavation.StartExcavation
local ClaimRemote = ReplicatedStorage.Remotes.Excavation.ClaimExcavation
local UpdateRemote = ReplicatedStorage.Remotes.Excavation.UpdateExcavationData

local function BindCharacter(char)
    Character = char
    LocalCharacter = Characters:WaitForChild(LocalPlayer.Name)
    Humanoid = char:WaitForChild("Humanoid")
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    Animator = Humanoid:WaitForChild("Animator")
    WashAnimation = Animator:LoadAnimation(PanningAnimations.Wash)
end

BindCharacter(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())
LocalPlayer.CharacterAdded:Connect(BindCharacter)

-- Others
local NPCs = Workspace:WaitForChild("NPCs")
local PlaceId = game.PlaceId
local JobId = game.JobId

-- UI
local ToolUI = PlayerGui:WaitForChild("ToolUI")
local FillingPan = ToolUI:WaitForChild("FillingPan")
local FillText = FillingPan:WaitForChild("FillText")

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

local ESP = {
    Players = {},
    Totems = {},
    Connections = {}
}

local CraftingState = {
    selectedEquipment = nil,
    selectedMaterials = {},
    discoveredRecipes = {},
    autocraft = false,
    autocraftRunning = false,
    selectBestOres = false
}

local AutoFarmState = {
    active = false,
    actionMode = "Instant",
    travelMode = "Teleport",
    interrupted = false,
    running = false,
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

local ExcavationState = {
    selected = nil,
    data = nil,
    autoClaim = false,
    waiting = false
}

-- ==================== HELPERS ====================

local function createNotification(content, duration)
    SimpleUI:createNotification({
        Type = "Default",
        Title = "Notification",
        Description = content or "[DEBUG] TEST",
        Duration = duration or 5
    })
end

local function equipPan()
    local Players = SimpleUI:getService("Players")
    local ReplicatedStorage = SimpleUI:getService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

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
        if n >= 10 and n <= 2000 then
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
            isEmpty = true
        }
    end
    local function cleanAndParseNumber(raw, fallback)
        if not raw then
            return fallback
        end
        local cleaned = string.gsub(string.gsub(string.gsub(tostring(raw), ",", ""), " ", ""), "%s+", "")
        if cleaned == "" then
            return fallback
        end
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
        isEmpty = current <= 0
    }
end

local function CollectInvokeServer(collect)
    collect:InvokeServer(1, true)
end

local function getRegion(HumanoidRootPart)
    local PointToRegion = require(ReplicatedStorage.Modules.Location.PointToRegion)
    local region, _ = PointToRegion.GetPanningRegion(HumanoidRootPart.Position)
    return region
end

local function isMerchant(npc)
    local imgPass = false
    local icon = npc:FindFirstChild("IconUI")
    local img = icon and icon:FindFirstChild("ImageLabel")
    if img and img.Image == "rbxassetid://2246496691" then
        imgPass = true
    end
    local objPass = false
    local dialog = npc:FindFirstChild("Dialog")
    if dialog and dialog.ClassName == "ObjectValue" and dialog.Value and dialog.Value.Name == "Seller" then
        objPass = true
    end
    return imgPass and objPass
end

local function getClosestMerchant()
    local char = Players.LocalPlayer.Character
    local playerHrp = char and char:FindFirstChild("HumanoidRootPart")
    if not playerHrp then
        return nil, math.huge
    end

    local closest, closestDist = nil, math.huge

    for _, folder in ipairs(NPCs:GetChildren()) do
        for _, npc in ipairs(folder:GetChildren()) do
            if isMerchant(npc) and npc:FindFirstChild("HumanoidRootPart") then
                local hrp = npc.HumanoidRootPart
                local dist = (playerHrp.Position - hrp.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closest = hrp
                end
            end
        end
    end

    return closest, closestDist
end

local function encodeJSON(value, indentLevel)
    indentLevel = indentLevel or 0
    local indent = string.rep("    ", indentLevel)
    local nextIndent = string.rep("    ", indentLevel + 1)
    if typeof(value) == "table" then
        local isArray = (#value > 0)
        local buffer = {}
        if isArray then
            table.insert(buffer, "[")
            for i, v in ipairs(value) do
                table.insert(buffer, nextIndent .. encodeJSON(v, indentLevel + 1) .. (i < #value and "," or ""))
            end
            table.insert(buffer, indent .. "]")
        else
            table.insert(buffer, "{")
            local keys = {}
            for k in pairs(value) do
                table.insert(keys, k)
            end
            table.sort(keys, function(a, b)
                return tostring(a) < tostring(b)
            end)
            for i, k in ipairs(keys) do
                local v = value[k]
                local keyStr = ("%q"):format(tostring(k))
                local entry = nextIndent .. keyStr .. ": " .. encodeJSON(v, indentLevel + 1)
                if i < #keys then
                    entry = entry .. ","
                end
                table.insert(buffer, entry)
            end
            table.insert(buffer, indent .. "}")
        end
        return table.concat(buffer, "\n")
    elseif typeof(value) == "string" then
        return ("%q"):format(value)
    elseif typeof(value) == "boolean" or typeof(value) == "number" then
        return tostring(value)
    elseif value == nil then
        return "null"
    else
        return ("%q"):format("<unsupported>")
    end
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
    local TweenService = SimpleUI:getService("TweenService")
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
        part.Parent = Workspace
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
        rayParams.FilterDescendantsInstances = {character}
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        local result = Workspace:Raycast(position, Vector3.new(0, -200, 0), rayParams)
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
        rayParams.FilterDescendantsInstances = {character}
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        local checkPoints = math.max(3, math.floor(distance / 10))
        for i = 1, checkPoints do
            local checkPos = start + unit * (distance * i / checkPoints)
            checkPos = Vector3.new(checkPos.X, checkPos.Y + checkHeight, checkPos.Z)
            local directions = {Vector3.new(0, 0, 0), Vector3.new(agentRadius, 0, 0), Vector3.new(-agentRadius, 0, 0),
                                Vector3.new(0, 0, agentRadius), Vector3.new(0, 0, -agentRadius),
                                Vector3.new(0, agentRadius, 0), Vector3.new(0, -agentRadius, 0)}
            for _, dir in pairs(directions) do
                local testPos = checkPos + dir
                local result = Workspace:Raycast(testPos, Vector3.new(0, -checkHeight - 10, 0), rayParams)
                if result and result.Position.Y > testPos.Y - 5 then
                    return true
                end
                local ceilingResult = Workspace:Raycast(testPos, Vector3.new(0, 10, 0), rayParams)
                if ceilingResult and ceilingResult.Position.Y < testPos.Y + 6 then
                    return true
                end
                local forwardRay = Workspace:Raycast(testPos, unit * 10, rayParams)
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
            return {{
                Position = startPos
            }, directWaypoint}
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
                Danger = math.huge
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
        rayParams.FilterDescendantsInstances = {character}
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        local groundResult = Workspace:Raycast(targetPos, Vector3.new(0, -200, 0), rayParams)
        local landingY = groundResult and groundResult.Position.Y + 3 or targetPos.Y
        local hoverPos = Vector3.new(targetPos.X, targetPos.Y + 8, targetPos.Z)
        bp.Position = hoverPos
        task.wait(hoverDuration)
        local finalPos = Vector3.new(targetPos.X, landingY, targetPos.Z)
        local landingTween = TweenService:Create(bp, TweenInfo.new(landingDuration, Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out), {
            Position = finalPos
        })
        local velocityTween = TweenService:Create(bv, TweenInfo.new(landingDuration * 0.8, Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out), {
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
                local color = i == 1 and Color3.new(0, 1, 0) or i == #waypoints and Color3.new(0, 0, 1) or
                                  Color3.new(1, 0.5, 0)
                createDebugWaypoint(waypoint.Position, color, 1.5)
            end
        end
        return waypoints ~= nil
    end
    local function detectObstacles(position, direction, distance)
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {character}
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        local obstacles = {}
        local checkDistance = math.min(distance, 10)
        local rayDirections = {direction, direction:Cross(Vector3.new(0, 1, 0)).Unit * 0.3 + direction * 0.954,
                               direction:Cross(Vector3.new(0, -1, 0)).Unit * 0.3 + direction * 0.954}
        for i, rayDir in pairs(rayDirections) do
            local result = Workspace:Raycast(position, rayDir * checkDistance, rayParams)
            if result and result.Distance > 2 then
                table.insert(obstacles, {
                    position = result.Position,
                    normal = result.Normal,
                    distance = result.Distance,
                    direction = i
                })
            end
        end
        local upwardRay = Workspace:Raycast(position, Vector3.new(0, 10, 0), rayParams)
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
        if #obstacles == 0 then
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
        if currentWaypointIndex <= #waypoints then
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
            if #waypoints == 0 then
                return 0
            end
            return math.min(1, currentWaypointIndex / #waypoints)
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
    local player = LocalPlayer
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
                SimpleUI:createNotification({
                    Type = "Default",
                    Title = "Notification",
                    Description = "Distance is too long, try again while being closer to the target",
                    Duration = 10
                })
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
                if success then
                    break
                end
                local offset = Vector3.new(math.random() * offsetRange - offsetRange / 2, math.random(5, 10),
                    math.random() * offsetRange - offsetRange / 2)
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
            SimpleUI:createNotification({
                Type = "Default",
                Title = "Notification",
                Description = messages.general.noPan,
                Duration = 10
            })
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
            SimpleUI:createNotification({
                Type = "Default",
                Title = "Notification",
                Description = messages.general.noScript,
                Duration = 10
            })
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
                break
            end
            if not isInValidRegion("Deposit") then
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
        pcall(CollectInvokeServer, collectScript)
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
                return "SUCCESS"
            end
            if mode == "Legit" then
                SimpleUI:createNotification({
                    Type = "Default",
                    Title = "Notification",
                    Description = messages.general.legitWIP,
                    Duration = 5
                })
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
        SimpleUI:createNotification({
            Type = "Default",
            Title = "Notification",
            Description = messages.general.invalidAction,
            Duration = 10
        })
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
            LandingDuration = 1.2
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
    local LocalPlayer = LocalPlayer
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
    createNotification("Exiting The Void to find merchant...", 5)
    SimpleUI:createNotification({
        Type = "Default",
        Title = "Notification",
        Description = "Exiting The Void to find merchant...",
        Duration = 5
    })
    HumanoidRootPart.CFrame = CFrame.new(Map.EventStuff["The Void"].Model.ExitPortal.CFrame.Position +
                                             Vector3.new(0, 3, 0))
    local maxWait = tick() + 7
    repeat
        task.wait(0.1)
    until (LocalPlayer:GetAttribute("CurrentArea") == "Fortune River" and LocalPlayer:GetAttribute("GameplayPaused") ==
        false) or tick() > maxWait
    if LocalPlayer:GetAttribute("CurrentArea") ~= "Fortune River" then
        SimpleUI:createNotification({
            Type = "Default",
            Title = "Notification",
            Description = "Failed to exit The Void properly.",
            Duration = 5
        })
        return false
    end
    task.wait(2)
    local closestHrp
    for i = 1, 4 do
        closestHrp = getClosestMerchant()
        if closestHrp then
            break
        end
        if i < 4 then
            task.wait(1)
        end
    end
    if not closestHrp then
        SimpleUI:createNotification({
            Type = "Default",
            Title = "Notification",
            Description = "No merchant found after exiting void.",
            Duration = 5
        })
        HumanoidRootPart.CFrame = CFrame.new(Map.EventStuff.VoidPortal.Part.CFrame.Position + Vector3.new(0, 3, 0))
        return false
    end
    SimpleUI:createNotification({
        Type = "Default",
        Title = "Notification",
        Description = "Found merchant, teleporting and selling..",
        Duration = 5
    })
    local sellSuccess = teleportToTarget(closestHrp.Position, {
        Mode = "Critical",
        FireRemoteFunc = function()
            SimpleUI:createNotification({
                Type = "Default",
                Title = "Notification",
                Description = "Selling all valuables...",
                Duration = 3
            })
            return SimpleUI:getService("ReplicatedStorage").Remotes.Shop.SellAll:InvokeServer()
        end,
        Timeout = 90
    })
    if sellSuccess then
        local success
        task.wait(3)
        SimpleUI:createNotification({
            Type = "Default",
            Title = "Notification",
            Description = "Returning to The Void...",
            Duration = 5
        })
        local voidportal = Map.EventStuff.VoidPortal
        teleportToTarget(voidportal.WorldPivot.Position, {
            Mode = "Standard",
            OnComplete = function(moveSuccess)
                success = moveSuccess or false
            end
        })
        task.wait()
        return success
    end
    return sellSuccess
end

local function executeSell()
    return SimpleUI:getService("ReplicatedStorage").Remotes.Shop.SellAll:InvokeServer()
end

local function sellInventory(config, mode)
    local closestHrp, dist = getClosestMerchant()

    local ServerTime = Workspace:GetServerTimeNow()
    local trialTime = LocalPlayer:GetAttribute("SellAnywhereTrialTime")
    local requiredDistance = config.RequiredDistance or 45

    if LocalPlayer:GetAttribute("SellAnywhere") == true or (trialTime and trialTime + 600 > ServerTime) then
        local itemsSold, _ = executeSell()
        if itemsSold and itemsSold > 0 then
            return true
        end
    end

    if not closestHrp and LocalPlayer:GetAttribute("CurrentArea") == "The Void" then
        return handleVoidSellRequest(config, mode)
    end

    if closestHrp and dist <= requiredDistance then
        executeSell()
        return true
    end

    if not closestHrp then
        SimpleUI:createNotification({
            Type = "Error",
            Title = "Notification",
            Description = "No merchant found nearby.",
            Duration = 5
        })
        return false
    end

    applyDefaults(config, mode)

    if mode == "Tween" then
        local completed = false
        local successSell = false
        config.OnStart = function()
            SimpleUI:createNotification({
                Type = "Default",
                Title = "Notification",
                Description = "Tweening to merchant...",
                Duration = 5
            })
        end
        config.OnComplete = function()
            task.wait(1)
            local _, finalDistance = getClosestMerchant()
            if finalDistance and finalDistance <= requiredDistance then
                executeSell()
                successSell = true
            else
                SimpleUI:createNotification({
                    Type = "Error",
                    Title = "Notification",
                    Description = "Could not reach merchant via tween",
                    Duration = 5
                })
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
        return teleportToTarget(closestHrp, config)
    end
end

local function getInventoryCount()
    local player = SimpleUI:getService("Players").LocalPlayer
    local count = 0

    for _, item in ipairs(player.BackpackTwo:GetChildren()) do
        local t = item:GetAttribute("ItemType")
        if t == "Valuable" or t == "Equipment" then
            count = count + 1
        end
    end

    local character = player.Character
    if character then
        local equipped = character:FindFirstChildOfClass("Tool")
        if equipped then
            local t = equipped:GetAttribute("ItemType")
            if t == "Valuable" or t == "Equipment" then
                count = count + 1
            end
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
    local purchRoot = Workspace:FindFirstChild("Purchasable")
    if not purchRoot then
        return purchasable
    end
    for _, region in ipairs(purchRoot:GetChildren()) do
        for _, item in ipairs(region:GetChildren()) do
            local shopItem = item:FindFirstChild("ShopItem")
            local stats = shopItem and shopItem:FindFirstChild("Stats")
            if shopItem and stats then
                local isShardPrice = shopItem:GetAttribute("Price") == nil and shopItem:GetAttribute("ShardPrice") ~=
                                         nil
                local price = shopItem:GetAttribute(isShardPrice and "ShardPrice" or "Price")
                if price then
                    local formattedEntry = item.Name .. " - " .. formatPrice(price, isShardPrice)
                    if stats:GetAttribute("ShakeSpeed") and not stats:GetAttribute("Duration") then
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
                else
                    for attrName, attrValue in pairs(shopItem:GetAttributes()) do
                        if typeof(attrValue) == "number" and attrName ~= "Price" and attrName ~= "ShardPrice" then
                            local entry = string.format("%s - %d %s", item.Name, attrValue, attrName)
                            table.insert(purchasable.Others, entry)
                            break
                        end
                    end
                end
            end
        end
    end
    return purchasable
end

local ConfirmationPrompt = {}
function ConfirmationPrompt.show(config)
    local Players = SimpleUI:getService("Players")
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
    other = nil
}

local function findModelByName(name)
    for _, folder in pairs(Workspace.Purchasable:GetChildren()) do
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
        SimpleUI:createNotification({
            Type = "Error",
            Title = "Notification",
            Description = "Please select a " .. itemType .. " first!",
            Duration = 5
        })
        return
    end
    local name, rest = selectedOption:match("^(.-)%s*[%-%–—]%s*(.+)$")
    if not name or not rest then
        SimpleUI:createNotification({
            Type = "Error",
            Title = "Notification",
            Description = "Error: Invalid item format!",
            Duration = 5
        })
        return
    end
    local currency, value = rest:match("^([^0-9]+)([%d%.%a]+)$")
    if not currency or not value then
        SimpleUI:createNotification({
            Type = "Error",
            Title = "Notification",
            Description = "Error: Invalid item format!",
            Duration = 5
        })
        return
    end
    local price = currency .. value
    local remote = ReplicatedStorage.Remotes.Shop.BuyItem
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
                SimpleUI:createNotification({
                    Type = "Default",
                    Title = "Notification",
                    Description = "Triggered purchase for " .. name .. " for " .. price .. "!",
                    Duration = 5
                })
                remote:InvokeServer(shopItem)
            else
                SimpleUI:createNotification({
                    Type = "Error",
                    Title = "Notification",
                    Description = "Error: Could not find item or ShopItem!",
                    Duration = 5
                })
            end
        end,
        onCancel = function()
            SimpleUI:createNotification({
                Type = "Info",
                Title = "Notification",
                Description = "Purchase cancelled",
                Duration = 5
            })
        end
    })
end

local storedValues = {}

local function lockCharacterAt(targetCFrame)
    local player = Players.LocalPlayer
    local char = player.Character
    if not char then
        return
    end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        return
    end
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
    if not char then
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local values = storedValues[player.UserId] or {
            WalkSpeed = 16,
            JumpPower = 50
        }
        hum.WalkSpeed = values.WalkSpeed
        hum.JumpPower = values.JumpPower
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        storedValues[player.UserId] = nil
    end
end

local function refreshData()
    if ExcavationState.waiting then
        return
    end
    ExcavationState.waiting = true
    local con
    con = UpdateRemote.OnClientEvent:Connect(function(d)
        ExcavationState.data = d
        ExcavationState.waiting = false
        con:Disconnect()
    end)
    UpdateRemote:FireServer()
end

local function getCurrentExcavationStatus()
    if not ExcavationState.data then
        refreshData()
    end
    repeat
        task.wait()
    until ExcavationState.data
    local d = ExcavationState.data
    local ce = d.CurrentExcavation
    local marker = Workspace:FindFirstChild("Marker")
    if marker then
        local ui = marker:FindFirstChild("UI")
        if ui then
            local n = ui:FindFirstChild("ExcavationName")
            if n and typeof(n.Text) == "string" and n.Text ~= "" then
                return "Finished", n.Text
            end
        end
    end
    if ce and ce ~= "" then
        return "Active", ce
    end
    return "None", nil
end

local function canStartExcavation()
    local status = getCurrentExcavationStatus()
    return status == "None"
end

local function claimExcavation()
    local status, name = getCurrentExcavationStatus()
    if status ~= "Finished" or not name then
        return false
    end
    local ok = ClaimRemote:InvokeServer(name)
    if ok then
        task.wait(2)
        refreshData()
        return true
    end
    return false
end

local function startExcavation()
    if not ExcavationState.selected then
        return false, "No excavation selected."
    end
    local d = ExcavationState.data
    if not d then
        refreshData()
        repeat
            task.wait()
        until ExcavationState.data
        d = ExcavationState.data
    end
    local unlocked = d.UnlockedExcavationSites
    if not table.find(unlocked, ExcavationState.selected) then
        return false, "You haven't unlocked this excavation."
    end
    if not canStartExcavation() then
        if d.CurrentExcavation and d.CurrentExcavation ~= "" then
            return false, "Cannot start — active excavation: " .. d.CurrentExcavation
        else
            return false, "Cannot start — check for unclaimed excavation."
        end
    end
    local ok = StartRemote:InvokeServer(ExcavationState.selected)
    if ok then
        refreshData()
        return true
    end
    return false, "Server rejected the request."
end

local function getExcavationNames()
    local t = {}
    for name in pairs(Excavations.Sites) do
        table.insert(t, name)
    end
    return t
end

local function isGeodeCollected(geode)
    return not geode or not geode.Parent
end

local function getGeodeModels()
    local geodeFolder = Workspace:FindFirstChild("Geode")
    if not geodeFolder then
        return {}
    end
    local geodeModels = {}
    for _, child in pairs(geodeFolder:GetChildren()) do
        if child:IsA("Model") then
            table.insert(geodeModels, child)
        end
    end
    return geodeModels
end

local function getGeodeTeleportPosition(geodeModel)
    local cf, size = geodeModel:GetBoundingBox()
    return cf.Position
end

local function teleportToGeodePosition(position)
    local character = Player.Character
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

local function teleportToNextGeode(geodeStatus)
    local geodeModels = getGeodeModels()

    if #geodeModels == 0 then
        if geodeStatus then
            geodeStatus.setFields({"No geodes found"})
        end
        return false
    end

    if currentGeodeIndex > #geodeModels then
        currentGeodeIndex = 1
    end

    local targetGeode = geodeModels[currentGeodeIndex]

    if isGeodeCollected(targetGeode) then
        currentGeodeIndex = currentGeodeIndex + 1
        return false
    end

    local geodePosition = getGeodeTeleportPosition(targetGeode)

    if teleportToGeodePosition(geodePosition) then
        if geodeStatus then
            geodeStatus.setFields({string.format("Teleported to: %s (%d/%d)", targetGeode.Name, currentGeodeIndex,
                #geodeModels)})
        end
        return true
    else
        if geodeStatus then
            geodeStatus.setFields({"Failed to teleport – Character not found"})
        end
        return false
    end
end

local function getRunes()
    local folder = Map:FindFirstChild("FindableRunes")
    return folder and folder:GetChildren() or {}
end

local function teleportToNextRune(runeStatus)
    local list = getRunes()

    if #list == 0 then
        if runeStatus then
            runeStatus.setFields({"No runes found in workspace"})
        end
        return
    end

    currentRuneIndex = currentRuneIndex + 1
    if currentRuneIndex > #list then
        currentRuneIndex = 1
    end

    local rune = list[currentRuneIndex]
    if not rune or not rune:IsA("Model") then
        if runeStatus then
            runeStatus.setFields({"Invalid rune"})
        end
        return
    end

    local target = rune:FindFirstChild("MainPart")
    if not target or not target:IsA("BasePart") then
        if runeStatus then
            runeStatus.setFields({"Rune has no MainPart"})
        end
        return
    end

    local char = Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then
        if runeStatus then
            runeStatus.setFields({"No HumanoidRootPart"})
        end
        return
    end

    root.CFrame = target.CFrame + Vector3.new(0, 3, 0)

    if runeStatus then
        runeStatus.setFields({string.format("Teleported to rune %d/%d", currentRuneIndex, #list)})
    end
end

local function getModifierNames()
    local t = {}
    for k in pairs(require(ReplicatedStorage.GameInfo.Modifiers)) do
        t[#t + 1] = k
    end
    return t
end

local function getOreNames()
    local t = {}
    for _, obj in ipairs(ReplicatedStorage.Items.Valuables:GetChildren()) do
        t[#t + 1] = obj.Name
    end
    return t
end

local function createBillboard(target, name, color, player)
    local bb = Instance.new("BillboardGui")
    bb.Name = "ESPBillboard"
    bb.Adornee = target
    bb.AlwaysOnTop = true
    bb.StudsOffset = Vector3.new(0, 2.6, 0)
    bb.Size = UDim2.fromOffset(200, 24)
    bb.Parent = target

    local frame = Instance.new("Frame")
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.fromScale(1, 1)
    frame.Parent = bb

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 4)
    padding.PaddingRight = UDim.new(0, 4)
    padding.Parent = frame

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Padding = UDim.new(0, 5)
    layout.Parent = frame

    if player then
        local avatar = Instance.new("ImageLabel")
        avatar.BackgroundTransparency = 1
        avatar.Size = UDim2.fromOffset(16, 16)
        avatar.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size48x48)
        avatar.Parent = frame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = avatar
    end

    local nameLabel = Instance.new("TextLabel")
    nameLabel.BackgroundTransparency = 1
    nameLabel.Font = Enum.Font.GothamSemibold
    nameLabel.TextSize = 13
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.TextColor3 = color or Color3.new(1, 1, 1)
    nameLabel.Text = name
    nameLabel.AutomaticSize = Enum.AutomaticSize.X
    nameLabel.Parent = frame

    local distLabel = Instance.new("TextLabel")
    distLabel.BackgroundTransparency = 1
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextSize = 11
    distLabel.TextXAlignment = Enum.TextXAlignment.Left
    distLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
    distLabel.AutomaticSize = Enum.AutomaticSize.X
    distLabel.Parent = frame

    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not bb.Parent or not target.Parent then
            conn:Disconnect()
            return
        end
        local d = (Camera.CFrame.Position - target.Position).Magnitude
        distLabel.Text = string.format("%dm", d + 0.5)
    end)

    return bb
end

local function getDiscoveredRecipes()
    local discovered = {}
    local discoveredIDs = {}

    local UpdateRemote = ReplicatedStorage.Remotes.Crafting.UpdateDiscoveredEquipment

    local waiting = true
    local conn
    conn = UpdateRemote.OnClientEvent:Connect(function(ids)
        discoveredIDs = ids
        waiting = false
        conn:Disconnect()
    end)

    UpdateRemote:FireServer()

    local timeout = 5
    local elapsed = 0
    while waiting and elapsed < timeout do
        task.wait(0.1)
        elapsed = elapsed + 0.1
    end

    for _, item in ipairs(ReplicatedStorage.Items.Equipment:GetChildren()) do
        if item:GetAttribute("Hidden") then
            local itemID = item:GetAttribute("ItemID")
            if itemID and table.find(discoveredIDs, itemID) then
                local equipData = item:FindFirstChild("EquipmentData")
                if equipData and equipData:IsA("ModuleScript") then
                    local success, data = pcall(require, equipData)
                    if success and data.Materials then
                        table.insert(discovered, {
                            Name = item.Name,
                            Item = item,
                            Data = data
                        })
                    end
                end
            end
        elseif not item:GetAttribute("AdminLimited") and not item:GetAttribute("ChristmasLimited") then
            local equipData = item:FindFirstChild("EquipmentData")
            if equipData and equipData:IsA("ModuleScript") then
                local success, data = pcall(require, equipData)
                if success and data.Materials then
                    table.insert(discovered, {
                        Name = item.Name,
                        Item = item,
                        Data = data
                    })
                end
            end
        end
    end

    table.sort(discovered, function(a, b)
        return a.Name < b.Name
    end)

    return discovered
end

local function getAvailableMaterials(materialName, minWeight)
    local available = {}
    local backpackItems = BackpackTwo:GetChildren()
    local charTool = Character and Character:FindFirstChildOfClass("Tool")

    if charTool then
        table.insert(backpackItems, charTool)
    end

    for _, tool in ipairs(backpackItems) do
        if tool.Name == materialName then
            local itemData = tool:FindFirstChild("ItemData")
            if itemData then
                local weight = itemData:GetAttribute("Weight") or 0
                if weight >= (minWeight or 0) then
                    table.insert(available, tool)
                end
            end
        end
    end

    return available
end

local function compareMaterialQuality(a, b)
    local ModifiersModule = require(ReplicatedStorage.GameInfo.Modifiers)

    local weightA = a:FindFirstChild("ItemData") and a.ItemData:GetAttribute("Weight") or 0
    local weightB = b:FindFirstChild("ItemData") and b.ItemData:GetAttribute("Weight") or 0

    local modifierA = a:FindFirstChild("ItemData") and a.ItemData:GetAttribute("Modifier")
    local modifierB = b:FindFirstChild("ItemData") and b.ItemData:GetAttribute("Modifier")

    if modifierA and ModifiersModule[modifierA] then
        weightA = weightA * ModifiersModule[modifierA].Multiplier
    end

    if modifierB and ModifiersModule[modifierB] then
        weightB = weightB * ModifiersModule[modifierB].Multiplier
    end

    return weightB < weightA
end

local function calculateQuality(materials, recipe)
    local QualityModule = require(ReplicatedStorage.Modules.Inventory.CraftingQuality)
    return QualityModule.DetermineQuality(materials, recipe)
end

local function updateCraftingStatus(craftingStatus)
    if not CraftingState.selectedEquipment then
        craftingStatus.setFields({"No equipment selected", "Select an equipment to begin"})
        return
    end

    local recipe = CraftingState.selectedEquipment.Data
    local fields = {"Equipment: " .. CraftingState.selectedEquipment.Name, "Price: " .. formatPrice(recipe.Price or 0)}

    local allMaterialsAvailable = true

    for materialName, requirements in pairs(recipe.Materials) do
        local selectedCount = CraftingState.selectedMaterials[materialName] and
                                  #CraftingState.selectedMaterials[materialName] or 0
        local required = requirements.Amount
        local available = #getAvailableMaterials(materialName, requirements.MinWeight)

        local status = string.format("%s: %d/%d selected (%d available)", materialName, selectedCount, required,
            available)

        if selectedCount < required then
            allMaterialsAvailable = false
        end

        table.insert(fields, {
            text = status,
            isSubField = true
        })
    end

    local quality = calculateQuality(CraftingState.selectedMaterials, recipe)

    if quality then
        local starDisplay = string.rep("★", quality)
        table.insert(fields, "Quality: " .. starDisplay .. " (" .. quality .. "/5)")

        if quality < 5 then
            table.insert(fields, {
                text = "⚠ Not maximum quality - you can still craft",
                isSubField = true
            })
        end
    else
        table.insert(fields, "Quality: ??? (insufficient materials)")
    end

    if allMaterialsAvailable then
        table.insert(fields, "✅ Ready to craft")
    else
        table.insert(fields, "❌ Missing materials")
    end

    craftingStatus.setFields(fields)
end

local function selectBestMaterials(craftingStatus)
    if not CraftingState.selectedEquipment then
        return
    end

    CraftingState.selectedMaterials = {}

    local recipe = CraftingState.selectedEquipment.Data

    for materialName, requirements in pairs(recipe.Materials) do
        local available = getAvailableMaterials(materialName, requirements.MinWeight)
        table.sort(available, compareMaterialQuality)

        CraftingState.selectedMaterials[materialName] = {}

        for i = 1, math.min(requirements.Amount, #available) do
            table.insert(CraftingState.selectedMaterials[materialName], available[i])
        end
    end

    updateCraftingStatus(craftingStatus)
end

local function canCraft()
    if not CraftingState.selectedEquipment then
        return false
    end

    local recipe = CraftingState.selectedEquipment.Data

    for materialName, requirements in pairs(recipe.Materials) do
        local selectedCount = CraftingState.selectedMaterials[materialName] and
                                  #CraftingState.selectedMaterials[materialName] or 0
        if selectedCount < requirements.Amount then
            return false
        end
    end

    return true
end

local function performCraft(equipmentItem, recipe, materials)
    local CraftRemote = ReplicatedStorage.Remotes.Crafting.CraftEquipment

    local success, result, model, craftedItem, auxData = pcall(function()
        return CraftRemote:InvokeServer(equipmentItem, materials)
    end)

    if not success then
        return false, "Remote call failed"
    end

    if not result then
        return false, "Server rejected craft"
    end

    return true, craftedItem
end

-- ========================= TABS =========================

local MainTab = SimpleUI:createTab(window, "Main", {
    Icon = {
        Image = "rbxassetid://16898613509",
        Size = UDim2.new(0, 16, 0, 16),
        ImageRectSize = Vector2.new(48, 48),
        ImageRectOffset = Vector2.new(771, 759),
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
});
local MainPage = MainTab.page

local TeleportTab = SimpleUI:createTab(window, "Teleport", {
    Icon = {
        Image = "rbxassetid://16898613777",
        Size = UDim2.new(0, 16, 0, 16),
        ImageRectSize = Vector2.new(48, 48),
        ImageRectOffset = Vector2.new(771, 98),
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
})

local TeleportPage = TeleportTab.page

local ToolsTab = SimpleUI:createTab(window, "Tools", {
    Icon = {
        Image = "rbxassetid://16898613044",
        Size = UDim2.new(0, 16, 0, 16),
        ImageRectSize = Vector2.new(48, 48),
        ImageRectOffset = Vector2.new(771, 955),
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
})
local ToolsPage = ToolsTab.page

local CraftingTab = SimpleUI:createTab(window, "Crafting", {
    Icon = {
        Image = "rbxassetid://10723396542",
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
})
local CraftingPage = CraftingTab.page

local FavouriteTab = SimpleUI:createTab(window, "Favourite", {
    Icon = {
        Image = "rbxassetid://10734966248",
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
})
local FavouritePage = FavouriteTab.page

local ShopTab = SimpleUI:createTab(window, "Shop", {
    Icon = {
        Image = "rbxassetid://10734952479",
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
})
local ShopPage = ShopTab.page

local PlayerTab = SimpleUI:createTab(window, "Player", {
    Icon = {
        Image = "rbxassetid://10747373176",
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
})
local PlayerPage = PlayerTab.page

local MiscellaneousTab = SimpleUI:createTab(window, "Miscellaneous", {
    Icon = {
        Image = "rbxassetid://10734963191",
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
})
local MiscellaneousPage = MiscellaneousTab.page

local OthersTab = SimpleUI:createTab(window, "Others", {
    Icon = {
        Image = "rbxassetid://10723404337",
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
})
local OthersPage = OthersTab.page

local SettingsTab = SimpleUI:createTab(window, "SettingsTab", {
    Icon = {
        Image = "rbxassetid://16898613777",
        Size = UDim2.new(0, 16, 0, 16),
        ImageRectSize = Vector2.new(48, 48),
        ImageRectOffset = Vector2.new(771, 257),
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
})
local SettingsPage = SettingsTab.page

-- ========================= MAIN =========================

SimpleUI:createSection(MainTab.page, "Auto Farming")

SimpleUI:createDropdown(MainPage, "Travel Mode", {"Tween", "Teleport"}, "Teleport", function(selection)
    AutoFarmState.travelMode = selection
end, {
    Description = "Teleport is highly recommended here"
})

SimpleUI:createButton(MainPage, "Set Digging location", function()
    if getRegion(HumanoidRootPart) == "Deposit" then
        AutoFarmState.sandCFrame = HumanoidRootPart.CFrame
        SimpleUI:createNotification({
            Type = "Success",
            Title = "Notification",
            Description = "✅ Sand location set",
            Duration = 5
        })
    else
        SimpleUI:createNotification({
            Type = "Error",
            Title = "Notification",
            Description = "❌ Must be at dig location",
            Duration = 5
        })
    end
end, {
    Description = "Stand where you want to dig and then press this button to save the location."
})

SimpleUI:createButton(MainPage, "Set Wash location", function()
    if getRegion(HumanoidRootPart) == "Water" then
        AutoFarmState.waterCFrame = HumanoidRootPart.CFrame
        SimpleUI:createNotification({
            Type = "Success",
            Title = "Notification",
            Description = "✅ Wash location set",
            Duration = 5
        })
    else
        SimpleUI:createNotification({
            Type = "Error",
            Title = "Notification",
            Description = "❌ Must be at wash location",
            Duration = 5
        })
    end
end, {
    Description = "Stand where you want to wash and then press this button to save the location."
})

SimpleUI:createToggle(MainPage, "Auto Farm", false, function(state)
    if state then
        if AutoFarmState.running then
            return
        end

        AutoFarmState.active = true
        AutoFarmState.running = true
        AutoFarmState.interrupted = false

        if not AutoFarmState.travelMode or AutoFarmState.travelMode == "" then
            createNotification("❌ Select travel mode!")
            AutoFarmState.active = false
            AutoFarmState.running = false
            return
        end

        if not AutoFarmState.actionMode or AutoFarmState.actionMode == "" then
            createNotification("❌ Select farming mode!")
            AutoFarmState.active = false
            AutoFarmState.running = false
            return
        end

        if not (AutoFarmState.sandCFrame and AutoFarmState.waterCFrame) then
            createNotification("❌ Set locations!")
            AutoFarmState.active = false
            AutoFarmState.running = false
            return
        end

        createNotification("🚀 Starting!")

        task.spawn(function()
            local function teardown()
                if AutoFarmState.locked then
                    unlockCharacter()
                    AutoFarmState.locked = false
                end

                if TaskManager:getMainTask() == "AutoFarm" then
                    TaskManager:finishTask("AutoFarm")
                end

                TaskManager:clearSubTasks()
                AutoFarmState.running = false
            end

            local function moveToLocation(targetCFrame)
                local completed = false
                local success = false

                local targetObj = {
                    Position = targetCFrame.Position,
                    CFrame = targetCFrame
                }

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
                        OnComplete = function(ok)
                            success = ok or false
                            completed = true
                        end
                    })
                else
                    teleportToTarget(targetObj.Position, {
                        Mode = "Standard",
                        OnComplete = function(ok)
                            success = ok or false
                            completed = true
                        end
                    })
                end

                local elapsed = 0
                while not completed and elapsed < 45 and AutoFarmState.active do
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
                local ok, result = pcall(function()
                    local pan = equipPan()
                    if not pan then
                        return false
                    end

                    if getRegion(HumanoidRootPart) ~= expectedRegion then
                        return false
                    end

                    local killSwitch = function()
                        return AutoFarmState.active
                    end

                    local r = handlePanAction(AutoFarmState.actionMode, actionType, true, killSwitch)
                    return r ~= "MAX_RETRY_FAIL" and r ~= "KILLED"
                end)

                return ok and result
            end

            local function performTask(taskName, nextTask, targetCFrame, actionType, expectedRegion)
                TaskManager:setCurrentTask(taskName)
                TaskManager:setNextTask(nextTask)

                if not moveToLocation(targetCFrame) then
                    return false
                end

                task.wait(0.1)

                if not doAction(actionType, expectedRegion) then
                    return false
                end

                TaskManager:setCurrentTask("AutoFarm")
                return true
            end

            local function checkAndDoSell()
                if not SellSettings.autoSell then
                    return
                end

                local shouldSell = false
                local mode = SellSettings.type or "Threshold"

                if mode == "Threshold" then
                    shouldSell = getInventoryCount() >= (tonumber(SellThreshold) or 50)
                elseif mode == "Time" then
                    shouldSell = SellSettings._scheduledSell or
                                     (os.clock() - (SellSettings._lastSell or 0) >= (tonumber(SellDelay) or 300))
                end

                if shouldSell then
                    if sellInventory({}, SellSettings.mode or "Teleport") then
                        SellSettings._lastSell = os.clock()
                        SellSettings._scheduledSell = false

                        if Players.LocalPlayer and Players.LocalPlayer.Character and
                            Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            lockCharacterAt(Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                            AutoFarmState.locked = true
                        end
                    end
                end
            end

            while AutoFarmState.active do
                local acquired = TaskManager:requestTask("AutoFarm", 1)

                if acquired then
                    local hasTurn = TaskManager:waitForTurn("AutoFarm", 5)

                    if hasTurn then
                        local started = TaskManager:startTask("AutoFarm")

                        if started then
                            while AutoFarmState.active and TaskManager:canRun("AutoFarm") do
                                if AutoFarmState.interrupted then
                                    if AutoFarmState.locked then
                                        unlockCharacter()
                                        AutoFarmState.locked = false
                                    end

                                    while AutoFarmState.interrupted and AutoFarmState.active do
                                        task.wait(0.1)
                                    end
                                end

                                local ok = pcall(function()
                                    local panStatus = getPanStatus()
                                    if not panStatus then
                                        task.wait(0.05)
                                        return
                                    end

                                    checkAndDoSell()

                                    if panStatus.isFull then
                                        if not performTask("MovingToWater", "WashPan", AutoFarmState.waterCFrame,
                                            "Wash", "Water") then
                                            AutoFarmState.active = false
                                        end
                                    else
                                        if not performTask("MovingToSand", "DigSand", AutoFarmState.sandCFrame, "Dig",
                                            "Deposit") then
                                            AutoFarmState.active = false
                                        end
                                    end
                                end)

                                if not ok then
                                    if AutoFarmState.locked then
                                        unlockCharacter()
                                        AutoFarmState.locked = false
                                    end
                                    task.wait(0.05)
                                end

                                task.wait(0.01)
                            end

                            TaskManager:finishTask("AutoFarm")
                        else
                            task.wait(0.1)
                        end
                    end
                else
                    task.wait(0.1)
                end
            end

            teardown()
            createNotification("🛑 Stopped")
        end)
    else
        AutoFarmState.active = false
    end
end)

SimpleUI:createButton(MainPage, "Unstuck Character / Stop tween", function()
    unlockCharacter()
end)

SimpleUI:createButton(MainPage, "Remove Crocodiles", function()
    local crocsFolder = Map and Map:FindFirstChild("Crocodiles")
    if crocsFolder then
        crocsFolder:Destroy()
        createNotification("Crocodiles removed!")
        return
    end
    createNotification("Crocodiles not found, already removed?")
end)

SimpleUI:createSection(MainPage, "Selling")

SimpleUI:createDropdown(MainPage, "Sell Type", {"Threshold", "Duration"}, "Threshold", function(selection)
    SellSettings.type = selection
    createNotification("📌 Sell Type: " .. selection)
end, {
    Description = "Threshold means the minimum items before it sells the inventory & duration means how often to sell inventory"
})

SimpleUI:createTextInput(MainPage, "Enter value", nil, function(input)
    local result, kind = validateSellValue(input)
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
            "❌ Invalid input. Use either Threshold from 10 to 2000 items OR use Time from 30 seconds to 1 day.", 10)
    end
end, {
    Description = "Input Threshold number or Duration number in seconds - for example: 1min 30s would be = 90sec"
})

SimpleUI:createButton(MainPage, "Sell All Inventory", function()
    if TaskManager:getMainTask() then
        return createNotification(
            "Please wait for current task to complete, if something (AutoFarm) is running, turn it off and try this again.",
            5)
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
end)

SimpleUI:createToggle(MainPage, "Auto Sell", false, function(state)
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
                task.wait(5)
            end
        end)
    end
    createNotification(state and "✅ Auto Sell Enabled" or "❌ Auto Sell Disabled")
end)

SimpleUI:createSection(TeleportPage, "Waypoints")

local waypointsTable = {}
if waypointFolder then
    for _, wp in pairs(waypointFolder:GetChildren()) do
        if wp:IsA("Model") then
            table.insert(waypointsTable, wp.Name)
        end
    end
end
local WaypointsDropdown = SimpleUI:createDropdown(TeleportPage, "Select Waypoint", waypointsTable, nil,
    function(selection)
        local attr = LocalPlayer:GetAttribute("CurrentArea")
        local currentWaypoint = nil
        for _, w in pairs(waypointFolder:GetChildren()) do
            if string.find(string.lower(attr), string.lower(w.Name)) then
                currentWaypoint = w
                break
            end
        end
        currentWaypoint = currentWaypoint or waypointFolder["Museum"]
        local targetWaypoint = waypointFolder:FindFirstChild(selection)
        if currentWaypoint and targetWaypoint then
            ReplicatedStorage.Remotes.Misc.FastTravel:FireServer(currentWaypoint, targetWaypoint)
        end
    end, {
        Description = "Refresh waypoints to load locations, only unlocked waypoints are available."
    })

SimpleUI:createButton(TeleportPage, "Refresh waypoints", function()
    local Table = {}
    if waypointFolder then
        for _, wp in pairs(waypointFolder:GetChildren()) do
            if wp:IsA("Model") then
                table.insert(Table, wp.Name)
            end
        end
    end
    WaypointsDropdown.setOptions(Table)
end)

SimpleUI:createButton(TeleportPage, "Unlock all waypoints", function()
    if not fireproximityprompt then
        return SimpleUI:createNotification({
            Title = "Not supported",
            Type = "Error",
            Description = "Your exploit does not support fireproximityprompt",
            Duration = 4
        })
    end
    local waypoints = waypointFolder:GetChildren()
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
            HumanoidRootPart.CFrame = model:GetPivot() + Vector3.new(0, 5, 0)
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
end)

SimpleUI:createButton(TeleportPage, "EMERGENCY TELEPORT", function()
    ReplicatedStorage.Remotes.Misc.FastTravel:FireServer(waypointFolder["Museum"], waypointFolder["Rubble Creek"])
end, {
    Description = "Teleports to Starter Town in cases of emergency"
})

SimpleUI:createSection(TeleportPage, "Geodes")

local geodeStatus = SimpleUI:createParagraph(TeleportPage, "Geode Teleporter", {"Scanning..."})

local geodes = getGeodeModels()
geodeStatus.setFields({#geodes > 0 and ("Found " .. #geodes .. " geodes") or "No geodes found"})

SimpleUI:createButton(TeleportPage, "Teleport to Next Geode", function()
    teleportToNextGeode(geodeStatus)
end)

SimpleUI:createToggle(TeleportPage, "Auto Teleport", false, function(state)
    geodeAutoLoopEnabled = state
    if geodeTeleportConnection then
        geodeTeleportConnection:Disconnect()
        geodeTeleportConnection = nil
    end
    if not state then
        local list = getGeodeModels()
        geodeStatus.setFields({#list > 0 and ("Found " .. #list .. " geodes") or "No geodes found"})
        return
    end
    geodeStatus.setFields({"Auto Teleport: ON"})
    lastGeodeTeleportTime = tick()
    geodeTeleportConnection = RunService.Heartbeat:Connect(function()
        if tick() - lastGeodeTeleportTime >= GEODE_AUTO_LOOP_DELAY then
            teleportToNextGeode(geodeStatus)
            lastGeodeTeleportTime = tick()
        end
    end)
end)

SimpleUI:createSection(TeleportPage, "Runes")

local runeStatus = SimpleUI:createParagraph(TeleportPage, "Rune Tracker", {"Scanning..."})

local runes = getRunes()
runeStatus.setFields({#runes > 0 and ("Found " .. #runes .. " runes") or "No runes found"})

SimpleUI:createButton(TeleportPage, "Teleport to Next Rune", function()
    teleportToNextRune(runeStatus)
end)

SimpleUI:createToggle(TeleportPage, "Auto Teleport", false, function(state)
    runeAutoLoopEnabled = state
    if runeTeleportConnection then
        runeTeleportConnection:Disconnect()
        runeTeleportConnection = nil
    end
    if not state then
        local list = getRunes()
        runeStatus.setFields({#list > 0 and ("Found " .. #list .. " runes") or "No runes found"})
        return
    end
    runeStatus.setFields({"Auto Teleport: ON"})
    lastRuneTeleportTime = tick()
    runeTeleportConnection = RunService.Heartbeat:Connect(function()
        if tick() - lastRuneTeleportTime >= RUNE_AUTO_LOOP_DELAY then
            teleportToNextRune(runeStatus)
            lastRuneTeleportTime = tick()
        end
    end)
end)

SimpleUI:createSection(ToolsPage, "Reforge")

local selectedGUID = nil
local equipmentInfo = SimpleUI:createParagraph(ToolsPage, "Equipment Information", {})

local function safeSetFields(fields)
    pcall(function()
        equipmentInfo.setFields(fields)
    end)
end

local function updateEquipmentInfo(guid)
    if not guid then
        safeSetFields({"No equipment selected"})
        return
    end
    if not BackpackTwo or not BackpackTwo.GetChildren then
        safeSetFields({"Backpack unavailable"})
        return
    end
    local equipment
    for _, child in ipairs(BackpackTwo:GetChildren() or {}) do
        if child and child.GetAttribute and child:GetAttribute("GUID") == guid then
            equipment = child
            break
        end
    end
    if not equipment then
        safeSetFields({"Equipment not found"})
        return
    end
    local fields = {}
    table.insert(fields, "Name: " .. tostring(equipment.Name or "Unknown"))
    local reforges = (equipment:FindFirstChild("ItemData") and equipment.ItemData:GetAttribute("Reforges")) or 0
    table.insert(fields, "Reforges: " .. tostring(reforges))
    local cost
    pcall(function()
        cost = game:GetService("ReplicatedStorage").Remotes.Crafting.GetReforgeCost:InvokeServer(equipment)
    end)
    table.insert(fields, "Price: " .. formatPrice(cost or 0))
    local statRolls
    pcall(function()
        statRolls = equipment:FindFirstChild("StatRolls")
    end)
    if statRolls and statRolls.GetAttributes then
        table.insert(fields, "Stats:")
        local attributes = {}
        pcall(function()
            attributes = statRolls:GetAttributes()
        end)
        for attrName, attrValue in pairs(attributes or {}) do
            table.insert(fields, {
                text = tostring(attrName) .. ": " .. tostring(attrValue),
                isSubField = true
            })
        end
    end
    safeSetFields(fields)
end

local equipmentReforgeDropdown = SimpleUI:createDropdown(ToolsPage, "Select Equipment", {}, nil, function(selection)
    if type(selection) ~= "table" then
        selectedGUID = nil
        updateEquipmentInfo(nil)
        return
    end
    selectedGUID = selection.guid
    updateEquipmentInfo(selectedGUID)
end)

SimpleUI:createButton(ToolsPage, "Refresh Equipment", function()
    local equipmentOptions = {}
    local nameCounts = {}
    if BackpackTwo and BackpackTwo.GetChildren then
        for _, child in ipairs(BackpackTwo:GetChildren() or {}) do
            if child and child.GetAttribute and child:GetAttribute("ItemType") == "Equipment" then
                local baseName = tostring(child.Name or "Unknown")
                nameCounts[baseName] = (nameCounts[baseName] or 0) + 1
                local displayName = baseName
                if nameCounts[baseName] > 1 then
                    displayName = baseName .. " #" .. nameCounts[baseName]
                end
                table.insert(equipmentOptions, {
                    text = displayName,
                    guid = child:GetAttribute("GUID")
                })
            end
        end
    end
    selectedGUID = nil
    pcall(function()
        equipmentReforgeDropdown.setOptions(equipmentOptions)
    end)
    updateEquipmentInfo(nil)
end)

SimpleUI:createButton(ToolsPage, "Reforge Equipment", function()
    if not selectedGUID then
        createNotification("Select an Equipment from your Backpack first!")
        return
    end
    if not BackpackTwo or not BackpackTwo.GetChildren then
        createNotification("Backpack unavailable.")
        return
    end
    local equipment
    for _, child in ipairs(BackpackTwo:GetChildren() or {}) do
        if child and child.GetAttribute and child:GetAttribute("GUID") == selectedGUID then
            equipment = child
            break
        end
    end
    if not equipment then
        createNotification("Selected equipment not found.")
        return
    end
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
        for _, child in ipairs(BackpackTwo:GetChildren() or {}) do
            if child and child.GetAttribute and child:GetAttribute("GUID") == selectedGUID then
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
        createNotification("Reforge succeeded, but updated item not found.")
        return
    end
    pcall(function()
        CraftingRemotes.GetReforgeCost:InvokeServer(newEquipment)
    end)
    updateEquipmentInfo(selectedGUID)
    pcall(function()
        equipmentReforgeDropdown.setOptions({})
    end)
end)

SimpleUI:createSection(ToolsPage, "Pan Enchants")

local selectedMaterial = "Aurorite"
local targetPanEnchant = "Prismatic"
local autoEnchantingPan = {false}

local PanEnchantRemote = ReplicatedStorage.Remotes.Crafting.Enchant
local enchantsModule = require(ReplicatedStorage.GameInfo.Enchants)

local panEnchantNames = {}
for name in pairs(enchantsModule) do
    panEnchantNames[#panEnchantNames + 1] = name
end
table.sort(panEnchantNames)

local function findPanMaterial()
    if not BackpackTwo then
        return nil
    end
    return BackpackTwo:FindFirstChild(selectedMaterial)
end

local function enchantItem(remote, item, itemName)
    local ok, result = pcall(function()
        return remote:InvokeServer(item)
    end)
    if ok then
        createNotification("Successfully enchanted with " .. tostring(result) .. " using " .. itemName, 4)
        return result
    else
        createNotification("Error enchanting " .. itemName, 3)
        return nil
    end
end

local function performAutoEnchant(findFunc, remote, itemName, target, flag)
    task.spawn(function()
        while flag[1] do
            local item = findFunc()
            if not item then
                flag[1] = false
                createNotification("Item not found: " .. itemName, 3)
                break
            end
            local enchant = enchantItem(remote, item, itemName)
            if enchant then
                if enchant == target then
                    flag[1] = false
                    createNotification("Got target enchant: " .. enchant, 5)
                    break
                end
            end
            task.wait(1.5)
        end
    end)
end

SimpleUI:createDropdown(ToolsPage, "Select Material", {{
    text = "Aetherite"
}, {
    text = "Aurorite"
}}, "Aurorite", function(selection)
    if selection and selection.text then
        selectedMaterial = selection.text
    end
end)

SimpleUI:createDropdown(ToolsPage, "Target Enchant", panEnchantNames, nil, function(selection)
    targetPanEnchant = selection
end, {
    Description = "For obvious reasons you cannot get Book-Only enchants"
})

SimpleUI:createButton(ToolsPage, "Enchant Pan", function()
    local match = findPanMaterial()
    if not match then
        createNotification("Material not found: " .. selectedMaterial, 3)
        return
    end
    enchantItem(PanEnchantRemote, match, selectedMaterial)
end)

SimpleUI:createButton(ToolsPage, "Auto Enchant Pan", function()
    if autoEnchantingPan[1] then
        autoEnchantingPan[1] = false
        createNotification("Stopped auto enchanting pan", 2)
        return
    end
    autoEnchantingPan[1] = true
    createNotification("Auto enchanting pan until " .. targetPanEnchant, 3)
    performAutoEnchant(findPanMaterial, PanEnchantRemote, selectedMaterial, targetPanEnchant, autoEnchantingPan)
end)

SimpleUI:createSection(ToolsPage, "Shovel Enchants")

local selectedShovelModifier = "Iridescent"
local targetShovelEnchant = "WellBalanced"
local autoEnchantingShovel = {false}

local ShovelEnchantRemote = ReplicatedStorage.Remotes.Crafting.EnchantShovel
local shovelEnchantsModule = require(ReplicatedStorage.GameInfo.ShovelEnchants)

local shovelEnchantNames = {}
for name in pairs(shovelEnchantsModule) do
    shovelEnchantNames[#shovelEnchantNames + 1] = name
end
table.sort(shovelEnchantNames)

local function findShovelMaterial()
    if not BackpackTwo then
        return nil
    end
    for _, tool in ipairs(BackpackTwo:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == "Aetherite" then
            local itemData = tool:FindFirstChild("ItemData")
            if itemData and itemData:GetAttribute("Modifier") == selectedShovelModifier then
                return tool
            end
        end
    end
    return nil
end

SimpleUI:createDropdown(ToolsPage, "Select Modifier", {{
    text = "Iridescent"
}, {
    text = "Voidtorn"
}, {
    text = "Electrified"
}}, nil, function(sel)
    if sel and sel.text then
        selectedShovelModifier = sel.text
    end
end)

SimpleUI:createDropdown(ToolsPage, "Target Enchant", shovelEnchantNames, nil, function(selection)
    targetShovelEnchant = selection
end)

SimpleUI:createButton(ToolsPage, "Enchant Shovel", function()
    local shovel = findShovelMaterial()
    if not shovel then
        createNotification("Shovel material not found", 3)
        return
    end
    enchantItem(ShovelEnchantRemote, shovel, selectedShovelModifier .. " Aetherite")
end)

SimpleUI:createButton(ToolsPage, "Auto Enchant Shovel", function()
    if autoEnchantingShovel[1] then
        autoEnchantingShovel[1] = false
        createNotification("Stopped auto enchanting shovel", 2)
        return
    end
    autoEnchantingShovel[1] = true
    createNotification("Auto enchanting shovel until " .. targetShovelEnchant, 3)
    performAutoEnchant(findShovelMaterial, ShovelEnchantRemote, selectedShovelModifier .. " Aetherite",
        targetShovelEnchant, autoEnchantingShovel)
end)

SimpleUI:createButton(ToolsPage, "Stop All Enchanting", function()
    if autoEnchantingPan then
        autoEnchantingPan[1] = false
    end
    if autoEnchantingShovel then
        autoEnchantingShovel[1] = false
    end
    createNotification("EMERGENCY STOP - All auto enchanting terminated", 3)
end)

SimpleUI:createSection(FavouritePage, "Favourite")

local selectedModifiers = {}
local selectedOre = nil
local autoFavEnabled = false

local function isLocked(item)
    return item:GetAttribute("Locked") == true
end

local function toggleFavourite(item)
    ReplicatedStorage.Remotes.Inventory.ToggleLock:FireServer(item)
end

local function favouriteItem(item)
    if not isLocked(item) then
        toggleFavourite(item)
    end
end

local function matchesModifier(item, modifier)
    return item:FindFirstChild("ItemData"):GetAttribute("Modifier") == modifier
end

local function matchesOre(item, oreName)
    return item.Name == oreName
end

local function isValuable(item)
    return item:GetAttribute("ItemType") == "Valuable"
end

SimpleUI:createDropdown(FavouritePage, "Select Modifier(s)", getModifierNames(), nil, function(values)
    selectedModifiers = {}
    for _, v in pairs(values or {}) do
        table.insert(selectedModifiers, v)
    end
end, {
    MultiSelect = true
})

SimpleUI:createButton(FavouritePage, "Instant Favourite (Modifier)", function()
    if #selectedModifiers == 0 then
        SimpleUI:createNotification({
            Type = "Warning",
            Title = "No Modifiers Selected",
            Description = "Select at least one modifier first."
        })
        return
    end

    for _, item in pairs(LocalPlayer.BackpackTwo:GetChildren()) do
        for _, modifier in ipairs(selectedModifiers) do
            if isValuable(item) and matchesModifier(item, modifier) then
                favouriteItem(item)
                break
            end
        end
    end

    SimpleUI:createNotification({
        Type = "Success",
        Title = "Completed",
        Description = "Items with selected modifiers were favourited."
    })
end)

SimpleUI:createDropdown(FavouritePage, "Select Ore", getOreNames(), nil, function(value)
    selectedOre = value
end)

SimpleUI:createButton(FavouritePage, "Instant Favourite (Ore)", function()
    if not selectedOre then
        SimpleUI:createNotification({
            Type = "Warning",
            Title = "No Ore Selected",
            Description = "Select an ore first."
        })
        return
    end

    for _, item in pairs(LocalPlayer.BackpackTwo:GetChildren()) do
        if isValuable(item) and matchesOre(item, selectedOre) then
            favouriteItem(item)
        end
    end

    SimpleUI:createNotification({
        Type = "Success",
        Title = "Completed",
        Description = "All matching ores were favourited."
    })
end)

SimpleUI:createButton(FavouritePage, "Favourite Selected Ore with Selected Modifiers", function()
    if not selectedOre or #selectedModifiers == 0 then
        SimpleUI:createNotification({
            Type = "Warning",
            Title = "Selection Incomplete",
            Description = "Select both an ore and at least one modifier."
        })
        return
    end

    for _, item in pairs(LocalPlayer.BackpackTwo:GetChildren()) do
        if isValuable(item) and matchesOre(item, selectedOre) then
            for _, modifier in ipairs(selectedModifiers) do
                if matchesModifier(item, modifier) then
                    favouriteItem(item)
                    break
                end
            end
        end
    end

    SimpleUI:createNotification({
        Type = "Success",
        Title = "Completed",
        Description = "Matching items were favourited."
    })
end)

SimpleUI:createToggle(FavouritePage, "Auto Favourite", false, function(state)
    autoFavEnabled = state
end, {
    Description = "Automatically favourite items as they are obtained."
})

LocalPlayer.BackpackTwo.ChildAdded:Connect(function(item)
    if not autoFavEnabled then
        return
    end
    if not isValuable(item) then
        return
    end

    if selectedOre and #selectedModifiers > 0 then
        if matchesOre(item, selectedOre) then
            for _, modifier in ipairs(selectedModifiers) do
                if matchesModifier(item, modifier) then
                    task.wait(0.1)
                    favouriteItem(item)
                    break
                end
            end
        end
    elseif selectedOre then
        if matchesOre(item, selectedOre) then
            task.wait(0.1)
            favouriteItem(item)
        end
    elseif #selectedModifiers > 0 then
        for _, modifier in ipairs(selectedModifiers) do
            if matchesModifier(item, modifier) then
                task.wait(0.1)
                favouriteItem(item)
                break
            end
        end
    end
end)

SimpleUI:createParagraph(FavouritePage, "Auto Favourite System",
    {"Select Modifier: Choose which modifiers are affected.",
     "Instant Favourite (Modifier): Favourite all items with selected modifiers.", "Select Ore: Choose an ore type.",
     "Instant Favourite (Ore): Favourite all items of that ore.",
     "Favourite Selected Ore with Selected Modifiers: Requires both selections.",
     "Auto Favourite: Automatically favourites newly obtained items based on your selections.", {
        text = "[BETA] Favorite System, full version will take a little time, sorry :_]",
        isSubField = true
    }})

SimpleUI:createSection(CraftingPage, "Equipment Crafting")

local craftingStatus = SimpleUI:createParagraph(CraftingPage, "Crafting Status",
    {"No equipment selected", "Select an equipment to begin"})

local equipmentDropdown = SimpleUI:createDropdown(CraftingPage, "Select Equipment", {}, nil, function(selection)
    for _, recipe in ipairs(CraftingState.discoveredRecipes) do
        if recipe.Name == selection then
            CraftingState.selectedEquipment = recipe
            CraftingState.selectedMaterials = {}
            updateCraftingStatus(craftingStatus)

            if CraftingState.selectBestOres then
                selectBestMaterials(craftingStatus)
            end

            return
        end
    end
end)

SimpleUI:createButton(CraftingPage, "Load Discovered Recipes", function()
    CraftingState.discoveredRecipes = getDiscoveredRecipes()

    local options = {}
    for _, recipe in ipairs(CraftingState.discoveredRecipes) do
        table.insert(options, recipe.Name)
    end

    equipmentDropdown.setOptions(options)

    createNotification("Loaded " .. #options .. " discovered recipes", 3)
end)

SimpleUI:createToggle(CraftingPage, "Select Best Ores", false, function(state)
    CraftingState.selectBestOres = state

    if state and CraftingState.selectedEquipment then
        selectBestMaterials(craftingStatus)
    end
end, {
    Description = "Automatically select highest quality materials when equipment is chosen"
})

SimpleUI:createButton(CraftingPage, "Craft Equipment", function()
    if not canCraft() then
        createNotification("Cannot craft - missing materials or no equipment selected", 4)
        return
    end

    local success, craftedItem = performCraft(CraftingState.selectedEquipment.Item,
        CraftingState.selectedEquipment.Data, CraftingState.selectedMaterials)

    if success then
        createNotification("Successfully crafted " .. CraftingState.selectedEquipment.Name, 4)
        CraftingState.selectedMaterials = {}
        updateCraftingStatus(craftingStatus)

        if CraftingState.selectBestOres then
            task.wait(0.5)
            selectBestMaterials(craftingStatus)
        end
    else
        createNotification("Crafting failed: " .. tostring(craftedItem), 4)
    end
end)

SimpleUI:createToggle(CraftingPage, "Auto Craft", false, function(state)
    CraftingState.autocraft = state

    if not state then
        return
    end

    if CraftingState.autocraftRunning then
        return
    end

    CraftingState.autocraftRunning = true

    task.spawn(function()
        while CraftingState.autocraft do
            if CraftingState.selectedEquipment then
                if CraftingState.selectBestOres then
                    selectBestMaterials(craftingStatus)
                end

                while CraftingState.autocraft and not canCraft() do
                    if CraftingState.selectBestOres then
                        selectBestMaterials(craftingStatus)
                    end

                    updateCraftingStatus(craftingStatus)
                    task.wait(2)
                end

                if CraftingState.autocraft then
                    local success = performCraft(CraftingState.selectedEquipment.Item,
                        CraftingState.selectedEquipment.Data, CraftingState.selectedMaterials)

                    if success then
                        CraftingState.selectedMaterials = {}
                        updateCraftingStatus(craftingStatus)
                        task.wait(1)
                    else
                        task.wait(3)
                    end
                end
            else
                updateCraftingStatus(craftingStatus)
                task.wait(1)
            end
        end

        CraftingState.autocraftRunning = false
    end)

end, {
    Description = "Continuously craft selected equipment when materials are available"
})

SimpleUI:createParagraph(CraftingPage, "About Select Best Ores",
    {"This toggle acts like a two-step verification so you don't accidentally craft, you have to keep it enabled for craft to work"})

SimpleUI:createSection(CraftingPage, "Firefly Flare")

SimpleUI:createTextInput(CraftingPage, "Craft Amount", 1, function(input)
    local value = tonumber(input)

    if not value or value ~= math.floor(value) then
        SimpleUI:createNotification({
            Type = "Error",
            Title = "Invalid Amount",
            Description = "Please enter a natural number."
        })
        return
    end

    if value < 1 or value >= 1000 then
        SimpleUI:createNotification({
            Type = "Warning",
            Title = "Out of Range",
            Description = "Craft amount must be between 1 and 999."
        })
        return
    end

    fireflyAmount = value
end, {
    Description = "The number of Firefly Flares to craft. 1 Firefly Stone = 1 Firefly Flare"
})

local FireflyCrafting = false
local FireflyStopRequested = false

local flareTable = Map:WaitForChild("LushCaverns"):WaitForChild("AbyssAssets"):WaitForChild("FlareTable")

local EquipRemote = ReplicatedStorage.Remotes.CustomBackpack.EquipRemote

SimpleUI:createButton(CraftingPage, "Craft Firefly Flare", function()
    if FireflyCrafting then
        SimpleUI:createNotification({
            Type = "Warning",
            Title = "Already Crafting",
            Description = "Firefly crafting is already running."
        })
        return
    end

    if type(fireflyAmount) ~= "number" or fireflyAmount < 1 or fireflyAmount >= 1000 then
        SimpleUI:createNotification({
            Type = "Error",
            Title = "Invalid Amount",
            Description = "Craft amount must be between 1 and 999."
        })
        return
    end

    local stones = {}
    for _, tool in ipairs(BackpackTwo:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == "Firefly Stone" then
            table.insert(stones, tool)
        end
    end

    if #stones < fireflyAmount then
        SimpleUI:createNotification({
            Type = "Error",
            Title = "Insufficient Materials",
            Description = "Not enough Firefly Stones."
        })
        return
    end

    local prompt = flareTable:FindFirstChild("Prompt", true)
    if not prompt or not fireproximityprompt then
        SimpleUI:createNotification({
            Type = "Error",
            Title = "Executor Unsupported",
            Description = "fireproximityprompt is unavailable."
        })
        return
    end

    if not HumanoidRootPart then
        return
    end

    local distance = (HumanoidRootPart.Position - flareTable:GetPivot().Position).Magnitude
    if distance > 20 then
        SimpleUI:createNotification({
            Type = "Warning",
            Title = "Too Far Away",
            Description = "Go to the Firefly crafting table."
        })
        return
    elseif distance > 10 then
        SimpleUI:createNotification({
            Type = "Info",
            Title = "Get Closer",
            Description = "Move closer to the crafting table."
        })
        return
    end

    prompt.HoldDuration = 0
    FireflyCrafting = true
    FireflyStopRequested = false

    SimpleUI:createNotification({
        Type = "Info",
        Title = "Crafting Started",
        Description = "Crafting Firefly Flares..."
    })

    task.spawn(function()
        for i = 1, fireflyAmount do
            if FireflyStopRequested then
                break
            end
            if not Character or not HumanoidRootPart then
                break
            end

            local currentDistance = (HumanoidRootPart.Position - flareTable:GetPivot().Position).Magnitude
            if currentDistance > 20 then
                break
            end

            local tool = stones[i]
            if not tool or not tool.Parent then
                break
            end

            pcall(function()
                EquipRemote:FireServer(tool)
            end)

            task.wait(0.05)

            pcall(function()
                fireproximityprompt(prompt)
            end)

            task.wait(0.15)
        end

        FireflyCrafting = false
        FireflyStopRequested = false

        SimpleUI:createNotification({
            Type = "Success",
            Title = "Crafting Complete",
            Description = "Firefly crafting process finished."
        })
    end)
end, {
    Description = "Reminder: 1 Firefly Stone = 1 Firefly Flare"
})

SimpleUI:createButton(CraftingPage, "Stop Crafting", function()
    if not FireflyCrafting then
        SimpleUI:createNotification({
            Type = "Info",
            Title = "Idle",
            Description = "No crafting process is running."
        })
        return
    end

    FireflyStopRequested = true

    SimpleUI:createNotification({
        Type = "Warning",
        Title = "Stopping",
        Description = "Stopping Firefly crafting..."
    })
end)

SimpleUI:createParagraph(CraftingPage, "Information", {"You have to be near the firefly crafting table to convert."})

SimpleUI:createSection(ShopPage, "Buy items LIKE A BOSS")

SimpleUI:createButton(ShopPage, "Open amazong", function()
    amazong:Toggle()
end)

SimpleUI:createSection(ShopPage, "Buy items")

local selectedOptions = {}

SimpleUI:createDropdown(ShopPage, "Select Pan", buildPurchasableTable().Pans, nil, function(opt)
    selectedOptions.pan = opt
end)

SimpleUI:createButton(ShopPage, "Buy Pan", function()
    handlePurchase("pan", selectedOptions.pan)
end)

SimpleUI:createDropdown(ShopPage, "Select Shovel", buildPurchasableTable().Shovels, nil, function(opt)
    selectedOptions.shovel = opt
end)

SimpleUI:createButton(ShopPage, "Buy Shovel", function()
    handlePurchase("shovel", selectedOptions.shovel)
end)

SimpleUI:createDropdown(ShopPage, "Select Sluice", buildPurchasableTable().Sluices, nil, function(opt)
    selectedOptions.sluice = opt
end)

SimpleUI:createButton(ShopPage, "Buy Sluice", function()
    handlePurchase("sluice", selectedOptions.sluice)
end)

SimpleUI:createDropdown(ShopPage, "Select Potion", buildPurchasableTable().Potions, nil, function(opt)
    selectedOptions.potion = opt
end)

SimpleUI:createButton(ShopPage, "Buy Potion", function()
    handlePurchase("potion", selectedOptions.potion)
end)

SimpleUI:createDropdown(ShopPage, "Select Totem", buildPurchasableTable().Totems, nil, function(opt)
    selectedOptions.totem = opt
end)

SimpleUI:createButton(ShopPage, "Buy Totem", function()
    handlePurchase("totem", selectedOptions.totem)
end)

SimpleUI:createDropdown(ShopPage, "Select Others", buildPurchasableTable().Others, nil, function(opt)
    selectedOptions.other = opt
end)

SimpleUI:createButton(ShopPage, "Buy Others", function()
    handlePurchase("others", selectedOptions.other)
end)

SimpleUI:createSection(PlayerPage, "Humanoid")

local jumpPower = Humanoid.JumpPower or 50
local walkSpeedValue = Humanoid and Humanoid.WalkSpeed or 16

SimpleUI:createSlider(PlayerPage, "Walk Speed", 0, 100, walkSpeedValue, function(val)
    pcall(function()
        walkSpeedValue = val
        if Humanoid then
            Humanoid.WalkSpeed = val
        end
    end)
end)

if Humanoid then
    Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if Humanoid.WalkSpeed ~= walkSpeedValue then
            Humanoid.WalkSpeed = walkSpeedValue
        end
    end)
end

SimpleUI:createSlider(PlayerPage, "Jump Power", 1, 100, jumpPower, function(val)
    pcall(function()
        jumpPower = val
        if Humanoid then
            Humanoid.UseJumpPower = true
            Humanoid.JumpPower = val
        end
    end)
end)

if Humanoid then
    Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
        if Humanoid.JumpPower ~= jumpPower then
            Humanoid.UseJumpPower = true
            Humanoid.JumpPower = jumpPower
        end
    end)
end

SimpleUI:createSlider(PlayerPage, "Adjust FOV", 30, 120, Camera.FieldOfView, function(value)
    Camera.FieldOfView = value
end, {
    Increment = 1
})

local fogDensity = 0.1
local atmosphere = Lighting:FindFirstChildWhichIsA("Atmosphere") or Instance.new("Atmosphere", Lighting)
RunService.RenderStepped:Connect(function()
    if atmosphere then
        atmosphere.Density = math.clamp(fogDensity, 0, 1)
    end
end)
SimpleUI:createSlider(PlayerPage, "Fog Density", 0.30, 1, 0.40, function(value)
    fogDensity = value
end, {
    Increment = 0.01
})

SimpleUI:createSection(PlayerPage, "ESP")

SimpleUI:createToggle(PlayerPage, "Players ESP", false, function(enabled)
    if enabled then
        local function attachESP(plr)
            if plr == LocalPlayer then
                return
            end

            local char = plr.Character
            if not char then
                return
            end

            local head = char:FindFirstChild("Head")
            if not head then
                return
            end

            if ESP.Players[plr] then
                ESP.Players[plr]:Destroy()
            end

            ESP.Players[plr] = createBillboard(head, plr.Name, Color3.fromRGB(255, 255, 255), plr)
        end

        local function hookPlayer(plr)
            if plr == LocalPlayer then
                return
            end

            if plr.Character then
                attachESP(plr)
            end

            ESP.Connections["Char_" .. plr.UserId] = plr.CharacterAdded:Connect(function()
                attachESP(plr)
            end)

            plr.CharacterRemoving:Connect(function()
                if ESP.Players[plr] then
                    ESP.Players[plr]:Destroy()
                    ESP.Players[plr] = nil
                end
            end)
        end

        for _, plr in ipairs(Players:GetPlayers()) do
            hookPlayer(plr)
        end

        ESP.Connections.PlayerAdded = Players.PlayerAdded:Connect(hookPlayer)

        ESP.Connections.PlayerRemoving = Players.PlayerRemoving:Connect(function(plr)
            if ESP.Players[plr] then
                ESP.Players[plr]:Destroy()
                ESP.Players[plr] = nil
            end

            local conn = ESP.Connections["Char_" .. plr.UserId]
            if conn then
                conn:Disconnect()
                ESP.Connections["Char_" .. plr.UserId] = nil
            end
        end)
    else
        for _, bb in pairs(ESP.Players) do
            if bb then
                bb:Destroy()
            end
        end

        for _, conn in pairs(ESP.Connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end

        ESP.Players = {}
        ESP.Connections = {}
    end
end)

SimpleUI:createToggle(PlayerPage, "Totems ESP", false, function(enabled)
    local folder = workspace:FindFirstChild("ActiveTotems")
    if not folder then
        return
    end

    if enabled then
        local function addTotem(model)
            if model:IsA("Model") then
                local part = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
                if part then
                    local color = model:GetAttribute("NameColor")
                    if typeof(color) ~= "Color3" then
                        color = Color3.fromRGB(150, 200, 255)
                    end
                    local bb = createBillboard(part, model.Name, color)
                    ESP.Totems[model] = bb
                end
            end
        end

        for _, m in ipairs(folder:GetChildren()) do
            addTotem(m)
        end

        ESP.Connections.TotemAdded = folder.ChildAdded:Connect(addTotem)
        ESP.Connections.TotemRemoved = folder.ChildRemoved:Connect(function(m)
            if ESP.Totems[m] then
                ESP.Totems[m]:Destroy()
                ESP.Totems[m] = nil
            end
        end)
    else
        for _, v in pairs(ESP.Totems) do
            v:Destroy()
        end
        if ESP.Connections.TotemAdded then
            ESP.Connections.TotemAdded:Disconnect()
        end
        if ESP.Connections.TotemRemoved then
            ESP.Connections.TotemRemoved:Disconnect()
        end
        ESP.Totems = {}
    end
end)

SimpleUI:createButton(PlayerPage, "Clear All ESP", function()
    local function clearFromFolder(folder)
        if not folder then
            return
        end
        for _, obj in ipairs(folder:GetDescendants()) do
            if obj:IsA("BillboardGui") and obj.Name == "ESPBillboard" then
                obj:Destroy()
            end
        end
    end

    clearFromFolder(workspace:FindFirstChild("ActiveTotems"))
    clearFromFolder(workspace:FindFirstChild("Characters"))

    for _, bb in pairs(ESP.Players or {}) do
        if bb and bb.Parent then
            bb:Destroy()
        end
    end
    ESP.Players = {}

    for _, bb in pairs(ESP.Totems or {}) do
        if bb and bb.Parent then
            bb:Destroy()
        end
    end
    ESP.Totems = {}

    for _, conn in pairs(ESP.Connections or {}) do
        if typeof(conn) == "RBXScriptConnection" then
            conn:Disconnect()
        end
    end
    ESP.Connections = {}

    if ESP.Toggles then
        ESP.Toggles.Players = false
        ESP.Toggles.Totems = false
    end
end)

SimpleUI:createSection(MiscellaneousPage, "Excavation")

local excavationStatus = SimpleUI:createParagraph(MiscellaneousPage, "Excavation Status", {"Idle", "No site selected"})

SimpleUI:createDropdown(MiscellaneousPage, "Select Excavation", getExcavationNames(), nil, function(s)
    ExcavationState.selected = s
    excavationStatus.setFields({"Status: Ready", "Selected: " .. tostring(s)})
end)

SimpleUI:createButton(MiscellaneousPage, "Start Excavation", function()
    if not ExcavationState.selected then
        excavationStatus.setFields({"Status: Error", "No excavation selected"})
        return
    end
    local ok, msg = startExcavation()
    if ok then
        excavationStatus.setFields({"Status: Running", "Site: " .. ExcavationState.selected})
    else
        excavationStatus.setFields({"Status: Failed", tostring(msg)})
    end
end)

SimpleUI:createToggle(MiscellaneousPage, "Auto Claim", true, function(state)
    ExcavationState.autoClaim = state
    excavationStatus.setFields({"Status: " .. (state and "Auto-Claim Enabled" or "Auto-Claim Disabled"),
                                "Site: " .. tostring(ExcavationState.selected)})
    if not state then
        return
    end
    task.spawn(function()
        while ExcavationState.autoClaim do
            if getCurrentExcavationStatus() == "Finished" then
                claimExcavation()
            end
            task.wait(1)
        end
    end)
end)

SimpleUI:createButton(MiscellaneousPage, "View Item Chances", function()
    if not ExcavationState.selected then
        excavationStatus.setFields({"Status: Error", "Select an excavation first"})
        return
    end
    local site = Excavations.Sites[ExcavationState.selected]
    if not site then
        excavationStatus.setFields({"Status: Error", "Invalid excavation site"})
        return
    end
    local total = 0
    for _, w in pairs(site.Weights) do
        total = total + w
    end
    local drops = {}
    for name, w in pairs(site.Weights) do
        table.insert(drops, {
            name = name,
            chance = (w / total) * 100
        })
    end
    table.sort(drops, function(a, b)
        return a.chance > b.chance
    end)
    local lines = {"Site: " .. site.Name, "Geode: " .. site.GeodeType,
                   "Items: " .. site.MinItems .. " - " .. site.MaxItems, "Duration: " .. (site.Duration / 3600) .. "h",
                   "Unlock Cost: " .. site.UnlockCost, "Start Cost: " .. site.StartCost, "", "Drop Rates:"}
    for _, d in ipairs(drops) do
        table.insert(lines, string.format("• %s — %.2f%%", d.name, d.chance))
    end
    SimpleUI:createPopup("ExcavationPopup", {
        title = "Excavation Info",
        text = table.concat(lines, "\n")
    })

end)

SimpleUI:createSection(MiscellaneousPage, "Remove Barriers")

SimpleUI:createButton(MiscellaneousPage, "Remove Vines", function()
    local vines = Map and Map:FindFirstChild("LushCaverns") and Map.LushCaverns:FindFirstChild("Vines")
    if vines then
        vines:Destroy()
    end
end, {
    Description = "Removes vines in Deeproot Area"
})

SimpleUI:createButton(MiscellaneousPage, "Remove Abyssal Gate", function()
    local abyssAssets = Map and Map:FindFirstChild("LushCaverns") and Map.LushCaverns:FindFirstChild("AbyssAssets")
    local gate = abyssAssets and abyssAssets:FindFirstChild("Gate")
    if gate then
        gate:Destroy()
    end
end, {
    Description = "Removes the 25,000 items barrier in Abyssal Depths"
})

SimpleUI:createButton(MiscellaneousPage, "Remove Mountain Block", function()
    local mountains = Map and Map:FindFirstChild("Mountains")
    local added = mountains and mountains:FindFirstChild("Added")
    local gateBlock = added and added:FindFirstChild("GateBlockScript") and
                          added.GateBlockScript:FindFirstChild("GateBlockage")
    if gateBlock then
        gateBlock:Destroy()
    end
end, {
    Description = "Removes the big final rock to reach the summit peak"
})

SimpleUI:createSection(OthersPage, "Server")

SimpleUI:createToggle(OthersPage, "Anti-AFK", true, function(state)
    local GC = getconnections or get_signal_cons
    if state then
        if GC then
            for _, c in pairs(GC(LocalPlayer.Idled)) do
                if c.Disable then
                    c:Disable()
                end
                if c.Disconnect then
                    c:Disconnect()
                end
            end
        else
            local VirtualUser = cloneref and cloneref(game:GetService("VirtualUser")) or game:GetService("VirtualUser")
            getgenv().AntiAFKConnection = LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    else
        if getgenv().AntiAFKConnection then
            getgenv().AntiAFKConnection:Disconnect()
            getgenv().AntiAFKConnection = nil
        end
    end
end)

SimpleUI:createButton(OthersPage, "Rejoin Server", function()
    if #Players:GetPlayers() <= 1 then
        LocalPlayer:Kick("Rejoining...")
        task.wait()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
end)

SimpleUI:createButton(OthersPage, "Server Hop", function()
    local servers = {}
    local req = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId ..
                                                        "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true"))

    for _, v in pairs(req.data or {}) do
        if v.id ~= game.JobId and v.playing < v.maxPlayers then
            table.insert(servers, v.id)
        end
    end

    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(#servers)], LocalPlayer)
    else
        createNotification("No available servers found", 4)
    end
end)

SimpleUI:createSection(OthersPage, "User Interface")

if SimpleUI:isMobile() then
    local TweenService = (SimpleUI and SimpleUI.getService) and SimpleUI:getService("TweenService")
    local UserInputService = (SimpleUI and SimpleUI.getService) and SimpleUI:getService("UserInputService")

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
    toggleButton.Parent = window.SimpleGUI

    local dragging = false
    local dragStart, startPos
    local hasMoved = false
    local normalSize = UDim2.new(0, 40, 0, 40)
    local pressSize = UDim2.new(0, 50, 0, 50)
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

    if toggleButton and TweenService then
        toggleButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
                TweenService:Create(toggleButton, tweenInfo, {
                    Size = normalSize
                }):Play()
                if not hasMoved then
                    if window.isVisible() then
                        window.hide()
                    else
                        window.show()
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
                    toggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale,
                        startPos.Y.Offset + delta.Y)
                end
            end
        end)
    end
else
    SimpleUI:createKeybind(OthersPage, "UI visibility keybind", Enum.KeyCode.Q, function(key)
        window.toggle()
    end)
end

local inventory = game:GetService("Players").LocalPlayer.PlayerGui.BackpackGui.Backpack.Inventory
local scrollingFrame = inventory.ScrollingFrame
local gridFrame = scrollingFrame.UIGridFrame

local FilterPanelToggle = SimpleUI:createToggle(OthersPage, "Enable Inventory Filter", true, function(state)
    local existingPanel = inventory:FindFirstChild("FilterPanel")
    if existingPanel then
        existingPanel:Destroy()
        task.wait()
    end

    if not state then
        return
    end

    local filterPanel = Instance.new("Frame")
    filterPanel.Name = "FilterPanel"
    filterPanel.Parent = inventory
    filterPanel.AnchorPoint = Vector2.new(0, 0)
    filterPanel.Position = UDim2.new(1, 0.02, 0, -30)
    filterPanel.Size = UDim2.new(0.22, 0, 1.08, 0)
    filterPanel.BackgroundTransparency = 1
    filterPanel.BorderSizePixel = 0

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 0)
    padding.PaddingBottom = UDim.new(0.04, 0)
    padding.PaddingLeft = UDim.new(0.06, 0)
    padding.PaddingRight = UDim.new(0.06, 0)
    padding.Parent = filterPanel

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0.018, 0)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = filterPanel

    local fontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold,
        Enum.FontStyle.Italic)

    local title = Instance.new("TextLabel")
    title.Name = "CurrentFilter"
    title.Parent = filterPanel
    title.Size = UDim2.new(1, 0, 0.16, 0)
    title.BackgroundTransparency = 1
    title.Text = "Filter: All Items"
    title.TextWrapped = true
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextYAlignment = Enum.TextYAlignment.Center
    title.FontFace = fontFace
    title.TextScaled = true
    title.LineHeight = 1
    title.TextColor3 = Color3.fromRGB(245, 245, 245)
    title.LayoutOrder = 1

    local titleStroke = Instance.new("UIStroke")
    titleStroke.Color = Color3.fromRGB(0, 0, 0)
    titleStroke.Thickness = 1
    titleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    titleStroke.Parent = title

    local function createFilterButton(text, color, order)
        local button = Instance.new("TextButton")
        button.Name = text .. "Filter"
        button.Parent = filterPanel
        button.Size = UDim2.new(1, 0, 0.075, 0)
        button.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
        button.BorderSizePixel = 0
        button.Text = text
        button.FontFace = fontFace
        button.TextScaled = true
        button.LineHeight = 1
        button.TextColor3 = color
        button.AutoButtonColor = false
        button.LayoutOrder = order

        local stroke = Instance.new("UIStroke")
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Color = color
        stroke.Thickness = 1
        stroke.Parent = button

        return button
    end

    local FILTER_BUTTONS = {{"Ores", Color3.fromRGB(190, 190, 190)}, {"Equipments", Color3.fromRGB(255, 90, 90)},
                            {"Totems/Relics", Color3.fromRGB(120, 220, 120)}, {"Geodes", Color3.fromRGB(90, 170, 255)},
                            {"Maps", Color3.fromRGB(200, 160, 255)}, {"Others", Color3.fromRGB(200, 120, 255)},
                            {"All Items", Color3.fromRGB(245, 245, 245)}}

    local ICON_CATEGORY = {
        ["rbxassetid://71590406800942"] = "Equipments",
        ["rbxassetid://128090935503267"] = "Equipments",
        ["rbxassetid://95192688083586"] = "Equipments",
        ["rbxassetid://84287308918508"] = "Ores",
        ["rbxassetid://18624930841"] = "Totems/Relics",
        ["rbxassetid://6947202399"] = "Totems/Relics",
        ["rbxassetid://9019175526"] = "Geodes",
        ["rbxassetid://8360687671"] = "Maps"
    }

    local connections = {}
    local itemCache = {}
    local currentFilter = "All Items"
    local isUpdating = false
    local filterChanged = false

    local PADDING = 10
    local originalCanvasSize = scrollingFrame.CanvasSize

    local function getCategory(button)
        local icon = button:FindFirstChild("TypeIcon")
        if icon and icon:IsA("ImageLabel") then
            return ICON_CATEGORY[icon.Image] or "Others"
        end
        return "Others"
    end

    local function cacheItem(button)
        if not itemCache[button] then
            itemCache[button] = {
                pos = button.Position,
                vis = button.Visible,
                cat = getCategory(button)
            }
        end
        return itemCache[button]
    end

    local function getAllItems()
        local items = {}
        for _, child in ipairs(gridFrame:GetChildren()) do
            if child:IsA("TextButton") then
                table.insert(items, child)
            end
        end
        return items
    end

    local function calculateLayout(visibleItems)
        if #visibleItems == 0 then
            return 0
        end

        local firstItem = visibleItems[1]
        local itemWidth = firstItem.AbsoluteSize.X
        local itemHeight = firstItem.AbsoluteSize.Y
        local frameWidth = gridFrame.AbsoluteSize.X

        local cols = math.max(1, math.floor((frameWidth + PADDING) / (itemWidth + PADDING)))
        local rows = math.ceil(#visibleItems / cols)

        for i, item in ipairs(visibleItems) do
            local row = math.floor((i - 1) / cols)
            local col = (i - 1) % cols
            item.Position = UDim2.fromOffset(col * (itemWidth + PADDING), row * (itemHeight + PADDING))
        end

        return rows * (itemHeight + PADDING)
    end

    local function applyFilter(filter)
        if isUpdating then
            return
        end
        isUpdating = true

        local savedScroll = scrollingFrame.CanvasPosition
        currentFilter = filter
        local items = getAllItems()

        if filter == "All Items" then
            for _, item in ipairs(items) do
                local cached = itemCache[item]
                if cached then
                    item.Visible = cached.vis
                    item.Position = cached.pos
                else
                    item.Visible = true
                end
            end
            scrollingFrame.CanvasSize = originalCanvasSize
        else
            local visible = {}
            for _, item in ipairs(items) do
                local cached = cacheItem(item)
                if cached.cat == filter then
                    item.Visible = true
                    table.insert(visible, item)
                else
                    item.Visible = false
                end
            end
            local canvasHeight = calculateLayout(visible)
            scrollingFrame.CanvasSize = UDim2.fromOffset(0, canvasHeight)
        end

        if filterChanged then
            scrollingFrame.CanvasPosition = Vector2.zero
            filterChanged = false
        else
            scrollingFrame.CanvasPosition = savedScroll
        end

        isUpdating = false
    end

    local debounce = false
    local function onItemsChanged(child)
        if debounce then
            return
        end
        if not child:IsA("TextButton") then
            return
        end
        debounce = true
        task.wait(0.05)
        for _, item in ipairs(getAllItems()) do
            cacheItem(item)
        end
        applyFilter(currentFilter)
        debounce = false
    end

    for _, item in ipairs(getAllItems()) do
        cacheItem(item)
    end

    for i, data in ipairs(FILTER_BUTTONS) do
        local text, color = data[1], data[2]
        local button = createFilterButton(text, color, i + 1)

        table.insert(connections, button.MouseButton1Click:Connect(function()
            filterChanged = true
            title.Text = "Filter: " .. text
            applyFilter(text)
        end))

        table.insert(connections, button.MouseEnter:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end))

        table.insert(connections, button.MouseLeave:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
        end))
    end

    table.insert(connections, gridFrame.ChildAdded:Connect(onItemsChanged))
    table.insert(connections, gridFrame.ChildRemoved:Connect(onItemsChanged))

    table.insert(connections, filterPanel.Destroying:Connect(function()
        for _, conn in ipairs(connections) do
            if conn.Connected then
                conn:Disconnect()
            end
        end
        table.clear(connections)
        table.clear(itemCache)
    end))
end)

SimpleUI:createSlider(SettingsPage, "UI Scale", 0.5, 2, window.getScale(), function(value)
    window.setScale(value, true)
end, {
    Increment = 0.001
})

local themes = {}
for name in pairs(SimpleUI.Themes) do
    themes[#themes + 1] = name
end

SimpleUI:createDropdown(SettingsPage, "Set Theme", themes, nil, function(val)
    window:setTheme(val, true)
end, {
    Description = "Choose from " .. (#themes > 0 and #themes or "a variety of") .. " themes"
})