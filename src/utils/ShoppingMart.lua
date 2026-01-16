local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Theme = {
    Background = Color3.fromRGB(14, 14, 16),
    Surface = Color3.fromRGB(22, 22, 26),
    SurfaceAlt = Color3.fromRGB(30, 30, 34),
    TextPrimary = Color3.fromRGB(240, 240, 245),
    TextSecondary = Color3.fromRGB(150, 150, 160),
    Accent = Color3.fromRGB(255, 107, 0),
    AccentDark = Color3.fromRGB(200, 80, 0),
    Success = Color3.fromRGB(52, 199, 89),
    Danger = Color3.fromRGB(255, 59, 48),
    Stroke = Color3.fromRGB(45, 45, 50),
    ShardPrice = Color3.fromRGB(245, 170, 210)
}

local NumberFormatter = {}
NumberFormatter.Suffixes = {{1e21, "Sx"}, {1e18, "Qi"}, {1e15, "Qa"}, {1e12, "T"}, {1e9, "B"}, {1e6, "M"}, {1e3, "k"}}

function NumberFormatter.Format(n)
    n = math.floor(n + 0.5)
    for _, data in ipairs(NumberFormatter.Suffixes) do
        if n >= data[1] then
            local value = math.floor((n / data[1]) * 100) / 100
            local str = tostring(value):gsub("%.0+$", ""):gsub("(%..-)0+$", "%1")
            return str .. data[2]
        end
    end
    return tostring(n)
end

local ItemCatalog = {}

function ItemCatalog.Build()
    local catalog = {
        Pans = {},
        Shovels = {},
        Sluices = {},
        Potions = {},
        Totems = {},
        Others = {}
    }

    local icons = {
        Pans = "rbxassetid://10789587520",
        Shovels = "rbxassetid://10098013519",
        Sluices = "rbxassetid://7964618035",
        Potions = "rbxassetid://16181402439",
        Totems = "rbxassetid://18624930841",
        Utility = "rbxassetid://12392897830"
    }

    local purchRoot = Workspace:FindFirstChild("Purchasable")
    if not purchRoot then
        return catalog
    end

    for _, region in ipairs(purchRoot:GetChildren()) do
        if region:IsA("Folder") and #region:GetChildren() > 0 then
            for _, item in ipairs(region:GetChildren()) do
                if item:IsA("Model") then
                    local shopItem = item:FindFirstChild("ShopItem")
                    if shopItem then
                        local stats = shopItem:FindFirstChild("Stats")
                        if stats then
                            local isShardPrice = shopItem:GetAttribute("Price") == nil and
                                                     shopItem:GetAttribute("ShardPrice") ~= nil
                            local price = shopItem:GetAttribute(isShardPrice and "ShardPrice" or "Price")
                            local description = shopItem:GetAttribute("Description")
                            local category

                            if price then
                                category = ItemCatalog.DetermineCategory(item, stats)
                            else
                                category = "Others"
                            end

                            local iconImage = icons[category] or icons.Utility

                            if price then
                                table.insert(catalog[category], {
                                    name = item.Name,
                                    description = description,
                                    price = price,
                                    currency = isShardPrice and "ƒ" or "$",
                                    category = category,
                                    model = item,
                                    shopItem = shopItem,
                                    iconImage = iconImage
                                })
                            else
                                for attrName, attrValue in pairs(shopItem:GetAttributes()) do
                                    if typeof(attrValue) == "number" and attrName ~= "Price" and attrName ~=
                                        "ShardPrice" then
                                        table.insert(catalog.Others, {
                                            name = item.Name,
                                            description = description,
                                            price = attrValue,
                                            currency = attrName,
                                            category = "Others",
                                            model = item,
                                            shopItem = shopItem,
                                            iconImage = icons.Utility
                                        })
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return catalog
end

local CATEGORY_FOLDERS = {
    Pans = ReplicatedStorage.Items.Pans,
    Totems = ReplicatedStorage.Items.Totems,
    Potions = ReplicatedStorage.Potions,
    Shovels = ReplicatedStorage.Shovels,
    Sluices = ReplicatedStorage.Items.Sluices
}

