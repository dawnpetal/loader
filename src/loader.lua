local cloneref = cloneref or clonereference or function(o)
    return o
end
local gethui = gethui or function()
    return game:GetService("CoreGui")
end
local protectgui = protectgui or (syn and syn.protect_gui) or function()
end
local getgenv = getgenv or function()
    return _G
end
local setclipboard = setclipboard or (Clipboard and Clipboard.set) or function()
end

local Players = cloneref(game:GetService("Players"))
local TweenServ = cloneref(game:GetService("TweenService"))
local HttpServ = cloneref(game:GetService("HttpService"))
local RunServ = cloneref(game:GetService("RunService"))
local TextServ = cloneref(game:GetService("TextService"))

do
    local env = getgenv()
    if env.__LOADER_ACTIVE then
        return
    end
    env.__LOADER_ACTIVE = true
end

local CDNS = {"https://raw.githubusercontent.com/dawnpetal/loader/main/src/",
              "https://cdn.jsdelivr.net/gh/dawnpetal/loader@main/src/"}

local GAME_ID = tostring(game.PlaceId)
local TITLE = "Simple Scripts"
local DISCORD = "discord.gg/5BUTb4vYm3"

local c = Color3.fromRGB

local THEMES = {{
    card = c(16, 14, 22),
    border = c(50, 44, 72),
    text = c(240, 236, 255),
    track = c(28, 24, 40),
    accent = c(160, 120, 255),
    green = c(80, 220, 140),
    red = c(255, 70, 70),
    amber = c(240, 170, 60)
}, {
    card = c(20, 15, 11),
    border = c(65, 46, 28),
    text = c(255, 240, 220),
    track = c(32, 22, 14),
    accent = c(220, 155, 70),
    green = c(100, 210, 120),
    red = c(220, 70, 60),
    amber = c(230, 155, 55)
}, {
    card = c(10, 15, 22),
    border = c(28, 46, 68),
    text = c(215, 232, 255),
    track = c(16, 26, 42),
    accent = c(70, 160, 255),
    green = c(60, 215, 155),
    red = c(255, 75, 80),
    amber = c(225, 165, 55)
}, {
    card = c(22, 11, 14),
    border = c(68, 30, 38),
    text = c(255, 230, 232),
    track = c(36, 16, 20),
    accent = c(240, 90, 90),
    green = c(90, 215, 135),
    red = c(245, 55, 55),
    amber = c(230, 158, 52)
}, {
    card = c(11, 18, 14),
    border = c(30, 56, 38),
    text = c(218, 248, 224),
    track = c(16, 30, 20),
    accent = c(75, 205, 115),
    green = c(75, 220, 130),
    red = c(220, 75, 75),
    amber = c(210, 165, 60)
}, {
    card = c(12, 12, 12),
    border = c(42, 42, 42),
    text = c(240, 240, 240),
    track = c(22, 22, 22),
    accent = c(200, 200, 200),
    green = c(120, 210, 130),
    red = c(210, 70, 70),
    amber = c(210, 165, 65)
}}

