local cloneref = cloneref or function(obj) return obj end

local function getServiceSafe(serviceName)
    return cloneref(game:GetService(serviceName))
end

local virtualUser = getServiceSafe("VirtualUser")
local runService = getServiceSafe("RunService")
local tweenService = getServiceSafe("TweenService")
local userInputService = getServiceSafe("UserInputService")

local camera = cloneref(workspace.CurrentCamera)
local simulator = {}

local activeOps = {}
local operationCounter = 0
local connections = {}
local randomGen = Random.new(tick())

local config = {
    defaultDragDuration = 0.3,
    defaultHoldDuration = 0.5,
    defaultDoubleClickDelay = 0.1,
    defaultPatternInterval = 0.1,
    minDuration = 0.01,
    minDragDuration = 0.05,
    defaultCircleRadius = 50,
    minCircleRadius = 5,
    defaultCircleDuration = 1.0,
    minCircleDuration = 0.1
}

local function generateOperationId()
    operationCounter = operationCounter + 1
    return operationCounter
end

local function addHumanNoise(value, noiseFactor)
    noiseFactor = noiseFactor or 0.02
    return value + (randomGen:NextNumber(-noiseFactor, noiseFactor) * value)
end

local function addHumanDelay()
    task.wait(randomGen:NextNumber(0.001, 0.005))
end

local function validatePosition(position)
    if not position then 
        return camera.ViewportSize * 0.5 
    end
    
    if typeof(position) ~= "Vector2" then
        return camera.ViewportSize * 0.5
    end
    
    local viewport = camera.ViewportSize
    local xOffset = randomGen:NextNumber(-2, 2)
    local yOffset = randomGen:NextNumber(-2, 2)
    
    return Vector2.new(
        math.clamp(position.X + xOffset, 0, viewport.X),
        math.clamp(position.Y + yOffset, 0, viewport.Y)
    )
end

local function isValidOperation(operationId)
    return activeOps[operationId] ~= nil
end

local function cleanupOperation(operationId)
    if connections[operationId] then
        local connection = connections[operationId]
        if connection and typeof(connection) == "RBXScriptConnection" then
            connection:Disconnect()
        end
        connections[operationId] = nil
    end
    activeOps[operationId] = nil
end

local function safeExecute(func, ...)
    local success, result = pcall(func, ...)
    if success then
        addHumanDelay()
        return result
    end
    return nil
end

function simulator:mouseDown(position)
    position = validatePosition(position)
    safeExecute(function()
        local vuRef = cloneref(virtualUser)
        local camRef = cloneref(camera)
        if vuRef and camRef then
            vuRef:Button1Down(position, camRef.CFrame)
        end
    end)
    return self
end

function simulator:mouseUp(position)
    position = validatePosition(position)
    safeExecute(function()
        local vuRef = cloneref(virtualUser)
        local camRef = cloneref(camera)
        if vuRef and camRef then
            vuRef:Button1Up(position, camRef.CFrame)
        end
    end)
    return self
end

function simulator:moveMouse(position)
    position = validatePosition(position)
    safeExecute(function()
        local vuRef = cloneref(virtualUser)
        if vuRef then
            vuRef:SetMousePos(position.X, position.Y)
        end
    end)
    return self
end

function simulator:click(position)
    local clickDelay = addHumanNoise(0.016)
    self:mouseDown(position)
    task.wait(clickDelay)
    self:mouseUp(position)
    return self
end

function simulator:rightClick(position)
    position = validatePosition(position)
    safeExecute(function()
        local vuRef = cloneref(virtualUser)
        local camRef = cloneref(camera)
        if vuRef and camRef then
            vuRef:Button2Down(position, camRef.CFrame)
            task.wait(addHumanNoise(0.016))
            vuRef:Button2Up(position, camRef.CFrame)
        end
    end)
    return self
end

function simulator:doubleClick(position, delay)
    delay = math.max(delay or config.defaultDoubleClickDelay, config.minDuration)
    delay = addHumanNoise(delay)
    self:click(position)
    task.wait(delay)
    self:click(position)
    return self
end

function simulator:hold(position, duration)
    duration = math.max(duration or config.defaultHoldDuration, config.minDuration)
    duration = addHumanNoise(duration)
    self:mouseDown(position)
    task.wait(duration)
    self:mouseUp(position)
    return self
end

