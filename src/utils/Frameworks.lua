local cloneref = cloneref or clonereference or function(instance)
    return instance
end

local function GetService(serviceName)
    return cloneref(game:GetService(serviceName))
end

local Services = {
    Players = GetService("Players"),
    ReplicatedStorage = GetService("ReplicatedStorage"),
    PathfindingService = GetService("PathfindingService"),
    TeleportService = GetService("TeleportService"),
    Workspace = GetService("Workspace"),
    RunService = GetService("RunService"),
    HttpService = GetService("HttpService"),
    Lighting = GetService("Lighting"),
    TweenService = GetService("TweenService"),
    UserInputService = GetService("UserInputService"),
    StarterGui = GetService("StarterGui")
}

local StateManager = {}
StateManager.__index = StateManager

function StateManager.new(initialState)
    local self = setmetatable({}, StateManager)
    self._state = initialState or {}
    self._listeners = {}
    return self
end

function StateManager:Get(key)
    return self._state[key]
end

function StateManager:GetAll()
    return self._state
end

function StateManager:Set(key, value)
    if self._state[key] ~= value then
        self._state[key] = value
        self:_notify(key, value)
    end
end

function StateManager:Update(updates)
    for key, value in pairs(updates) do
        self:Set(key, value)
    end
end

function StateManager:Subscribe(key, callback)
    if not self._listeners[key] then
        self._listeners[key] = {}
    end
    table.insert(self._listeners[key], callback)
    return function()
        local listeners = self._listeners[key]
        if listeners then
            for i, cb in ipairs(listeners) do
                if cb == callback then
                    table.remove(listeners, i)
                    break
                end
            end
        end
    end
end

function StateManager:_notify(key, value)
    local listeners = self._listeners[key]
    if listeners then
        for _, callback in ipairs(listeners) do
            task.spawn(callback, value)
        end
    end
end

function StateManager:Reset()
    self._state = {}
    self._listeners = {}
end

local EventBus = {}
EventBus.__index = EventBus

function EventBus.new()
    local self = setmetatable({}, EventBus)
    self._events = {}
    return self
end

function EventBus:On(eventName, callback)
    if not self._events[eventName] then
        self._events[eventName] = {}
    end
    table.insert(self._events[eventName], callback)
    
    return function()
        local callbacks = self._events[eventName]
        if callbacks then
            for i, cb in ipairs(callbacks) do
                if cb == callback then
                    table.remove(callbacks, i)
                    break
                end
            end
        end
    end
end

function EventBus:Once(eventName, callback)
    local unsubscribe
    unsubscribe = self:On(eventName, function(...)
        unsubscribe()
        callback(...)
    end)
    return unsubscribe
end

function EventBus:Emit(eventName, ...)
    local callbacks = self._events[eventName]
    if callbacks then
        for _, callback in ipairs(callbacks) do
            task.spawn(callback, ...)
        end
    end
end

function EventBus:Clear(eventName)
    if eventName then
        self._events[eventName] = nil
    else
        self._events = {}
    end
end

local ConnectionManager = {}
ConnectionManager.__index = ConnectionManager

function ConnectionManager.new()
    local self = setmetatable({}, ConnectionManager)
    self._connections = {}
    return self
end

function ConnectionManager:Register(key, connection)
    if self._connections[key] then
        self._connections[key]:Disconnect()
    end
    self._connections[key] = connection
    return connection
end

function ConnectionManager:Cleanup(key)
    if self._connections[key] then
        self._connections[key]:Disconnect()
        self._connections[key] = nil
    end
end

function ConnectionManager:CleanupAll()
    for _, conn in pairs(self._connections) do
        if typeof(conn) == "RBXScriptConnection" then
            conn:Disconnect()
        end
    end
    self._connections = {}
end

function ConnectionManager:Has(key)
    return self._connections[key] ~= nil
end

local Signal = {}
Signal.__index = Signal

function Signal.new()
    local self = setmetatable({}, Signal)
    self._handlers = {}
    return self
end

function Signal:Connect(handler)
    table.insert(self._handlers, handler)
    
    local connection = {
        Disconnect = function()
            for i, h in ipairs(self._handlers) do
                if h == handler then
                    table.remove(self._handlers, i)
                    break
                end
            end
        end
    }
    
    return connection
end

function Signal:Fire(...)
    for _, handler in ipairs(self._handlers) do
        task.spawn(handler, ...)
    end
end

function Signal:Wait()
    local thread = coroutine.running()
    local connection
    connection = self:Connect(function(...)
        connection:Disconnect()
        task.spawn(thread, ...)
    end)
    return coroutine.yield()
end

function Signal:DisconnectAll()
    self._handlers = {}
end

local Debouncer = {}

function Debouncer.new(duration)
    return {
        _duration = duration or 1,
        _lastCall = 0,
        
        Try = function(self, callback)
            local now = tick()
            if now - self._lastCall >= self._duration then
                self._lastCall = now
                return callback()
            end
            return nil
        end,
        
        Reset = function(self)
            self._lastCall = 0
        end,
        
        IsReady = function(self)
            return tick() - self._lastCall >= self._duration
        end
    }