function ItemCatalog.DetermineCategory(item)
    if not item then
        return "Others"
    end

    local itemNameLower = item.Name:lower()

    for category, folder in pairs(CATEGORY_FOLDERS) do
        if folder then
            for _, child in folder:GetChildren() do
                if child.Name:lower() == itemNameLower then
                    return category
                end
            end
        end
    end

    return "Others"
end

local ShoppingMartClass = {}
ShoppingMartClass.__index = ShoppingMartClass
ShoppingMartClass.buying = false

function ShoppingMartClass.new(uiScale)
    local self = setmetatable({}, ShoppingMartClass)

    self.shoppingCart = {}
    self.selectedCategory = "All"
    self.uiScale = uiScale
    self.gui = nil

    self:CreateUI()

    return self
end

function ShoppingMartClass:CreateCorner(radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    return corner
end

function ShoppingMartClass:CreatePadding(all)
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, all)
    padding.PaddingBottom = UDim.new(0, all)
    padding.PaddingLeft = UDim.new(0, all)
    padding.PaddingRight = UDim.new(0, all)
    return padding
end

function ShoppingMartClass:UpdateScrollCanvas(scrollFrame, layout)
    local contentSize = layout.AbsoluteContentSize
    local padding = scrollFrame:FindFirstChildOfClass("UIPadding")
    local padTop = padding and padding.PaddingTop.Offset or 0
    local padBottom = padding and padding.PaddingBottom.Offset or 0
    local buffer = 20
    scrollFrame.CanvasSize = UDim2.fromOffset(0, (contentSize.Y / self.uiScale) + padTop + padBottom + buffer)
end
function ShoppingMartClass:AddToCart(itemData)
    for _, cartItem in ipairs(self.shoppingCart) do
        if cartItem.name == itemData.name then
            cartItem.quantity = cartItem.quantity + 1
            return
        end
    end

    table.insert(self.shoppingCart, {
        name = itemData.name,
        price = itemData.price,
        currency = itemData.currency,
        category = itemData.category,
        model = itemData.model,
        shopItem = itemData.shopItem,
        quantity = 1
    })
end

function ShoppingMartClass:RemoveFromCart(itemName)
    for i, cartItem in ipairs(self.shoppingCart) do
        if cartItem.name == itemName then
            table.remove(self.shoppingCart, i)
            return
        end
    end
end

function ShoppingMartClass:UpdateCartQuantity(itemName, delta)
    for i, cartItem in ipairs(self.shoppingCart) do
        if cartItem.name == itemName then
            cartItem.quantity = math.max(0, cartItem.quantity + delta)
            if cartItem.quantity == 0 then
                table.remove(self.shoppingCart, i)
            end
            return
        end
    end
end

function ShoppingMartClass:CalculateTotals()
    local totals = {}
    for _, cartItem in ipairs(self.shoppingCart) do
        totals[cartItem.currency] = (totals[cartItem.currency] or 0) + (cartItem.price * cartItem.quantity)
    end
    return totals
end

function ShoppingMartClass:GetItemCount()
    local count = 0
    for _, cartItem in ipairs(self.shoppingCart) do
        count = count + cartItem.quantity
    end
    return count
end

function ShoppingMartClass:ClearCart()
    self.shoppingCart = {}
end

function ShoppingMartClass:CreateUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ShoppingMartUI_" .. tostring(os.clock())
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false
    screenGui.Enabled = false
    screenGui.DisplayOrder = 100

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 920, 0, 620)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Theme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local scale = Instance.new("UIScale")
    scale.Scale = self.uiScale
    scale.Parent = mainFrame

    self:CreateCorner(16).Parent = mainFrame
    self:CreateTopBar(mainFrame)

    local inputBlocker = Instance.new("TextButton")
    inputBlocker.Name = "InputBlocker"
    inputBlocker.Size = UDim2.new(1, 0, 1, 0)
    inputBlocker.Position = UDim2.new(0, 0, 0, 0)
    inputBlocker.BackgroundTransparency = 1
    inputBlocker.Text = ""
    inputBlocker.AutoButtonColor = false
    inputBlocker.BorderSizePixel = 0
    inputBlocker.Visible = false
    inputBlocker.Parent = mainFrame

    self.inputBlocker = inputBlocker

    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -32, 1, -72)
    contentFrame.Position = UDim2.new(0, 16, 0, 64)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local leftPanel = Instance.new("Frame")
    leftPanel.Name = "LeftPanel"
    leftPanel.Size = UDim2.new(0.65, -8, 1, 0)
    leftPanel.BackgroundTransparency = 1
    leftPanel.Parent = contentFrame

    local rightPanel = Instance.new("Frame")
    rightPanel.Name = "RightPanel"
    rightPanel.Size = UDim2.new(0.35, -8, 1, 0)
    rightPanel.Position = UDim2.new(0.65, 8, 0, 0)
    rightPanel.BackgroundColor3 = Theme.Surface
    rightPanel.BorderSizePixel = 0
    rightPanel.Parent = contentFrame

    self:CreateCorner(12).Parent = rightPanel

    self:CreateCategoryBar(leftPanel)
    self:CreateItemsPanel(leftPanel)
    self:CreateCartPanel(rightPanel)

    screenGui.Parent = playerGui
    self.gui = screenGui

    self:UpdateItemDisplay()
    self:UpdateCart()
