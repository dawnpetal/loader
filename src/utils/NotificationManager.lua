-- W I P

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local NotificationFramework = {}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NotificationSystem"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local NotificationSystem = {}
NotificationSystem.__index = NotificationSystem

function NotificationSystem.new(config)
    local self = setmetatable({}, NotificationSystem)
    
    config = config or {}
    self.maxNotifications = config.maxNotifications or 5
    self.defaultDuration = config.defaultDuration or 5
    self.width = config.width or 350
    self.spacing = 10
    self.headerHeight = 35
    self.minContentHeight = 25
    self.padding = 15
    
    self.container = self:_createContainer()
    self.notifications = {}
    
    return self
end

function NotificationSystem:_createContainer()
    local container = Instance.new("Frame")
    container.Name = "NotificationContainer"
    container.AnchorPoint = Vector2.new(1, 0)
    container.Position = UDim2.new(1, -20, 0, 80)
    container.Size = UDim2.new(0, self.width, 1, -100)
    container.BackgroundTransparency = 1
    container.Parent = screenGui
    
    return container
end

function NotificationSystem:_createTween(obj, duration, properties, style, direction)
    return TweenService:Create(
        obj, 
        TweenInfo.new(
            duration, 
            style or Enum.EasingStyle.Quart, 
            direction or Enum.EasingDirection.Out
        ), 
        properties
    )
end

function NotificationSystem:_calculateTextHeight(text, width)
    local textSize = TextService:GetTextSize(text, 14, Enum.Font.Gotham, Vector2.new(width - (self.padding * 2), math.huge))
    return math.max(textSize.Y + 10, self.minContentHeight)
end

function NotificationSystem:_calculateNotificationDimensions(content, isStacked)
    local contentWidth = self.width - (self.padding * 2)
    local contentHeight = self:_calculateTextHeight(content, self.width)
    
    if isStacked then
        contentHeight = self.minContentHeight
    end
    
    local totalHeight = self.headerHeight + contentHeight + self.padding
    
    return totalHeight, contentHeight
end

function NotificationSystem:_calculateStackPositions()
    local positions = {}
    local currentY = 0
    
    for i, notifData in ipairs(self.notifications) do
        if notifData.notification.Parent then
            positions[i] = currentY
            local isStacked = i > 1
            local height, _ = self:_calculateNotificationDimensions(notifData.content or "", isStacked)
            currentY = currentY + height + self.spacing
        end
    end
    
    return positions
end

function NotificationSystem:_updateAllNotifications()
    local positions = self:_calculateStackPositions()
    
    for i, notifData in ipairs(self.notifications) do
        if notifData.notification.Parent then
            local isStacked = i > 1
            local height, contentHeight = self:_calculateNotificationDimensions(notifData.content or "", isStacked)
            local yPosition = positions[i] or 0
            
            local targetPosition = UDim2.new(0, 0, 0, yPosition)
            local targetSize = UDim2.new(0, self.width, 0, height)
            
            self:_createTween(notifData.notification, 0.4, {
                Position = targetPosition,
                Size = targetSize
            }):Play()
            
            if notifData.contentLabel then
                self:_createTween(notifData.contentLabel, 0.4, {
                    Size = UDim2.new(1, -self.padding * 2, 0, contentHeight)
                }):Play()
            end
            
            local transparency = isStacked and 0.3 or 0
            local textTransparency = isStacked and 0.5 or 0
            
            self:_createTween(notifData.notification, 0.4, {
                BackgroundTransparency = transparency
            }):Play()
            
            if notifData.headerFrame then
                self:_createTween(notifData.headerFrame, 0.4, {
                    BackgroundTransparency = transparency + 0.1
                }):Play()
            end
            
            if notifData.headerMask then
                self:_createTween(notifData.headerMask, 0.4, {
                    BackgroundTransparency = transparency + 0.1
                }):Play()
            end
            
            if notifData.headerLabel then
                self:_createTween(notifData.headerLabel, 0.4, {
                    TextTransparency = textTransparency
                }):Play()
            end
            
            if notifData.contentLabel then
                local contentOpacity = isStacked and 0.8 or 0
                self:_createTween(notifData.contentLabel, 0.4, {
                    TextTransparency = contentOpacity
                }):Play()
            end
            
            if notifData.closeButton then
                local buttonOpacity = isStacked and 0.8 or 0
                self:_createTween(notifData.closeButton, 0.4, {
                    TextTransparency = buttonOpacity
                }):Play()
            end
        end
    end
end