function simulator:drag(startPos, endPos, duration, easingStyle, easingDirection)
    startPos = validatePosition(startPos)
    endPos = validatePosition(endPos)
    duration = math.max(duration or config.defaultDragDuration, config.minDragDuration)
    duration = addHumanNoise(duration)
    easingStyle = easingStyle or Enum.EasingStyle.Sine
    easingDirection = easingDirection or Enum.EasingDirection.Out
    
    local operationId = generateOperationId()
    activeOps[operationId] = true
    
    self:mouseDown(startPos)
    local startTime = tick()
    
    local rsRef = cloneref(runService)
    connections[operationId] = rsRef.Heartbeat:Connect(function()
        if not isValidOperation(operationId) then
            cleanupOperation(operationId)
            return
        end
        
        local elapsed = tick() - startTime
        local progress = math.min(elapsed / duration, 1)
        local tsRef = cloneref(tweenService)
        local alpha = tsRef:GetValue(progress, easingStyle, easingDirection)
        
        local currentPosition = startPos:Lerp(endPos, alpha)
        local xNoise = randomGen:NextNumber(-0.5, 0.5)
        local yNoise = randomGen:NextNumber(-0.5, 0.5)
        currentPosition = Vector2.new(currentPosition.X + xNoise, currentPosition.Y + yNoise)
        
        self:moveMouse(currentPosition)
        
        if progress >= 1 then
            self:mouseUp(endPos)
            cleanupOperation(operationId)
        end
    end)
    
    return operationId
end

function simulator:smoothMove(startPos, endPos, duration, easingStyle)
    startPos = validatePosition(startPos)
    endPos = validatePosition(endPos)
    duration = math.max(duration or config.defaultDragDuration, config.minDragDuration)
    duration = addHumanNoise(duration)
    easingStyle = easingStyle or Enum.EasingStyle.Sine
    
    local operationId = generateOperationId()
    activeOps[operationId] = true
    
    local startTime = tick()
    
    local rsRef = cloneref(runService)
    connections[operationId] = rsRef.Heartbeat:Connect(function()
        if not isValidOperation(operationId) then
            cleanupOperation(operationId)
            return
        end
        
        local elapsed = tick() - startTime
        local progress = math.min(elapsed / duration, 1)
        local tsRef = cloneref(tweenService)
        local alpha = tsRef:GetValue(progress, easingStyle, Enum.EasingDirection.Out)
        
        local position = startPos:Lerp(endPos, alpha)
        local xNoise = randomGen:NextNumber(-1, 1)
        local yNoise = randomGen:NextNumber(-1, 1)
        position = Vector2.new(position.X + xNoise, position.Y + yNoise)
        
        self:moveMouse(position)
        
        if progress >= 1 then
            cleanupOperation(operationId)
        end
    end)
    
    return operationId
end

function simulator:circle(center, radius, duration, clockwise, startAngle)
    center = validatePosition(center)
    radius = math.max(radius or config.defaultCircleRadius, config.minCircleRadius)
    radius = addHumanNoise(radius, 0.05)
    duration = math.max(duration or config.defaultCircleDuration, config.minCircleDuration)
    duration = addHumanNoise(duration, 0.1)
    clockwise = clockwise ~= false
    startAngle = startAngle or 0
    
    local operationId = generateOperationId()
    activeOps[operationId] = true
    
    local startTime = tick()
    local startPosition = center + Vector2.new(
        math.cos(startAngle) * radius,
        math.sin(startAngle) * radius
    )
    
    self:mouseDown(startPosition)
    
    local rsRef = cloneref(runService)
    connections[operationId] = rsRef.Heartbeat:Connect(function()
        if not isValidOperation(operationId) then
            cleanupOperation(operationId)
            return
        end
        
        local progress = (tick() - startTime) / duration
        
        if progress >= 1 then
            self:mouseUp(startPosition)
            cleanupOperation(operationId)
            return
        end
        
        local angle = startAngle + progress * math.pi * 2
        if not clockwise then
            angle = startAngle - progress * math.pi * 2
        end
        
        local wobble = randomGen:NextNumber(-0.02, 0.02)
        angle = angle + wobble
        
        local position = center + Vector2.new(
            math.cos(angle) * radius,
            math.sin(angle) * radius
        )
        
        self:moveMouse(position)
    end)
    
    return operationId
end

function simulator:spiral(center, startRadius, endRadius, duration, rotations, clockwise)
    center = validatePosition(center)
    startRadius = math.max(startRadius or 20, 1)
    endRadius = math.max(endRadius or 100, 1)
    duration = math.max(duration or 2, config.minCircleDuration)
    duration = addHumanNoise(duration, 0.15)
    rotations = math.max(rotations or 3, 1)
    clockwise = clockwise ~= false
    
    local operationId = generateOperationId()
    activeOps[operationId] = true
    
    local startTime = tick()
    local startPosition = center + Vector2.new(startRadius, 0)
    
    self:mouseDown(startPosition)
    
    local rsRef = cloneref(runService)
    connections[operationId] = rsRef.Heartbeat:Connect(function()
        if not isValidOperation(operationId) then
            cleanupOperation(operationId)
            return
        end
        
        local progress = (tick() - startTime) / duration
        
        if progress >= 1 then
            local finalPosition = center + Vector2.new(endRadius, 0)
            self:mouseUp(finalPosition)
            cleanupOperation(operationId)
            return
        end
        
        local currentRadius = startRadius + (endRadius - startRadius) * progress
        local angle = progress * math.pi * 2 * rotations
        if not clockwise then
            angle = -angle
        end
        
        local wobble = randomGen:NextNumber(-0.03, 0.03)
        angle = angle + wobble
        
        local position = center + Vector2.new(
            math.cos(angle) * currentRadius,
            math.sin(angle) * currentRadius
        )
        
        self:moveMouse(position)
    end)
    
    return operationId
