local SimpleUI = {}

SimpleUI.Services = {}
SimpleUI.Windows = {}
SimpleUI._internal = {
    protected = {},
    connections = {},
    nextId = 1,
    scaleCallbacks = {},
    themeCallbacks = {}
}

local ZERO_UDIM2 = UDim2.new(0, 0, 0, 0)
local FULL_UDIM2 = UDim2.new(1, 0, 1, 0)
local CENTER_VECTOR2 = Vector2.new(0.5, 0.5)

function SimpleUI:getService(name)
    if not self.Services[name] then
        self.Services[name] = (cloneref or function(x)
            return x
        end)(game:GetService(name))
    end
    return self.Services[name]
end

local function getHiddenContainer()
    local container = (gethui or get_hidden_gui or function()
        return SimpleUI:getService("CoreGui")
    end)()
    return container
end

local function protectInstance(inst)
    if protectgui or syn_protect_gui then
        (protectgui or syn_protect_gui)(inst)
    end
end

local function wrapCallback(func)
    if newcclosure then
        return newcclosure(func)
    end
    return func
end

local function generateId()
    local id = SimpleUI._internal.nextId
    SimpleUI._internal.nextId = id + 1
    return tostring(id)
end

local function storeConnection(id, connection)
    if not SimpleUI._internal.connections[id] then
        SimpleUI._internal.connections[id] = {}
    end
    table.insert(SimpleUI._internal.connections[id], connection)
end

local function disconnectAll(id)
    local conns = SimpleUI._internal.connections[id]
    if conns then
        for _, conn in ipairs(conns) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        SimpleUI._internal.connections[id] = nil
    end
end

SimpleUI.ScaleSystem = {
    BaseResolution = Vector2.new(1920, 1080),
    CurrentViewport = Vector2.new(1920, 1080),
    ScaleFactor = 1,
    MinScale = 0.5,
    MaxScale = 2.0,
    Enabled = true
}

SimpleUI.Themes = {
    Default = {
        PrimaryColor = Color3.fromRGB(20, 20, 20),
        SecondaryColor = Color3.fromRGB(80, 80, 80),
        SecondaryColorHover = Color3.fromRGB(100, 100, 100),
        SecondaryColorActive = Color3.fromRGB(120, 120, 120),
        SecondaryColorMouse1Down = Color3.fromRGB(50, 50, 50),
        TertiaryColor = Color3.fromRGB(60, 60, 60),
        TertiaryColorHover = Color3.fromRGB(80, 80, 80),
        TertiaryColorActive = Color3.fromRGB(100, 100, 100),
        TertiaryColorMouse1Down = Color3.fromRGB(50, 50, 50),
        TextInactive = Color3.fromRGB(230, 230, 230),
        TextActive = Color3.fromRGB(255, 255, 255),
        TextPrimary = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(180, 180, 180),
        AccentColor = Color3.fromRGB(180, 180, 180),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.05,
        SecondaryTransparency = 0.8
    },
    Dusk = {
        PrimaryColor = Color3.fromRGB(22, 23, 26),
        SecondaryColor = Color3.fromRGB(42, 44, 50),
        SecondaryColorHover = Color3.fromRGB(58, 60, 68),
        SecondaryColorActive = Color3.fromRGB(76, 78, 88),
        SecondaryColorMouse1Down = Color3.fromRGB(34, 36, 40),
        TertiaryColor = Color3.fromRGB(48, 50, 56),
        TertiaryColorHover = Color3.fromRGB(64, 66, 74),
        TertiaryColorActive = Color3.fromRGB(86, 88, 100),
        TertiaryColorMouse1Down = Color3.fromRGB(40, 42, 46),
        TextInactive = Color3.fromRGB(185, 188, 196),
        TextActive = Color3.fromRGB(230, 232, 240),
        TextPrimary = Color3.fromRGB(245, 247, 252),
        TextSecondary = Color3.fromRGB(160, 165, 176),
        AccentColor = Color3.fromRGB(255, 145, 90),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.04,
        SecondaryTransparency = 0.63
    },
    Monokai = {
        PrimaryColor = Color3.fromRGB(20, 20, 24),
        SecondaryColor = Color3.fromRGB(45, 47, 49),
        SecondaryColorHover = Color3.fromRGB(75, 78, 68),
        SecondaryColorActive = Color3.fromRGB(90, 94, 82),
        SecondaryColorMouse1Down = Color3.fromRGB(50, 52, 44),
        TertiaryColor = Color3.fromRGB(50, 53, 53),
        TertiaryColorHover = Color3.fromRGB(85, 89, 77),
        TertiaryColorActive = Color3.fromRGB(100, 105, 91),
        TertiaryColorMouse1Down = Color3.fromRGB(58, 60, 52),
        TextInactive = Color3.fromRGB(248, 248, 240),
        TextActive = Color3.fromRGB(255, 255, 255),
        TextPrimary = Color3.fromRGB(248, 248, 240),
        TextSecondary = Color3.fromRGB(205, 205, 200),
        AccentColor = Color3.fromRGB(166, 226, 46),
        PrimaryFont = Enum.Font.Code,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.Code,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0,
        SecondaryTransparency = 0.67
    }
}

SimpleUI.DefaultElements = {}

function SimpleUI:calculateScale()
    if not self.ScaleSystem.Enabled then
        return 1
    end

    local cam = workspace.CurrentCamera
    if not cam then
        return self.ScaleSystem.ScaleFactor
    end

    local viewport = cam.ViewportSize
    self.ScaleSystem.CurrentViewport = viewport

    local scaleX = viewport.X / self.ScaleSystem.BaseResolution.X
    local scaleY = viewport.Y / self.ScaleSystem.BaseResolution.Y

    local scale = math.min(scaleX, scaleY)
    scale = math.clamp(scale, self.ScaleSystem.MinScale, self.ScaleSystem.MaxScale)

    self.ScaleSystem.ScaleFactor = scale
    return scale
end

function SimpleUI:scale(value)
    if not self.ScaleSystem.Enabled then
        return value
    end

    local sf = self.ScaleSystem.ScaleFactor

    if typeof(value) == "UDim2" then
        return UDim2.new(value.X.Scale, math.floor(value.X.Offset * sf + 0.5), value.Y.Scale,
            math.floor(value.Y.Offset * sf + 0.5))
    elseif typeof(value) == "Vector2" then
        return Vector2.new(math.floor(value.X * sf + 0.5), math.floor(value.Y * sf + 0.5))
    elseif typeof(value) == "number" then
        return math.floor(value * sf + 0.5)
    end

    return value
end

function SimpleUI:unscale(value)
    if not self.ScaleSystem.Enabled then
        return value
    end

    local sf = self.ScaleSystem.ScaleFactor

    if typeof(value) == "UDim2" then
        return UDim2.new(value.X.Scale, math.floor(value.X.Offset / sf + 0.5), value.Y.Scale,
            math.floor(value.Y.Offset / sf + 0.5))
    elseif typeof(value) == "Vector2" then
        return Vector2.new(math.floor(value.X / sf + 0.5), math.floor(value.Y / sf + 0.5))
    elseif typeof(value) == "number" then
        return math.floor(value / sf + 0.5)
    end

    return value
end

function SimpleUI:isMobile()
    local uis = self:getService("UserInputService")
    return uis.TouchEnabled and not uis.MouseEnabled
end

function SimpleUI:createElement(className, props, parent)
    local obj = Instance.new(className)

    for k, v in pairs(props or {}) do
        if k == "Size" or k == "Position" then
            obj:SetAttribute("_sui_original_" .. k, v)
            obj[k] = self:scale(v)
        elseif k == "TextSize" then
            obj:SetAttribute("_sui_original_TextSize", v)
            obj.TextSize = self:scale(v)
        else
            obj[k] = v
        end
    end

    obj.Parent = parent
    return obj
end

function SimpleUI:rescaleElement(element)
    if not element or not element:IsA("GuiObject") then
        return
    end

    local originalSize = element:GetAttribute("_sui_original_Size")
    if originalSize then
        element.Size = self:scale(originalSize)
    end

    local originalPos = element:GetAttribute("_sui_original_Position")
    if originalPos then
        element.Position = self:scale(originalPos)
    end

    if element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox") then
        local originalTextSize = element:GetAttribute("_sui_original_TextSize")
        if originalTextSize then
            element.TextSize = self:scale(originalTextSize)
        end
    end

    for _, child in ipairs(element:GetChildren()) do
        if child:IsA("UICorner") then
            local originalRadius = child:GetAttribute("_sui_original_CornerRadius")
            if originalRadius then
                child.CornerRadius = UDim.new(0, self:scale(originalRadius))
            end
        elseif child:IsA("UIPadding") then
            for _, paddingProp in ipairs({"PaddingTop", "PaddingBottom", "PaddingLeft", "PaddingRight"}) do
                local originalPadding = child:GetAttribute("_sui_original_" .. paddingProp)
                if originalPadding then
                    child[paddingProp] = UDim.new(0, self:scale(originalPadding))
                end
            end
        elseif child:IsA("UIListLayout") or child:IsA("UIGridLayout") then
            local originalPadding = child:GetAttribute("_sui_original_Padding")
            if originalPadding then
                child.Padding = UDim.new(0, self:scale(originalPadding))
            end
        elseif child:IsA("UISizeConstraint") then
            local originalMin = child:GetAttribute("_sui_original_MinSize")
            if originalMin then
                child.MinSize = self:scale(originalMin)
            end
            local originalMax = child:GetAttribute("_sui_original_MaxSize")
            if originalMax then
                child.MaxSize = self:scale(originalMax)
            end
        end
    end
end

function SimpleUI:rescaleTree(root)
    if not root then
        return
    end

    self:rescaleElement(root)

    for _, child in ipairs(root:GetDescendants()) do
        self:rescaleElement(child)
    end
end

function SimpleUI:merge(base, override)
    local result = {}
    for k, v in pairs(base or {}) do
        result[k] = type(v) == "table" and self:merge(v, {}) or v
    end
    for k, v in pairs(override or {}) do
        if type(v) == "table" and type(result[k]) == "table" then
            result[k] = self:merge(result[k], v)
        else
            result[k] = v
        end
    end
    return result
end

function SimpleUI:getTheme(element)
    local gui = element
    while gui do
        if gui:IsA("ScreenGui") then
            if self.Windows and self.Windows[gui] then
                return self.Windows[gui].Theme
            end
            break
        end
        gui = gui.Parent
    end
    return self.Themes.Default
end

function SimpleUI:applyTheme(properties, themeMap, theme)
    local result = {}
    for k, v in pairs(properties) do
        result[k] = v
    end
    if themeMap then
        for propName, themeKey in pairs(themeMap) do
            if theme[themeKey] then
                result[propName] = theme[themeKey]
            end
        end
    end
    return result
end

function SimpleUI:setTheme(window, themeNameOrTable)
    if not window or not window.Elements then
        return
    end

    local newTheme
    if type(themeNameOrTable) == "string" then
        newTheme = self.Themes[themeNameOrTable]
    elseif type(themeNameOrTable) == "table" then
        newTheme = themeNameOrTable
    end

    if not newTheme then
        return
    end

    window.Theme = newTheme

    local httpService = self:getService("HttpService")
    for _, element in ipairs(window.Elements.ScreenGui:GetDescendants()) do
        local themeMap = element:GetAttribute("_sui_themeMap")
        if themeMap then
            local success, decoded = pcall(function()
                return httpService:JSONDecode(themeMap)
            end)
            if success and decoded then
                for propName, themeKey in pairs(decoded) do
                    if newTheme[themeKey] then
                        element[propName] = newTheme[themeKey]
                    end
                end
            end
        end
    end

    for _, callback in ipairs(self._internal.themeCallbacks) do
        pcall(callback, newTheme)
    end

    if window.OnThemeChanged then
        pcall(window.OnThemeChanged, newTheme)
    end
end

function SimpleUI:registerTheme(name, themeData)
    self.Themes[name] = themeData
end

function SimpleUI:onScaleChanged(callback)
    table.insert(self._internal.scaleCallbacks, wrapCallback(callback))
end

function SimpleUI:onThemeChanged(callback)
    table.insert(self._internal.themeCallbacks, wrapCallback(callback))
end

function SimpleUI:getScale()
    return self.ScaleSystem.ScaleFactor
end

function SimpleUI:setBaseResolution(resolution)
    self.ScaleSystem.BaseResolution = resolution
    self:calculateScale()

    for gui, window in pairs(self.Windows) do
        if gui.Parent then
            self:rescaleTree(window.Elements.MainFrame)
        end
    end

    for _, callback in ipairs(self._internal.scaleCallbacks) do
        pcall(callback, self.ScaleSystem.ScaleFactor)
    end
end

SimpleUI.DefaultElements.MainFrame = {
    Class = "Frame",
    Properties = {
        Name = "MainFrame",
        AnchorPoint = CENTER_VECTOR2,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 800, 0, 500),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = false
    },
    ScaleConstraints = {
        MinSize = Vector2.new(500, 335),
        MaxSize = Vector2.new(1200, 800)
    }
}