local T = THEMES[math.random(1, #THEMES)]

local function S(n)
    local cam = workspace.CurrentCamera
    return math.floor(math.min(cam.ViewportSize.X / 1920, cam.ViewportSize.Y / 1080) * n + 0.5)
end

local function tw(obj, props, info)
    TweenServ:Create(obj, info, props):Play()
end

local function fastwait(s)
    local t = tick()
    repeat
        RunServ.Heartbeat:Wait()
    until tick() - t >= (s or 0)
end

local function fetch(path)
    for _, cdn in ipairs(CDNS) do
        local ok, body = pcall(game.HttpGetAsync, game, cdn .. path)
        if ok and body and body ~= "" then
            return body
        end
    end
end

local function buildKey(seed, salt)
    local raw = tostring(seed * math.pi * #salt):reverse() .. salt
    local buf = table.create(#raw)
    for i = 1, #raw do
        buf[i] = string.char(((string.byte(raw, i) * (i % 7 + 3)) % 126) + 1)
    end
    local rev = string.reverse(table.concat(buf))
    local hex = table.create(#rev)
    for i = 1, #rev do
        hex[i] = string.format("%02X", string.byte(rev, i))
    end
    local h = table.concat(hex)
    h = h .. string.rep("0", math.max(0, 32 - #h))
    return ("%s-%s-%s-%s"):format(h:sub(1, 8), h:sub(9, 16), h:sub(17, 24), h:sub(25, 32))
end

local storageRegistry = {}
local moduleRegistry = {}
local generatedKey = ""

local function newStorage()
    local t = tick()
    local salt = HttpServ:GenerateGUID(false):gsub("-", "")
    local key = buildKey(t, salt)
    generatedKey = key
    local proxy = newproxy(true)
    local mt = getmetatable(proxy)
    mt.__index = {
        Time = t,
        Salt = salt,
        Key = key,
        Func = buildKey,
        Prereqs = {}
    }
    mt.__metatable = "Locked"
    getgenv()[proxy] = true
    return proxy
end

local function setupRegistry(storage)
    storageRegistry[storage] = {
        Time = tick(),
        Salt = HttpServ:GenerateGUID(false):gsub("-", ""),
        Key = "",
        Func = function()
            return ""
        end,
        Prereqs = {}
    }
    getgenv().__PrereqStorageRegistry = storageRegistry
    getgenv().__PrereqModuleRegistry = moduleRegistry
end

local function registerModule(storage, name, mod)
    local data = storageRegistry[storage]
    if not data then
        return
    end
    local proxy = newproxy(true)
    local mt = getmetatable(proxy)
    mt.__index = function()
        return mod
    end
    mt.__tostring = function()
        return name
    end
    mt.__metatable = "Locked"
    moduleRegistry[proxy] = {
        name = name,
        module = mod
    }
    data.Prereqs[proxy] = true
end

local W = S(440)
local PAD = S(26)
local PAD_TOP = S(30)
local PAD_BOT = S(22)
local TITLE_SIZE = S(21)
local TITLE_H = S(26)
local ROW_H = S(18)
local ROW_SIZE = S(13)
local STATUS_H = S(17)
local STATUS_SIZE = S(13)
local BAR_H = S(5)

local Y_TITLE = 0
local Y_SUB = Y_TITLE + TITLE_H + S(8)
local Y_KEY = Y_SUB + ROW_H + S(6)
local Y_STATUS = Y_KEY + ROW_H + S(20)
local Y_BAR = Y_STATUS + STATUS_H + S(10)

local H_INTRO = PAD_TOP + TITLE_H + PAD_BOT
local H_KEY = PAD_TOP + Y_KEY + ROW_H + PAD_BOT
local H_FULL = PAD_TOP + Y_BAR + BAR_H + PAD_BOT

local Y_UMSG = Y_BAR + BAR_H + S(20)
local Y_UHINT = Y_UMSG + ROW_H + S(6)
local Y_ULINK = Y_UHINT + ROW_H + S(8)
local H_UNSUP = PAD_TOP + Y_ULINK + ROW_H + PAD_BOT

local gui = Instance.new("ScreenGui")
gui.Name = HttpServ:GenerateGUID(false)
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
pcall(protectgui, gui)
if not pcall(function()
    gui.Parent = gethui()
end) then
    gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

local card = Instance.new("Frame")
card.AnchorPoint = Vector2.new(0.5, 0.5)
card.Position = UDim2.fromScale(0.5, 0.5)
card.Size = UDim2.new(0, W, 0, 0)
card.BackgroundColor3 = T.card
card.BorderSizePixel = 0
card.ClipsDescendants = true
card.Parent = gui

local cardScale = Instance.new("UIScale")
cardScale.Scale = 0.94
cardScale.Parent = card

Instance.new("UICorner", card).CornerRadius = UDim.new(0, S(14))

local cardStroke = Instance.new("UIStroke")
cardStroke.Color = T.border
cardStroke.Thickness = 1
cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
cardStroke.Transparency = 1
cardStroke.Parent = card

do
    local p = Instance.new("UIPadding")
    p.PaddingLeft = UDim.new(0, PAD)
    p.PaddingRight = UDim.new(0, PAD)
    p.PaddingTop = UDim.new(0, PAD_TOP)
    p.PaddingBottom = UDim.new(0, PAD_BOT)
    p.Parent = card
end

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, TITLE_H)
titleLabel.Position = UDim2.fromOffset(0, Y_TITLE)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = ""
titleLabel.TextColor3 = T.text
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = TITLE_SIZE
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextTransparency = 0
titleLabel.Parent = card

local cursor = Instance.new("Frame")
cursor.Size = UDim2.new(0, S(2), 0, S(18))
cursor.AnchorPoint = Vector2.new(0, 0.5)
cursor.Position = UDim2.new(0, 0, 0, Y_TITLE + TITLE_H * 0.5)
cursor.BackgroundColor3 = T.accent
cursor.BorderSizePixel = 0
cursor.Parent = card

Instance.new("UICorner", cursor).CornerRadius = UDim.new(0, S(1))

local subLabel = Instance.new("TextLabel")
subLabel.Size = UDim2.new(1, 0, 0, ROW_H)
subLabel.Position = UDim2.fromOffset(0, Y_SUB + S(6))
subLabel.BackgroundTransparency = 1
subLabel.Text = "Fetching game details..."
subLabel.TextColor3 = T.text
subLabel.Font = Enum.Font.Gotham
subLabel.TextSize = ROW_SIZE
subLabel.TextXAlignment = Enum.TextXAlignment.Left
subLabel.TextTransparency = 1
subLabel.Parent = card

local keyRow = Instance.new("Frame")
keyRow.Size = UDim2.new(1, 0, 0, ROW_H)
keyRow.Position = UDim2.fromOffset(0, Y_KEY)
keyRow.BackgroundTransparency = 1
keyRow.Parent = card

local keyHeader = Instance.new("TextLabel")
keyHeader.Size = UDim2.new(0, S(28), 1, 0)
keyHeader.Position = UDim2.fromOffset(0, 0)
keyHeader.BackgroundTransparency = 1
keyHeader.Text = "Key"
keyHeader.TextColor3 = T.text
keyHeader.Font = Enum.Font.GothamMedium
keyHeader.TextSize = ROW_SIZE
keyHeader.TextXAlignment = Enum.TextXAlignment.Left
keyHeader.TextTransparency = 1
keyHeader.Parent = keyRow

local keyValue = Instance.new("TextLabel")
keyValue.Size = UDim2.new(1, -S(38), 1, 0)
keyValue.Position = UDim2.fromOffset(S(38), 0)
keyValue.BackgroundTransparency = 1
keyValue.Text = "Generating..."
keyValue.TextColor3 = T.accent
keyValue.Font = Enum.Font.RobotoMono
keyValue.TextSize = S(12)
keyValue.TextXAlignment = Enum.TextXAlignment.Left
keyValue.TextTransparency = 1
keyValue.Parent = keyRow

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -S(50), 0, STATUS_H)
statusLabel.Position = UDim2.fromOffset(0, Y_STATUS)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Connecting"
statusLabel.TextColor3 = T.text
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = STATUS_SIZE
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.TextTransparency = 1
statusLabel.Parent = card

local pctLabel = Instance.new("TextLabel")
pctLabel.Size = UDim2.new(0, S(44), 0, STATUS_H)
pctLabel.Position = UDim2.new(1, -S(44), 0, Y_STATUS)
pctLabel.BackgroundTransparency = 1
pctLabel.Text = "0%"
pctLabel.TextColor3 = T.text
pctLabel.Font = Enum.Font.GothamBold
pctLabel.TextSize = S(12)
pctLabel.TextXAlignment = Enum.TextXAlignment.Right
pctLabel.TextTransparency = 1
pctLabel.Parent = card

local track = Instance.new("Frame")
track.Size = UDim2.new(1, 0, 0, BAR_H)
track.Position = UDim2.fromOffset(0, Y_BAR)
track.BackgroundColor3 = T.track
track.BackgroundTransparency = 1
track.BorderSizePixel = 0
track.Parent = card

Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

local bar = Instance.new("Frame")
bar.Size = UDim2.fromScale(0, 1)
bar.BackgroundColor3 = T.accent
bar.BorderSizePixel = 0
bar.Parent = track

Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

local barGlow = Instance.new("Frame")
barGlow.AnchorPoint = Vector2.new(1, 0.5)
barGlow.Position = UDim2.fromScale(1, 0.5)
barGlow.Size = UDim2.fromOffset(S(8), S(8))
barGlow.BackgroundColor3 = T.text
barGlow.BackgroundTransparency = 0.35
barGlow.BorderSizePixel = 0
barGlow.Parent = bar

Instance.new("UICorner", barGlow).CornerRadius = UDim.new(1, 0)

local uMsgLabel = Instance.new("TextLabel")
uMsgLabel.Size = UDim2.new(1, 0, 0, ROW_H * 2)
uMsgLabel.Position = UDim2.fromOffset(0, Y_UMSG)
uMsgLabel.BackgroundTransparency = 1
uMsgLabel.Text = "This game is not supported or its support has been discontinued."
uMsgLabel.TextColor3 = T.text
uMsgLabel.Font = Enum.Font.GothamMedium
uMsgLabel.TextSize = ROW_SIZE
uMsgLabel.TextXAlignment = Enum.TextXAlignment.Left
uMsgLabel.TextWrapped = true
uMsgLabel.TextTransparency = 1
uMsgLabel.Parent = card

local uHintLabel = Instance.new("TextLabel")
uHintLabel.Size = UDim2.new(1, 0, 0, ROW_H)
uHintLabel.Position = UDim2.fromOffset(0, Y_UHINT)
uHintLabel.BackgroundTransparency = 1
uHintLabel.Text = "Visit our Discord for more information."
uHintLabel.TextColor3 = T.text
uHintLabel.Font = Enum.Font.Gotham
uHintLabel.TextSize = ROW_SIZE
uHintLabel.TextXAlignment = Enum.TextXAlignment.Left
uHintLabel.TextTransparency = 1
uHintLabel.Parent = card

local linkBtn = Instance.new("TextButton")
linkBtn.Size = UDim2.new(1, 0, 0, ROW_H)
linkBtn.Position = UDim2.fromOffset(0, Y_ULINK)
linkBtn.BackgroundTransparency = 1
linkBtn.Text = DISCORD
linkBtn.TextColor3 = T.accent
linkBtn.Font = Enum.Font.GothamMedium
linkBtn.TextSize = ROW_SIZE
linkBtn.TextXAlignment = Enum.TextXAlignment.Left
linkBtn.TextTransparency = 1
linkBtn.AutoButtonColor = false
linkBtn.Parent = card

local EASE = TweenInfo.new(0.38, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local SOFT = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local BARMOV = TweenInfo.new(0.26, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local QSOFT = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local progress = 0
local closing = false

local function sz(h)
    return UDim2.new(0, W, 0, h)
end

local fadeTargets = {{card, "BackgroundTransparency", 1}, {cardStroke, "Transparency", 1},
                     {titleLabel, "TextTransparency", 1}, {subLabel, "TextTransparency", 1},
                     {keyHeader, "TextTransparency", 1}, {keyValue, "TextTransparency", 1},
                     {statusLabel, "TextTransparency", 1}, {pctLabel, "TextTransparency", 1},
                     {track, "BackgroundTransparency", 1}, {bar, "BackgroundTransparency", 1},
                     {barGlow, "BackgroundTransparency", 1}, {uMsgLabel, "TextTransparency", 1},
                     {uHintLabel, "TextTransparency", 1}, {linkBtn, "TextTransparency", 1}}

local function fadeAll(dur)
    local info = TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    for _, e in ipairs(fadeTargets) do
        tw(e[1], {
            [e[2]] = e[3]
        }, info)
    end
end

local function dismiss()
    if closing then
        return
    end
    closing = true
    linkVisible = false
    cursor.Visible = false
    fadeAll(0.30)
    task.delay(0.38, function()
        gui:Destroy()
        getgenv().__LOADER_ACTIVE = false
    end)
end

local function setAccent(col)
    bar.BackgroundColor3 = col
    barGlow.BackgroundColor3 = col
    cursor.BackgroundColor3 = col
end

local function setProgress(pct, text)
    pct = math.clamp(pct, progress, 1)
    progress = pct
    tw(bar, {
        Size = UDim2.fromScale(pct, 1)
    }, BARMOV)
    pctLabel.Text = math.floor(pct * 100) .. "%"
    if text then
        statusLabel.Text = text
    end
end

local function setKey(value)
    keyValue.Text = value
end

local copyCooldown = false
local linkVisible = false

linkBtn.MouseButton1Click:Connect(function()
    if copyCooldown or not linkVisible then
        return
    end
    copyCooldown = true
    pcall(setclipboard, DISCORD)
    tw(linkBtn, {
        TextTransparency = 0.5
    }, QSOFT)
    fastwait(0.10)
    linkBtn.Text = "Copied to clipboard!"
    tw(linkBtn, {
        TextTransparency = 0
    }, QSOFT)
    fastwait(1.6)
    linkBtn.Text = DISCORD
    tw(linkBtn, {
        TextTransparency = 0
    }, QSOFT)
    copyCooldown = false
end)

linkBtn.MouseEnter:Connect(function()
    if not linkVisible then
        return
    end
    tw(linkBtn, {
        TextTransparency = 0.35
    }, QSOFT)
end)

linkBtn.MouseLeave:Connect(function()
    if not linkVisible then
        return
    end
    tw(linkBtn, {
        TextTransparency = 0
    }, QSOFT)
end)

local function fail(msg)
    setAccent(T.red)
    statusLabel.TextColor3 = T.red
    statusLabel.Text = msg
    task.delay(2.5, dismiss)
end

local function unsupported()
    subLabel.Text = "No game files found."
    setAccent(T.amber)
    linkBtn.TextColor3 = T.amber

    tw(bar, {
        Size = UDim2.fromScale(1, 1)
    }, BARMOV)
    tw(cardStroke, {
        Color = T.amber
    }, SOFT)
    statusLabel.Text = "Not supported"
    statusLabel.TextColor3 = T.amber
    pctLabel.Text = "!"
    pctLabel.TextColor3 = T.amber
    tw(card, {
        Size = sz(H_UNSUP)
    }, EASE)

    task.delay(0.28, function()
        task.delay(0.00, function()
            tw(uMsgLabel, {
                TextTransparency = 0
            }, SOFT)
        end)
        task.delay(0.12, function()
            tw(uHintLabel, {
                TextTransparency = 0
            }, SOFT)
        end)
        task.delay(0.24, function()
            tw(linkBtn, {
                TextTransparency = 0
            }, SOFT)
            task.delay(0.30, function()
                linkVisible = true
            end)
        end)
    end)

    task.delay(9, dismiss)
end

local function cursorX()
    return TextServ:GetTextSize(titleLabel.Text, TITLE_SIZE, titleLabel.Font, Vector2.new(9999, 9999)).X + S(4)
end

local function playIntro()
    fastwait(0.04)

    tw(cardStroke, {
        Transparency = 0
    }, TweenInfo.new(0.20, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
    tw(card, {
        Size = sz(H_INTRO)
    }, TweenInfo.new(0.34, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
    tw(cardScale, {
        Scale = 1
    }, TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out))

    fastwait(0.16)

    for i = 1, #TITLE do
        titleLabel.Text = TITLE:sub(1, i)
        cursor.Position = UDim2.new(0, cursorX(), 0, Y_TITLE + TITLE_H * 0.5)
        fastwait(0.042)
    end

    for _, v in ipairs({1, 0, 1, 0, 1, 0}) do
        fastwait(0.11)
        cursor.BackgroundTransparency = v
    end
    cursor.Visible = false

    tw(card, {
        Size = sz(H_KEY)
    }, EASE)
    subLabel.Position = UDim2.fromOffset(0, Y_SUB + S(6))
    tw(subLabel, {
        TextTransparency = 0,
        Position = UDim2.fromOffset(0, Y_SUB)
    }, SOFT)

    fastwait(0.16)
    tw(keyHeader, {
        TextTransparency = 0
    }, SOFT)
    tw(keyValue, {
        TextTransparency = 0
    }, SOFT)
    fastwait(0.36)

    tw(card, {
        Size = sz(H_FULL)
    }, EASE)
    fastwait(0.18)
    tw(statusLabel, {
        TextTransparency = 0
    }, SOFT)
    tw(pctLabel, {
        TextTransparency = 0
    }, SOFT)
    fastwait(0.07)
    tw(track, {
        BackgroundTransparency = 0
    }, SOFT)
    fastwait(0.12)
end

local function fetchModule(path)
    local src = fetch(path)
    if not src then
        return
    end
    local fn = loadstring(src)
    if not fn then
        return
    end
    local ok, result = pcall(fn)
    return ok and type(result) == "table" and result or nil
end

local function tableLen(t)
    local n = 0
    for _ in pairs(t) do
        n = n + 1
    end
    return n
end

local function run()
    local storage = newStorage()
    setupRegistry(storage)

    local cfgRaw, fetching = nil, true
    task.spawn(function()
        cfgRaw = fetch(GAME_ID .. "/config.json")
        fetching = false
    end)

    playIntro()
    setKey(generatedKey)

    while fetching do
        RunServ.Heartbeat:Wait()
    end

    setProgress(0.08, "Connecting")
    if not cfgRaw then
        unsupported()
        return
    end

    setProgress(0.18, "Parsing config")
    local ok, cfg = pcall(HttpServ.JSONDecode, HttpServ, cfgRaw)
    if not ok or type(cfg) ~= "table" then
        unsupported()
        return
    end

    local mods = {}
    local rawList = cfg.prerequisites
    if type(rawList) == "table" then
        if #rawList > 0 then
            for _, v in ipairs(rawList) do
                local name = v:match("([^/]+)%.lua$") or v
                mods[name] = v:find("/") and v or ("utils/" .. v .. ".lua")
            end
        else
            mods = rawList
        end
    end

    local total, loaded = tableLen(mods), 0
    for name, path in pairs(mods) do
        local fullPath = path:match("^utils/") and path or (GAME_ID .. "/" .. path)
        setProgress(0.18 + (loaded / math.max(total, 1)) * 0.56, name)

        local mod = fetchModule(fullPath)
        if not mod then
            fail("Failed: " .. name)
            return
        end

        registerModule(storage, name, mod)
        loaded = loaded + 1
        task.wait(0.01)
    end

    setProgress(0.76, "Loading")
    local mainSrc = fetch(GAME_ID .. "/main.lua")
    if not mainSrc then
        fail("Main not found")
        return
    end

    local main = loadstring(mainSrc)
    if not main then
        fail("Compile error")
        return
    end

    setProgress(0.94, "Executing")
    if not pcall(main) then
        fail("Runtime error")
        return
    end

    setProgress(1, "Done")
    setAccent(T.green)
    statusLabel.TextColor3 = T.green
    task.delay(0.8, dismiss)
end

task.spawn(run)