end

function simulator:pattern(points, interval, repeatCount, holdDuration)
    if type(points) ~= "table" or #points == 0 then
        return false
    end
    
    interval = math.max(interval or config.defaultPatternInterval, config.minDuration)
    interval = addHumanNoise(interval, 0.1)
    repeatCount = math.max(repeatCount or 1, 1)
    holdDuration = holdDuration or 0
    
    local operationId = generateOperationId()
    activeOps[operationId] = true
    
    task.spawn(function()
        for rep = 1, repeatCount do
            if not isValidOperation(operationId) then break end
            
            for i, position in ipairs(points) do
                if not isValidOperation(operationId) then break end
                
                local currentDelay = addHumanNoise(interval, 0.2)
                
                if holdDuration > 0 then
                    self:hold(position, holdDuration)
                else
                    self:click(position)
                end
                
                if i < #points and rep <= repeatCount then
                    task.wait(currentDelay)
                end
            end
            
            if rep < repeatCount then
                task.wait(addHumanNoise(interval, 0.3))
            end
        end
        
        activeOps[operationId] = nil
    end)
    
    return operationId
end

function simulator:swipe(startPos, direction, distance, duration, easingStyle)
    startPos = validatePosition(startPos)
    
    if typeof(direction) == "Vector2" then
        direction = direction.Unit
    elseif type(direction) == "string" then
        local directions = {
            up = Vector2.new(0, -1),
            down = Vector2.new(0, 1),
            left = Vector2.new(-1, 0),
            right = Vector2.new(1, 0)
        }
        direction = directions[direction:lower()] or Vector2.new(1, 0)
    else
        direction = Vector2.new(1, 0)
    end
    
    distance = math.max(distance or 100, 10)
    distance = addHumanNoise(distance, 0.05)
    local endPos = startPos + direction * distance
    
    return self:drag(startPos, endPos, duration, easingStyle)
end

function simulator:stop(operationId)
    if operationId and isValidOperation(operationId) then
        cleanupOperation(operationId)
        return true
    end
    return false
end

function simulator:stopAll()
    local count = 0
    for id in pairs(activeOps) do
        cleanupOperation(id)
        count = count + 1
    end
    return count
end

function simulator:isRunning(operationId)
    return isValidOperation(operationId)
end

function simulator:getActiveCount()
    local count = 0
    for _ in pairs(activeOps) do
        count = count + 1
    end
    return count
end

function simulator:getViewport()
    local camRef = cloneref(camera)
    return camRef and camRef.ViewportSize or Vector2.new(1024, 768)
end

function simulator:getMousePosition()
    local uisRef = cloneref(userInputService)
    return uisRef and uisRef:GetMouseLocation() or Vector2.new(0, 0)
end

function simulator:waitForCompletion(operationId, timeout)
    timeout = timeout or 30
    local startTime = tick()
    
    while isValidOperation(operationId) do
        if tick() - startTime > timeout then
            self:stop(operationId)
            return false
        end
        task.wait(0.1)
    end
    
    return true
end

function simulator:chain()
    local chainObject = {}
    local operations = {}
    
    function chainObject:click(position)
        table.insert(operations, {type = "click", pos = position})
        return self
    end
    
    function chainObject:move(position)
        table.insert(operations, {type = "move", pos = position})
        return self
    end
    
    function chainObject:wait(duration)
        table.insert(operations, {type = "wait", duration = duration})
        return self
    end
    
    function chainObject:execute(interval)
        interval = interval or 0.1
        local operationId = generateOperationId()
        activeOps[operationId] = true
        
        task.spawn(function()
            for _, operation in ipairs(operations) do
                if not isValidOperation(operationId) then break end
                
                if operation.type == "click" then
                    simulator:click(operation.pos)
                elseif operation.type == "move" then
                    simulator:moveMouse(operation.pos)
                elseif operation.type == "wait" then
                    task.wait(operation.duration)
                end
                
                if interval > 0 and operation.type ~= "wait" then
                    task.wait(interval)
                end
            end
            activeOps[operationId] = nil
        end)
        
        return operationId
    end
    
    return chainObject
end

return simulator