end

function ShoppingMartClass:CreateTopBar(parent)
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 56)
    topBar.BackgroundColor3 = Theme.Surface
    topBar.BorderSizePixel = 0
    topBar.Parent = parent

    local topCover = Instance.new("Frame")
    topCover.Size = UDim2.new(1, 0, 0, 1)
    topCover.Position = UDim2.new(0, 0, 1, 0)
    topCover.BackgroundColor3 = Theme.AccentDark
    topCover.BorderSizePixel = 0
    topCover.Parent = topBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 200, 1, 0)
    titleLabel.Position = UDim2.new(0, 20, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "WALMART WOHOOO"
    titleLabel.TextColor3 = Theme.TextPrimary
    titleLabel.TextSize = 20
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = topBar

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 36, 0, 36)
    closeButton.Position = UDim2.new(1, -46, 0.5, 0)
    closeButton.AnchorPoint = Vector2.new(0, 0.5)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "x"
    closeButton.TextColor3 = Theme.TextSecondary
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.BorderSizePixel = 0
    closeButton.AutoButtonColor = false
    closeButton.Parent = topBar

    self:CreateCorner(8).Parent = closeButton

    closeButton.MouseEnter:Connect(function()
        closeButton.BackgroundColor3 = Theme.Accent
        closeButton.TextColor3 = Theme.TextPrimary
    end)

    closeButton.MouseLeave:Connect(function()
        closeButton.BackgroundColor3 = Theme.Surface
        closeButton.TextColor3 = Theme.TextSecondary
    end)

    closeButton.MouseButton1Click:Connect(function()
        self.gui.Enabled = false
    end)

    local UserInputService = game:GetService("UserInputService")

    local dragging, dragStart, startPos = false, nil, nil

    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = parent.Position
            input:GetPropertyChangedSignal("UserInputState"):Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and
            (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            parent.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale,
                startPos.Y.Offset + delta.Y)
        end
    end)
end