function NotificationSystem:_createNotification(header, content, duration)
    if #self.notifications >= self.maxNotifications then
        self:_removeOldestNotification()
    end
    
    local height, contentHeight = self:_calculateNotificationDimensions(content, false)
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, self.width, 0, height)
    notification.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    notification.BorderSizePixel = 0
    notification.BackgroundTransparency = 1
    notification.Position = UDim2.new(0, self.width + 50, 0, 0)
    notification.Parent = self.container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notification
    
    local headerFrame = Instance.new("Frame")
    headerFrame.Name = "Header"
    headerFrame.Size = UDim2.new(1, 0, 0, self.headerHeight)
    headerFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    headerFrame.BorderSizePixel = 0
    headerFrame.BackgroundTransparency = 1
    headerFrame.Parent = notification
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 8)
    headerCorner.Parent = headerFrame
    
    local headerMask = Instance.new("Frame")
    headerMask.Size = UDim2.new(1, 0, 0, 8)
    headerMask.Position = UDim2.new(0, 0, 1, -8)
    headerMask.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    headerMask.BorderSizePixel = 0
    headerMask.BackgroundTransparency = 1
    headerMask.Parent = headerFrame
    
    local headerLabel = Instance.new("TextLabel")
    headerLabel.Size = UDim2.new(1, -50, 1, 0)
    headerLabel.Position = UDim2.new(0, self.padding, 0, 0)
    headerLabel.BackgroundTransparency = 1
    headerLabel.Text = header
    headerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    headerLabel.TextSize = 14
    headerLabel.Font = Enum.Font.GothamBold
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.TextYAlignment = Enum.TextYAlignment.Center
    headerLabel.TextTransparency = 1
    headerLabel.Parent = headerFrame
    
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 25, 0, 25)
    closeButton.Position = UDim2.new(1, -35, 0, 5)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.fromRGB(180, 180, 180)
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextTransparency = 1
    closeButton.Parent = headerFrame
    
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Size = UDim2.new(1, -self.padding * 2, 0, contentHeight)
    contentLabel.Position = UDim2.new(0, self.padding, 0, self.headerHeight + 5)
    contentLabel.BackgroundTransparency = 1
    contentLabel.Text = content
    contentLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    contentLabel.TextSize = 14
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextYAlignment = Enum.TextYAlignment.Top
    contentLabel.TextWrapped = true
    contentLabel.TextTransparency = 1
    contentLabel.Parent = notification
    
    local notifData = {
        notification = notification,
        headerFrame = headerFrame,
        headerMask = headerMask,
        headerLabel = headerLabel,
        closeButton = closeButton,
        contentLabel = contentLabel,
        content = content,
        header = header
    }
    
    table.insert(self.notifications, 1, notifData)
    
    local targetPosition = UDim2.new(0, 0, 0, 0)
    
    task.spawn(function()
        task.wait(0.05)
        
        local slideIn = self:_createTween(notification, 0.6, {Position = targetPosition})
        local fadeIn = self:_createTween(notification, 0.5, {BackgroundTransparency = 0})
        local headerFadeIn = self:_createTween(headerFrame, 0.5, {BackgroundTransparency = 0.1})
        local headerMaskFadeIn = self:_createTween(headerMask, 0.5, {BackgroundTransparency = 0.1})
        local headerTextFadeIn = self:_createTween(headerLabel, 0.5, {TextTransparency = 0})
        local closeButtonFadeIn = self:_createTween(closeButton, 0.5, {TextTransparency = 0})
        local contentTextFadeIn = self:_createTween(contentLabel, 0.5, {TextTransparency = 0})
        
        slideIn:Play()
        fadeIn:Play()
        headerFadeIn:Play()
        headerMaskFadeIn:Play()
        headerTextFadeIn:Play()
        closeButtonFadeIn:Play()
        contentTextFadeIn:Play()
        
        slideIn.Completed:Connect(function()
            self:_updateAllNotifications()
        end)
    end)
    
    closeButton.MouseEnter:Connect(function()
        self:_createTween(closeButton, 0.2, {
            TextColor3 = Color3.fromRGB(255, 100, 100),
            TextSize = 20
        }, Enum.EasingStyle.Back):Play()
    end)
    
    closeButton.MouseLeave:Connect(function()
        self:_createTween(closeButton, 0.2, {
            TextColor3 = Color3.fromRGB(180, 180, 180),
            TextSize = 18
        }):Play()
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        self:_removeNotification(notifData)
    end)
    
    notification.MouseEnter:Connect(function()
        self:_expandNotification(notifData)
    end)
    
    notification.MouseLeave:Connect(function()
        task.wait(0.3)
        self:_updateAllNotifications()
    end)
    
    if duration > 0 then
        task.spawn(function()
            task.wait(duration)
            if notification.Parent then
                self:_removeNotification(notifData)
            end
        end)
    end
    
    return notification