SimpleUI.DefaultElements.TopBar = {
    Class = "Frame",
    Properties = {
        Name = "TopBar",
        Size = UDim2.new(1, 0, 0, 40),
        BorderSizePixel = 0,
        ZIndex = 1,
        ClipsDescendants = false,
        Active = true
    },
    Theme = {
        BackgroundColor3 = "PrimaryColor",
        BackgroundTransparency = "PrimaryTransparency"
    }
}

SimpleUI.DefaultElements.TitleLabel = {
    Class = "TextLabel",
    Properties = {
        Name = "TitleLabel",
        Size = FULL_UDIM2,
        BackgroundTransparency = 1,
        Text = "SimpleUI",
        TextSize = 20,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2
    },
    Theme = {
        Font = "PrimaryFont",
        TextColor3 = "TextPrimary"
    }
}

SimpleUI.DefaultElements.MainContainer = {
    Class = "Frame",
    Properties = {
        Name = "MainContainer",
        Position = UDim2.new(0, 0, 0, 40),
        Size = UDim2.new(1, 0, 1, -50),
        BorderSizePixel = 0,
        ZIndex = 1,
        ClipsDescendants = true
    },
    Theme = {
        BackgroundColor3 = "PrimaryColor",
        BackgroundTransparency = "PrimaryTransparency"
    }
}

SimpleUI.DefaultElements.TabsContainer = {
    Class = "Frame",
    Properties = {
        Name = "TabsContainer",
        Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(0.25, -20, 1, -20),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 2,
        ClipsDescendants = false
    },
    Padding = 10,
    ListLayout = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center
    }
}

SimpleUI.DefaultElements.ContentsContainer = {
    Class = "Frame",
    Properties = {
        Name = "ContentsContainer",
        Position = UDim2.new(0.22, 10, 0, 10),
        Size = UDim2.new(0.77, -20, 1, -20),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ZIndex = 2,
        ClipsDescendants = true
    },
    Padding = 10
}

function SimpleUI:createWindow(options)
    options = options or {}
    local theme = options.Theme or self.Themes.Monokai

    self:calculateScale()

    local windowId = generateId()
    local container = getHiddenContainer()

    local gui = self:createElement("ScreenGui", {
        Name = (options.Name or "SimpleUI") .. "_" .. windowId,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }, container)

    protectInstance(gui)

    local frameData = self:merge(self.DefaultElements.MainFrame, options.MainFrame or {})
    local frame = self:createElement(frameData.Class, frameData.Properties, gui)

    if frameData.ScaleConstraints then
        local constraint = self:createElement("UISizeConstraint", {}, frame)
        constraint:SetAttribute("_sui_original_MinSize", frameData.ScaleConstraints.MinSize)
        constraint:SetAttribute("_sui_original_MaxSize", frameData.ScaleConstraints.MaxSize)
        constraint.MinSize = self:scale(frameData.ScaleConstraints.MinSize)
        constraint.MaxSize = self:scale(frameData.ScaleConstraints.MaxSize)
    end

    local topBarData = self:merge(self.DefaultElements.TopBar, options.TopBar or {})
    local topBarProps = self:applyTheme(topBarData.Properties, topBarData.Theme, theme)
    local topBar = self:createElement(topBarData.Class, topBarProps, frame)

    if topBarData.Theme then
        local httpService = self:getService("HttpService")
        topBar:SetAttribute("_sui_themeMap", httpService:JSONEncode(topBarData.Theme))
    end

    self:createElement("TextButton", {
        Name = "InputBlocker",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        ZIndex = frame.ZIndex,
        Active = true,
        Selectable = false
    }, frame)

    self:createElement("Frame", {
        Name = "TopBarSeparator",
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = Color3.fromRGB(225, 225, 225),
        BackgroundTransparency = 0.80,
        BorderSizePixel = 0,
        ZIndex = topBar.ZIndex + 1
    }, topBar)

    local titleContainer = self:createElement("Frame", {
        Name = "TitleContainer",
        Position = UDim2.new(0, 10, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0.7, -10, 0.7, 0),
        BackgroundTransparency = 1,
        ZIndex = 2
    }, topBar)

    local titleData = self:merge(self.DefaultElements.TitleLabel, options.TitleLabel or {})
    local titleProps = self:applyTheme(titleData.Properties, titleData.Theme, theme)
    titleProps.Text = options.Title or titleProps.Text
    local titleLabel = self:createElement(titleData.Class, titleProps, titleContainer)

    if titleData.Theme then
        local httpService = self:getService("HttpService")
        titleLabel:SetAttribute("_sui_themeMap", httpService:JSONEncode(titleData.Theme))
    end

    local controlsContainer = self:createElement("Frame", {
        Name = "ControlsContainer",
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        Size = UDim2.new(0.3, -10, 0.7, 0),
        BackgroundTransparency = 1,
        ZIndex = 2
    }, topBar)

    self:createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, self:scale(4))
    }, controlsContainer)

    local closeButton = self:createElement("TextButton", {
        Name = "CloseButton",
        Size = UDim2.new(0, 32, 0, 32),
        BackgroundColor3 = Color3.fromRGB(40, 40, 45),
        BorderSizePixel = 0,
        Text = "×",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
        ZIndex = 3,
        LayoutOrder = 3
    }, controlsContainer)

    self:createElement("UICorner", {
        CornerRadius = UDim.new(0, self:scale(4))
    }, closeButton)

    local minimizeButton = self:createElement("TextButton", {
        Name = "MinimizeButton",
        Size = UDim2.new(0, 32, 0, 32),
        BackgroundColor3 = Color3.fromRGB(40, 40, 45),
        BorderSizePixel = 0,
        Text = "—",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
        ZIndex = 3,
        LayoutOrder = 2
    }, controlsContainer)

    self:createElement("UICorner", {
        CornerRadius = UDim.new(0, self:scale(4))
    }, minimizeButton)

    local mainContainerData = self:merge(self.DefaultElements.MainContainer, options.MainContainer or {})
    local mainContainerProps = self:applyTheme(mainContainerData.Properties, mainContainerData.Theme, theme)
    local mainContainer = self:createElement(mainContainerData.Class, mainContainerProps, frame)

    if mainContainerData.Theme then
        local httpService = self:getService("HttpService")
        mainContainer:SetAttribute("_sui_themeMap", httpService:JSONEncode(mainContainerData.Theme))
    end

    local tabsContainerData = self:merge(self.DefaultElements.TabsContainer, options.TabsContainer or {})
    local tabsContainer = self:createElement(tabsContainerData.Class, tabsContainerData.Properties, mainContainer)

    if tabsContainerData.ListLayout then
        local layout = self:createElement("UIListLayout", {
            SortOrder = tabsContainerData.ListLayout.SortOrder,
            HorizontalAlignment = tabsContainerData.ListLayout.HorizontalAlignment
        }, tabsContainer)

        if tabsContainerData.Padding then
            layout:SetAttribute("_sui_original_Padding", tabsContainerData.Padding)
            layout.Padding = UDim.new(0, self:scale(tabsContainerData.Padding))
        end
    end

    local contentsContainerData = self:merge(self.DefaultElements.ContentsContainer, options.ContentsContainer or {})
    local contentsContainer = self:createElement(contentsContainerData.Class, contentsContainerData.Properties,
        mainContainer)

    if contentsContainerData.Padding then
        local p = contentsContainerData.Padding
        local padding = self:createElement("UIPadding", {}, contentsContainer)
        padding:SetAttribute("_sui_original_PaddingBottom", p)
        padding:SetAttribute("_sui_original_PaddingLeft", p)
        padding:SetAttribute("_sui_original_PaddingRight", p)
        padding.PaddingBottom = UDim.new(0, self:scale(p))
        padding.PaddingLeft = UDim.new(0, self:scale(p))
        padding.PaddingRight = UDim.new(0, self:scale(p))
    end

    local windowInstance = {
        Id = windowId,
        Theme = theme,
        Elements = {
            ScreenGui = gui,
            MainFrame = frame,
            TopBar = topBar,
            TitleContainer = titleContainer,
            ControlsContainer = controlsContainer,
            MainContainer = mainContainer,
            TabsContainer = tabsContainer,
            ContentsContainer = contentsContainer,
            CloseButton = closeButton,
            MinimizeButton = minimizeButton,
            Tabs = {},
            Pages = {}
        },
        ActiveTab = nil,
        ActivePage = nil,
        TabUpdates = {},
        Minimized = false,
        Visible = true,
        hide = function()
            frame.Visible = false
            windowInstance.Visible = false
        end,
        show = function()
            frame.Visible = true
            windowInstance.Visible = true
        end,
        toggle = function()
            frame.Visible = not frame.Visible
            windowInstance.Visible = frame.Visible
        end,
        destroy = function()
            disconnectAll(windowId)
            gui:Destroy()
            SimpleUI.Windows[gui] = nil
        end,
        isVisible = function()
            return windowInstance.Visible
        end,
        setTheme = function(themeNameOrTable)
            SimpleUI:setTheme(windowInstance, themeNameOrTable)
        end,
        OnThemeChanged = nil
    }

    self.Windows[gui] = windowInstance

    local TweenService = self:getService("TweenService")
    local UIS = self:getService("UserInputService")

    local dragging = false
    local dragStart, startPos

    local dragConn = topBar.InputBegan:Connect(wrapCallback(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            local stateConn
            stateConn = input:GetPropertyChangedSignal("UserInputState"):Connect(wrapCallback(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if stateConn then
                        stateConn:Disconnect()
                        stateConn = nil
                    end
                end
            end))
            storeConnection(windowId, stateConn)
        end
    end))
    storeConnection(windowId, dragConn)

    local inputEndConn = UIS.InputEnded:Connect(wrapCallback(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end))
    storeConnection(windowId, inputEndConn)

    local inputChangeConn = UIS.InputChanged:Connect(wrapCallback(function(input)
        if dragging and
            (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local currentPos = input.Position
            local delta = currentPos - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale,
                startPos.Y.Offset + delta.Y)
        end
    end))
    storeConnection(windowId, inputChangeConn)

    local closeConn = closeButton.Activated:Connect(wrapCallback(function()
        local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

        for _, obj in ipairs(gui:GetDescendants()) do
            if obj:IsA("GuiObject") then
                local props = {}
                if obj:IsA("Frame") or obj:IsA("ScrollingFrame") or obj:IsA("TextButton") or obj:IsA("TextLabel") then
                    props.BackgroundTransparency = 1
                end
                if obj:IsA("TextButton") or obj:IsA("TextLabel") then
                    props.TextTransparency = 1
                end
                if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
                    props.ImageTransparency = 1
                end
                if next(props) then
                    TweenService:Create(obj, tweenInfo, props):Play()
                end
            end
        end

        for _, obj in ipairs(gui:GetChildren()) do
            if obj:IsA("Frame") then
                TweenService:Create(obj, tweenInfo, {
                    Size = UDim2.new(obj.Size.X.Scale, obj.Size.X.Offset, 0, 0)
                }):Play()
            end
        end

        task.delay(0.42, function()
            windowInstance:destroy()
        end)
    end))
    storeConnection(windowId, closeConn)

    local minimizeConn = minimizeButton.Activated:Connect(wrapCallback(function()
        local inputBlocker = frame:FindFirstChild("InputBlocker")
        if not inputBlocker then
            return
        end

        if not mainContainer:GetAttribute("_sui_openSize") then
            mainContainer:SetAttribute("_sui_openSize", mainContainer.Size)
        end

        windowInstance.Minimized = not windowInstance.Minimized
        mainContainer.ClipsDescendants = true
        inputBlocker.Visible = not windowInstance.Minimized
        mainContainer.AutomaticSize = Enum.AutomaticSize.None

        local targetSize = windowInstance.Minimized and
                               UDim2.new(mainContainer.Size.X.Scale, mainContainer.Size.X.Offset, 0, 0) or
                               mainContainer:GetAttribute("_sui_openSize")

        TweenService:Create(mainContainer, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = targetSize
        }):Play()
    end))
    storeConnection(windowId, minimizeConn)

    local viewportConn = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(wrapCallback(
        function()
            self:calculateScale()
            self:rescaleTree(frame)

            for _, callback in ipairs(self._internal.scaleCallbacks) do
                pcall(callback, self.ScaleSystem.ScaleFactor)
            end
        end))
    storeConnection(windowId, viewportConn)

    return windowInstance
end

SimpleUI.DefaultElements.Tab = {
    Class = "TextButton",
    Properties = {
        Size = UDim2.new(1, -10, 0, 30),
        BorderSizePixel = 0,
        Text = "Tab",
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        AutoButtonColor = false,
        ZIndex = 3
    },
    Theme = {
        BackgroundColor3 = "SecondaryColor",
        BackgroundTransparency = "SecondaryTransparency",
        Font = "SecondaryFont",
        TextColor3 = "TextInactive"
    },
    Corner = {
        CornerRadius = 4
    },
    Padding = {
        Left = 8,
        Right = 2
    }
}