function ShoppingMartClass:CreateCategoryBar(parent)
    local categoryBar = Instance.new("ScrollingFrame")
    categoryBar.Name = "CategoryBar"
    categoryBar.Size = UDim2.new(1, 0, 0, 40)
    categoryBar.BackgroundTransparency = 1
    categoryBar.BorderSizePixel = 0
    categoryBar.ScrollBarThickness = 0
    categoryBar.Active = true
    categoryBar.ScrollingDirection = Enum.ScrollingDirection.X
    categoryBar.CanvasSize = UDim2.new(0, 0, 0, 40)
    categoryBar.Parent = parent

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    layout.Padding = UDim.new(0, 8)
    layout.Parent = categoryBar

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self:UpdateScrollCanvas(categoryBar, layout)
    end)

    local categories = {"All", "Pans", "Shovels", "Sluices", "Potions", "Totems", "Others"}

    for _, category in ipairs(categories) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 0, 0, 32)
        button.AutomaticSize = Enum.AutomaticSize.X
        button.BackgroundColor3 = category == self.selectedCategory and Theme.Accent or Theme.Surface
        button.Text = category
        button.TextColor3 = category == self.selectedCategory and Theme.TextPrimary or Theme.TextSecondary
        button.TextSize = 13
        button.Font = Enum.Font.GothamBold
        button.BorderSizePixel = 0
        button.Parent = categoryBar

        local padding = self:CreatePadding(0)
        padding.PaddingLeft = UDim.new(0, 14)
        padding.PaddingRight = UDim.new(0, 14)
        padding.Parent = button

        self:CreateCorner(16).Parent = button

        button.MouseButton1Click:Connect(function()
            self.selectedCategory = category
            for _, btn in ipairs(categoryBar:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = btn.Text == self.selectedCategory and Theme.Accent or Theme.Surface
                    btn.TextColor3 = btn.Text == self.selectedCategory and Theme.TextPrimary or Theme.TextSecondary
                end
            end
            self:UpdateItemDisplay()
        end)
    end
end

function ShoppingMartClass:CreateItemsPanel(parent)
    local itemsScrollFrame = Instance.new("ScrollingFrame")
    itemsScrollFrame.Name = "ItemsScrollFrame"
    itemsScrollFrame.Size = UDim2.new(1, 0, 1, -48)
    itemsScrollFrame.Position = UDim2.new(0, 0, 0, 48)
    itemsScrollFrame.BackgroundTransparency = 1
    itemsScrollFrame.BorderSizePixel = 0
    itemsScrollFrame.ScrollBarThickness = 4
    itemsScrollFrame.ScrollBarImageColor3 = Theme.Stroke
    itemsScrollFrame.Active = true
    itemsScrollFrame.Parent = parent

    local padding = self:CreatePadding(12)
    padding.Parent = itemsScrollFrame

    local grid = Instance.new("UIGridLayout")
    grid.CellSize = UDim2.new(0, 170, 0, 210)
    grid.CellPadding = UDim2.new(0, 12, 0, 12)
    grid.SortOrder = Enum.SortOrder.Name
    grid.Parent = itemsScrollFrame

    grid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self:UpdateScrollCanvas(itemsScrollFrame, grid)
    end)
end

function ShoppingMartClass:CreateCartPanel(parent)
    local cartTitle = Instance.new("TextLabel")
    cartTitle.Size = UDim2.new(1, -24, 0, 32)
    cartTitle.Position = UDim2.new(0, 12, 0, 12)
    cartTitle.BackgroundTransparency = 1
    cartTitle.Text = "Your Cart"
    cartTitle.TextColor3 = Theme.TextPrimary
    cartTitle.TextSize = 16
    cartTitle.Font = Enum.Font.GothamBold
    cartTitle.TextXAlignment = Enum.TextXAlignment.Left
    cartTitle.Parent = parent

    local cartScrollFrame = Instance.new("ScrollingFrame")
    cartScrollFrame.Name = "CartScrollFrame"
    cartScrollFrame.Size = UDim2.new(1, -24, 1, -180)
    cartScrollFrame.Position = UDim2.new(0, 12, 0, 52)
    cartScrollFrame.BackgroundTransparency = 1
    cartScrollFrame.BorderSizePixel = 0
    cartScrollFrame.Active = true
    cartScrollFrame.ScrollBarThickness = 4
    cartScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 205)
    cartScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    cartScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    cartScrollFrame.Parent = parent

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = cartScrollFrame

    self:CreateCheckoutFrame(parent)
end