end

local Throttler = {}

function Throttler.new(duration)
    return {
        _duration = duration or 1,
        _lastCall = 0,
        _scheduled = nil,
        
        Call = function(self, callback)
            local now = tick()
            if now - self._lastCall >= self._duration then
                self._lastCall = now
                callback()
            else
                if self._scheduled then
                    self._scheduled:Cancel()
                end
                self._scheduled = task.delay(self._duration - (now - self._lastCall), function()
                    self._lastCall = tick()
                    callback()
                end)
            end
        end
    }
end

local Cache = {}
Cache.__index = Cache

function Cache.new(ttl)
    local self = setmetatable({}, Cache)
    self._cache = {}
    self._ttl = ttl or 60
    return self
end

function Cache:Set(key, value, customTTL)
    self._cache[key] = {
        value = value,
        expiry = tick() + (customTTL or self._ttl)
    }
end

function Cache:Get(key)
    local entry = self._cache[key]
    if not entry then return nil end
    
    if tick() > entry.expiry then
        self._cache[key] = nil
        return nil
    end
    
    return entry.value
end

function Cache:Clear(key)
    if key then
        self._cache[key] = nil
    else
        self._cache = {}
    end
end

function Cache:Has(key)
    local entry = self._cache[key]
    if not entry then return false end
    if tick() > entry.expiry then
        self._cache[key] = nil
        return false
    end
    return true
end

local Queue = {}
Queue.__index = Queue

function Queue.new()
    local self = setmetatable({}, Queue)
    self._items = {}
    self._head = 1
    self._tail = 0
    return self
end

function Queue:Enqueue(item)
    self._tail = self._tail + 1
    self._items[self._tail] = item
end

function Queue:Dequeue()
    if self:IsEmpty() then return nil end
    local item = self._items[self._head]
    self._items[self._head] = nil
    self._head = self._head + 1
    return item
end

function Queue:Peek()
    if self:IsEmpty() then return nil end
    return self._items[self._head]
end

function Queue:IsEmpty()
    return self._head > self._tail
end

function Queue:Size()
    return self._tail - self._head + 1
end

function Queue:Clear()
    self._items = {}
    self._head = 1
    self._tail = 0
end

local Retry = {}

function Retry.Execute(fn, maxAttempts, delay, backoff)
    maxAttempts = maxAttempts or 3
    delay = delay or 1
    backoff = backoff or 1
    
    local currentDelay = delay
    
    for attempt = 1, maxAttempts do
        local success, result = pcall(fn)
        if success then
            return true, result
        end
        
        if attempt < maxAttempts then
            task.wait(currentDelay)
            currentDelay = currentDelay * backoff
        end
    end
    
    return false, nil
end

local Promise = {}
Promise.__index = Promise

function Promise.new(executor)
    local self = setmetatable({}, Promise)
    self._state = "pending"
    self._value = nil
    self._handlers = {}
    
    local function resolve(value)
        if self._state ~= "pending" then return end
        self._state = "fulfilled"
        self._value = value
        for _, handler in ipairs(self._handlers) do
            if handler.onFulfilled then
                task.spawn(handler.onFulfilled, value)
            end
        end
    end
    
    local function reject(reason)
        if self._state ~= "pending" then return end
        self._state = "rejected"
        self._value = reason
        for _, handler in ipairs(self._handlers) do
            if handler.onRejected then
                task.spawn(handler.onRejected, reason)
            end
        end
    end
    
    task.spawn(function()
        local success, err = pcall(executor, resolve, reject)
        if not success then
            reject(err)
        end
    end)
    
    return self
end

function Promise:Then(onFulfilled, onRejected)
    if self._state == "fulfilled" and onFulfilled then
        task.spawn(onFulfilled, self._value)
    elseif self._state == "rejected" and onRejected then
        task.spawn(onRejected, self._value)
    elseif self._state == "pending" then
        table.insert(self._handlers, {
            onFulfilled = onFulfilled,
            onRejected = onRejected
        })
    end
    return self
end

function Promise:Catch(onRejected)
    return self:Then(nil, onRejected)
end

function Promise.Resolve(value)
    return Promise.new(function(resolve)
        resolve(value)
    end)
end

function Promise.Reject(reason)
    return Promise.new(function(_, reject)
        reject(reason)
    end)
end

local ObjectPool = {}
ObjectPool.__index = ObjectPool

function ObjectPool.new(creator, resetter, initialSize)
    local self = setmetatable({}, ObjectPool)
    self._available = {}
    self._inUse = {}
    self._creator = creator
    self._resetter = resetter or function() end
    
    for i = 1, (initialSize or 10) do
        table.insert(self._available, creator())
    end
    
    return self
end

function ObjectPool:Acquire()
    local obj = table.remove(self._available)
    if not obj then
        obj = self._creator()
    end
    self._inUse[obj] = true
    return obj
end

function ObjectPool:Release(obj)
    if not self._inUse[obj] then return end
    self._inUse[obj] = nil
    self._resetter(obj)
    table.insert(self._available, obj)
end

