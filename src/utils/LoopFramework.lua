local LoopFramework = {}
LoopFramework.tasks = {}
LoopFramework.running = false

function LoopFramework:registerTask(taskName, interval, callback, priority)
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

function LoopFramework:unregisterTask(taskName)
    self.tasks[taskName] = nil
    return self
end

function LoopFramework:setTaskEnabled(taskName, enabled)
    local task = self.tasks[taskName]
    if task then
        task.enabled = enabled
    else
        warn(("Task '%s' not found"):format(taskName))
    end
    return self
end

function LoopFramework:getTask(taskName)
    return self.tasks[taskName]
end

function LoopFramework:reset(taskName)
    local task = self.tasks[taskName]
    if task then
        task.lastRun = 0
    end
    return self
end

function LoopFramework:start(tickRate)
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

function LoopFramework:stop()
    self.running = false
    return self
end

return LoopFramework