function ShoppingMartClass:CreateCheckoutFrame(parent)
    local checkoutFrame = Instance.new("Frame")
    checkoutFrame.Name = "CheckoutFrame"
    checkoutFrame.Size = UDim2.new(1, -24, 0, 120)
    checkoutFrame.Position = UDim2.new(0, 12, 1, -132)
    checkoutFrame.BackgroundColor3 = Theme.SurfaceAlt
    checkoutFrame.BorderSizePixel = 0
    checkoutFrame.Parent = parent

    self:CreateCorner(12).Parent = checkoutFrame

    local totalLabel = Instance.new("TextLabel")
    totalLabel.Name = "TotalLabel"
    totalLabel.Size = UDim2.new(1, -24, 0, 24)
    totalLabel.Position = UDim2.new(0, 12, 0, 12)
    totalLabel.BackgroundTransparency = 1
    totalLabel.Text = "Total: $0"
    totalLabel.TextColor3 = Theme.TextPrimary
    totalLabel.TextSize = 18
    totalLabel.Font = Enum.Font.GothamBold
    totalLabel.TextXAlignment = Enum.TextXAlignment.Left
    totalLabel.Parent = checkoutFrame

    local itemCountLabel = Instance.new("TextLabel")
    itemCountLabel.Name = "ItemCountLabel"
    itemCountLabel.Size = UDim2.new(1, -24, 0, 18)
    itemCountLabel.Position = UDim2.new(0, 12, 0, 38)
    itemCountLabel.BackgroundTransparency = 1
    itemCountLabel.Text = "0 items"
    itemCountLabel.TextColor3 = Color3.fromRGB(140, 140, 145)
    itemCountLabel.TextSize = 13
    itemCountLabel.Font = Enum.Font.Gotham
    itemCountLabel.TextXAlignment = Enum.TextXAlignment.Left
    itemCountLabel.Parent = checkoutFrame

    local checkoutButton = Instance.new("TextButton")
    checkoutButton.Name = "CheckoutButton"
    checkoutButton.Size = UDim2.new(1, -24, 0, 44)
    checkoutButton.Position = UDim2.new(0, 12, 0, 64)
    checkoutButton.BackgroundColor3 = Theme.Accent
    checkoutButton.Text = "Checkout"
    checkoutButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    checkoutButton.TextSize = 15
    checkoutButton.Font = Enum.Font.GothamBold
    checkoutButton.BorderSizePixel = 0
    checkoutButton.Parent = checkoutFrame

    self:CreateCorner(10).Parent = checkoutButton

    checkoutButton.MouseButton1Click:Connect(function()
        self:ProcessCheckout(checkoutButton)
    end)
end

function ShoppingMartClass:CreateItemCard(itemData)
    local card = Instance.new("Frame")
    card.Name = "Item_" .. itemData.name
    card.BackgroundColor3 = Theme.Surface
    card.BorderSizePixel = 0

    self:CreateCorner(16).Parent = card

    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Stroke
    stroke.Thickness = 1
    stroke.Parent = card

    self:CreatePadding(12).Parent = card

    local iconFrame = Instance.new("Frame")
    iconFrame.Size = UDim2.new(1, 0, 0, 70)
    iconFrame.BackgroundColor3 = Theme.SurfaceAlt
    iconFrame.BorderSizePixel = 0
    iconFrame.Parent = card

    self:CreateCorner(12).Parent = iconFrame

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 50, 0, 50)
    icon.Position = UDim2.new(0.5, 0, 0.5, 0)
    icon.AnchorPoint = Vector2.new(0.5, 0.5)
    icon.BackgroundTransparency = 1
    icon.Image = itemData.iconImage or ""
    icon.ImageColor3 = Theme.TextSecondary
    icon.Parent = iconFrame

    local name = Instance.new("TextLabel")
    name.Size = UDim2.new(1, 0, 0, 40)
    name.Position = UDim2.new(0, 0, 0, 78)
    name.BackgroundTransparency = 1
    name.Text = itemData.name
    name.TextColor3 = Theme.TextPrimary
    name.TextSize = 14
    name.Font = Enum.Font.GothamBold
    name.TextWrapped = true
    name.TextTruncate = Enum.TextTruncate.AtEnd
    name.TextXAlignment = Enum.TextXAlignment.Left
    name.Parent = card

    local priceFrame = Instance.new("Frame")
    priceFrame.Size = UDim2.new(1, 0, 0, 24)
    priceFrame.Position = UDim2.new(0, 0, 1, -62)
    priceFrame.BackgroundTransparency = 1
    priceFrame.Parent = card

    local price = Instance.new("TextLabel")
    price.Size = UDim2.new(0.5, 0, 1, 0)
    price.BackgroundTransparency = 1
    price.Text = itemData.currency .. NumberFormatter.Format(itemData.price)
    price.TextColor3 = itemData.currency == "ƒ" and Theme.ShardPrice or Theme.Accent
    price.TextSize = 17
    price.Font = Enum.Font.GothamBold
    price.TextXAlignment = Enum.TextXAlignment.Left
    price.TextTruncate = Enum.TextTruncate.AtEnd
    price.Parent = priceFrame

    local tagLabel = Instance.new("TextLabel")
    tagLabel.Size = UDim2.new(0.5, 0, 1, 0)
    tagLabel.Position = UDim2.new(0.5, 0, 0, 0)
    tagLabel.BackgroundTransparency = 1
    tagLabel.Text = itemData.category
    tagLabel.TextColor3 = Theme.TextSecondary
    tagLabel.TextSize = 11
    tagLabel.Font = Enum.Font.Gotham
    tagLabel.TextXAlignment = Enum.TextXAlignment.Right
    tagLabel.TextTruncate = Enum.TextTruncate.AtEnd
    tagLabel.Parent = priceFrame

    local buyButton = Instance.new("TextButton")
    buyButton.Size = UDim2.new(1, 0, 0, 38)
    buyButton.Position = UDim2.new(0, 0, 1, -38)
    buyButton.BackgroundColor3 = Theme.Accent
    buyButton.Text = "ADD TO CART"
    buyButton.TextColor3 = Theme.TextPrimary
    buyButton.TextSize = 14
    buyButton.Font = Enum.Font.GothamBold
    buyButton.BorderSizePixel = 0
    buyButton.Parent = card

    self:CreateCorner(12).Parent = buyButton

    buyButton.MouseButton1Click:Connect(function()
        self:AddToCart(itemData)
        self:UpdateCart()

        buyButton.Text = "ADDED"
        buyButton.BackgroundColor3 = Theme.Success
        task.wait(1)
        buyButton.Text = "ADD TO CART"
        buyButton.BackgroundColor3 = Theme.Accent
    end)

    return card