SimpleUI.DefaultElements.Page = {
    Class = "Frame",
    Properties = {
        Size = FULL_UDIM2,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 3,
        ClipsDescendants = false
    },
    Padding = 8,
    ListLayout = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = 8
    }
}

function SimpleUI:createTab(window, name, options)
    if not window or not window.Elements or not window.Elements.TabsContainer then
        return
    end

    options = options or {}
    local theme = self:getTheme(window.Elements.TabsContainer)
    local mobile = self:isMobile()

    local tabData = self:merge(self.DefaultElements.Tab, options)
    tabData.Properties.Name = name
    tabData.Properties.Text = name
    tabData.Properties.LayoutOrder = #window.Elements.Tabs

    local tabProps = self:applyTheme(tabData.Properties, tabData.Theme, theme)
    local tab = self:createElement(tabData.Class, tabProps, window.Elements.TabsContainer)

    if tabData.Theme then
        local httpService = self:getService("HttpService")
        tab:SetAttribute("_sui_themeMap", httpService:JSONEncode(tabData.Theme))
    end

    if tabData.Corner then
        local corner = self:createElement("UICorner", {}, tab)
        corner:SetAttribute("_sui_original_CornerRadius", tabData.Corner.CornerRadius)
        corner.CornerRadius = UDim.new(0, self:scale(tabData.Corner.CornerRadius))
    end

    if tabData.Padding then
        local padding = self:createElement("UIPadding", {}, tab)
        padding:SetAttribute("_sui_original_PaddingLeft", tabData.Padding.Left)
        padding:SetAttribute("_sui_original_PaddingRight", tabData.Padding.Right)
        padding.PaddingLeft = UDim.new(0, self:scale(tabData.Padding.Left))
        padding.PaddingRight = UDim.new(0, self:scale(tabData.Padding.Right))
    end

    local pageData = self:merge(self.DefaultElements.Page, {})
    pageData.Properties.Name = name .. "Page"
    local page = self:createElement(pageData.Class, pageData.Properties, window.Elements.ContentsContainer)

    if pageData.ListLayout then
        local layout = self:createElement("UIListLayout", {
            SortOrder = pageData.ListLayout.SortOrder
        }, page)

        if pageData.ListLayout.Padding then
            layout:SetAttribute("_sui_original_Padding", pageData.ListLayout.Padding)
            layout.Padding = UDim.new(0, self:scale(pageData.ListLayout.Padding))
        end
    end

    if pageData.Padding then
        local p = pageData.Padding
        local padding = self:createElement("UIPadding", {}, page)
        padding:SetAttribute("_sui_original_PaddingTop", p)
        padding:SetAttribute("_sui_original_PaddingBottom", p)
        padding.PaddingTop = UDim.new(0, self:scale(p))
        padding.PaddingBottom = UDim.new(0, self:scale(p))
    end

    window.Elements.Pages[name] = page

    local isActive, isHovering, isPressed = false, false, false

    local function update()
        if isActive then
            tab.BackgroundColor3 = theme.SecondaryColorActive
            tab.TextColor3 = theme.TextActive
        elseif isPressed then
            tab.BackgroundColor3 = theme.SecondaryColorMouse1Down
            tab.TextColor3 = theme.TextInactive
        elseif isHovering then
            tab.BackgroundColor3 = theme.SecondaryColorHover
            tab.TextColor3 = theme.TextInactive
        else
            tab.BackgroundColor3 = theme.SecondaryColor
            tab.TextColor3 = theme.TextInactive
        end
    end

    if not mobile then
        local enterConn = tab.MouseEnter:Connect(wrapCallback(function()
            if not isActive then
                isHovering = true
                update()
            end
        end))
        storeConnection(window.Id, enterConn)

        local leaveConn = tab.MouseLeave:Connect(wrapCallback(function()
            if not isActive then
                isHovering = false
                isPressed = false
                update()
            end
        end))
        storeConnection(window.Id, leaveConn)

        local downConn = tab.MouseButton1Down:Connect(wrapCallback(function()
            if not isActive then
                isPressed = true
                update()
            end
        end))
        storeConnection(window.Id, downConn)

        local upConn = tab.MouseButton1Up:Connect(wrapCallback(function()
            if not isActive then
                isPressed = false
                update()
            end
        end))
        storeConnection(window.Id, upConn)
    end

    local activateConn = tab.Activated:Connect(wrapCallback(function()
        if isActive then
            return
        end

        if window.ActiveTab and window.ActiveTab ~= tab then
            local prevUpdate = window.TabUpdates[window.ActiveTab]
            if prevUpdate then
                prevUpdate(false)
            end
            if window.ActivePage then
                window.ActivePage.Visible = false
            end
        end

        isActive = true
        window.ActiveTab = tab
        window.ActivePage = page
        page.Visible = true
        update()
    end))
    storeConnection(window.Id, activateConn)

    window.TabUpdates[tab] = function(active)
        isActive = active
        isHovering = false
        isPressed = false
        update()
    end

    window.Elements.Tabs[name] = tab

    if not window.ActiveTab then
        isActive = true
        window.ActiveTab = tab
        window.ActivePage = page
        page.Visible = true
    end

    update()

    return {
        tab = tab,
        page = page
    }
end

SimpleUI.DefaultElements.Section = {
    Class = "Frame",
    Properties = {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 4
    },
    Label = {
        Properties = {
            Size = UDim2.new(1, 0, 0, 26),
            Position = UDim2.new(0, 0, 0, 0),
            Text = "Section",
            TextSize = 19,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            ZIndex = 5
        },
        Theme = {
            Font = "PrimaryFont",
            TextColor3 = "TextActive"
        }
    },
    Underline = {
        Properties = {
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 1, -1),
            BorderSizePixel = 0,
            ZIndex = 5
        },
        Theme = {
            BackgroundColor3 = "AccentColor"
        }
    }
}

function SimpleUI:createSection(page, text, options)
    if not page then
        return
    end

    options = options or {}
    local theme = self:getTheme(page)
    local data = self:merge(self.DefaultElements.Section, options)

    local props = self:applyTheme(data.Properties, data.Theme, theme)
    props.Name = "Section"
    local section = self:createElement(data.Class, props, page)

    local labelProps = self:applyTheme(data.Label.Properties, data.Label.Theme, theme)
    labelProps.Text = text or labelProps.Text
    local label = self:createElement("TextLabel", labelProps, section)

    if data.Label.Theme then
        local httpService = self:getService("HttpService")
        label:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Label.Theme))
    end

    local underlineProps = self:applyTheme(data.Underline.Properties, data.Underline.Theme, theme)
    local underline = self:createElement("Frame", underlineProps, section)

    if data.Underline.Theme then
        local httpService = self:getService("HttpService")
        underline:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Underline.Theme))
    end

    local corner = self:createElement("UICorner", {}, underline)
    corner:SetAttribute("_sui_original_CornerRadius", 999)
    corner.CornerRadius = UDim.new(1, 0)

    return {
        Section = section,
        Label = label,
        Underline = underline,
        setText = function(t)
            label.Text = t
        end,
        setVisible = function(v)
            section.Visible = v
        end
    }
end

SimpleUI.DefaultElements.Button = {
    Class = "TextButton",
    Properties = {
        Size = UDim2.new(1, 0, 0, 35),
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        ZIndex = 4
    },
    Theme = {
        BackgroundColor3 = "SecondaryColor",
        BackgroundTransparency = "SecondaryTransparency"
    },
    Corner = {
        CornerRadius = 4
    },
    Title = {
        Properties = {
            Size = UDim2.new(1, -40, 1, 0),
            Position = UDim2.new(0, 10, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Text = "Button",
            TextSize = 15,
            TextXAlignment = Enum.TextXAlignment.Left
        },
        Theme = {
            Font = "SecondaryFont",
            TextColor3 = "TextPrimary"
        }
    },
    Arrow = {
        Properties = {
            Size = UDim2.new(0, 16, 0, 16),
            Position = UDim2.new(1, -10, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            Image = "rbxassetid://113826256227095",
            ImageRectOffset = Vector2.new(448, 192),
            ImageRectSize = Vector2.new(64, 64)
        },
        Theme = {
            ImageColor3 = "TextPrimary"
        }
    }
}

function SimpleUI:createButton(page, text, callback, options)
    if not page then
        return
    end

    options = options or {}
    local theme = self:getTheme(page)
    local data = self:merge(self.DefaultElements.Button, options)
    local mobile = self:isMobile()

    local props = self:applyTheme(data.Properties, data.Theme, theme)
    props.Name = "ButtonContainer"
    local button = self:createElement(data.Class, props, page)

    if data.Theme then
        local httpService = self:getService("HttpService")
        button:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Theme))
    end

    if data.Corner then
        local corner = self:createElement("UICorner", {}, button)
        corner:SetAttribute("_sui_original_CornerRadius", data.Corner.CornerRadius)
        corner.CornerRadius = UDim.new(0, self:scale(data.Corner.CornerRadius))
    end

    local titleProps = self:applyTheme(data.Title.Properties, data.Title.Theme, theme)
    titleProps.Text = text or titleProps.Text
    titleProps.ZIndex = 5
    local title = self:createElement("TextLabel", titleProps, button)

    if data.Title.Theme then
        local httpService = self:getService("HttpService")
        title:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Title.Theme))
    end

    local arrowProps = self:applyTheme(data.Arrow.Properties, data.Arrow.Theme, theme)
    arrowProps.ZIndex = 5
    local arrow = self:createElement("ImageLabel", arrowProps, button)

    if data.Arrow.Theme then
        local httpService = self:getService("HttpService")
        arrow:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Arrow.Theme))
    end

    local state, held = "Base", false

    local function setColor(s)
        if s == "Base" then
            button.BackgroundColor3 = theme.SecondaryColor
        elseif s == "Hover" then
            button.BackgroundColor3 = theme.SecondaryColorHover
        elseif s == "Button1Down" then
            button.BackgroundColor3 = theme.SecondaryColorMouse1Down
        end
    end

    if not mobile then
        button.MouseEnter:Connect(wrapCallback(function()
            if not held then
                state = "Hover"
                setColor(state)
            end
        end))

        button.MouseLeave:Connect(wrapCallback(function()
            if held then
                held = false
            end
            state = "Base"
            setColor(state)
        end))

        button.MouseButton1Down:Connect(wrapCallback(function()
            held = true
            state = "Button1Down"
            setColor(state)
        end))

        button.MouseButton1Up:Connect(wrapCallback(function()
            if held then
                held = false
                state = "Hover"
                setColor(state)
                if callback then
                    task.spawn(callback)
                end
            end
        end))
    else
        button.Activated:Connect(wrapCallback(function()
            state = "Button1Down"
            setColor(state)
            task.delay(0.1, function()
                state = "Base"
                setColor(state)
            end)
            if callback then
                task.spawn(callback)
            end
        end))
    end

    setColor("Base")

    return {
        Button = button,
        Title = title,
        Arrow = arrow,
        setTitle = function(t)
            title.Text = t
        end,
        setVisible = function(v)
            button.Visible = v
        end,
        getState = function()
            return state
        end
    }
end