end

function NotificationSystem:_expandNotification(notifData)
    local notification = notifData.notification
    local index = self:_getNotificationIndex(notifData)
    
    if index and index > 1 then
        local fullHeight, fullContentHeight = self:_calculateNotificationDimensions(notifData.content, false)
        
        self:_createTween(notification, 0.3, {
            Size = UDim2.new(0, self.width, 0, fullHeight)
        }):Play()
        
        if notifData.contentLabel then
            self:_createTween(notifData.contentLabel, 0.3, {
                Size = UDim2.new(1, -self.padding * 2, 0, fullContentHeight)
            }):Play()
        end
        
        self:_createTween(notification, 0.3, {BackgroundTransparency = 0}):Play()
        
        if notifData.headerFrame then
            self:_createTween(notifData.headerFrame, 0.3, {BackgroundTransparency = 0.1}):Play()
        end
        
        if notifData.headerMask then
            self:_createTween(notifData.headerMask, 0.3, {BackgroundTransparency = 0.1}):Play()
        end
        
        if notifData.headerLabel then
            self:_createTween(notifData.headerLabel, 0.3, {TextTransparency = 0}):Play()
        end
        
        if notifData.contentLabel then
            self:_createTween(notifData.contentLabel, 0.3, {TextTransparency = 0}):Play()
        end
        
        if notifData.closeButton then
            self:_createTween(notifData.closeButton, 0.3, {TextTransparency = 0}):Play()
        end
    end
end

function NotificationSystem:_getNotificationIndex(targetNotifData)
    for i, notifData in ipairs(self.notifications) do
        if notifData == targetNotifData then
            return i
        end
    end
    return nil
end

function NotificationSystem:_removeOldestNotification()
    if #self.notifications > 0 then
        self:_removeNotification(self.notifications[#self.notifications])
    end
end

function NotificationSystem:_removeNotification(notifData)
    if not notifData or not notifData.notification.Parent then return end
    
    local notification = notifData.notification
    
    local slideOut = self:_createTween(notification, 0.4, {
        Position = UDim2.new(0, self.width + 50, notification.Position.Y.Offset, 0)
    })
    
    local fadeOut = self:_createTween(notification, 0.3, {BackgroundTransparency = 1})
    
    if notifData.headerFrame then
        self:_createTween(notifData.headerFrame, 0.3, {BackgroundTransparency = 1}):Play()
    end
    
    if notifData.headerMask then
        self:_createTween(notifData.headerMask, 0.3, {BackgroundTransparency = 1}):Play()
    end
    
    if notifData.headerLabel then
        self:_createTween(notifData.headerLabel, 0.3, {TextTransparency = 1}):Play()
    end
    
    if notifData.closeButton then
        self:_createTween(notifData.closeButton, 0.3, {TextTransparency = 1}):Play()
    end
    
    if notifData.contentLabel then
        self:_createTween(notifData.contentLabel, 0.3, {TextTransparency = 1}):Play()
    end
    
    slideOut:Play()
    fadeOut:Play()
    
    for i, storedNotif in ipairs(self.notifications) do
        if storedNotif == notifData then
            table.remove(self.notifications, i)
            break
        end
    end
    
    slideOut.Completed:Connect(function()
        notification:Destroy()
        self:_updateAllNotifications()
    end)
end

function NotificationSystem:show(content, header, duration)
    content = tostring(content or "Empty notification")
    header = tostring(header or "Notification")
    duration = tonumber(duration) or self.defaultDuration
    
    return self:_createNotification(header, content, duration)
end

function NotificationSystem:error(content, duration)
    return self:show(content, "Error", duration)
end

function NotificationSystem:alert(content, duration)
    return self:show(content, "Alert", duration)
end

function NotificationSystem:info(content, duration)
    return self:show(content, "Info", duration)
end

function NotificationSystem:success(content, duration)
    return self:show(content, "Success", duration)
end

function NotificationSystem:clear()
    for _, notifData in ipairs(self.notifications) do
        if notifData.notification.Parent then
            notifData.notification:Destroy()
        end
    end
    self.notifications = {}
end

local defaultSystem = NotificationSystem.new()

NotificationFramework.new = NotificationSystem.new
NotificationFramework.show = function(...) return defaultSystem:show(...) end
NotificationFramework.error = function(...) return defaultSystem:error(...) end
NotificationFramework.alert = function(...) return defaultSystem:alert(...) end
NotificationFramework.info = function(...) return defaultSystem:info(...) end
NotificationFramework.success = function(...) return defaultSystem:success(...) end
NotificationFramework.clear = function(...) return defaultSystem:clear() end

return NotificationFramework