end

function ShoppingMartClass:CreateCartItem(cartItem)
    local frame = Instance.new("Frame")
    frame.Name = "CartItem_" .. cartItem.name
    frame.Size = UDim2.new(1, 0, 0, 64)
    frame.BackgroundColor3 = Theme.SurfaceAlt
    frame.BorderSizePixel = 0

    self:CreateCorner(10).Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -36, 0, 25)
    title.Position = UDim2.new(0, 10, 0, 15)
    title.BackgroundTransparency = 1
    title.Text = cartItem.name
    title.TextColor3 = Theme.TextPrimary
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextYAlignment = Enum.TextYAlignment.Top
    title.TextTruncate = Enum.TextTruncate.AtEnd
    title.Parent = frame

    local removeButton = Instance.new("ImageButton")
    removeButton.Size = UDim2.new(0, 14, 0, 14)
    removeButton.Position = UDim2.new(1, -25, 0.2, 0)
    removeButton.Image = "rbxassetid://10747362393"
    removeButton.ImageColor3 = Theme.Danger
    removeButton.BackgroundTransparency = 1
    removeButton.Parent = frame

    removeButton.MouseButton1Click:Connect(function()
        self:RemoveFromCart(cartItem.name)
        self:UpdateCart()
    end)

    local price = Instance.new("TextLabel")
    price.Size = UDim2.new(0.5, 0, 0, 20)
    price.Position = UDim2.new(0, 10, 1, -28)
    price.BackgroundTransparency = 1
    price.Text = cartItem.currency .. NumberFormatter.Format(cartItem.price * cartItem.quantity)
    price.TextColor3 = cartItem.currency == "ƒ" and Theme.ShardPrice or Theme.Accent
    price.TextSize = 15
    price.Font = Enum.Font.GothamBold
    price.TextXAlignment = Enum.TextXAlignment.Left
    price.TextYAlignment = Enum.TextYAlignment.Center
    price.Parent = frame

    local qtyFrame = Instance.new("Frame")
    qtyFrame.Size = UDim2.new(0, 72, 0, 20)
    qtyFrame.Position = UDim2.new(1, -82, 1, -28)
    qtyFrame.BackgroundTransparency = 1
    qtyFrame.Parent = frame

    local minusButton = Instance.new("TextButton")
    minusButton.Size = UDim2.new(0, 20, 1, 0)
    minusButton.BackgroundTransparency = 1
    minusButton.Text = "−"
    minusButton.TextColor3 = Theme.TextPrimary
    minusButton.TextSize = 16
    minusButton.Font = Enum.Font.GothamBold
    minusButton.BorderSizePixel = 0
    minusButton.Parent = qtyFrame

    minusButton.MouseButton1Click:Connect(function()
        self:UpdateCartQuantity(cartItem.name, -1)
        self:UpdateCart()
    end)

    local qtyLabel = Instance.new("TextLabel")
    qtyLabel.Size = UDim2.new(0, 32, 1, 0)
    qtyLabel.Position = UDim2.new(0, 20, 0, 0)
    qtyLabel.BackgroundTransparency = 1
    qtyLabel.Text = tostring(cartItem.quantity)
    qtyLabel.TextColor3 = Theme.TextPrimary
    qtyLabel.TextSize = 14
    qtyLabel.Font = Enum.Font.GothamBold
    qtyLabel.TextXAlignment = Enum.TextXAlignment.Center
    qtyLabel.TextYAlignment = Enum.TextYAlignment.Center
    qtyLabel.Parent = qtyFrame

    local plusButton = Instance.new("TextButton")
    plusButton.Size = UDim2.new(0, 20, 1, 0)
    plusButton.Position = UDim2.new(1, -20, 0, 0)
    plusButton.BackgroundTransparency = 1
    plusButton.Text = "+"
    plusButton.TextColor3 = Theme.TextPrimary
    plusButton.TextSize = 16
    plusButton.Font = Enum.Font.GothamBold
    plusButton.BorderSizePixel = 0
    plusButton.Parent = qtyFrame

    plusButton.MouseButton1Click:Connect(function()
        self:UpdateCartQuantity(cartItem.name, 1)
        self:UpdateCart()
    end)

    return frame