SimpleUI.DefaultElements.Toggle = {
    Class = "Frame",
    Properties = {
        Size = UDim2.new(1, 0, 0, 35),
        BorderSizePixel = 0,
        ZIndex = 4
    },
    Theme = {
        BackgroundColor3 = "SecondaryColor",
        BackgroundTransparency = "SecondaryTransparency"
    },
    Corner = {
        CornerRadius = 4
    },
    Label = {
        Size = UDim2.new(0.7, -10, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Text = "Toggle",
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Theme = {
            Font = "SecondaryFont",
            TextColor3 = "TextPrimary"
        }
    },
    Switch = {
        Size = UDim2.new(0, 40, 0, 20),
        Position = UDim2.new(1, -50, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BorderSizePixel = 0,
        Theme = {
            BackgroundColor3 = "SecondaryColorMouse1Down"
        }
    },
    Indicator = {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 2, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BorderSizePixel = 0,
        Theme = {
            BackgroundColor3 = "TextInactive"
        }
    }
}

function SimpleUI:createToggle(page, text, defaultValue, callback, options)
    if not page then
        return
    end

    options = options or {}
    local theme = self:getTheme(page)
    local data = self:merge(self.DefaultElements.Toggle, options)

    local containerProps = self:applyTheme(data.Properties, data.Theme, theme)
    local container = self:createElement(data.Class, containerProps, page)

    if data.Theme then
        local httpService = self:getService("HttpService")
        container:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Theme))
    end

    if data.Corner then
        local corner = self:createElement("UICorner", {}, container)
        corner:SetAttribute("_sui_original_CornerRadius", data.Corner.CornerRadius)
        corner.CornerRadius = UDim.new(0, self:scale(data.Corner.CornerRadius))
    end

    local labelProps = self:applyTheme(data.Label, data.Label.Theme, theme)
    labelProps.Text = text
    labelProps.BackgroundTransparency = 1
    labelProps.ZIndex = 5
    local label = self:createElement("TextLabel", labelProps, container)

    if data.Label.Theme then
        local httpService = self:getService("HttpService")
        label:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Label.Theme))
    end

    local switchProps = self:applyTheme(data.Switch, data.Switch.Theme, theme)
    switchProps.Text = ""
    switchProps.AutoButtonColor = false
    switchProps.ZIndex = 5
    local switch = self:createElement("TextButton", switchProps, container)

    if data.Switch.Theme then
        local httpService = self:getService("HttpService")
        switch:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Switch.Theme))
    end

    local switchCorner = self:createElement("UICorner", {}, switch)
    switchCorner:SetAttribute("_sui_original_CornerRadius", 999)
    switchCorner.CornerRadius = UDim.new(1, 0)

    local indicatorProps = self:applyTheme(data.Indicator, data.Indicator.Theme, theme)
    indicatorProps.ZIndex = 6
    local indicator = self:createElement("Frame", indicatorProps, switch)

    if data.Indicator.Theme then
        local httpService = self:getService("HttpService")
        indicator:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Indicator.Theme))
    end

    local indicatorCorner = self:createElement("UICorner", {}, indicator)
    indicatorCorner:SetAttribute("_sui_original_CornerRadius", 999)
    indicatorCorner.CornerRadius = UDim.new(1, 0)

    local state = defaultValue or false
    local tweenService = self:getService("TweenService")

    local function updateToggle(animate)
        local posGoal = state and UDim2.new(1, self:scale(-18), 0.5, 0) or UDim2.new(0, self:scale(2), 0.5, 0)
        local colorGoal = state and theme.AccentColor or theme.SecondaryColorMouse1Down
        local indicatorColorGoal = state and theme.TextActive or theme.TextInactive

        if animate then
            tweenService:Create(indicator, TweenInfo.new(0.2), {
                Position = posGoal
            }):Play()
            tweenService:Create(switch, TweenInfo.new(0.2), {
                BackgroundColor3 = colorGoal
            }):Play()
            tweenService:Create(indicator, TweenInfo.new(0.2), {
                BackgroundColor3 = indicatorColorGoal
            }):Play()
        else
            indicator.Position = posGoal
            switch.BackgroundColor3 = colorGoal
            indicator.BackgroundColor3 = indicatorColorGoal
        end
    end

    updateToggle(false)

    if state and callback then
        task.spawn(callback, state)
    end

    switch.Activated:Connect(wrapCallback(function()
        state = not state
        updateToggle(true)
        if callback then
            task.spawn(callback, state)
        end
    end))

    return {
        container = container,
        getState = function()
            return state
        end,
        setState = function(val)
            state = val
            updateToggle(true)
        end
    }
end

SimpleUI.DefaultElements.Slider = {
    Class = "Frame",
    Properties = {
        Size = UDim2.new(1, 0, 0, 50),
        BorderSizePixel = 0,
        ZIndex = 4
    },
    Theme = {
        BackgroundColor3 = "SecondaryColor",
        BackgroundTransparency = "SecondaryTransparency"
    },
    Corner = {
        CornerRadius = 4
    },
    Label = {
        Size = UDim2.new(1, -60, 0, 20),
        Position = UDim2.new(0, 10, 0, 8),
        Text = "Slider",
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Theme = {
            Font = "SecondaryFont",
            TextColor3 = "TextPrimary"
        }
    },
    Value = {
        Size = UDim2.new(0, 50, 0, 20),
        Position = UDim2.new(1, -10, 0, 8),
        AnchorPoint = Vector2.new(1, 0),
        TextSize = 13,
        Theme = {
            Font = "SecondaryFont",
            TextColor3 = "TextSecondary"
        }
    },
    Track = {
        Size = UDim2.new(1, -20, 0, 4),
        Position = UDim2.new(0, 10, 1, -12),
        Theme = {
            BackgroundColor3 = "TertiaryColorMouse1Down"
        }
    },
    Fill = {
        Size = UDim2.new(0.5, 0, 1, 0),
        Theme = {
            BackgroundColor3 = "AccentColor"
        }
    },
    Thumb = {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Theme = {
            BackgroundColor3 = "TextActive"
        }
    }
}

function SimpleUI:createSlider(page, text, min, max, defaultValue, callback, options)
    if not page then
        return
    end

    options = options or {}
    local theme = self:getTheme(page)
    local data = self:merge(self.DefaultElements.Slider, options)
    local increment = options.Increment or 1

    local containerProps = self:applyTheme(data.Properties, data.Theme, theme)
    local container = self:createElement(data.Class, containerProps, page)

    if data.Theme then
        local httpService = self:getService("HttpService")
        container:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Theme))
    end

    if data.Corner then
        local corner = self:createElement("UICorner", {}, container)
        corner:SetAttribute("_sui_original_CornerRadius", data.Corner.CornerRadius)
        corner.CornerRadius = UDim.new(0, self:scale(data.Corner.CornerRadius))
    end

    local labelProps = self:applyTheme(data.Label, data.Label.Theme, theme)
    labelProps.Text = text
    labelProps.BackgroundTransparency = 1
    labelProps.ZIndex = 5
    local label = self:createElement("TextLabel", labelProps, container)

    if data.Label.Theme then
        local httpService = self:getService("HttpService")
        label:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Label.Theme))
    end

    local valueProps = self:applyTheme(data.Value, data.Value.Theme, theme)
    valueProps.Text = tostring(defaultValue or min)
    valueProps.BackgroundTransparency = 1
    valueProps.TextXAlignment = Enum.TextXAlignment.Right
    valueProps.ZIndex = 5
    local valueLabel = self:createElement("TextLabel", valueProps, container)

    if data.Value.Theme then
        local httpService = self:getService("HttpService")
        valueLabel:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Value.Theme))
    end

    local trackProps = self:applyTheme(data.Track, data.Track.Theme, theme)
    trackProps.BorderSizePixel = 0
    trackProps.ZIndex = 5
    local track = self:createElement("Frame", trackProps, container)

    if data.Track.Theme then
        local httpService = self:getService("HttpService")
        track:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Track.Theme))
    end

    local trackCorner = self:createElement("UICorner", {}, track)
    trackCorner:SetAttribute("_sui_original_CornerRadius", 999)
    trackCorner.CornerRadius = UDim.new(1, 0)

    local fillProps = self:applyTheme(data.Fill, data.Fill.Theme, theme)
    fillProps.BorderSizePixel = 0
    fillProps.ZIndex = 6
    local fill = self:createElement("Frame", fillProps, track)

    if data.Fill.Theme then
        local httpService = self:getService("HttpService")
        fill:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Fill.Theme))
    end

    local fillCorner = self:createElement("UICorner", {}, fill)
    fillCorner:SetAttribute("_sui_original_CornerRadius", 999)
    fillCorner.CornerRadius = UDim.new(1, 0)

    local thumbProps = self:applyTheme(data.Thumb, data.Thumb.Theme, theme)
    thumbProps.BorderSizePixel = 0
    thumbProps.ZIndex = 7
    local thumb = self:createElement("Frame", thumbProps, track)

    if data.Thumb.Theme then
        local httpService = self:getService("HttpService")
        thumb:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Thumb.Theme))
    end

    local thumbCorner = self:createElement("UICorner", {}, thumb)
    thumbCorner:SetAttribute("_sui_original_CornerRadius", 999)
    thumbCorner.CornerRadius = UDim.new(1, 0)

    local dragging = false
    local value = defaultValue or min

    local function round(num)
        return math.floor(num / increment + 0.5) * increment
    end

    local function updateSlider(val)
        value = math.clamp(round(val), min, max)
        local percent = (value - min) / (max - min)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        thumb.Position = UDim2.new(percent, 0, 0.5, 0)
        valueLabel.Text = tostring(value)
        if callback then
            task.spawn(callback, value)
        end
    end

    local function onInput(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            local percent = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            updateSlider(min + (max - min) * percent)
        end
    end

    track.InputBegan:Connect(wrapCallback(onInput))
    thumb.InputBegan:Connect(wrapCallback(onInput))

    local uis = self:getService("UserInputService")
    uis.InputChanged:Connect(wrapCallback(function(input)
        if dragging and
            (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local percent = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            updateSlider(min + (max - min) * percent)
        end
    end))

    uis.InputEnded:Connect(wrapCallback(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end))

    updateSlider(value)

    return {
        container = container,
        getValue = function()
            return value
        end,
        setValue = function(val)
            updateSlider(val)
        end,
        setMin = function(newMin)
            min = newMin
            updateSlider(value)
        end,
        setMax = function(newMax)
            max = newMax
            updateSlider(value)
        end
    }
end

SimpleUI.DefaultElements.TextInput = {
    Class = "Frame",
    Properties = {
        Size = UDim2.new(1, 0, 0, 35),
        BorderSizePixel = 0,
        ZIndex = 4
    },
    Theme = {
        BackgroundColor3 = "SecondaryColor",
        BackgroundTransparency = "SecondaryTransparency"
    },
    Corner = {
        CornerRadius = 4
    },
    Label = {
        Size = UDim2.new(0.35, -10, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Text = "Input",
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Theme = {
            Font = "SecondaryFont",
            TextColor3 = "TextPrimary"
        }
    },
    Input = {
        Size = UDim2.new(0.35, 0, 0, 30),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        TextSize = 13,
        PlaceholderText = "Enter text...",
        Theme = {
            Font = "SecondaryFont",
            TextColor3 = "TextPrimary",
            BackgroundColor3 = "TertiaryColor",
            PlaceholderColor3 = "TextSecondary"
        }
    },
    Underline = {
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        Theme = {
            BackgroundColor3 = "TertiaryColor"
        }
    }
}

function SimpleUI:createTextInput(page, text, defaultValue, callback, options)
    if not page then
        return
    end

    options = options or {}
    local theme = self:getTheme(page)
    local data = self:merge(self.DefaultElements.TextInput, options)
    local mobile = self:isMobile()

    local containerProps = self:applyTheme(data.Properties, data.Theme, theme)
    local container = self:createElement(data.Class, containerProps, page)

    if data.Theme then
        local httpService = self:getService("HttpService")
        container:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Theme))
    end

    if data.Corner then
        local corner = self:createElement("UICorner", {}, container)
        corner:SetAttribute("_sui_original_CornerRadius", data.Corner.CornerRadius)
        corner.CornerRadius = UDim.new(0, self:scale(data.Corner.CornerRadius))
    end

    local labelProps = self:applyTheme(data.Label, data.Label.Theme, theme)
    labelProps.Text = text
    labelProps.BackgroundTransparency = 1
    labelProps.ZIndex = 5
    local label = self:createElement("TextLabel", labelProps, container)

    if data.Label.Theme then
        local httpService = self:getService("HttpService")
        label:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Label.Theme))
    end

    local inputProps = self:applyTheme(data.Input, data.Input.Theme, theme)
    inputProps.BorderSizePixel = 0
    inputProps.Text = defaultValue or ""
    inputProps.ClearTextOnFocus = false
    inputProps.ZIndex = 5
    local inputBox = self:createElement("TextBox", inputProps, container)

    if data.Input.Theme then
        local httpService = self:getService("HttpService")
        inputBox:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Input.Theme))
    end

    local inputCorner = self:createElement("UICorner", {}, inputBox)
    inputCorner:SetAttribute("_sui_original_CornerRadius", 4)
    inputCorner.CornerRadius = UDim.new(0, self:scale(4))

    local inputPadding = self:createElement("UIPadding", {}, inputBox)
    inputPadding:SetAttribute("_sui_original_PaddingLeft", 8)
    inputPadding:SetAttribute("_sui_original_PaddingRight", 8)
    inputPadding.PaddingLeft = UDim.new(0, self:scale(8))
    inputPadding.PaddingRight = UDim.new(0, self:scale(8))

    local underlineProps = self:applyTheme(data.Underline, data.Underline.Theme, theme)
    underlineProps.BorderSizePixel = 0
    underlineProps.ZIndex = 6
    local underline = self:createElement("Frame", underlineProps, inputBox)

    if data.Underline.Theme then
        local httpService = self:getService("HttpService")
        underline:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Underline.Theme))
    end

    local underlineCorner = self:createElement("UICorner", {}, underline)
    underlineCorner:SetAttribute("_sui_original_CornerRadius", 999)
    underlineCorner.CornerRadius = UDim.new(1, 0)

    local isFocused = false
    local tween = self:getService("TweenService")

    inputBox.Focused:Connect(wrapCallback(function()
        isFocused = true
        tween:Create(underline, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = theme.AccentColor
        }):Play()
    end))

    inputBox.FocusLost:Connect(wrapCallback(function()
        isFocused = false
        tween:Create(underline, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = theme.TertiaryColorMouse1Down
        }):Play()
        if callback then
            task.spawn(callback, inputBox.Text)
        end
    end))

    if not mobile then
        inputBox.MouseEnter:Connect(wrapCallback(function()
            if not isFocused then
                inputBox.BackgroundColor3 = theme.TertiaryColorHover
            end
        end))

        inputBox.MouseLeave:Connect(wrapCallback(function()
            if not isFocused then
                inputBox.BackgroundColor3 = theme.TertiaryColor
            end
        end))
    end

    return {
        container = container,
        getValue = function()
            return inputBox.Text
        end,
        setValue = function(val)
            inputBox.Text = val or ""
        end,
        setPlaceholder = function(p)
            inputBox.PlaceholderText = p or ""
        end,
        clear = function()
            inputBox.Text = ""
        end
    }
