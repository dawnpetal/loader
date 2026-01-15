local TaskManager = {
    mainTask = nil,
    currentSubTask = nil,
    nextSubTask = nil,
    taskQueue = {},
    isRunning = false
}

function TaskManager:requestTask(taskName, priority)
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

function TaskManager:startTask(taskName)
    if self.mainTask and self.mainTask ~= taskName then
        return false
    end
    self.mainTask = taskName
    self.isRunning = true
    return true
end

function TaskManager:finishTask(taskName)
    if self.mainTask == taskName then
        self.mainTask = nil
        self.currentSubTask = nil
        self.nextSubTask = nil
        self.isRunning = false
        if # self.taskQueue > 0 then
            local nextTask = table.remove(self.taskQueue, 1)
            task.wait(1)
        end
    end
end

function TaskManager:pauseTask(taskName)
    if self.mainTask == taskName then
        self.isPaused = true
        return true
    end
    return false
end

function TaskManager:resumeTask(taskName)
    if self.mainTask == taskName then
        self.isPaused = false
        return true
    end
    return false
end

function TaskManager:canRun(taskName)
    return (not self.isRunning or self.mainTask == taskName) and not self.isPaused
end

function TaskManager:waitForTurn(taskName, maxWait)
    maxWait = maxWait or 30
    local startTime = tick()
    while not self:canRun(taskName) and (tick() - startTime) < maxWait do
        task.wait(1)
    end
    return self:canRun(taskName)
end

function TaskManager:setCurrentTask(subtask)
    self.currentSubTask = subtask
end

function TaskManager:setNextTask(subtask)
    self.nextSubTask = subtask
end

function TaskManager:getCurrentTask()
    return self.currentSubTask
end

function TaskManager:getNextTask()
    return self.nextSubTask
end

function TaskManager:getMainTask()
    return self.mainTask
end

function TaskManager:clearSubTasks()
    self.currentSubTask = nil
    self.nextSubTask = nil
end

return TaskManager