end

function ShoppingMartClass:UpdateCart()
    if not self.gui then
        return
    end

    local cartScrollFrame = self.gui.MainFrame.ContentFrame.RightPanel.CartScrollFrame
    local checkoutFrame = self.gui.MainFrame.ContentFrame.RightPanel.CheckoutFrame

    for _, child in ipairs(cartScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    for _, cartItem in ipairs(self.shoppingCart) do
        local cartItemFrame = self:CreateCartItem(cartItem)
        cartItemFrame.Parent = cartScrollFrame
    end

    local totals = self:CalculateTotals()
    local totalText = ""
    for currency, amount in pairs(totals) do
        if totalText ~= "" then
            totalText = totalText .. " + "
        end
        totalText = totalText .. currency .. NumberFormatter.Format(amount)
    end

    local totalLabel = checkoutFrame:FindFirstChild("TotalLabel")
    local itemCountLabel = checkoutFrame:FindFirstChild("ItemCountLabel")

    if totalLabel then
        totalLabel.Text = "Total: " .. (totalText ~= "" and totalText or "$0")
    end

    if itemCountLabel then
        local count = self:GetItemCount()
        itemCountLabel.Text = count .. " item" .. (count ~= 1 and "s" or "")
    end
end

function ShoppingMartClass:UpdateItemDisplay()
    if not self.gui then
        return
    end

    local itemsScrollFrame = self.gui.MainFrame.ContentFrame.LeftPanel.ItemsScrollFrame

    for _, child in ipairs(itemsScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    local catalog = ItemCatalog.Build()

    for category, items in pairs(catalog) do
        if self.selectedCategory == "All" or self.selectedCategory == category then
            for _, itemData in ipairs(items) do
                local card = self:CreateItemCard(itemData)
                card.Parent = itemsScrollFrame
            end
        end
    end
end

function ShoppingMartClass:ProcessCheckout(button)
    if self.buying or #self.shoppingCart == 0 then
        return
    end

    self.buying = true

    button.Text = "Processing..."
    button.BackgroundColor3 = Theme.AccentDark

    for _, cartItem in ipairs(self.shoppingCart) do
        for i = 1, cartItem.quantity do
            if cartItem.shopItem then
                local remote = ReplicatedStorage.Remotes.Shop.BuyItem
                pcall(function()
                    remote:InvokeServer(cartItem.shopItem)
                end)
                task.wait(0.1)
            end
        end
    end

    self:ClearCart()
    self:UpdateCart()

    button.Text = "Completed"
    button.BackgroundColor3 = Theme.Success
    task.wait(1.5)
    button.Text = "Checkout"
    button.BackgroundColor3 = Theme.Accent

    self.buying = false
end

function ShoppingMartClass:Toggle()
    if self.gui then
        self.gui.Enabled = not self.gui.Enabled
    end
end

function ShoppingMartClass:Show()
    if self.gui then
        self.gui.Enabled = true
        self.inputBlocker.Visible = true
    end
end

function ShoppingMartClass:Hide()
    if self.gui then
        self.gui.Enabled = false
        self.inputBlocker.Visible = false
    end
end

return ShoppingMartClass