end

SimpleUI.DefaultElements.Paragraph = {
    Class = "Frame",
    Properties = {
        Size = UDim2.new(1, 0, 0, 50),
        BorderSizePixel = 0,
        ZIndex = 4
    },
    Theme = {
        BackgroundColor3 = "SecondaryColor",
        BackgroundTransparency = "SecondaryTransparency"
    },
    Corner = {
        CornerRadius = 4
    },
    Title = {
        Size = UDim2.new(1, -20, 0, 20),
        Position = UDim2.new(0, 10, 0, 8),
        Text = "Paragraph",
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Theme = {
            Font = "PrimaryFont",
            TextColor3 = "TextActive"
        }
    },
    Field = {
        Size = UDim2.new(1, 0, 0, 18),
        TextSize = 14,
        Theme = {
            Font = "SecondaryFont",
            TextColor3 = "TextPrimary"
        }
    },
    SubField = {
        Size = UDim2.new(1, 0, 0, 16),
        TextSize = 13,
        Theme = {
            Font = "SecondaryFont",
            TextColor3 = "TextSecondary"
        }
    }
}

function SimpleUI:createParagraph(page, title, fields, options)
    if not page then
        return
    end

    options = options or {}
    local theme = self:getTheme(page)
    local data = self:merge(self.DefaultElements.Paragraph, options)

    local containerProps = self:applyTheme(data.Properties, data.Theme, theme)
    containerProps.AutomaticSize = Enum.AutomaticSize.Y
    local container = self:createElement(data.Class, containerProps, page)

    if data.Theme then
        local httpService = self:getService("HttpService")
        container:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Theme))
    end

    if data.Corner then
        local corner = self:createElement("UICorner", {}, container)
        corner:SetAttribute("_sui_original_CornerRadius", data.Corner.CornerRadius)
        corner.CornerRadius = UDim.new(0, self:scale(data.Corner.CornerRadius))
    end

    local contentContainer = self:createElement("Frame", {
        Size = UDim2.new(1, self:scale(-20), 0, 0),
        Position = UDim2.new(0, self:scale(10), 0, self:scale(8)),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 5
    }, container)

    local layout = self:createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder
    }, contentContainer)

    layout:SetAttribute("_sui_original_Padding", 4)
    layout.Padding = UDim.new(0, self:scale(4))

    local titleProps = self:applyTheme(data.Title, data.Title.Theme, theme)
    titleProps.Text = title or "Paragraph"
    titleProps.BackgroundTransparency = 1
    titleProps.AutomaticSize = Enum.AutomaticSize.Y
    titleProps.TextWrapped = true
    titleProps.LayoutOrder = 0
    titleProps.ZIndex = 5
    local titleLabel = self:createElement("TextLabel", titleProps, contentContainer)

    if data.Title.Theme then
        local httpService = self:getService("HttpService")
        titleLabel:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Title.Theme))
    end

    local function updateContainerSize()
        container.Size = UDim2.new(container.Size.X.Scale, container.Size.X.Offset, 0,
            layout.AbsoluteContentSize.Y + self:scale(16))
    end

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(wrapCallback(updateContainerSize))
    task.defer(updateContainerSize)

    local fieldElements = {}
    local fieldCounter = 0

    local function createField(fieldData, layoutOrder)
        fieldCounter = fieldCounter + 1
        local fieldId = "field_" .. fieldCounter
        local isSubField = fieldData.isSubField or false
        local fieldConfig = isSubField and data.SubField or data.Field

        local fieldProps = self:applyTheme({
            Size = UDim2.new(1, isSubField and self:scale(-20) or 0, 0, 0),
            Position = isSubField and UDim2.new(0, self:scale(20), 0, 0) or UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = fieldData.text or "",
            TextSize = fieldConfig.TextSize,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextWrapped = true,
            LayoutOrder = layoutOrder or (fieldCounter + 1),
            ZIndex = 5
        }, fieldConfig.Theme, theme)

        local field = self:createElement("TextLabel", fieldProps, contentContainer)

        if fieldConfig.Theme then
            local httpService = self:getService("HttpService")
            field:SetAttribute("_sui_themeMap", httpService:JSONEncode(fieldConfig.Theme))
        end

        fieldElements[fieldId] = {
            element = field,
            data = fieldData,
            id = fieldId
        }

        return fieldId, field
    end

    if fields and type(fields) == "table" then
        for i, fieldData in ipairs(fields) do
            createField(type(fieldData) == "string" and {
                text = fieldData
            } or fieldData, i)
        end
    end

    return {
        container = container,
        addField = function(text, isSubField, position)
            return createField({
                text = text,
                isSubField = isSubField or false
            }, position or (fieldCounter + 2))
        end,
        removeField = function(fieldId)
            if not fieldElements[fieldId] then
                return false
            end
            fieldElements[fieldId].element:Destroy()
            fieldElements[fieldId] = nil
            return true
        end,
        setField = function(fieldId, text)
            if not fieldElements[fieldId] then
                return false
            end
            fieldElements[fieldId].element.Text = text
            fieldElements[fieldId].data.text = text
            return true
        end,
        getField = function(fieldId)
            return fieldElements[fieldId] and fieldElements[fieldId].data.text or nil
        end,
        setTitle = function(newTitle)
            titleLabel.Text = newTitle
        end,
        clearFields = function()
            for id, fieldData in pairs(fieldElements) do
                fieldData.element:Destroy()
            end
            fieldElements, fieldCounter = {}, 0
        end
    }
end

function SimpleUI:createNotification(options)
    local isDismissing = false
    options = options or {}
    local container = getHiddenContainer()
    local containerName = "SimpleUI_NotificationContainer_" .. generateId()
    local isMobile = self:isMobile()

    local gui = container:FindFirstChild(containerName)
    if not gui then
        gui = self:createElement("ScreenGui", {
            Name = containerName,
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 999
        }, container)

        protectInstance(gui)

        local holderSize = isMobile and UDim2.new(0, 280, 1, 0) or UDim2.new(0, 320, 1, 0)
        local holderPosition = isMobile and UDim2.new(0.5, 0, 0, 10) or UDim2.new(1, self:scale(-15), 0, self:scale(15))
        local holderAnchor = isMobile and Vector2.new(0.5, 0) or Vector2.new(1, 0)

        local holder = self:createElement("Frame", {
            Name = "Holder",
            Position = holderPosition,
            AnchorPoint = holderAnchor,
            Size = holderSize,
            BackgroundTransparency = 1
        }, gui)

        local layout = self:createElement("UIListLayout", {
            Name = "Layout",
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = isMobile and Enum.HorizontalAlignment.Center or Enum.HorizontalAlignment.Right
        }, holder)

        layout:SetAttribute("_sui_original_Padding", isMobile and 6 or 8)
        layout.Padding = UDim.new(0, self:scale(isMobile and 6 or 8))
    end

    local holder = gui:FindFirstChild("Holder")
    local theme = options.Theme or self.Themes.Default
    local notifType = options.Type or "Default"

    local typeColors = {
        Default = Color3.fromRGB(200, 200, 200),
        Info = Color3.fromRGB(30, 144, 255),
        Success = Color3.fromRGB(40, 167, 69),
        Warning = Color3.fromRGB(255, 193, 7),
        Error = Color3.fromRGB(220, 53, 69)
    }

    local typeIcons = {
        Default = "rbxassetid://10709775704",
        Info = "rbxassetid://10723415903",
        Success = "rbxassetid://10734951367",
        Warning = "rbxassetid://10734951173",
        Error = "rbxassetid://10747384037"
    }

    local accentColor = typeColors[notifType] or typeColors.Default
    local duration = options.Duration or 5

    local notification = self:createElement("Frame", {
        Name = "Notification",
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(28, 28, 32),
        BorderSizePixel = 0,
        ClipsDescendants = false,
        LayoutOrder = tick()
    }, holder)

    self:createElement("Frame", {
        Name = "AccentBar",
        Size = UDim2.new(0, self:scale(2), 1, 0),
        BackgroundColor3 = accentColor,
        BorderSizePixel = 0
    }, notification)

    local shadow = self:createElement("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, self:scale(20), 1, self:scale(20)),
        BackgroundTransparency = 1,
        Image = "rbxassetid://7717391613",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.75,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        ZIndex = 0
    }, notification)

    local basePadding = isMobile and 8 or 10
    local sidePadding = isMobile and 10 or 12

    local content = self:createElement("Frame", {
        Name = "Content",
        Position = UDim2.new(0, self:scale(2), 0, 0),
        Size = UDim2.new(1, self:scale(-2), 1, 0),
        BackgroundTransparency = 1
    }, notification)

    local contentPadding = self:createElement("UIPadding", {}, content)
    contentPadding:SetAttribute("_sui_original_PaddingTop", basePadding)
    contentPadding:SetAttribute("_sui_original_PaddingBottom", basePadding)
    contentPadding:SetAttribute("_sui_original_PaddingLeft", sidePadding)
    contentPadding:SetAttribute("_sui_original_PaddingRight", sidePadding)
    contentPadding.PaddingTop = UDim.new(0, self:scale(basePadding))
    contentPadding.PaddingBottom = UDim.new(0, self:scale(basePadding))
    contentPadding.PaddingLeft = UDim.new(0, self:scale(sidePadding))
    contentPadding.PaddingRight = UDim.new(0, self:scale(sidePadding))

    local hasIcon = options.Icon == nil
    local iconImage = options.Icon or typeIcons[notifType]
    local iconSize = isMobile and 18 or (options.IconSize or 20)

    local iconFrame
    if hasIcon and iconImage then
        iconFrame = self:createElement("ImageLabel", {
            Name = "Icon",
            Size = UDim2.new(0, self:scale(iconSize), 0, self:scale(iconSize)),
            Position = UDim2.new(0, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Image = iconImage,
            ImageColor3 = options.IconColor or accentColor,
            ScaleType = Enum.ScaleType.Fit
        }, content)
    end

    local showClose = options.Closable ~= false
    local textOffset = hasIcon and (self:scale(iconSize) + self:scale(isMobile and 8 or 10)) or 0

    local textContainer = self:createElement("Frame", {
        Name = "TextContainer",
        Position = UDim2.new(0, textOffset, 0, 0),
        Size = UDim2.new(1, -textOffset, 1, 0),
        BackgroundTransparency = 1
    }, content)

    local textLayout = self:createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center
    }, textContainer)

    textLayout:SetAttribute("_sui_original_Padding", isMobile and 1 or 2)
    textLayout.Padding = UDim.new(0, self:scale(isMobile and 1 or 2))

    local titleSize = isMobile and 12 or (options.TitleSize or 13)
    local title = self:createElement("TextLabel", {
        Name = "Title",
        LayoutOrder = 1,
        Size = UDim2.new(1, showClose and self:scale(-(isMobile and 22 or 26)) or 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text = options.Title or "Notification",
        Font = Enum.Font.GothamBold,
        TextSize = titleSize,
        TextColor3 = options.TitleColor or Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        RichText = true,
        LineHeight = 1.1
    }, textContainer)

    title:SetAttribute("_sui_original_TextSize", titleSize)

    if options.Description then
        local descSize = isMobile and 11 or (options.DescriptionSize or 12)
        local description = self:createElement("TextLabel", {
            Name = "Description",
            LayoutOrder = 2,
            Size = UDim2.new(1, showClose and self:scale(-(isMobile and 22 or 26)) or 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = options.Description,
            Font = Enum.Font.Gotham,
            TextSize = descSize,
            TextColor3 = options.DescriptionColor or Color3.fromRGB(185, 185, 190),
            TextTransparency = 0.2,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            RichText = true,
            LineHeight = 1.2
        }, textContainer)

        description:SetAttribute("_sui_original_TextSize", descSize)
    end

    if showClose then
        local closeSize = isMobile and 16 or 18
        local closeButton = self:createElement("TextButton", {
            Name = "CloseButton",
            Position = UDim2.new(1, 0, 0, 0),
            AnchorPoint = Vector2.new(1, 0),
            Size = UDim2.new(0, self:scale(closeSize), 0, self:scale(closeSize)),
            BackgroundTransparency = 1,
            Text = "×",
            Font = Enum.Font.GothamBold,
            TextSize = isMobile and 18 or 20,
            TextColor3 = Color3.fromRGB(140, 140, 145),
            AutoButtonColor = false
        }, content)

        closeButton:SetAttribute("_sui_original_TextSize", isMobile and 18 or 20)

        local isHovering = false
        closeButton.MouseEnter:Connect(wrapCallback(function()
            isHovering = true
            local TweenService = self:getService("TweenService")
            TweenService:Create(closeButton, TweenInfo.new(0.15), {
                TextColor3 = Color3.fromRGB(255, 85, 85),
                Rotation = 90
            }):Play()
        end))

        closeButton.MouseLeave:Connect(wrapCallback(function()
            isHovering = false
            local TweenService = self:getService("TweenService")
            TweenService:Create(closeButton, TweenInfo.new(0.15), {
                TextColor3 = Color3.fromRGB(140, 140, 145),
                Rotation = 0
            }):Play()
        end))

        closeButton.MouseButton1Click:Connect(wrapCallback(function()
            if not isHovering then
                return
            end
            if isDismissing then
                return
            end
            isDismissing = true
            self:dismissNotification(notification)
        end))
    end

    if options.Callback then
        local clickArea = self:createElement("TextButton", {
            Name = "ClickArea",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = "",
            ZIndex = 1
        }, notification)

        clickArea.MouseButton1Click:Connect(wrapCallback(function()
            task.spawn(options.Callback, notification)
        end))

        clickArea.MouseEnter:Connect(wrapCallback(function()
            local TweenService = self:getService("TweenService")
            TweenService:Create(notification, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(35, 35, 40)
            }):Play()
        end))

        clickArea.MouseLeave:Connect(wrapCallback(function()
            local TweenService = self:getService("TweenService")
            TweenService:Create(notification, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(28, 28, 32)
            }):Play()
        end))
    end

    task.defer(function()
        task.wait()

        local contentSize
        if options.Height then
            contentSize = self:scale(options.Height)
        else
            local textHeight = 0
            for _, child in ipairs(textContainer:GetChildren()) do
                if child:IsA("TextLabel") then
                    textHeight = textHeight + child.AbsoluteSize.Y
                end
            end

            local layoutPadding = textContainer:FindFirstChildOfClass("UIListLayout")
            if layoutPadding and #textContainer:GetChildren() > 1 then
                textHeight = textHeight + (layoutPadding.Padding.Offset * (#textContainer:GetChildren() - 1))
            end

            local minHeight = hasIcon and (self:scale(iconSize) + self:scale(basePadding * 2)) or
                                  self:scale(isMobile and 38 or 42)
            contentSize = math.max(textHeight + self:scale(basePadding * 2), minHeight)
        end

        notification.Size = UDim2.new(1, 0, 0, contentSize)
        notification.Position = UDim2.new(0, isMobile and self:scale(15) or self:scale(20), 0, 0)
        notification.BackgroundTransparency = 1
        shadow.ImageTransparency = 1

        if content then
            for _, child in ipairs(content:GetDescendants()) do
                if child:IsA("TextLabel") or child:IsA("TextButton") then
                    child.TextTransparency = 1
                elseif child:IsA("ImageLabel") and child.Name ~= "Shadow" then
                    child.ImageTransparency = 1
                elseif child:IsA("Frame") and child.Name ~= "TextContainer" and child.Name ~= "Content" then
                    child.BackgroundTransparency = 1
                end
            end
        end

        local TweenService = self:getService("TweenService")
        local slideInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local enterTweens = {}

        table.insert(enterTweens, TweenService:Create(notification, slideInfo, {
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 0
        }))

        table.insert(enterTweens, TweenService:Create(shadow, slideInfo, {
            ImageTransparency = 0.75
        }))

        if content then
            for _, child in ipairs(content:GetDescendants()) do
                if child:IsA("TextLabel") or child:IsA("TextButton") then
                    table.insert(enterTweens, TweenService:Create(child, slideInfo, {
                        TextTransparency = 0
                    }))
                elseif child:IsA("ImageLabel") and child.Name ~= "Shadow" then
                    table.insert(enterTweens, TweenService:Create(child, slideInfo, {
                        ImageTransparency = 0
                    }))
                elseif child:IsA("Frame") and child.Name == "AccentBar" then
                    table.insert(enterTweens, TweenService:Create(child, slideInfo, {
                        BackgroundTransparency = 0
                    }))
                end
            end
        end

        for _, tween in ipairs(enterTweens) do
            tween:Play()
        end

        if options.Progress ~= false then
            local progressBar = self:createElement("Frame", {
                Name = "ProgressBar",
                Position = UDim2.new(0, 0, 1, self:scale(-2)),
                Size = UDim2.new(1, 0, 0, self:scale(2)),
                BackgroundColor3 = accentColor,
                BorderSizePixel = 0,
                ZIndex = 10
            }, notification)

            TweenService:Create(progressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
                Size = UDim2.new(0, 0, 0, self:scale(2))
            }):Play()
        end

        if options.AutoDismiss ~= false then
            task.wait(duration)
            if not isDismissing then
                isDismissing = true
                self:dismissNotification(notification)
            end
        end
    end)

    return notification
end

function SimpleUI:dismissNotification(notification)
    if not notification or not notification.Parent then
        return
    end

    local TweenService = self:getService("TweenService")
    local fadeInfo = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local shadow = notification:FindFirstChild("Shadow")
    local tweens = {}

    table.insert(tweens, TweenService:Create(notification, fadeInfo, {
        BackgroundTransparency = 1
    }))

    if shadow then
        table.insert(tweens, TweenService:Create(shadow, fadeInfo, {
            ImageTransparency = 1
        }))
    end

    for _, obj in ipairs(notification:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") then
            table.insert(tweens, TweenService:Create(obj, fadeInfo, {
                TextTransparency = 1
            }))
        elseif obj:IsA("ImageLabel") and obj ~= shadow then
            table.insert(tweens, TweenService:Create(obj, fadeInfo, {
                ImageTransparency = 1
            }))
        elseif obj:IsA("Frame") and obj ~= notification then
            table.insert(tweens, TweenService:Create(obj, fadeInfo, {
                BackgroundTransparency = 1
            }))
        end
    end

    for _, tween in ipairs(tweens) do
        tween:Play()
    end

    task.delay(0.35, function()
        TweenService:Create(notification, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 0, 0)
        }):Play()
        task.wait(0.15)
        notification:Destroy()
    end)