function ObjectPool:Clear()
    self._available = {}
    self._inUse = {}
end

local TaskManager = {}

function TaskManager.new()
    local self = {
        mainTask = nil,
        currentSubTask = nil,
        nextSubTask = nil,
        taskQueue = {},
        isRunning = false,
        isPaused = false
    }
    
    function self:requestTask(taskName, priority)
        priority = priority or 1
        if self.mainTask == taskName then
            return false
        end
        table.insert(self.taskQueue, {
            name = taskName,
            priority = priority,
            timestamp = tick()
        })
        table.sort(self.taskQueue, function(a, b)
            if a.priority == b.priority then
                return a.timestamp < b.timestamp
            end
            return a.priority > b.priority
        end)
        return true
    end
    
    function self:startTask(taskName)
        if self.mainTask and self.mainTask ~= taskName then
            return false
        end
        self.mainTask = taskName
        self.isRunning = true
        return true
    end
    
    function self:finishTask(taskName)
        if self.mainTask == taskName then
            self.mainTask = nil
            self.currentSubTask = nil
            self.nextSubTask = nil
            self.isRunning = false
            if #self.taskQueue > 0 then
                local nextTask = table.remove(self.taskQueue, 1)
                task.wait(1)
            end
        end
    end
    
    function self:pauseTask(taskName)
        if self.mainTask == taskName then
            self.isPaused = true
            return true
        end
        return false
    end
    
    function self:resumeTask(taskName)
        if self.mainTask == taskName then
            self.isPaused = false
            return true
        end
        return false
    end
    
    function self:canRun(taskName)
        return (not self.isRunning or self.mainTask == taskName) and not self.isPaused
    end
    
    function self:waitForTurn(taskName, maxWait)
        maxWait = maxWait or 30
        local startTime = tick()
        while not self:canRun(taskName) and (tick() - startTime) < maxWait do
            task.wait(1)
        end
        return self:canRun(taskName)
    end
    
    function self:setCurrentTask(subtask)
        self.currentSubTask = subtask
    end
    
    function self:setNextTask(subtask)
        self.nextSubTask = subtask
    end
    
    function self:getCurrentTask()
        return self.currentSubTask
    end
    
    function self:getNextTask()
        return self.nextSubTask
    end
    
    function self:getMainTask()
        return self.mainTask
    end
    
    function self:clearSubTasks()
        self.currentSubTask = nil
        self.nextSubTask = nil
    end
    
    return self
end

local LoopFramework = {}

function LoopFramework.new()
    local self = {
        tasks = {},
        running = false
    }
    
    function self:registerTask(taskName, interval, callback, priority)
        if type(taskName) ~= "string" or taskName == "" then
            error("Task name must be a non-empty string")
        end
        if type(interval) ~= "number" or interval <= 0 then
            error("Interval must be a positive number")
        end
        if type(callback) ~= "function" then
            error("Callback must be a function")
        end
        
        self.tasks[taskName] = {
            interval = interval,
            callback = callback,
            lastRun = 0,
            priority = priority or 1,
            enabled = true
        }
        
        return self
    end
    
    function self:unregisterTask(taskName)
        self.tasks[taskName] = nil
        return self
    end
    
    function self:setTaskEnabled(taskName, enabled)
        local task = self.tasks[taskName]
        if task then
            task.enabled = enabled
        else
            warn(("Task '%s' not found"):format(taskName))
        end
        return self
    end
    
    function self:getTask(taskName)
        return self.tasks[taskName]
    end
    
    function self:reset(taskName)
        local task = self.tasks[taskName]
        if task then
            task.lastRun = 0
        end
        return self
    end
    
    function self:start(tickRate)
        if self.running then
            return self
        end
        
        self.running = true
        tickRate = tickRate or 0.1
        
        task.spawn(function()
            while self.running do
                local now = tick()
                local pendingTasks = {}
                
                for name, taskData in pairs(self.tasks) do
                    if taskData.enabled and now - taskData.lastRun >= taskData.interval then
                        table.insert(pendingTasks, {name = name, data = taskData})
                    end
                end
                
                table.sort(pendingTasks, function(a, b)
                    return a.data.priority > b.data.priority
                end)
                
                for _, taskInfo in ipairs(pendingTasks) do
                    if not self.running then break end
                    
                    taskInfo.data.lastRun = now
                    
                    local success, err = pcall(taskInfo.data.callback)
                    if not success then
                        warn(("Error in task '%s': %s"):format(taskInfo.name, tostring(err)))
                    end
                end
                
                task.wait(tickRate)
            end
        end)
        
        return self
    end
    
    function self:stop()
        self.running = false
        return self
    end
    
    return self
end

return {
    Services = Services,
    StateManager = StateManager,
    EventBus = EventBus,
    ConnectionManager = ConnectionManager,
    Signal = Signal,
    Debouncer = Debouncer,
    Throttler = Throttler,
    Cache = Cache,
    Queue = Queue,
    Retry = Retry,
    Promise = Promise,
    ObjectPool = ObjectPool,
    TaskManager = TaskManager,
    LoopFramework = LoopFramework
}