end

function SimpleUI:createPopup(overlayName, options)
    local function convertMarkdownToRichText(markdown)
        local text = markdown
        text = text:gsub("### (.-)\n", '<font size="18"><b>%1</b></font>\n')
        text = text:gsub("## (.-)\n", '<font size="20"><b>%1</b></font>\n')
        text = text:gsub("# (.-)\n", '<font size="22"><b>%1</b></font>\n')
        text = text:gsub("%*%*%*(.-)%*%*%*", "<b><i>%1</i></b>")
        text = text:gsub("%*%*(.-)%*%*", "<b>%1</b>")
        text = text:gsub("%*(.-)%*", "<i>%1</i>")
        text = text:gsub("__(.-)__", "<b>%1</b>")
        text = text:gsub("_(.-)_", "<i>%1</i>")
        text = text:gsub("~~(.-)~~", "<s>%1</s>")
        text = text:gsub("`([^`]+)`",
            '<font face="RobotoMono"><stroke color="rgb(50,50,60)" joins="miter" thickness="3" transparency="0">%1</stroke></font>')
        text = text:gsub("```(.-)```", function(code)
            return
                '<font face="RobotoMono" size="13"><stroke color="rgb(50,50,60)" joins="miter" thickness="3" transparency="0">' ..
                    code .. '</stroke></font>'
        end)
        text = text:gsub("%[(.-)%]%((.-)%)", '<font color="rgb(100,150,255)"><u>%1</u></font>')
        text = text:gsub("^%- (.-)\n", "• %1\n")
        text = text:gsub("\n%- (.-)\n", "\n• %1\n")
        text = text:gsub("\n%- (.-)", "\n• %1")
        text = text:gsub("^%* (.-)\n", "• %1\n")
        text = text:gsub("\n%* (.-)\n", "\n• %1\n")
        text = text:gsub("\n%* (.-)", "\n• %1")
        text = text:gsub("^%d+%. (.-)\n", "%1\n")
        text = text:gsub("\n%d+%. (.-)\n", "\n%1\n")
        text = text:gsub("%-%-%-+", "────────────────────────")
        text = text:gsub("%*%*%*+", "────────────────────────")
        return text
    end

    local title = options.title or "Popup"
    local text = options.text or ""
    local width = options.width or UDim2.new(0.55, 0, 0.8, 0)
    local onClose = options.onClose or function()
    end

    local container = getHiddenContainer()
    local screenGui = self:createElement("ScreenGui", {
        Name = overlayName or "PopupOverlay",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true
    }, container)

    protectInstance(screenGui)

    local blurFrame = self:createElement("TextButton", {
        Name = "BlurBackground",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Modal = true
    }, screenGui)

    local lighting = self:getService("Lighting")
    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Size = self:scale(20)
    blurEffect.Parent = lighting

    local popup = self:createElement("Frame", {
        Name = "Popup",
        Size = width,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(25, 25, 30),
        BorderSizePixel = 0
    }, screenGui)

    local popupCorner = self:createElement("UICorner", {}, popup)
    popupCorner:SetAttribute("_sui_original_CornerRadius", 8)
    popupCorner.CornerRadius = UDim.new(0, self:scale(8))

    local topBar = self:createElement("Frame", {
        Name = "TopBar",
        Size = UDim2.new(1, 0, 0.08, 0),
        BackgroundColor3 = Color3.fromRGB(30, 30, 35),
        BorderSizePixel = 0
    }, popup)

    local topBarCorner = self:createElement("UICorner", {}, topBar)
    topBarCorner:SetAttribute("_sui_original_CornerRadius", 8)
    topBarCorner.CornerRadius = UDim.new(0, self:scale(8))

    local topBarBottom = self:createElement("Frame", {
        Size = UDim2.new(1, 0, 0.2, 0),
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Color3.fromRGB(30, 30, 35),
        BorderSizePixel = 0
    }, topBar)

    local titleLabel = self:createElement("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0.85, 0, 1, 0),
        Position = UDim2.new(0.03, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 15,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextScaled = true
    }, topBar)

    titleLabel:SetAttribute("_sui_original_TextSize", 15)

    local titleConstraint = Instance.new("UITextSizeConstraint")
    titleConstraint.MaxTextSize = self:scale(15)
    titleConstraint.MinTextSize = self:scale(10)
    titleConstraint.Parent = titleLabel

    local closeButton = self:createElement("TextButton", {
        Name = "CloseButton",
        Size = UDim2.new(0.08, 0, 0.65, 0),
        Position = UDim2.new(0.95, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(40, 40, 45),
        Text = "x",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 14,
        Font = Enum.Font.Arcade,
        TextScaled = true
    }, topBar)

    closeButton:SetAttribute("_sui_original_TextSize", 14)

    local closeButtonConstraint = Instance.new("UITextSizeConstraint")
    closeButtonConstraint.MaxTextSize = self:scale(14)
    closeButtonConstraint.MinTextSize = self:scale(10)
    closeButtonConstraint.Parent = closeButton

    local closeButtonCorner = self:createElement("UICorner", {}, closeButton)
    closeButtonCorner.CornerRadius = UDim.new(0.15, 0)

    local containerFrame = self:createElement("ScrollingFrame", {
        Name = "Container",
        Size = UDim2.new(0.93, 0, 0.85, 0),
        Position = UDim2.new(0.035, 0, 0.12, 0),
        BackgroundColor3 = Color3.fromRGB(20, 20, 25),
        BorderSizePixel = 0,
        ScrollBarThickness = self:scale(4),
        ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    }, popup)

    local containerCorner = self:createElement("UICorner", {}, containerFrame)
    containerCorner:SetAttribute("_sui_original_CornerRadius", 6)
    containerCorner.CornerRadius = UDim.new(0, self:scale(6))

    local contentPadding = self:createElement("UIPadding", {}, containerFrame)
    contentPadding.PaddingTop = UDim.new(0.02, 0)
    contentPadding.PaddingBottom = UDim.new(0.02, 0)
    contentPadding.PaddingLeft = UDim.new(0.03, 0)
    contentPadding.PaddingRight = UDim.new(0.03, 0)

    local contentLabel = self:createElement("TextLabel", {
        Name = "Content",
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = convertMarkdownToRichText(text),
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        RichText = true,
        AutomaticSize = Enum.AutomaticSize.Y
    }, containerFrame)

    contentLabel:SetAttribute("_sui_original_TextSize", 14)

    local function closePopup()
        if blurEffect then
            blurEffect:Destroy()
        end
        screenGui:Destroy()
        task.spawn(onClose)
    end

    closeButton.MouseButton1Click:Connect(wrapCallback(closePopup))

    return {
        gui = screenGui,
        popup = popup,
        container = containerFrame,
        contentLabel = contentLabel,
        close = closePopup
    }
end

SimpleUI.DefaultElements.Dropdown = {
    Class = "Frame",
    Properties = {
        Size = UDim2.new(1, 0, 0, 35),
        BorderSizePixel = 0,
        ZIndex = 4
    },
    Theme = {
        BackgroundColor3 = "SecondaryColor",
        BackgroundTransparency = "SecondaryTransparency"
    },
    Corner = {
        CornerRadius = 4
    },
    Label = {
        Size = UDim2.new(0.5, -10, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Text = "Dropdown",
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Theme = {
            Font = "SecondaryFont",
            TextColor3 = "TextPrimary"
        }
    },
    Display = {
        Size = UDim2.new(0, 160, 0, 30),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        TextSize = 13,
        Theme = {
            Font = "SecondaryFont",
            TextColor3 = "TextPrimary",
            BackgroundColor3 = "TertiaryColor"
        }
    },
    Container = {
        Theme = {
            BackgroundColor3 = "TertiaryColor",
            BackgroundTransparency = "PrimaryTransparency"
        }
    },
    Option = {
        Size = UDim2.new(1, 0, 0, 28),
        TextSize = 13,
        Theme = {
            Font = "SecondaryFont",
            TextColor3 = "TextPrimary",
            BackgroundColor3 = "TertiaryColor"
        }
    }
}

function SimpleUI:createDropdown(page, text, options, defaultValue, callback, dropdownOptions)
    if not page then
        return
    end

    dropdownOptions = dropdownOptions or {}
    local theme = self:getTheme(page)
    local data = self:merge(self.DefaultElements.Dropdown, dropdownOptions)
    local mobile = self:isMobile()
    local multiSelect = dropdownOptions.MultiSelect or false

    local httpService = self:getService("HttpService")

    local containerProps = self:applyTheme(data.Properties, data.Theme, theme)
    local container = self:createElement(data.Class, containerProps, page)

    if data.Theme then
        container:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Theme))
    end

    if data.Corner then
        local corner = self:createElement("UICorner", {}, container)
        corner:SetAttribute("_sui_original_CornerRadius", data.Corner.CornerRadius)
        corner.CornerRadius = UDim.new(0, self:scale(data.Corner.CornerRadius))
    end

    local labelProps = self:applyTheme(data.Label, data.Label.Theme, theme)
    labelProps.Text = text
    labelProps.BackgroundTransparency = 1
    labelProps.ZIndex = 5
    local label = self:createElement("TextLabel", labelProps, container)

    if data.Label.Theme then
        label:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Label.Theme))
    end

    local displayProps = self:applyTheme(data.Display, data.Display.Theme, theme)
    displayProps.BorderSizePixel = 0
    displayProps.Text = ""
    displayProps.AutoButtonColor = false
    displayProps.ZIndex = 5
    local display = self:createElement("TextButton", displayProps, container)

    if data.Display.Theme then
        display:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Display.Theme))
    end

    local displayCorner = self:createElement("UICorner", {}, display)
    displayCorner:SetAttribute("_sui_original_CornerRadius", 4)
    displayCorner.CornerRadius = UDim.new(0, self:scale(4))

    local displayLabel = self:createElement("TextLabel", {
        Size = UDim2.new(1, self:scale(-28), 1, 0),
        Position = UDim2.new(0, self:scale(8), 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = displayProps.TextColor3 or theme.TextPrimary,
        TextSize = displayProps.TextSize or 13,
        Font = displayProps.Font or theme.SecondaryFont,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 6
    }, display)

    displayLabel:SetAttribute("_sui_original_TextSize", displayProps.TextSize or 13)

    local arrow = self:createElement("ImageLabel", {
        Size = UDim2.new(0, 12, 0, 12),
        Position = UDim2.new(1, self:scale(-8), 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://10709790948",
        ImageColor3 = theme.TextPrimary,
        ZIndex = 6
    }, display)

    local gui = page
    while gui do
        if gui:IsA("ScreenGui") then
            break
        end
        gui = gui.Parent
    end

    local containerTheme = self:applyTheme({}, data.Container.Theme, theme)
    local listContainer = self:createElement("Frame", {
        Size = UDim2.new(0, displayProps.Size.X.Offset, 0, 0),
        BackgroundColor3 = containerTheme.BackgroundColor3,
        BackgroundTransparency = containerTheme.BackgroundTransparency,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 250,
        ClipsDescendants = true
    }, gui)

    protectInstance(listContainer)

    local listCorner = self:createElement("UICorner", {}, listContainer)
    listCorner:SetAttribute("_sui_original_CornerRadius", 4)
    listCorner.CornerRadius = UDim.new(0, self:scale(4))

    local searchBox = self:createElement("TextBox", {
        Size = UDim2.new(1, self:scale(-8), 0, 28),
        Position = UDim2.new(0, self:scale(4), 0, self:scale(4)),
        BackgroundColor3 = theme.TertiaryColor,
        BorderSizePixel = 0,
        Text = "",
        PlaceholderText = "Search...",
        TextColor3 = theme.TextPrimary,
        PlaceholderColor3 = theme.TextSecondary,
        TextSize = 13,
        Font = theme.SecondaryFont,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        Visible = false,
        ZIndex = 251
    }, listContainer)

    searchBox:SetAttribute("_sui_original_TextSize", 13)

    local searchCorner = self:createElement("UICorner", {}, searchBox)
    searchCorner:SetAttribute("_sui_original_CornerRadius", 4)
    searchCorner.CornerRadius = UDim.new(0, self:scale(4))

    local searchPadding = self:createElement("UIPadding", {}, searchBox)
    searchPadding:SetAttribute("_sui_original_PaddingLeft", 8)
    searchPadding:SetAttribute("_sui_original_PaddingRight", 8)
    searchPadding.PaddingLeft = UDim.new(0, self:scale(8))
    searchPadding.PaddingRight = UDim.new(0, self:scale(8))

    local scrollList = self:createElement("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, self:scale(-36)),
        Position = UDim2.new(0, 0, 0, self:scale(36)),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = self:scale(4),
        ScrollBarImageColor3 = theme.TextSecondary,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = 251,
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    }, listContainer)

    local listLayout = self:createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder
    }, scrollList)

    listLayout:SetAttribute("_sui_original_Padding", 2)
    listLayout.Padding = UDim.new(0, self:scale(2))

    local scrollPadding = self:createElement("UIPadding", {}, scrollList)
    scrollPadding:SetAttribute("_sui_original_PaddingTop", 4)
    scrollPadding:SetAttribute("_sui_original_PaddingBottom", 4)
    scrollPadding:SetAttribute("_sui_original_PaddingLeft", 4)
    scrollPadding:SetAttribute("_sui_original_PaddingRight", 4)
    scrollPadding.PaddingTop = UDim.new(0, self:scale(4))
    scrollPadding.PaddingBottom = UDim.new(0, self:scale(4))
    scrollPadding.PaddingLeft = UDim.new(0, self:scale(4))
    scrollPadding.PaddingRight = UDim.new(0, self:scale(4))

    local normalizedOptions = {}
    local optionDataMap = {}
    for i, opt in ipairs(options) do
        if type(opt) == "table" then
            local displayText = opt.text or opt.Text or opt.label or opt.Label or tostring(opt)
            normalizedOptions[i] = displayText
            optionDataMap[displayText] = opt
        else
            normalizedOptions[i] = tostring(opt)
            optionDataMap[tostring(opt)] = opt
        end
    end

    local selectedValues = {}
    if multiSelect then
        if type(defaultValue) == "table" then
            for _, v in ipairs(defaultValue) do
                local normalized = type(v) == "table" and (v.text or v.Text or v.label or v.Label or tostring(v)) or
                                       tostring(v)
                selectedValues[normalized] = true
            end
        end
    else
        if defaultValue then
            selectedValues = type(defaultValue) == "table" and
                                 (defaultValue.text or defaultValue.Text or defaultValue.label or defaultValue.Label or
                                     tostring(defaultValue)) or tostring(defaultValue)
        else
            selectedValues = normalizedOptions[1]
        end
    end

    local isToggling = false
    local inputBlocker = nil
    local targetHeight = 0
    local hasSearch = false
    local userInputService = self:getService("UserInputService")
    local tweenService = self:getService("TweenService")
    local inputConnection
    local isOpen = false

    local function closeDropdown()
        if inputBlocker then
            inputBlocker:Destroy()
            inputBlocker = nil
        end
        if not isOpen then
            return
        end

        isOpen = false
        tweenService:Create(listContainer, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, self:scale(displayProps.Size.X.Offset), 0, 0)
        }):Play()

        task.wait(0.15)
        listContainer.Visible = false
        searchBox.Text = ""

        if inputConnection then
            inputConnection:Disconnect()
            inputConnection = nil
        end
    end

    local function updateDisplay()
        if multiSelect then
            local selected = {}
            for v, enabled in pairs(selectedValues) do
                if enabled then
                    table.insert(selected, v)
                end
            end
            displayLabel.Text = #selected > 0 and table.concat(selected, ", ") or "Select"
        else
            displayLabel.Text = selectedValues or "Select"
        end
    end

    local function filterOptions(query)
        query = query:lower()
        for _, child in ipairs(scrollList:GetChildren()) do
            if child:IsA("Frame") then
                local opt = child:FindFirstChild("TextButton")
                if opt then
                    child.Visible = query == "" or opt.Text:lower():find(query, 1, true) ~= nil
                end
            end
        end
    end

    local function updateListPosition()
        local displayPos = display.AbsolutePosition
        local displaySize = display.AbsoluteSize
        local screenSize = gui.AbsoluteSize

        local baseMaxHeight = self:scale(150)
        local contentHeight = listLayout.AbsoluteContentSize.Y + self:scale(8)
        hasSearch = contentHeight > baseMaxHeight

        searchBox.Visible = hasSearch

        if hasSearch then
            scrollList.Size = UDim2.new(1, 0, 1, self:scale(-36))
            scrollList.Position = UDim2.new(0, 0, 0, self:scale(36))
        else
            scrollList.Size = UDim2.new(1, 0, 1, 0)
            scrollList.Position = UDim2.new(0, 0, 0, 0)
        end

        targetHeight = math.min(baseMaxHeight, contentHeight) + (hasSearch and self:scale(36) or 0)

        local yPos = displayPos.Y + displaySize.Y + self:scale(4)
        if yPos + targetHeight > screenSize.Y then
            yPos = displayPos.Y - targetHeight - self:scale(4)
        end

        listContainer.Position = UDim2.new(0, displayPos.X, 0, yPos)
    end

    local function createOption(optionText, index)
        local optionProps = self:applyTheme(data.Option, data.Option.Theme, theme)

        local optionContainer = self:createElement("Frame", {
            Size = UDim2.new(1, self:scale(-8), 0, optionProps.Size.Y.Offset),
            BackgroundTransparency = 1,
            ZIndex = 252,
            LayoutOrder = index
        }, scrollList)

        local option = self:createElement("TextButton", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundColor3 = optionProps.BackgroundColor3 or theme.TertiaryColor,
            BorderSizePixel = 0,
            Text = optionText,
            TextColor3 = optionProps.TextColor3 or theme.TextPrimary,
            TextSize = optionProps.TextSize or 13,
            Font = optionProps.Font or theme.SecondaryFont,
            TextTruncate = Enum.TextTruncate.SplitWord,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutoButtonColor = false,
            ZIndex = 253
        }, optionContainer)

        option:SetAttribute("_sui_original_TextSize", optionProps.TextSize or 13)

        local optionCorner = self:createElement("UICorner", {}, option)
        optionCorner:SetAttribute("_sui_original_CornerRadius", 3)
        optionCorner.CornerRadius = UDim.new(0, self:scale(3))

        local optionPadding = self:createElement("UIPadding", {}, option)
        optionPadding:SetAttribute("_sui_original_PaddingLeft", 14)
        optionPadding:SetAttribute("_sui_original_PaddingRight", 8)
        optionPadding.PaddingLeft = UDim.new(0, self:scale(14))
        optionPadding.PaddingRight = UDim.new(0, self:scale(8))

        local indicator = self:createElement("Frame", {
            Size = UDim2.new(0, 4, 0.5, 0),
            Position = UDim2.new(0, self:scale(2), 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = theme.AccentColor,
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = 254
        }, optionContainer)

        local indicatorCorner = self:createElement("UICorner", {}, indicator)
        indicatorCorner:SetAttribute("_sui_original_CornerRadius", 999)
        indicatorCorner.CornerRadius = UDim.new(1, 0)

        if multiSelect then
            local function updateIndicator()
                indicator.Visible = selectedValues[optionText] or false
            end

            option.Activated:Connect(wrapCallback(function()
                selectedValues[optionText] = not selectedValues[optionText]
                updateIndicator()
                updateDisplay()
                if callback then
                    local selected = {}
                    for v, enabled in pairs(selectedValues) do
                        if enabled then
                            table.insert(selected, optionDataMap[v])
                        end
                    end
                    task.spawn(callback, selected)
                end
            end))

            updateIndicator()
        else
            indicator.Visible = selectedValues == optionText

            option.Activated:Connect(wrapCallback(function()
                for _, child in ipairs(scrollList:GetChildren()) do
                    if child:IsA("Frame") then
                        local ind = child:FindFirstChild("Frame")
                        if ind then
                            ind.Visible = false
                        end
                    end
                end

                selectedValues = optionText
                indicator.Visible = true
                updateDisplay()
                closeDropdown()

                if callback then
                    task.spawn(callback, optionDataMap[optionText])
                end
            end))
        end

        if not mobile then
            option.MouseEnter:Connect(wrapCallback(function()
                option.BackgroundColor3 = theme.TertiaryColorHover
            end))
            option.MouseLeave:Connect(wrapCallback(function()
                option.BackgroundColor3 = theme.TertiaryColor
            end))
            option.MouseButton1Down:Connect(wrapCallback(function()
                option.BackgroundColor3 = theme.TertiaryColorMouse1Down
            end))
            option.MouseButton1Up:Connect(wrapCallback(function()
                option.BackgroundColor3 = theme.TertiaryColorHover
            end))
        end
    end

    for i, option in ipairs(normalizedOptions) do
        createOption(option, i)
    end

    searchBox:GetPropertyChangedSignal("Text"):Connect(wrapCallback(function()
        filterOptions(searchBox.Text)
    end))

    updateDisplay()

    local displayState = "Base"
    local function updateDisplayColor()
        if displayState == "Base" then
            display.BackgroundColor3 = theme.TertiaryColor
        elseif displayState == "Hover" then
            display.BackgroundColor3 = theme.TertiaryColorHover
        elseif displayState == "Active" then
            display.BackgroundColor3 = theme.TertiaryColorActive
        elseif displayState == "Mouse1Down" then
            display.BackgroundColor3 = theme.TertiaryColorMouse1Down
        end
    end

    if not mobile then
        display.MouseEnter:Connect(wrapCallback(function()
            if not isOpen then
                displayState = "Hover"
                updateDisplayColor()
            end
        end))
        display.MouseLeave:Connect(wrapCallback(function()
            displayState = "Base"
            updateDisplayColor()
        end))
        display.MouseButton1Down:Connect(wrapCallback(function()
            displayState = "Mouse1Down"
            updateDisplayColor()
        end))
        display.MouseButton1Up:Connect(wrapCallback(function()
            displayState = "Hover"
            updateDisplayColor()
        end))
    end

    display.Activated:Connect(wrapCallback(function()
        if isToggling then
            return
        end

        isToggling = true

        if isOpen then
            closeDropdown()
        else
            isOpen = true

            inputBlocker = Instance.new("TextButton")
            inputBlocker.Name = "DropdownInputBlocker"
            inputBlocker.Size = UDim2.fromScale(1, 1)
            inputBlocker.Position = UDim2.fromScale(0, 0)
            inputBlocker.Text = ""
            inputBlocker.BackgroundTransparency = 1
            inputBlocker.AutoButtonColor = false
            inputBlocker.ZIndex = 249
            inputBlocker.Parent = gui

            protectInstance(inputBlocker)

            inputBlocker.Activated:Connect(wrapCallback(function()
                displayState = "Base"
                updateDisplayColor()
                closeDropdown()
            end))

            displayState = "Active"
            updateDisplayColor()
            updateListPosition()

            listContainer.Size = UDim2.new(0, self:scale(displayProps.Size.X.Offset), 0, 0)
            listContainer.Visible = true

            tweenService:Create(listContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, self:scale(displayProps.Size.X.Offset), 0, targetHeight)
            }):Play()

            task.wait()

            inputConnection = userInputService.InputBegan:Connect(wrapCallback(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType ==
                    Enum.UserInputType.Touch then
                    local mousePos = input.Position
                    local listPos = listContainer.AbsolutePosition
                    local listSize = listContainer.AbsoluteSize
                    local displayPos = display.AbsolutePosition
                    local displaySize = display.AbsoluteSize

                    local inList = mousePos.X >= listPos.X and mousePos.X <= listPos.X + listSize.X and mousePos.Y >=
                                       listPos.Y and mousePos.Y <= listPos.Y + listSize.Y
                    local inDisplay = mousePos.X >= displayPos.X and mousePos.X <= displayPos.X + displaySize.X and
                                          mousePos.Y >= displayPos.Y and mousePos.Y <= displayPos.Y + displaySize.Y

                    if not inList and not inDisplay and not isToggling then
                        displayState = "Base"
                        updateDisplayColor()
                        closeDropdown()
                    end
                end
            end))
        end

        task.wait(0.1)
        isToggling = false
    end))

    updateDisplayColor()

    return {
        container = container,
        getValue = function()
            if multiSelect then
                local selected = {}
                for v, enabled in pairs(selectedValues) do
                    if enabled then
                        table.insert(selected, optionDataMap[v])
                    end
                end
                return selected
            else
                return optionDataMap[selectedValues]
            end
        end,
        setValue = function(val)
            if multiSelect then
                selectedValues = {}
                if type(val) == "table" then
                    for _, v in ipairs(val) do
                        local normalized = type(v) == "table" and
                                               (v.text or v.Text or v.label or v.Label or tostring(v)) or tostring(v)
                        if optionDataMap[normalized] then
                            selectedValues[normalized] = true
                        end
                    end
                end
            else
                local normalized = type(val) == "table" and
                                       (val.text or val.Text or val.label or val.Label or tostring(val)) or
                                       tostring(val)
                if optionDataMap[normalized] then
                    selectedValues = normalized
                end
            end

            for _, child in ipairs(scrollList:GetChildren()) do
                if child:IsA("Frame") then
                    local ind = child:FindFirstChild("Frame")
                    local opt = child:FindFirstChild("TextButton")
                    if ind and opt then
                        if multiSelect then
                            ind.Visible = selectedValues[opt.Text] or false
                        else
                            ind.Visible = selectedValues == opt.Text
                        end
                    end
                end
            end

            updateDisplay()

            if callback then
                if multiSelect then
                    local selected = {}
                    for v, enabled in pairs(selectedValues) do
                        if enabled then
                            table.insert(selected, optionDataMap[v])
                        end
                    end
                    task.spawn(callback, selected)
                else
                    task.spawn(callback, optionDataMap[selectedValues])
                end
            end
        end,
        setOptions = function(newOptions)
            for _, child in ipairs(scrollList:GetChildren()) do
                if child:IsA("Frame") then
                    child:Destroy()
                end
            end

            options = newOptions
            normalizedOptions = {}
            optionDataMap = {}

            for i, opt in ipairs(options) do
                if type(opt) == "table" then
                    local displayText = opt.text or opt.Text or opt.label or opt.Label or tostring(opt)
                    normalizedOptions[i] = displayText
                    optionDataMap[displayText] = opt
                else
                    normalizedOptions[i] = tostring(opt)
                    optionDataMap[tostring(opt)] = opt
                end
            end

            for i, option in ipairs(normalizedOptions) do
                createOption(option, i)
            end

            if multiSelect then
                local validSelected = {}
                for v, enabled in pairs(selectedValues) do
                    if optionDataMap[v] then
                        validSelected[v] = enabled
                    end
                end
                selectedValues = validSelected
            else
                if not optionDataMap[selectedValues] and normalizedOptions[1] then
                    selectedValues = normalizedOptions[1]
                end
            end

            updateDisplay()
        end,
        close = closeDropdown
    }
end

SimpleUI.DefaultElements.Keybind = {
    Class = "Frame",
    Properties = {
        Size = UDim2.new(1, 0, 0, 35),
        BorderSizePixel = 0,
        ZIndex = 4
    },
    Theme = {
        BackgroundColor3 = "SecondaryColor",
        BackgroundTransparency = "SecondaryTransparency"
    },
    Corner = {
        CornerRadius = 4
    },
    Label = {
        Size = UDim2.new(0.35, -10, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Text = "Keybind",
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Theme = {
            Font = "SecondaryFont",
            TextColor3 = "TextPrimary"
        }
    },
    Display = {
        Size = UDim2.new(0.3, 0, 0, 30),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        TextSize = 13,
        Theme = {
            Font = "SecondaryFont",
            TextColor3 = "TextPrimary",
            BackgroundColor3 = "TertiaryColor"
        }
    }
}

function SimpleUI:createKeybind(page, text, defaultKey, callback, options)
    if not page then
        return
    end

    options = options or {}
    local theme = self:getTheme(page)
    local data = self:merge(self.DefaultElements.Keybind, options)
    local mobile = self:isMobile()

    local httpService = self:getService("HttpService")

    local containerProps = self:applyTheme(data.Properties, data.Theme, theme)
    local container = self:createElement(data.Class, containerProps, page)

    if data.Theme then
        container:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Theme))
    end

    if data.Corner then
        local corner = self:createElement("UICorner", {}, container)
        corner:SetAttribute("_sui_original_CornerRadius", data.Corner.CornerRadius)
        corner.CornerRadius = UDim.new(0, self:scale(data.Corner.CornerRadius))
    end

    local labelProps = self:applyTheme(data.Label, data.Label.Theme, theme)
    labelProps.Text = text
    labelProps.BackgroundTransparency = 1
    labelProps.ZIndex = 5
    local label = self:createElement("TextLabel", labelProps, container)

    if data.Label.Theme then
        label:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Label.Theme))
    end

    local displayProps = self:applyTheme(data.Display, data.Display.Theme, theme)
    displayProps.BorderSizePixel = 0
    displayProps.Text = ""
    displayProps.AutoButtonColor = false
    displayProps.ZIndex = 5
    local display = self:createElement("TextButton", displayProps, container)

    if data.Display.Theme then
        display:SetAttribute("_sui_themeMap", httpService:JSONEncode(data.Display.Theme))
    end

    local displayCorner = self:createElement("UICorner", {}, display)
    displayCorner:SetAttribute("_sui_original_CornerRadius", 4)
    displayCorner.CornerRadius = UDim.new(0, self:scale(4))

    local displayPadding = self:createElement("UIPadding", {}, display)

    displayPadding:SetAttribute("_sui_original_PaddingLeft", 8)
    displayPadding:SetAttribute("_sui_original_PaddingRight", 8)
    displayPadding.PaddingLeft = UDim.new(0, self:scale(8))
    displayPadding.PaddingRight = UDim.new(0, self:scale(8))

    local displayLabel = self:createElement("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = displayProps.TextColor3 or theme.TextPrimary,
        TextSize = displayProps.TextSize or 13,
        Font = displayProps.Font or theme.SecondaryFont,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 6
    }, display)

    displayLabel:SetAttribute("_sui_original_TextSize", displayProps.TextSize or 13)

    local currentKey = defaultKey
    local listening = false
    local uis = self:getService("UserInputService")
    local bindConnection
    local inputConnection

    local function updateDisplay()
        if listening then
            displayLabel.Text = "Press a key..."
            display.BackgroundColor3 = theme.AccentColor
        else
            displayLabel.Text = "Key: " .. (currentKey and currentKey.Name or "Select Keybind...")
            display.BackgroundColor3 = theme.TertiaryColor
        end
    end

    local function setupBind()
        if bindConnection then
            bindConnection:Disconnect()
            bindConnection = nil
        end
        if currentKey and callback then
            bindConnection = uis.InputBegan:Connect(wrapCallback(
                function(input, gameProcessed)
                    if not gameProcessed and input.KeyCode == currentKey then
                        task.spawn(callback, currentKey)
                    end
                end))
        end
    end

    display.Activated:Connect(wrapCallback(function()
        if listening then
            return
        end

        listening = true
        updateDisplay()

        inputConnection = uis.InputBegan:Connect(wrapCallback(
            function(input, gameProcessed)
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    currentKey = input.KeyCode
                    listening = false

                    if inputConnection then
                        inputConnection:Disconnect()
                        inputConnection = nil
                    end

                    updateDisplay()
                    setupBind()
                end
            end))
    end))

    if not mobile then
        display.MouseEnter:Connect(wrapCallback(function()
            if not listening then
                display.BackgroundColor3 = theme.TertiaryColorHover
            end
        end))

        display.MouseLeave:Connect(wrapCallback(function()
            if not listening then
                display.BackgroundColor3 = theme.TertiaryColor
            end
        end))
    end

    updateDisplay()
    setupBind()

    return {
        container = container,
        getKey = function()
            return currentKey
        end,
        setKey = function(key)
            currentKey = key
            updateDisplay()
            setupBind()
        end,
        clear = function()
            currentKey = nil
            updateDisplay()
            if bindConnection then
                bindConnection:Disconnect()
                bindConnection = nil
            end
        end
    }
end

return SimpleUI
