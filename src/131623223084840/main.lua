local SimpleUI = {}

SimpleUI.Services = {}

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
    ElegantMonokai = {
        PrimaryColor = Color3.fromRGB(32, 30, 36),
        SecondaryColor = Color3.fromRGB(65, 60, 70),
        SecondaryColorHover = Color3.fromRGB(90, 80, 100),
        SecondaryColorActive = Color3.fromRGB(105, 95, 115),
        SecondaryColorMouse1Down = Color3.fromRGB(70, 65, 75),
        TertiaryColor = Color3.fromRGB(70, 65, 78),
        TertiaryColorHover = Color3.fromRGB(95, 85, 105),
        TertiaryColorActive = Color3.fromRGB(110, 100, 120),
        TertiaryColorMouse1Down = Color3.fromRGB(75, 70, 85),
        TextInactive = Color3.fromRGB(240, 240, 245),
        TextActive = Color3.fromRGB(255, 255, 255),
        TextPrimary = Color3.fromRGB(240, 240, 245),
        TextSecondary = Color3.fromRGB(210, 205, 220),
        AccentColor = Color3.fromRGB(180, 140, 200),
        PrimaryFont = Enum.Font.Code,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.Code,
        SecondaryFontSize = 12,
        PrimaryTransparency = 0,
        SecondaryTransparency = 0.65
    }
}

SimpleUI.DefaultElements = {
    MainFrame = {
        Class = "Frame",
        Properties = {
            Name = "MainFrame",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0.85, 0, 0.60, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ClipsDescendants = false
        },
        Children = {{
            Class = "UISizeConstraint",
            Properties = {
                MinSize = Vector2.new(500, 335),
                MaxSize = Vector2.new(800, 600)
            }
        }, {
            Class = "UIAspectRatioConstraint",
            Properties = {
                AspectRatio = 1.6,
                AspectType = Enum.AspectType.FitWithinMaxSize,
                DominantAxis = Enum.DominantAxis.Width
            }
        }}
    },
    TopBar = {
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
    },
    TitleContainer = {
        Class = "Frame",
        Properties = {
            Name = "TitleContainer",
            Size = UDim2.new(0.7, -10, 0.7, 0),
            BackgroundTransparency = 1,
            ZIndex = 2,
            ClipsDescendants = false
        }
    },
    TitleLabel = {
        Class = "TextLabel",
        Properties = {
            Name = "TitleLabel",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = "SimpleUI",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 20,
            TextYAlignment = Enum.TextYAlignment.Center,
            ZIndex = 2
        },
        Theme = {
            Font = "PrimaryFont"
        }
    },
    ControlsContainer = {
        Class = "Frame",
        Properties = {
            Name = "ControlsContainer",
            Size = UDim2.new(0.3, -10, 0.7, 0),
            BackgroundTransparency = 1,
            ZIndex = 2,
            ClipsDescendants = false
        }
    },
    MainContainer = {
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
    },
    TabsContainer = {
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
        Padding = {
            Horizontal = 0,
            Vertical = 10
        },
        ListLayout = {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center
        }
    },
    ContentsContainer = {
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
        Padding = {
            Horizontal = 10,
            Vertical = 10
        }
    },
    Tab = {
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
            CornerRadius = UDim.new(0, 4)
        }
    },
    Page = {
        Class = "Frame",
        Properties = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = 3,
            ClipsDescendants = false
        },
        Padding = {
            Horizontal = 0,
            Vertical = 8
        },
        ListLayout = {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        }
    },
    Section = {
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
    },
    Button = {
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
            BackgroundTransparency = "SecondaryTransparency",
            Font = "SecondaryFont"
        },
        Corner = {
            CornerRadius = UDim.new(0, 4)
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
    },
    Toggle = {
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
            CornerRadius = UDim.new(0, 4)
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
    },
    Dropdown = {
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
            CornerRadius = UDim.new(0, 4)
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
    },
    Slider = {
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
            CornerRadius = UDim.new(0, 4)
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
    },
    TextInput = {
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
            CornerRadius = UDim.new(0, 4)
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
    },
    Keybind = {
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
            CornerRadius = UDim.new(0, 4)
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
    },
    Paragraph = {
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
            CornerRadius = UDim.new(0, 4)
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
}

SimpleUI.WindowControlStyles = {
    MacOS = {
        Size = UDim2.new(0, 12, 0, 12),
        Spacing = 8,
        UseText = false,
        Alignment = "Left",
        Colors = {
            Close = Color3.fromRGB(255, 95, 86),
            Minimize = Color3.fromRGB(255, 189, 46),
            Maximize = Color3.fromRGB(40, 201, 64)
        }
    },
    Windows = {
        Size = UDim2.new(0, 32, 1, 0),
        Spacing = 0,
        Gap = 0,
        UseImage = true,
        Alignment = "Right",
        Transparency = 1,
        Icons = {
            Minimize = {
                Image = "rbxassetid://10734896206",
                ImageColor = Color3.fromRGB(255, 255, 255),
                ImageSize = UDim2.new(0, 16, 0, 16),
                HoverColor = Color3.fromRGB(60, 60, 60),
                ClickColor = Color3.fromRGB(80, 80, 80)
            },
            Maximize = {
                Image = "rbxassetid://9886659001",
                ImageColor = Color3.fromRGB(255, 255, 255),
                ImageSize = UDim2.new(0, 16, 0, 16),
                HoverColor = Color3.fromRGB(60, 60, 60),
                ClickColor = Color3.fromRGB(80, 80, 80)
            },
            Close = {
                Image = "rbxassetid://10747384394",
                ImageColor = Color3.fromRGB(255, 255, 255),
                ImageSize = UDim2.new(0, 16, 0, 16),
                HoverColor = Color3.fromRGB(232, 17, 35),
                ClickColor = Color3.fromRGB(180, 10, 25)
            }
        }
    }
}

function SimpleUI:getService(name)
    if not self.Services[name] then
        self.Services[name] = (cloneref or function(x)
            return x
        end)(game:GetService(name))
    end
    return self.Services[name]
end

function SimpleUI:isMobile()
    local uis = self:getService("UserInputService")
    return uis.TouchEnabled and not uis.MouseEnabled
end

function SimpleUI:createElement(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
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

function SimpleUI:setTheme(window, themeName)
    -- **construction noises**
end

function SimpleUI:updateScrollingContainer(container)
    if not container or not container.Parent then
        return container
    end

    local layout = container:FindFirstChildWhichIsA("UIListLayout")
    if not layout then
        return container
    end

    local parent = container.Parent
    if not parent then
        return container
    end

    local padding = container:FindFirstChildWhichIsA("UIPadding")
    local paddingOffset = padding and (padding.PaddingTop.Offset + padding.PaddingBottom.Offset) or 0
    local totalHeight = layout.AbsoluteContentSize.Y
    local availableHeight = container.AbsoluteSize.Y - paddingOffset
    local needsScrolling = totalHeight > availableHeight
    local isScrollFrame = container:IsA("ScrollingFrame")

    if needsScrolling and not isScrollFrame then
        local containerIndex = table.find(parent:GetChildren(), container)

        local scroll = self:createElement("ScrollingFrame", {
            Name = container.Name,
            Position = container.Position,
            Size = container.Size,
            AnchorPoint = container.AnchorPoint,
            BackgroundColor3 = container.BackgroundColor3,
            BackgroundTransparency = container.BackgroundTransparency,
            BorderSizePixel = 0,
            BorderMode = Enum.BorderMode.Inset,
            ZIndex = container.ZIndex,
            LayoutOrder = container.LayoutOrder,
            Visible = container.Visible,
            ClipsDescendants = true,
            ScrollBarThickness = 0,
            CanvasSize = UDim2.new(0, 0, 0, totalHeight + paddingOffset),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200),
            ScrollBarImageTransparency = 0,
            AutomaticCanvasSize = Enum.AutomaticSize.None,
            ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
            ScrollingEnabled = true,
            Active = true
        }, parent)

        for _, child in ipairs(container:GetChildren()) do
            child.Parent = scroll
        end

        local gui = parent
        while gui and not gui:IsA("ScreenGui") do
            gui = gui.Parent
        end

        if gui and self.Windows and self.Windows[gui] then
            local window = self.Windows[gui]

            if window.Elements and window.Elements.Pages then
                for pageName, page in pairs(window.Elements.Pages) do
                    if page == container then
                        window.Elements.Pages[pageName] = scroll
                        break
                    end
                end
            end

            if window.ActivePage == container then
                window.ActivePage = scroll
            end

            if window.Elements.TabsContainer == container then
                window.Elements.TabsContainer = scroll
            end
        end

        container:Destroy()
        container = scroll

    elseif needsScrolling and isScrollFrame then
        local newCanvasSize = UDim2.new(0, 0, 0, totalHeight + paddingOffset)
        if container.CanvasSize ~= newCanvasSize then
            container.CanvasSize = newCanvasSize
        end

    elseif not needsScrolling and isScrollFrame then
        if container.CanvasSize ~= UDim2.new(0, 0, 0, 0) then
            container.CanvasSize = UDim2.new(0, 0, 0, 0)
        end
    end

    if layout and not layout:GetAttribute("AutoScrollHooked") then
        layout:SetAttribute("AutoScrollHooked", true)

        local updateQueued = false
        local lastContentSize = layout.AbsoluteContentSize

        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            if updateQueued or layout.AbsoluteContentSize == lastContentSize then
                return
            end
            lastContentSize = layout.AbsoluteContentSize
            updateQueued = true

            task.defer(function()
                updateQueued = false
                if container and container.Parent then
                    SimpleUI:updateScrollingContainer(container)
                end
            end)
        end)
    end

    return container
end

function SimpleUI:createWindowControl(controlType, style, parent, index, totalControls)
    local config = self.WindowControlStyles[style]
    if not config then
        return
    end
    local iconData = config.Icons and config.Icons[controlType] or {}
    local alignment = config.Alignment or "Right"
    local baseColor = config.Colors and config.Colors[controlType] or Color3.fromRGB(45, 45, 45)
    local spacing = config.Gap or config.Spacing or 0
    local mobile = self:isMobile()
    local position = alignment == "Left" and UDim2.new(0, index * (config.Size.X.Offset + spacing), 0.5, 0) or
                         UDim2.new(1, -(totalControls - index) * (config.Size.X.Offset + spacing), 0.5, 0)
    local button = self:createElement("TextButton", {
        Name = controlType .. "Button",
        Size = config.Size,
        Position = position,
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = baseColor,
        BackgroundTransparency = config.Transparency or 0,
        Text = "",
        BorderSizePixel = 0,
        ClipsDescendants = true,
        AutoButtonColor = false,
        ZIndex = 3
    }, parent)
    if config.UseImage then
        local imageId = iconData.Image or ""
        local imageSize = iconData.ImageSize or UDim2.new(0, 12, 0, 12)
        self:createElement("ImageLabel", {
            Size = imageSize,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = imageId,
            ImageColor3 = iconData.ImageColor or Color3.fromRGB(255, 255, 255),
            ZIndex = 4
        }, button)
    elseif config.UseText then
        self:createElement("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = iconData.Text or "",
            TextColor3 = iconData.TextColor or Color3.fromRGB(240, 240, 240),
            TextSize = iconData.TextSize or 18,
            Font = Enum.Font.GothamBold,
            ZIndex = 4
        }, button)
    end
    self:createElement("UICorner", {
        CornerRadius = alignment == "Left" and UDim.new(1, 0) or UDim.new(0, 0)
    }, button)
    if iconData.HoverColor and not mobile then
        local isHovering = false
        button.MouseEnter:Connect(function()
            isHovering = true
            button.BackgroundColor3 = iconData.HoverColor
        end)
        button.MouseLeave:Connect(function()
            isHovering = false
            button.BackgroundColor3 = baseColor
        end)
        if iconData.ClickColor then
            button.Activated:Connect(function()
                button.BackgroundColor3 = iconData.ClickColor
                task.wait(0.1)
                button.BackgroundColor3 = isHovering and iconData.HoverColor or baseColor
            end)
        end
    elseif iconData.ClickColor then
        button.Activated:Connect(function()
            button.BackgroundColor3 = iconData.ClickColor
            task.wait(0.1)
            button.BackgroundColor3 = baseColor
        end)
    end
    local parentFrame = parent.Parent
    if controlType == "Close" then
        button.Activated:Connect(function()
            local gui = parentFrame.Parent.Parent
            if not gui then
                return
            end
            local TweenService = game:GetService("TweenService")
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
                        local tween = TweenService:Create(obj, tweenInfo, props)
                        tween:Play()
                    end
                end
            end
            for _, obj in ipairs(gui:GetChildren()) do
                if obj:IsA("Frame") then
                    local tween = TweenService:Create(obj, tweenInfo, {
                        Size = UDim2.new(obj.Size.X.Scale, obj.Size.X.Offset, 0, 0)
                    })
                    tween:Play()
                end
            end
            task.delay(0.42, function()
                gui:Destroy()
            end)
        end)
    end
    if controlType == "Minimize" then
        button.Activated:Connect(function()
            local gui = parentFrame.Parent.Parent
            if not gui then
                return
            end
            local mainFrame = gui:FindFirstChild("MainFrame")
            if not mainFrame then
                return
            end
            local mainContainer = mainFrame:FindFirstChild("MainContainer")
            if not mainContainer then
                return
            end
            local inputBlocker = mainFrame:FindFirstChild("InputBlocker")
            if not inputBlocker then
                return
            end
            local TweenService = game:GetService("TweenService")
            if not mainContainer:GetAttribute("OpenSize") then
                mainContainer:SetAttribute("OpenSize", mainContainer.Size)
            end
            local minimized = mainContainer:GetAttribute("Minimized") or false
            mainContainer:SetAttribute("Minimized", not minimized)
            mainContainer.ClipsDescendants = true
            inputBlocker.Visible = minimized
            mainContainer.AutomaticSize = Enum.AutomaticSize.None
            TweenService:Create(mainContainer, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = minimized and mainContainer:GetAttribute("OpenSize") or
                    UDim2.new(mainContainer.Size.X.Scale, mainContainer.Size.X.Offset, 0, 0)
            }):Play()
        end)
    end
    return button
end

function SimpleUI:createWindow(options)
    options = options or {}
    local theme = options.Theme or self.Themes.ElegantMonokai
    local player = self:getService("Players").LocalPlayer

    local gui = self:createElement("ScreenGui", {
        Name = options.Name or "SimpleUI",
        ResetOnSpawn = false
    }, player:WaitForChild("PlayerGui"))

    local frameData = self:merge(self.DefaultElements.MainFrame, options.MainFrame)
    local frame = self:createElement(frameData.Class, frameData.Properties, gui)
    frame.ClipsDescendants = false

    local topBarData = self:merge(self.DefaultElements.TopBar, options.TopBar)
    local topBarProps = self:applyTheme(topBarData.Properties, topBarData.Theme, theme)
    local topBar = self:createElement(topBarData.Class, topBarProps, frame)

    self:createElement("TextButton", {
        Name = "InputBlocker",
        Size = UDim2.new(1, 0, 1, -topBar.Size.Y.Offset),
        Position = UDim2.new(0, 0, 0, topBar.Size.Y.Offset),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        ZIndex = frame.ZIndex,
        Active = true,
        Selectable = false
    }, frame)

    if frameData.Children then
        for _, child in ipairs(frameData.Children) do
            self:createElement(child.Class, child.Properties, frame)
        end
    end

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

    local controlStyle = options.ControlStyle or "Windows"
    local titleAlignment = options.TitleAlignment or (controlStyle == "Windows" and "Left" or "Right")
    local hasIcon = options.Icon ~= nil
    local hasSubtitle = options.Subtitle and options.Subtitle ~= ""

    local titleContainerData = self:merge(self.DefaultElements.TitleContainer, options.TitleContainer)
    local controlsContainerData = self:merge(self.DefaultElements.ControlsContainer, options.ControlsContainer)

    local alignmentConfig = {
        Left = {
            title = {
                pos = UDim2.new(0, 10, 0.5, 0),
                anchor = Vector2.new(0, 0.5)
            },
            controls = {
                pos = UDim2.new(1, -10, 0.5, 0),
                anchor = Vector2.new(1, 0.5)
            }
        },
        Right = {
            title = {
                pos = UDim2.new(1, -10, 0.5, 0),
                anchor = Vector2.new(1, 0.5)
            },
            controls = {
                pos = UDim2.new(0, 10, 0.5, 0),
                anchor = Vector2.new(0, 0.5)
            }
        },
        Center = {
            title = {
                pos = UDim2.new(0.5, 0, 0.5, 0),
                anchor = Vector2.new(0.5, 0.5)
            },
            controls = {
                pos = UDim2.new(1, -10, 0.5, 0),
                anchor = Vector2.new(1, 0.5)
            }
        }
    }

    local config = alignmentConfig[titleAlignment] or alignmentConfig.Center
    titleContainerData.Properties.Position = config.title.pos
    titleContainerData.Properties.AnchorPoint = config.title.anchor
    controlsContainerData.Properties.Position = config.controls.pos
    controlsContainerData.Properties.AnchorPoint = config.controls.anchor
    titleContainerData.Properties.AutomaticSize = Enum.AutomaticSize.XY
    titleContainerData.Properties.BackgroundTransparency = 1

    local titleContainer, controlsContainer
    if titleAlignment == "Right" then
        controlsContainer = self:createElement(controlsContainerData.Class, controlsContainerData.Properties, topBar)
        titleContainer = self:createElement(titleContainerData.Class, titleContainerData.Properties, topBar)
    else
        titleContainer = self:createElement(titleContainerData.Class, titleContainerData.Properties, topBar)
        controlsContainer = self:createElement(controlsContainerData.Class, controlsContainerData.Properties, topBar)
    end

    self:createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 8)
    }, titleContainer)

    if hasIcon then
        local iconData = options.Icon
        local iconImage = iconData.Image or iconData.Url or ""

        if string.match(iconImage, "^https?://") then
            local success, result = pcall(function()
                local fileName = "simpleui_icon_" .. tostring(tick()):gsub("%.", "_") .. ".png"
                local imageData = game:HttpGet(iconImage)
                writefile(fileName, imageData)
                return getcustomasset(fileName)
            end)
            iconImage = (success and result) or ""
        elseif tonumber(iconImage) then
            iconImage = "rbxassetid://" .. iconImage
        end

        if iconImage ~= "" then
            self:createElement("ImageLabel", {
                Name = "TitleIcon",
                LayoutOrder = 1,
                Size = UDim2.new(0, iconData.Size or 16, 0, iconData.Size or 16),
                BackgroundTransparency = 1,
                Image = iconImage,
                ImageColor3 = iconData.Color or Color3.fromRGB(255, 255, 255),
                ScaleType = Enum.ScaleType.Fit,
                BorderSizePixel = 0
            }, titleContainer)
        end
    end

    local titleLabelData = self:merge(self.DefaultElements.TitleLabel, options.TitleLabel)
    local textAlignmentMap = {
        Left = Enum.TextXAlignment.Left,
        Right = Enum.TextXAlignment.Right,
        Center = Enum.TextXAlignment.Center
    }
    local textAlignment = textAlignmentMap[titleAlignment] or Enum.TextXAlignment.Center

    titleLabelData.Properties.TextXAlignment = textAlignment
    titleLabelData.Properties.LayoutOrder = hasIcon and 2 or 1
    titleLabelData.Properties.AutomaticSize = Enum.AutomaticSize.XY
    titleLabelData.Properties.Size = UDim2.new(0, 0, 1, 0)
    titleLabelData.Properties.BackgroundTransparency = 1

    local titleProps = self:applyTheme(titleLabelData.Properties, titleLabelData.Theme, theme)
    self:createElement(titleLabelData.Class, titleProps, titleContainer)

    if hasSubtitle then
        self:createElement("TextLabel", {
            Name = "SubtitleLabel",
            LayoutOrder = 3,
            Text = "| " .. tostring(options.Subtitle),
            TextColor3 = Color3.fromRGB(155, 155, 155),
            TextTransparency = 0.25,
            TextSize = math.floor((titleProps.TextSize or 14) * 0.70),
            Font = titleProps.Font or Enum.Font.Default,
            TextXAlignment = textAlignment,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = UDim2.new(0, 0, 1, 0),
            BorderSizePixel = 0,
            TextTruncate = Enum.TextTruncate.AtEnd
        }, titleContainer)
    end

    local controls = options.WindowControls or
                         (controlStyle == "Windows" and {"Minimize", "Maximize", "Close"} or
                             {"Close", "Minimize", "Maximize"})

    local controlButtons = {}
    if controls then
        for i, controlType in ipairs(controls) do
            local button = self:createWindowControl(controlType, controlStyle, controlsContainer, i - 1, #controls)
            if button then
                controlButtons[controlType] = button
            end
        end
    end

    local mainContainerData = self:merge(self.DefaultElements.MainContainer, options.MainContainer)
    local mainContainerProps = self:applyTheme(mainContainerData.Properties, mainContainerData.Theme, theme)
    local mainContainer = self:createElement(mainContainerData.Class, mainContainerProps, frame)

    local function createContainerWithPadding(containerData, parent)
        local container = self:createElement(containerData.Class, containerData.Properties, parent)

        if containerData.ListLayout then
            self:createElement("UIListLayout", {
                SortOrder = containerData.ListLayout.SortOrder,
                Padding = UDim.new(0, containerData.Padding and containerData.Padding.Vertical or 0),
                HorizontalAlignment = containerData.ListLayout.HorizontalAlignment
            }, container)
        end

        if containerData.Padding then
            local p = containerData.Padding.Horizontal
            self:createElement("UIPadding", {
                PaddingTop = UDim.new(0, p),
                PaddingBottom = UDim.new(0, p),
                PaddingLeft = UDim.new(0, p),
                PaddingRight = UDim.new(0, p)
            }, container)
        end

        return container
    end

    local tabsContainerData = self:merge(self.DefaultElements.TabsContainer, options.TabsContainer)
    local tabsContainer = createContainerWithPadding(tabsContainerData, mainContainer)

    local contentsContainerData = self:merge(self.DefaultElements.ContentsContainer, options.ContentsContainer)
    local contentsContainer = self:createElement(contentsContainerData.Class, contentsContainerData.Properties,
        mainContainer)

    if contentsContainerData.Padding then
        local p = contentsContainerData.Padding.Horizontal
        self:createElement("UIPadding", {
            PaddingBottom = UDim.new(0, p),
            PaddingLeft = UDim.new(0, p),
            PaddingRight = UDim.new(0, p)
        }, contentsContainer)
    end

    local windowInstance = {
        Theme = theme,
        Elements = {
            ScreenGui = gui,
            MainFrame = frame,
            TopBar = topBar,
            TitleContainer = titleContainer,
            ControlsContainer = controlsContainer,
            ControlButtons = controlButtons,
            MainContainer = mainContainer,
            TabsContainer = tabsContainer,
            ContentsContainer = contentsContainer,
            Tabs = {},
            Pages = {}
        },
        ActiveTab = nil,
        ActivePage = nil,
        TabUpdates = {},
        SimpleGUI = gui,
        hide = function()
            frame.Visible = false
        end,
        show = function()
            frame.Visible = true
        end,
        toggle = function()
            frame.Visible = not frame.Visible
        end,
        destroy = function()
            gui:Destroy()
        end,
        isVisible = function()
            return frame.Visible
        end
    }

    SimpleUI.Windows = SimpleUI.Windows or {}
    SimpleUI.Windows[gui] = windowInstance

    task.defer(function()
        local function updateContainers()
            task.wait()
            windowInstance.Elements.TabsContainer = self:updateScrollingContainer(windowInstance.Elements.TabsContainer)
            if windowInstance.ActivePage then
                windowInstance.ActivePage = self:updateScrollingContainer(windowInstance.ActivePage)
            end
        end

        updateContainers()

        windowInstance.Elements.TabsContainer.ChildAdded:Connect(updateContainers)
        windowInstance.Elements.TabsContainer.ChildRemoved:Connect(updateContainers)

        windowInstance.Elements.ContentsContainer.ChildAdded:Connect(function(child)
            if child:IsA("Frame") then
                local layout = child:FindFirstChildWhichIsA("UIListLayout")
                if layout then
                    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                        if child == windowInstance.ActivePage then
                            windowInstance.ActivePage = self:updateScrollingContainer(child)
                        end
                    end)
                end

                local function updatePage()
                    if child == windowInstance.ActivePage then
                        task.wait()
                        windowInstance.ActivePage = self:updateScrollingContainer(child)
                    end
                end

                child.ChildAdded:Connect(updatePage)
                child.ChildRemoved:Connect(updatePage)
            end
        end)
    end)

    local TweenService = self:getService("TweenService")
    local UIS = self:getService("UserInputService")

    local dragging = false
    local dragStart
    local startPos

    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input:GetPropertyChangedSignal("UserInputState"):Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and
            (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local currentPos = input.Position
            local delta = currentPos - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale,
                startPos.Y.Offset + delta.Y)
        end
    end)

    return windowInstance
end

function SimpleUI:createPage(window, name, options)
    if not window or not window.Elements or not window.Elements.ContentsContainer then
        return
    end
    options = options or {}
    local pageData = self:merge(self.DefaultElements.Page, options)
    pageData.Properties.Name = name .. "Page"
    local page = self:createElement(pageData.Class, pageData.Properties, window.Elements.ContentsContainer)
    if pageData.ListLayout then
        self:createElement("UIListLayout", {
            SortOrder = pageData.ListLayout.SortOrder,
            Padding = pageData.ListLayout.Padding
        }, page)
    end
    if pageData.Padding then
        local p = pageData.Padding.Horizontal
        self:createElement("UIPadding", {
            PaddingTop = UDim.new(0, p),
            PaddingBottom = UDim.new(0, p),
            PaddingLeft = UDim.new(0, p),
            PaddingRight = UDim.new(0, p)
        }, page)
    end
    window.Elements.Pages[name] = page
    task.defer(function()
        if window.ActivePage then
            window.ActivePage = SimpleUI:updateScrollingContainer(window.ActivePage)
        end
    end)
    return page
end

function SimpleUI:createTab(window, name, options)
    if not window or not window.Elements or not window.Elements.TabsContainer then
        return
    end
    options = options or {}
    local theme = self:getTheme(window.Elements.TabsContainer)
    local tabData = self:merge(self.DefaultElements.Tab, options)
    local mobile = self:isMobile()
    tabData.Properties.Name = name
    tabData.Properties.Text = name
    tabData.Properties.LayoutOrder = #window.Elements.Tabs
    local tabProps = self:applyTheme(tabData.Properties, tabData.Theme, theme)
    local tab = self:createElement(tabData.Class, tabProps, window.Elements.TabsContainer)
    if tabData.Corner then
        self:createElement("UICorner", {
            CornerRadius = tabData.Corner.CornerRadius
        }, tab)
    end
    local paddingLeft = 8
    local textOffset = 0
    local icon = nil
    if options.Icon and type(options.Icon) == "table" and options.Icon.Image then
        local iconData = options.Icon
        local iconSize = iconData.Size or UDim2.new(0, 16, 0, 16)
        local iconWidth = iconSize.X.Offset
        icon = self:createElement("ImageLabel", {
            Name = "TabIcon",
            Image = iconData.Image,
            ImageColor3 = iconData.ImageColor3 or Color3.fromRGB(255, 255, 255),
            Size = iconSize,
            ImageRectOffset = iconData.ImageRectOffset or Vector2.new(0, 0),
            ImageRectSize = iconData.ImageRectSize or Vector2.new(0, 0),
            ImageTransparency = iconData.ImageTransparency or 0,
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, -20, 0.5, 0),
            ZIndex = 4
        }, tab)
        textOffset = iconWidth + 6
        paddingLeft = paddingLeft + textOffset
    end
    self:createElement("UIPadding", {
        PaddingLeft = UDim.new(0, paddingLeft),
        PaddingRight = UDim.new(0, 2)
    }, tab)
    local page = self:createPage(window, name)
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
        tab.MouseEnter:Connect(function()
            if not isActive then
                isHovering = true
                update()
            end
        end)
        tab.MouseLeave:Connect(function()
            if not isActive then
                isHovering = false
                isPressed = false
                update()
            end
        end)
        tab.MouseButton1Down:Connect(function()
            if not isActive then
                isPressed = true
                update()
            end
        end)
        tab.MouseButton1Up:Connect(function()
            if not isActive then
                isPressed = false
                update()
            end
        end)
    end
    tab.Activated:Connect(function()
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
        local currentPage = window.Elements.ContentsContainer:FindFirstChild(name .. "Page")
        if currentPage then
            page = currentPage
            page = self:updateScrollingContainer(page)
            window.Elements.Pages[name] = page
        end
        window.ActivePage = page
        page.Visible = true
        update()
    end)
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
        page = page,
        icon = icon
    }
end

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
    labelProps.TextSize = options.TextSize or (labelProps.TextSize + 1)
    local label = self:createElement("TextLabel", labelProps, section)
    local underlineProps = self:applyTheme(data.Underline.Properties, data.Underline.Theme, theme)
    local underlineThickness = options.UnderlineThickness or 1
    local underlineWidth = options.UnderlineWidth
    underlineProps.Size = underlineWidth and UDim2.new(0, underlineWidth, 0, underlineThickness) or
                              UDim2.new(1, 0, 0, underlineThickness)
    underlineProps.Position = UDim2.new(0, 0, 1, -underlineThickness + 1)
    local underline = self:createElement("Frame", underlineProps, section)
    self:createElement("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, underline)
    local api = {}
    function api:setText(t)
        label.Text = t
    end
    function api:setTextSize(s)
        label.TextSize = s
    end
    function api:setUnderlineWidth(w)
        underline.Size = w and UDim2.new(0, w, 0, underlineThickness) or UDim2.new(1, 0, 0, underlineThickness)
    end
    function api:setVisible(v)
        section.Visible = v
    end
    function api:getElements()
        return {
            Section = section,
            Label = label,
            Underline = underline
        }
    end
    return api
end

function SimpleUI:createButton(page, text, callback, options)
    if not page then
        return
    end
    options = options or {}
    local theme = self:getTheme(page)
    local data = self:merge(self.DefaultElements.Button, options)
    local mobile = self:isMobile()
    local props = self:applyTheme(data.Properties, data.Theme, theme)
    props.Text, props.Name = "", "ButtonContainer"
    local button = self:createElement(data.Class, props, page)
    if data.Corner then
        self:createElement("UICorner", {
            CornerRadius = data.Corner.CornerRadius
        }, button)
    end
    local descriptionText = options.Description or options.description
    local hasDescription = descriptionText and descriptionText ~= ""
    local container = self:createElement("Frame", {
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        AnchorPoint = Vector2.new(0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = false
    }, button)
    if hasDescription then
        self:createElement("UIPadding", {
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 8)
        }, container)
    end
    local layout = self:createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = hasDescription and Enum.VerticalAlignment.Top or Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2)
    }, container)
    local titleProps = self:applyTheme(data.Title.Properties, data.Title.Theme, theme)
    titleProps.Text = text or titleProps.Text
    titleProps.Size = UDim2.new(1, 0, 0, 0)
    titleProps.Position = UDim2.new(0, 0, 0, 0)
    titleProps.AutomaticSize = Enum.AutomaticSize.Y
    titleProps.TextWrapped = true
    titleProps.LayoutOrder = 1
    titleProps.ZIndex = 5
    local title = self:createElement("TextLabel", titleProps, container)
    local description
    if hasDescription then
        description = self:createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = descriptionText,
            TextColor3 = theme.TextSecondary,
            TextSize = 14,
            Font = titleProps.Font,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 2,
            ZIndex = 5
        }, container)
    end
    local function updateButtonSize()
        button.Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset, 0,
            layout.AbsoluteContentSize.Y + (hasDescription and 16 or 24))
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateButtonSize)
    task.defer(updateButtonSize)
    local arrowProps = self:applyTheme(data.Arrow.Properties, data.Arrow.Theme, theme)
    local arrow = self:createElement("ImageLabel", arrowProps, button)
    local state, held = "Base", false
    local function setColor(s)
        local currentTheme = theme
        if s == "Base" then
            button.BackgroundColor3 = currentTheme.SecondaryColor
        elseif s == "Hover" then
            button.BackgroundColor3 = currentTheme.SecondaryColorHover
        elseif s == "Button1Down" then
            button.BackgroundColor3 = currentTheme.SecondaryColorMouse1Down
        end
    end
    if not mobile then
        button.MouseEnter:Connect(function()
            if not held then
                state = "Hover"
                setColor(state)
            end
        end)
        button.MouseLeave:Connect(function()
            if held then
                held = false
            end
            state = "Base"
            setColor(state)
        end)
        button.MouseButton1Down:Connect(function()
            held = true
            state = "Button1Down"
            setColor(state)
        end)
        button.MouseButton1Up:Connect(function()
            if held then
                held = false
                state = "Hover"
                setColor(state)
                if callback then
                    task.spawn(callback)
                end
            end
        end)
    else
        button.Activated:Connect(function()
            state = "Button1Down"
            setColor(state)
            task.delay(0.1, function()
                state = "Base"
                setColor(state)
            end)
            if callback then
                task.spawn(callback)
            end
        end)
    end
    setColor("Base")
    local api = {}
    function api:setTitle(t)
        title.Text = t
    end
    function api:setDescription(t)
        if not description and t then
            description = self:createElement("TextLabel", {
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                Text = t,
                TextColor3 = theme.TextSecondary,
                TextSize = 14,
                Font = titleProps.Font,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 2,
                ZIndex = 5
            }, container)
        elseif description then
            description.Text = t or ""
            description.Visible = (t ~= nil and t ~= "")
        end
    end
    function api:setCallback(cb)
        callback = cb
    end
    function api:setVisible(v)
        button.Visible = v
    end
    function api:getElements()
        return {
            Button = button,
            Title = title,
            Description = description,
            Arrow = arrow
        }
    end
    function api:getState()
        return state
    end
    return api
end

function SimpleUI:createToggle(page, text, defaultValue, callback, options)
    if not page then
        return
    end
    options = options or {}
    local theme = self:getTheme(page)
    local toggleData = self:merge(self.DefaultElements.Toggle, options)
    local containerProps = self:applyTheme(toggleData.Properties, toggleData.Theme, theme)
    containerProps.AutomaticSize = Enum.AutomaticSize.Y
    local container = self:createElement(toggleData.Class, containerProps, page)
    if toggleData.Corner then
        self:createElement("UICorner", {
            CornerRadius = toggleData.Corner.CornerRadius
        }, container)
    end
    local descriptionText = options.Description or options.description
    local hasDescription = descriptionText and descriptionText ~= ""
    local textContainer = self:createElement("Frame", {
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        AnchorPoint = Vector2.new(0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = false,
        ZIndex = 5
    }, container)
    if hasDescription then
        self:createElement("UIPadding", {
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 8)
        }, textContainer)
    end
    local layout = self:createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = hasDescription and Enum.VerticalAlignment.Top or Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2)
    }, textContainer)
    local labelProps = self:applyTheme({
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextSize = toggleData.Label.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 1,
        ZIndex = 5
    }, toggleData.Label.Theme, theme)
    local label = self:createElement("TextLabel", labelProps, textContainer)
    local description
    if hasDescription then
        description = self:createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = descriptionText,
            TextColor3 = theme.TextSecondary,
            TextSize = 14,
            Font = labelProps.Font,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 2,
            ZIndex = 5
        }, textContainer)
    end
    local function updateContainerSize()
        container.Size = UDim2.new(container.Size.X.Scale, container.Size.X.Offset, 0,
            layout.AbsoluteContentSize.Y + (hasDescription and 16 or 24))
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateContainerSize)
    task.defer(updateContainerSize)
    local switchProps = self:applyTheme(toggleData.Switch, toggleData.Switch.Theme, theme)
    local switch = self:createElement("TextButton", {
        Size = switchProps.Size,
        Position = switchProps.Position,
        AnchorPoint = switchProps.AnchorPoint,
        BackgroundColor3 = switchProps.BackgroundColor3,
        BorderSizePixel = switchProps.BorderSizePixel,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 5
    }, container)
    self:createElement("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, switch)
    local indicatorProps = self:applyTheme(toggleData.Indicator, toggleData.Indicator.Theme, theme)
    local indicator = self:createElement("Frame", {
        Size = indicatorProps.Size,
        Position = indicatorProps.Position,
        AnchorPoint = indicatorProps.AnchorPoint,
        BackgroundColor3 = indicatorProps.BackgroundColor3,
        BorderSizePixel = indicatorProps.BorderSizePixel,
        ZIndex = 6
    }, switch)
    self:createElement("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, indicator)
    local state = defaultValue or false
    local lastToggleTime = 0
    local TOGGLE_COOLDOWN = 0.450
    local tweenService = self:getService("TweenService")
    local function updateToggle(animate)
        local posGoal = state and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
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
        callback(state)
    end
    switch.Activated:Connect(function()
        local now = tick()
        if now - lastToggleTime < TOGGLE_COOLDOWN then
            return
        end
        lastToggleTime = now
        state = not state
        updateToggle(true)
        if callback then
            callback(state)
        end
    end)

    return {
        container = container,
        getState = function()
            return state
        end,
        setState = function(val)
            state = val
            updateToggle(true)
        end,
        setDescription = function(t)
            if not description and t then
                description = self:createElement("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = t,
                    TextColor3 = theme.TextSecondary,
                    TextSize = 14,
                    Font = labelProps.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 2,
                    ZIndex = 5
                }, textContainer)
            elseif description then
                description.Text = t or ""
                description.Visible = (t ~= nil and t ~= "")
            end
        end
    }
end

function SimpleUI:createDropdown(page, text, options, defaultValue, callback, dropdownOptions)
    if not page then
        return
    end
    dropdownOptions = dropdownOptions or {}
    local theme = self:getTheme(page)
    local data = self:merge(self.DefaultElements.Dropdown, dropdownOptions)
    local mobile = self:isMobile()
    local multiSelect = dropdownOptions.MultiSelect or false
    local changedEvent = Instance.new("BindableEvent")
    local containerProps = self:applyTheme(data.Properties, data.Theme, theme)
    containerProps.AutomaticSize = Enum.AutomaticSize.Y
    local container = self:createElement(data.Class, containerProps, page)
    if data.Corner then
        self:createElement("UICorner", {
            CornerRadius = data.Corner.CornerRadius
        }, container)
    end
    local descriptionText = dropdownOptions.Description or dropdownOptions.description
    local hasDescription = descriptionText and descriptionText ~= ""
    local textContainer = self:createElement("Frame", {
        Size = UDim2.new(1, -190, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        AnchorPoint = Vector2.new(0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = false,
        ZIndex = 5
    }, container)
    if hasDescription then
        self:createElement("UIPadding", {
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 8)
        }, textContainer)
    end
    local layout = self:createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = hasDescription and Enum.VerticalAlignment.Top or Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2)
    }, textContainer)
    local labelProps = self:applyTheme({
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextSize = data.Label.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 1,
        ZIndex = 5
    }, data.Label.Theme, theme)
    local label = self:createElement("TextLabel", labelProps, textContainer)
    local description
    if hasDescription then
        description = self:createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = descriptionText,
            TextColor3 = theme.TextSecondary,
            TextSize = 14,
            Font = labelProps.Font,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 2,
            ZIndex = 5
        }, textContainer)
    end
    local function updateContainerSize()
        container.Size = UDim2.new(container.Size.X.Scale, container.Size.X.Offset, 0,
            layout.AbsoluteContentSize.Y + (hasDescription and 16 or 24))
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateContainerSize)
    task.defer(updateContainerSize)
    local displayProps = self:applyTheme(data.Display, data.Display.Theme, theme)
    local display = self:createElement("TextButton", {
        Size = displayProps.Size,
        Position = displayProps.Position,
        AnchorPoint = displayProps.AnchorPoint,
        BackgroundColor3 = displayProps.BackgroundColor3,
        BorderSizePixel = 0,
        Text = "",
        TextColor3 = displayProps.TextColor3,
        TextSize = displayProps.TextSize,
        Font = displayProps.Font,
        AutoButtonColor = false,
        ZIndex = 5
    }, container)
    self:createElement("UICorner", {
        CornerRadius = UDim.new(0, 4)
    }, display)
    local displayLabel = self:createElement("TextLabel", {
        Size = UDim2.new(1, -28, 1, 0),
        Position = UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = displayProps.TextColor3,
        TextSize = displayProps.TextSize,
        Font = displayProps.Font,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 6
    }, display)
    local arrow = self:createElement("ImageLabel", {
        Size = UDim2.new(0, 12, 0, 12),
        Position = UDim2.new(1, -8, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://10709790948",
        ImageColor3 = theme.TextPrimary,
        ZIndex = 6
    }, display)
    local displayState = "Base"
    local isOpen = false
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
        display.MouseEnter:Connect(function()
            if not isOpen then
                displayState = "Hover"
                updateDisplayColor()
            end
        end)
        display.MouseLeave:Connect(function()
            displayState = "Base"
            updateDisplayColor()
        end)
        display.MouseButton1Down:Connect(function()
            displayState = "Mouse1Down"
            updateDisplayColor()
        end)
        display.MouseButton1Up:Connect(function()
            displayState = "Hover"
            updateDisplayColor()
        end)
    end
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
    self:createElement("UICorner", {
        CornerRadius = UDim.new(0, 4)
    }, listContainer)
    local searchBox = self:createElement("TextBox", {
        Size = UDim2.new(1, -8, 0, 28),
        Position = UDim2.new(0, 4, 0, 4),
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
    self:createElement("UICorner", {
        CornerRadius = UDim.new(0, 4)
    }, searchBox)
    self:createElement("UIPadding", {
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8)
    }, searchBox)
    local scrollList = self:createElement("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -36),
        Position = UDim2.new(0, 0, 0, 36),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = theme.TextSecondary,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = 251,
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    }, listContainer)
    local listLayout = self:createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2)
    }, scrollList)
    self:createElement("UIPadding", {
        PaddingTop = UDim.new(0, 4),
        PaddingBottom = UDim.new(0, 4),
        PaddingLeft = UDim.new(0, 4),
        PaddingRight = UDim.new(0, 4)
    }, scrollList)
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
            selectedValues = nil
        end
    end
    local isToggling = false
    local inputBlocker = nil
    local targetHeight = 0
    local hasSearch = false
    local userInputService = self:getService("UserInputService")
    local tweenService = self:getService("TweenService")
    local inputConnection
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
            Size = UDim2.new(0, displayProps.Size.X.Offset, 0, 0)
        }):Play()
        task.wait(0.15)
        listContainer.Visible = false
        searchBox.Text = ""
        isOpen = false
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
                    if query == "" or opt.Text:lower():find(query, 1, true) then
                        child.Visible = true
                    else
                        child.Visible = false
                    end
                end
            end
        end
    end
    local function updateListPosition()
        local displayPos = display.AbsolutePosition
        local displaySize = display.AbsoluteSize
        local screenSize = gui.AbsoluteSize
        local baseMaxHeight = 150
        local contentHeight = listLayout.AbsoluteContentSize.Y + 8
        hasSearch = contentHeight > baseMaxHeight
        searchBox.Visible = hasSearch
        if hasSearch then
            scrollList.Size = UDim2.new(1, 0, 1, -36)
            scrollList.Position = UDim2.new(0, 0, 0, 36)
        else
            scrollList.Size = UDim2.new(1, 0, 1, 0)
            scrollList.Position = UDim2.new(0, 0, 0, 0)
        end
        targetHeight = math.min(baseMaxHeight, contentHeight) + (hasSearch and 36 or 0)
        local yPos = displayPos.Y + displaySize.Y + 4
        if yPos + targetHeight > screenSize.Y then
            yPos = displayPos.Y - targetHeight - 4
        end
        listContainer.Position = UDim2.new(0, displayPos.X, 0, yPos)
    end
    local function createOption(optionText, index)
        local optionProps = self:applyTheme(data.Option, data.Option.Theme, theme)
        local optionContainer = self:createElement("Frame", {
            Size = UDim2.new(1, -8, 0, optionProps.Size.Y.Offset),
            BackgroundTransparency = 1,
            ZIndex = 252,
            LayoutOrder = index
        }, scrollList)
        local option = self:createElement("TextButton", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundColor3 = optionProps.BackgroundColor3,
            BorderSizePixel = 0,
            Text = optionText,
            TextColor3 = optionProps.TextColor3,
            TextSize = optionProps.TextSize,
            Font = optionProps.Font,
            TextTruncate = Enum.TextTruncate.SplitWord,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutoButtonColor = false,
            ZIndex = 253
        }, optionContainer)
        self:createElement("UICorner", {
            CornerRadius = UDim.new(0, 3)
        }, option)
        self:createElement("UIPadding", {
            PaddingLeft = UDim.new(0, 14),
            PaddingRight = UDim.new(0, 8)
        }, option)
        local indicator = self:createElement("Frame", {
            Size = UDim2.new(0, 4, 0.5, 0),
            Position = UDim2.new(0, 2, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = theme.AccentColor,
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = 254
        }, optionContainer)
        self:createElement("UICorner", {
            CornerRadius = UDim.new(1, 0)
        }, indicator)
        if multiSelect then
            local function updateIndicator()
                indicator.Visible = selectedValues[optionText] or false
            end
            option.Activated:Connect(function()
                selectedValues[optionText] = not selectedValues[optionText]
                updateIndicator()
                updateDisplay()
                local selected = {}
                for v, enabled in pairs(selectedValues) do
                    if enabled then
                        table.insert(selected, optionDataMap[v])
                    end
                end
                if callback then
                    callback(selected)
                end
                changedEvent:Fire(selected)
            end)
            updateIndicator()
        else
            indicator.Visible = selectedValues == optionText
            option.Activated:Connect(function()
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
                    callback(optionDataMap[optionText])
                    changedEvent:Fire(value)
                end
            end)
        end
        if not mobile then
            option.MouseEnter:Connect(function()
                option.BackgroundColor3 = theme.TertiaryColorHover
            end)
            option.MouseLeave:Connect(function()
                option.BackgroundColor3 = theme.TertiaryColor
            end)
            option.MouseButton1Down:Connect(function()
                option.BackgroundColor3 = theme.TertiaryColorMouse1Down
            end)
            option.MouseButton1Up:Connect(function()
                option.BackgroundColor3 = theme.TertiaryColorHover
            end)
        end
    end
    for i, option in ipairs(normalizedOptions) do
        createOption(option, i)
    end
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        filterOptions(searchBox.Text)
    end)
    updateDisplay()
    updateDisplayColor()
    display.Activated:Connect(function()
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
            inputBlocker.Activated:Connect(function()
                displayState = "Base"
                updateDisplayColor()
                closeDropdown()
            end)
            displayState = "Active"
            updateDisplayColor()
            updateListPosition()
            listContainer.Size = UDim2.new(0, displayProps.Size.X.Offset, 0, 0)
            listContainer.Visible = true
            tweenService:Create(listContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, displayProps.Size.X.Offset, 0, targetHeight)
            }):Play()
            task.wait()
            inputConnection = userInputService.InputBegan:Connect(function(input)
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
            end)
        end
        task.wait(0.1)
        isToggling = false
    end)
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
            changedEvent:Fire(val)
            if callback then
                if multiSelect then
                    local selected = {}
                    for v, enabled in pairs(selectedValues) do
                        if enabled then
                            table.insert(selected, optionDataMap[v])
                        end
                    end
                    callback(selected)
                else
                    callback(optionDataMap[selectedValues])
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
                    selectedValues = nil
                end
            end
            updateDisplay()
        end,
        setDescription = function(t)
            if not description and t then
                description = self:createElement("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = t,
                    TextColor3 = theme.TextSecondary,
                    TextSize = 14,
                    Font = labelProps.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 2,
                    ZIndex = 5
                }, textContainer)
            elseif description then
                description.Text = t or ""
                description.Visible = (t ~= nil and t ~= "")
            end
        end,
        close = closeDropdown,
        Changed = changedEvent.Event
    }
end

function SimpleUI:createSlider(page, text, min, max, defaultValue, callback, options)
    if not page then
        return
    end
    options = options or {}
    local theme = self:getTheme(page)
    local data = self:merge(self.DefaultElements.Slider, options)
    local increment = options.Increment or 1
    local containerProps = self:applyTheme(data.Properties, data.Theme, theme)
    containerProps.AutomaticSize = Enum.AutomaticSize.Y
    local container = self:createElement(data.Class, containerProps, page)
    if data.Corner then
        self:createElement("UICorner", {
            CornerRadius = data.Corner.CornerRadius
        }, container)
    end
    local descriptionText = options.Description or options.description
    local hasDescription = descriptionText and descriptionText ~= ""
    local textContainer = self:createElement("Frame", {
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = false,
        ZIndex = 5
    }, container)
    if hasDescription then
        self:createElement("UIPadding", {
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 8)
        }, textContainer)
    end
    local layout = self:createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = hasDescription and Enum.VerticalAlignment.Top or Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2)
    }, textContainer)
    local labelContainer = self:createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        ZIndex = 5
    }, textContainer)
    local labelProps = self:applyTheme({
        Size = UDim2.new(1, -60, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextSize = data.Label.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        ZIndex = 5
    }, data.Label.Theme, theme)
    local label = self:createElement("TextLabel", labelProps, labelContainer)
    local valueProps = self:applyTheme({
        Size = UDim2.new(0, 50, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Text = tostring(defaultValue or min),
        TextSize = data.Value.TextSize,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 5
    }, data.Value.Theme, theme)
    local valueLabel = self:createElement("TextLabel", valueProps, labelContainer)
    local description
    if hasDescription then
        description = self:createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = descriptionText,
            TextColor3 = theme.TextSecondary,
            TextSize = 14,
            Font = labelProps.Font,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 2,
            ZIndex = 5
        }, textContainer)
    end
    local function updateContainerSize()
        container.Size =
            UDim2.new(container.Size.X.Scale, container.Size.X.Offset, 0, layout.AbsoluteContentSize.Y + 38)
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateContainerSize)
    task.defer(updateContainerSize)
    local trackProps = self:applyTheme(data.Track, data.Track.Theme, theme)
    local track = self:createElement("Frame", {
        Size = UDim2.new(1, -20, 0, 4),
        Position = UDim2.new(0, 10, 1, -12),
        BackgroundColor3 = trackProps.BackgroundColor3,
        BorderSizePixel = 0,
        ZIndex = 5
    }, container)
    self:createElement("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, track)
    local fillProps = self:applyTheme(data.Fill, data.Fill.Theme, theme)
    local fill = self:createElement("Frame", {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = fillProps.BackgroundColor3,
        BorderSizePixel = 0,
        ZIndex = 6
    }, track)
    self:createElement("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, fill)
    local thumbProps = self:applyTheme(data.Thumb, data.Thumb.Theme, theme)
    local thumb = self:createElement("Frame", {
        Size = thumbProps.Size,
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = thumbProps.BackgroundColor3,
        BorderSizePixel = 0,
        ZIndex = 7
    }, track)
    self:createElement("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, thumb)
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
            callback(value)
        end
    end
    local function onInput(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            local percent = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            updateSlider(min + (max - min) * percent)
        end
    end
    track.InputBegan:Connect(onInput)
    thumb.InputBegan:Connect(onInput)
    local uis = self:getService("UserInputService")
    uis.InputChanged:Connect(function(input)
        if dragging and
            (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local percent = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            updateSlider(min + (max - min) * percent)
        end
    end)
    uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
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
        end,
        setDescription = function(t)
            if not description and t then
                description = self:createElement("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = t,
                    TextColor3 = theme.TextSecondary,
                    TextSize = 14,
                    Font = labelProps.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 2,
                    ZIndex = 5
                }, textContainer)
            elseif description then
                description.Text = t or ""
                description.Visible = (t ~= nil and t ~= "")
            end
        end
    }
end

function SimpleUI:createTextInput(page, text, defaultValue, callback, options)
    if not page then
        return
    end
    options = options or {}
    local theme = self:getTheme(page)
    local data = self:merge(self.DefaultElements.TextInput, options)
    local mobile = self:isMobile()
    local containerProps = self:applyTheme(data.Properties, data.Theme, theme)
    containerProps.AutomaticSize = Enum.AutomaticSize.Y
    local container = self:createElement(data.Class, containerProps, page)
    if data.Corner then
        self:createElement("UICorner", {
            CornerRadius = data.Corner.CornerRadius
        }, container)
    end
    local descriptionText = options.Description or options.description
    local hasDescription = descriptionText and descriptionText ~= ""
    local textContainer = self:createElement("Frame", {
        Size = UDim2.new(0.6, -10, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        AnchorPoint = Vector2.new(0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = false,
        ZIndex = 5
    }, container)
    if hasDescription then
        self:createElement("UIPadding", {
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 8)
        }, textContainer)
    end
    local layout = self:createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = hasDescription and Enum.VerticalAlignment.Top or Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2)
    }, textContainer)
    local labelProps = self:applyTheme({
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextSize = data.Label.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 1,
        ZIndex = 5
    }, data.Label.Theme, theme)
    local label = self:createElement("TextLabel", labelProps, textContainer)
    local description
    if hasDescription then
        description = self:createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = descriptionText,
            TextColor3 = theme.TextSecondary,
            TextSize = 14,
            Font = labelProps.Font,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 2,
            ZIndex = 5
        }, textContainer)
    end
    local function updateContainerSize()
        container.Size = UDim2.new(container.Size.X.Scale, container.Size.X.Offset, 0,
            layout.AbsoluteContentSize.Y + (hasDescription and 16 or 24))
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateContainerSize)
    task.defer(updateContainerSize)
    local inputProps = self:applyTheme(data.Input, data.Input.Theme, theme)
    local inputBox = self:createElement("TextBox", {
        Size = inputProps.Size,
        Position = inputProps.Position,
        AnchorPoint = inputProps.AnchorPoint,
        BackgroundColor3 = inputProps.BackgroundColor3,
        BorderSizePixel = 0,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Text = defaultValue or "",
        PlaceholderText = inputProps.PlaceholderText,
        TextColor3 = inputProps.TextColor3,
        PlaceholderColor3 = inputProps.PlaceholderColor3,
        TextSize = inputProps.TextSize,
        Font = inputProps.Font,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        ZIndex = 5
    }, container)
    self:createElement("UICorner", {
        CornerRadius = UDim.new(0, 4)
    }, inputBox)
    self:createElement("UIPadding", {
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8)
    }, inputBox)
    local underlineProps = self:applyTheme(data.Underline, data.Underline.Theme, theme)
    local underline = self:createElement("Frame", {
        Size = underlineProps.Size,
        Position = underlineProps.Position,
        BackgroundColor3 = underlineProps.BackgroundColor3,
        BorderSizePixel = 0,
        ZIndex = 6
    }, inputBox)
    self:createElement("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, underline)
    local isFocused = false
    local tween = self:getService("TweenService")
    inputBox.Focused:Connect(function()
        isFocused = true
        tween:Create(underline, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = theme.AccentColor
        }):Play()
    end)
    inputBox.FocusLost:Connect(function()
        isFocused = false
        tween:Create(underline, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = theme.TertiaryColorMouse1Down
        }):Play()
        if callback then
            callback(inputBox.Text)
        end
    end)
    if not mobile then
        inputBox.MouseEnter:Connect(function()
            if not isFocused then
                inputBox.BackgroundColor3 = theme.TertiaryColorHover
            end
        end)
        inputBox.MouseLeave:Connect(function()
            if not isFocused then
                inputBox.BackgroundColor3 = theme.TertiaryColor
            end
        end)
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
        end,
        setDescription = function(t)
            if not description and t then
                description = self:createElement("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = t,
                    TextColor3 = theme.TextSecondary,
                    TextSize = 14,
                    Font = labelProps.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 2,
                    ZIndex = 5
                }, textContainer)
            elseif description then
                description.Text = t or ""
                description.Visible = (t ~= nil and t ~= "")
            end
        end
    }
end

function SimpleUI:createKeybind(page, text, defaultKey, callback, options)
    if not page then
        return
    end
    options = options or {}
    local theme = self:getTheme(page)
    local data = self:merge(self.DefaultElements.Keybind, options)
    local mobile = self:isMobile()
    local containerProps = self:applyTheme(data.Properties, data.Theme, theme)
    containerProps.AutomaticSize = Enum.AutomaticSize.Y
    local container = self:createElement(data.Class, containerProps, page)
    if data.Corner then
        self:createElement("UICorner", {
            CornerRadius = data.Corner.CornerRadius
        }, container)
    end
    local descriptionText = options.Description or options.description
    local hasDescription = descriptionText and descriptionText ~= ""
    local textContainer = self:createElement("Frame", {
        Size = UDim2.new(0.75, -10, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        AnchorPoint = Vector2.new(0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = false,
        ZIndex = 5
    }, container)
    if hasDescription then
        self:createElement("UIPadding", {
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 8)
        }, textContainer)
    end
    local layout = self:createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = hasDescription and Enum.VerticalAlignment.Top or Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2)
    }, textContainer)
    local labelProps = self:applyTheme({
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextSize = data.Label.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 1,
        ZIndex = 5
    }, data.Label.Theme, theme)
    local label = self:createElement("TextLabel", labelProps, textContainer)
    local description
    if hasDescription then
        description = self:createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = descriptionText,
            TextColor3 = theme.TextSecondary,
            TextSize = 14,
            Font = labelProps.Font,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 2,
            ZIndex = 5
        }, textContainer)
    end
    local function updateContainerSize()
        container.Size = UDim2.new(container.Size.X.Scale, container.Size.X.Offset, 0,
            layout.AbsoluteContentSize.Y + (hasDescription and 16 or 24))
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateContainerSize)
    task.defer(updateContainerSize)
    local displayProps = self:applyTheme(data.Display, data.Display.Theme, theme)
    local display = self:createElement("TextButton", {
        Size = displayProps.Size,
        Position = displayProps.Position,
        AnchorPoint = displayProps.AnchorPoint,
        BackgroundColor3 = displayProps.BackgroundColor3,
        BorderSizePixel = 0,
        Text = "",
        TextColor3 = displayProps.TextColor3,
        TextSize = displayProps.TextSize,
        Font = displayProps.Font,
        AutoButtonColor = false,
        ZIndex = 5
    }, container)
    self:createElement("UICorner", {
        CornerRadius = UDim.new(0, 4)
    }, display)
    self:createElement("UIPadding", {
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8)
    }, display)
    local displayLabel = self:createElement("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = displayProps.TextColor3,
        TextSize = displayProps.TextSize,
        Font = displayProps.Font,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 6
    }, display)
    local currentKey = defaultKey
    local listening = false
    local uis = self:getService("UserInputService")
    local bindConnection
    local inputConnection
    local function updateDisplay()
        if listening then
            displayLabel.Text = "Press a key.."
            display.BackgroundColor3 = theme.AccentColor
        else
            displayLabel.Text = "Key: " .. (currentKey and currentKey.Name or "Select Keybind...")
            display.BackgroundColor3 = theme.TertiaryColor
        end
    end
    local function setupBind()
        if bindConnection then
            bindConnection:Disconnect()
        end
        if currentKey and callback then
            bindConnection = uis.InputBegan:Connect(function(input, gameProcessed)
                if not gameProcessed and input.KeyCode == currentKey then
                    callback(currentKey)
                end
            end)
        end
    end
    display.Activated:Connect(function()
        if listening then
            return
        end
        listening = true
        updateDisplay()
        inputConnection = uis.InputBegan:Connect(function(input, gameProcessed)
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
        end)
    end)
    if not mobile then
        display.MouseEnter:Connect(function()
            if not listening then
                display.BackgroundColor3 = theme.TertiaryColorHover
            end
        end)
        display.MouseLeave:Connect(function()
            if not listening then
                display.BackgroundColor3 = theme.TertiaryColor
            end
        end)
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
        end,
        setDescription = function(t)
            if not description and t then
                description = self:createElement("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = t,
                    TextColor3 = theme.TextSecondary,
                    TextSize = 14,
                    Font = labelProps.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 2,
                    ZIndex = 5
                }, textContainer)
            elseif description then
                description.Text = t or ""
                description.Visible = (t ~= nil and t ~= "")
            end
        end
    }
end

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
    if data.Corner then
        self:createElement("UICorner", {
            CornerRadius = data.Corner.CornerRadius
        }, container)
    end
    local contentContainer = self:createElement("Frame", {
        Size = UDim2.new(1, -20, 0, 0),
        Position = UDim2.new(0, 10, 0, 8),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 5
    }, container)
    local layout = self:createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4)
    }, contentContainer)
    local titleProps = self:applyTheme({
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = title or "Paragraph",
        TextSize = data.Title.TextSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutomaticSize = Enum.AutomaticSize.Y,
        TextWrapped = true,
        LayoutOrder = 0,
        ZIndex = 5
    }, data.Title.Theme, theme)
    local titleLabel = self:createElement("TextLabel", titleProps, contentContainer)
    local function updateContainerSize()
        container.Size =
            UDim2.new(container.Size.X.Scale, container.Size.X.Offset, 0, layout.AbsoluteContentSize.Y + 16)
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateContainerSize)
    task.defer(updateContainerSize)
    local fieldElements = {}
    local fieldCounter = 0
    local function createField(fieldData, layoutOrder)
        fieldCounter = fieldCounter + 1
        local fieldId = "field_" .. fieldCounter
        local isSubField = fieldData.isSubField or false
        local fieldConfig = isSubField and data.SubField or data.Field
        local fieldProps = self:applyTheme({
            Size = UDim2.new(1, isSubField and -20 or 0, 0, 0),
            Position = isSubField and UDim2.new(0, 20, 0, 0) or UDim2.new(0, 0, 0, 0),
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
        findField = function(searchText)
            for id, fieldData in pairs(fieldElements) do
                if fieldData.data.text:find(searchText, 1, true) then
                    return id, fieldData.data.text
                end
            end
            return nil
        end,
        getAllFields = function()
            local result = {}
            for id, fieldData in pairs(fieldElements) do
                table.insert(result, {
                    id = id,
                    text = fieldData.data.text,
                    isSubField = fieldData.data.isSubField
                })
            end
            return result
        end,
        setFields = function(newFields)
            for id, fieldData in pairs(fieldElements) do
                fieldData.element:Destroy()
            end
            fieldElements, fieldCounter = {}, 0
            if newFields and type(newFields) == "table" then
                for i, fieldData in ipairs(newFields) do
                    createField(type(fieldData) == "string" and {
                        text = fieldData
                    } or fieldData, i)
                end
            end
        end,
        clearFields = function()
            for id, fieldData in pairs(fieldElements) do
                fieldData.element:Destroy()
            end
            fieldElements, fieldCounter = {}, 0
        end,
        setTitle = function(newTitle)
            titleLabel.Text = newTitle
        end,
        getFieldCount = function()
            local count = 0
            for _ in pairs(fieldElements) do
                count = count + 1
            end
            return count
        end,
        sortFields = function(comparator)
            local fieldsArray = {}
            for id, fieldData in pairs(fieldElements) do
                table.insert(fieldsArray, {
                    id = id,
                    data = fieldData.data,
                    element = fieldData.element
                })
            end
            table.sort(fieldsArray, comparator or function(a, b)
                return a.element.LayoutOrder < b.element.LayoutOrder
            end)
            for i, field in ipairs(fieldsArray) do
                field.element.LayoutOrder = i
            end
        end,
        setFieldColor = function(fieldId, color)
            if not fieldElements[fieldId] then
                return false
            end
            fieldElements[fieldId].element.TextColor3 = color
            return true
        end,
        setFieldSize = function(fieldId, textSize)
            if not fieldElements[fieldId] then
                return false
            end
            fieldElements[fieldId].element.TextSize = textSize
            return true
        end
    }
end

function SimpleUI:createNotification(options)
    options = options or {}
    local Players = self:getService("Players")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local containerName = "SimpleUI_NotificationContainer"
    local isMobile = self:isMobile()

    local container = playerGui:FindFirstChild(containerName)
    if not container then
        container = self:createElement("ScreenGui", {
            Name = containerName,
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 999
        }, playerGui)

        local holderSize = isMobile and UDim2.new(0, 280, 1, 0) or UDim2.new(0, 320, 1, 0)
        local holderPosition = isMobile and UDim2.new(0.5, 0, 0, 10) or UDim2.new(1, -15, 0, 15)
        local holderAnchor = isMobile and Vector2.new(0.5, 0) or Vector2.new(1, 0)

        local holder = self:createElement("Frame", {
            Name = "Holder",
            Position = holderPosition,
            AnchorPoint = holderAnchor,
            Size = holderSize,
            BackgroundTransparency = 1
        }, container)

        self:createElement("UIListLayout", {
            Name = "Layout",
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = isMobile and Enum.HorizontalAlignment.Center or Enum.HorizontalAlignment.Right,
            Padding = UDim.new(0, isMobile and 6 or 8)
        }, holder)
    end

    local holder = container:FindFirstChild("Holder")
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
        Size = UDim2.new(0, 2, 1, 0),
        BackgroundColor3 = accentColor,
        BorderSizePixel = 0
    }, notification)

    local shadow = self:createElement("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 20, 1, 20),
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
        Position = UDim2.new(0, 2, 0, 0),
        Size = UDim2.new(1, -2, 1, 0),
        BackgroundTransparency = 1
    }, notification)

    self:createElement("UIPadding", {
        PaddingTop = UDim.new(0, basePadding),
        PaddingBottom = UDim.new(0, basePadding),
        PaddingLeft = UDim.new(0, sidePadding),
        PaddingRight = UDim.new(0, sidePadding)
    }, content)

    local hasIcon = options.Icon == nil
    local iconImage = options.Icon or typeIcons[notifType]
    local iconSize = isMobile and 18 or (options.IconSize or 20)

    local iconFrame
    if hasIcon and iconImage then
        iconFrame = self:createElement("ImageLabel", {
            Name = "Icon",
            Size = UDim2.new(0, iconSize, 0, iconSize),
            Position = UDim2.new(0, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Image = iconImage,
            ImageColor3 = options.IconColor or accentColor,
            ScaleType = Enum.ScaleType.Fit
        }, content)
    end

    local showClose = options.Closable ~= false
    local textOffset = hasIcon and (iconSize + (isMobile and 8 or 10)) or 0

    local textContainer = self:createElement("Frame", {
        Name = "TextContainer",
        Position = UDim2.new(0, textOffset, 0, 0),
        Size = UDim2.new(1, -textOffset, 1, 0),
        BackgroundTransparency = 1
    }, content)

    self:createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, isMobile and 1 or 2),
        VerticalAlignment = Enum.VerticalAlignment.Center
    }, textContainer)

    local titleSize = isMobile and 12 or (options.TitleSize or 13)
    local title = self:createElement("TextLabel", {
        Name = "Title",
        LayoutOrder = 1,
        Size = UDim2.new(1, showClose and -(isMobile and 22 or 26) or 0, 0, 0),
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

    if options.Description then
        local descSize = isMobile and 11 or (options.DescriptionSize or 12)
        self:createElement("TextLabel", {
            Name = "Description",
            LayoutOrder = 2,
            Size = UDim2.new(1, showClose and -(isMobile and 22 or 26) or 0, 0, 0),
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
    end

    if showClose then
        local closeSize = isMobile and 16 or 18
        local closeButton = self:createElement("TextButton", {
            Name = "CloseButton",
            Position = UDim2.new(1, 0, 0, 0),
            AnchorPoint = Vector2.new(1, 0),
            Size = UDim2.new(0, closeSize, 0, closeSize),
            BackgroundTransparency = 1,
            Text = "×",
            Font = Enum.Font.GothamBold,
            TextSize = isMobile and 18 or 20,
            TextColor3 = Color3.fromRGB(140, 140, 145),
            AutoButtonColor = false
        }, content)

        local isHovering = false
        closeButton.MouseEnter:Connect(function()
            isHovering = true
            local TweenService = self:getService("TweenService")
            TweenService:Create(closeButton, TweenInfo.new(0.15), {
                TextColor3 = Color3.fromRGB(255, 85, 85),
                Rotation = 90
            }):Play()
        end)

        closeButton.MouseLeave:Connect(function()
            isHovering = false
            local TweenService = self:getService("TweenService")
            TweenService:Create(closeButton, TweenInfo.new(0.15), {
                TextColor3 = Color3.fromRGB(140, 140, 145),
                Rotation = 0
            }):Play()
        end)

        closeButton.MouseButton1Click:Connect(function()
            if not isHovering then
                return
            end
            self:dismissNotification(notification)
        end)
    end

    if options.Callback then
        local clickArea = self:createElement("TextButton", {
            Name = "ClickArea",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = "",
            ZIndex = 1
        }, notification)

        clickArea.MouseButton1Click:Connect(function()
            options.Callback(notification)
        end)

        clickArea.MouseEnter:Connect(function()
            local TweenService = self:getService("TweenService")
            TweenService:Create(notification, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(35, 35, 40)
            }):Play()
        end)

        clickArea.MouseLeave:Connect(function()
            local TweenService = self:getService("TweenService")
            TweenService:Create(notification, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(28, 28, 32)
            }):Play()
        end)
    end

    task.defer(function()
        task.wait()

        local contentSize
        if options.Height then
            contentSize = options.Height
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

            local minHeight = hasIcon and (iconSize + (basePadding * 2)) or (isMobile and 38 or 42)
            contentSize = math.max(textHeight + (basePadding * 2), minHeight)
        end

        notification.Size = UDim2.new(1, 0, 0, contentSize)
        notification.Position = UDim2.new(0, isMobile and 15 or 20, 0, 0)
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
                Position = UDim2.new(0, 0, 1, -2),
                Size = UDim2.new(1, 0, 0, 2),
                BackgroundColor3 = accentColor,
                BorderSizePixel = 0,
                ZIndex = 10
            }, notification)

            TweenService:Create(progressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
                Size = UDim2.new(0, 0, 0, 2)
            }):Play()
        end

        if options.AutoDismiss ~= false then
            task.wait(duration)
            self:dismissNotification(notification)
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
    -- local content = notification:FindFirstChild("Content")
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
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = overlayName or "PopupOverlay"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local blurFrame = Instance.new("TextButton")
    blurFrame.Name = "BlurBackground"
    blurFrame.Size = UDim2.new(1, 0, 1, 0)
    blurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blurFrame.BackgroundTransparency = 0.4
    blurFrame.BorderSizePixel = 0
    blurFrame.Text = ""
    blurFrame.AutoButtonColor = false
    blurFrame.Modal = true
    blurFrame.Parent = screenGui
    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Size = 20
    blurEffect.Parent = game:GetService("Lighting")
    local popup = Instance.new("Frame")
    popup.Name = "Popup"
    popup.Size = width
    popup.Position = UDim2.new(0.5, 0, 0.5, 0)
    popup.AnchorPoint = Vector2.new(0.5, 0.5)
    popup.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    popup.BorderSizePixel = 0
    popup.Parent = screenGui
    local popupCorner = Instance.new("UICorner")
    popupCorner.CornerRadius = UDim.new(0.02, 0)
    popupCorner.Parent = popup
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0.08, 0)
    topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    topBar.BorderSizePixel = 0
    topBar.Parent = popup
    local topBarCorner = Instance.new("UICorner")
    topBarCorner.CornerRadius = UDim.new(0.02, 0)
    topBarCorner.Parent = topBar
    local topBarBottom = Instance.new("Frame")
    topBarBottom.Size = UDim2.new(1, 0, 0.2, 0)
    topBarBottom.Position = UDim2.new(0, 0, 1, 0)
    topBarBottom.AnchorPoint = Vector2.new(0, 1)
    topBarBottom.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    topBarBottom.BorderSizePixel = 0
    topBarBottom.Parent = topBar
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(0.85, 0, 1, 0)
    titleLabel.Position = UDim2.new(0.03, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 15
    titleLabel.Font = Enum.Font.GothamMedium
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextScaled = true
    titleLabel.Parent = topBar
    local titleConstraint = Instance.new("UITextSizeConstraint")
    titleConstraint.MaxTextSize = 15
    titleConstraint.MinTextSize = 10
    titleConstraint.Parent = titleLabel
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.08, 0, 0.65, 0)
    closeButton.Position = UDim2.new(0.95, 0, 0.5, 0)
    closeButton.AnchorPoint = Vector2.new(0.5, 0.5)
    closeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    closeButton.Text = "x"
    closeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    closeButton.TextSize = 14
    closeButton.Font = Enum.Font.Arcade
    closeButton.TextScaled = true
    closeButton.Parent = topBar
    local closeButtonConstraint = Instance.new("UITextSizeConstraint")
    closeButtonConstraint.MaxTextSize = 14
    closeButtonConstraint.MinTextSize = 10
    closeButtonConstraint.Parent = closeButton
    local closeButtonCorner = Instance.new("UICorner")
    closeButtonCorner.CornerRadius = UDim.new(0.15, 0)
    closeButtonCorner.Parent = closeButton
    local container = Instance.new("ScrollingFrame")
    container.Name = "Container"
    container.Size = UDim2.new(0.93, 0, 0.85, 0)
    container.Position = UDim2.new(0.035, 0, 0.12, 0)
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    container.BorderSizePixel = 0
    container.ScrollBarThickness = 4
    container.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
    container.CanvasSize = UDim2.new(0, 0, 0, 0)
    container.AutomaticCanvasSize = Enum.AutomaticSize.Y
    container.Parent = popup
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0.03, 0)
    containerCorner.Parent = container
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingTop = UDim.new(0.02, 0)
    contentPadding.PaddingBottom = UDim.new(0.02, 0)
    contentPadding.PaddingLeft = UDim.new(0.03, 0)
    contentPadding.PaddingRight = UDim.new(0.03, 0)
    contentPadding.Parent = container
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Name = "Content"
    contentLabel.Size = UDim2.new(1, 0, 0, 0)
    contentLabel.BackgroundTransparency = 1
    contentLabel.Text = convertMarkdownToRichText(text)
    contentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    contentLabel.TextSize = 14
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextYAlignment = Enum.TextYAlignment.Top
    contentLabel.TextWrapped = true
    contentLabel.RichText = true
    contentLabel.AutomaticSize = Enum.AutomaticSize.Y
    contentLabel.Parent = container
    local function closePopup()
        if blurEffect then
            blurEffect:Destroy()
        end
        screenGui:Destroy()
        onClose()
    end
    closeButton.MouseButton1Click:Connect(closePopup)
    return {
        gui = screenGui,
        popup = popup,
        container = container,
        contentLabel = contentLabel,
        close = closePopup
    }
end

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
    print("Loader required")
end

local storageRegistry = getgenv().__PrereqStorageRegistry
local moduleRegistry = getgenv().__PrereqModuleRegistry

if not storageRegistry or not moduleRegistry then
    print("Loader required")
end

local data = storageRegistry[proxy]
local prereqs = data.Prereqs

if not prereqs or not next(prereqs) then
    print("Loader required")
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

local LoopFramework = getPrerequisite("LoopFramework")
LoopFramework:start()

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
    Name = "SimpleUI",
    TitleLabel = {
        Properties = {
            Text = "Escape the Tsunami"
        }
    },
    Subtitle = "by SimpleScripts"
})

-- ========================= TAB SYSTEM =========================

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

local UpgradesTab = SimpleUI:createTab(window, "Upgrades", {
    Icon = {
        Image = "rbxassetid://16898612629",
        Size = UDim2.new(0, 16, 0, 16),
        ImageRectSize = Vector2.new(48, 48),
        ImageRectOffset = Vector2.new(612, 918),
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
});
local UpgradesPage = UpgradesTab.page

local MiscellaneousTab = SimpleUI:createTab(window, "Misc", {
    Icon = {
        Image = "rbxassetid://10734963191",
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
})
local MiscellaneousPage = MiscellaneousTab.page

local PlayerTab = SimpleUI:createTab(window, "Player", {
    Icon = {
        Image = "rbxassetid://16898613509",
        Size = UDim2.new(0, 16, 0, 16),
        ImageRectSize = Vector2.new(48, 48),
        ImageRectOffset = Vector2.new(918, 49),
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
});
local PlayerPage = PlayerTab.page

local OthersTab = SimpleUI:createTab(window, "Others", {
    Icon = {
        Image = "rbxassetid://10723404337",
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
})
local OthersPage = OthersTab.page

-- ========================= STATES / VARS / SERVICES =========================

local ProximityPromptService = SimpleUI:getService("ProximityPromptService")
local ReplicatedStorage = SimpleUI:getService("ReplicatedStorage")
local RunService = SimpleUI:getService("RunService")
local Players = SimpleUI:getService("Players")

local Character
local Humanoid
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function BindCharacter(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
end

BindCharacter(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())
LocalPlayer.CharacterAdded:Connect(BindCharacter)

local BrainrotModule = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("BrainrotModule"))
local SlotInfo = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("SlotInfo"))
local CarryInfo = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("CarryModule"))

local Backpack = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("BackpackGui"):WaitForChild("Backpack")
local InventoryGrid = Backpack:WaitForChild("Inventory"):WaitForChild("ScrollingFrame"):WaitForChild("UIGridFrame")
local Hotbar = Backpack:WaitForChild("Hotbar")

local RemoteFunctions = ReplicatedStorage:WaitForChild("RemoteFunctions")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local CollectMoneyRemote = RemoteEvents:WaitForChild("CollectMoney")
local SellAllRemote = RemoteFunctions:WaitForChild("SellAll")
local SellToolRemote = RemoteFunctions:WaitForChild("SellTool")
local UpgradeBrainrotRemote = RemoteFunctions:WaitForChild("UpgradeBrainrot")
local UpgradeBaseRemote = RemoteFunctions:WaitForChild("UpgradeBase")
local UpgradeCarryRemote = RemoteFunctions:WaitForChild("UpgradeCarry")

local AutoClaimMoney
local AutoTakeBrainrots = false
local SelectedRarities = {}
local localSpeed = LocalPlayer and LocalPlayer:GetAttribute("CurrentSpeed") or 50 or 50
local jumpPower = Humanoid.JumpPower or 50
local InventoryConns = {}
local InventoryStyled = {}

local ESP = {
    Player = {
        Models = {},
        Connections = {},
        Enabled = false
    },
    Brainrot = {
        Models = {},
        Connections = {},
        Enabled = false,
        SelectedTiers = {
            All = true
        }
    }
}

local UpgradeConfig = {
    Brainrot = {
        All = false,
        TierEnabled = false,
        Tier = {}
    },
    Stats = {
        CarryStat = false,
        BaseUpgrade = false
    }
}
-- ========================= HELPER FUNCTIONS =========================

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

local function getPlayerBase()
    local bases = workspace:FindFirstChild("Bases")
    if not bases then
        return nil
    end

    local userId = LocalPlayer.UserId

    for _, model in ipairs(bases:GetChildren()) do
        if model:IsA("Model") and model:GetAttribute("Holder") == userId then
            return model
        end
    end

    return nil
end

local function getBaseSlots()
    local base = getPlayerBase()
    if not base then
        return
    end

    local slots = base:FindFirstChild("Slots")
    if not slots then
        return
    end

    local occupiedSlots = {}
    local occupiedSlotNumbers = {}
    local occupiedCount = 0
    local maxSlot = 0

    for _, slot in ipairs(slots:GetChildren()) do
        local n = tonumber(slot.Name:match("%d+"))
        if n and n > maxSlot then
            maxSlot = n
        end

        local tool = slot:FindFirstChildWhichIsA("Tool")
        if tool and tool:FindFirstChild("Handle") then
            occupiedCount = occupiedCount + 1
            occupiedSlots[#occupiedSlots + 1] = slot
            occupiedSlotNumbers[#occupiedSlotNumbers + 1] = n
        end
    end

    return occupiedSlots, occupiedSlotNumbers, occupiedCount, maxSlot
end

local function collectSlotMoney(slot)
    CollectMoneyRemote:FireServer(slot)
end

local function teleportTo(part, isBr)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = part.CFrame + (isBr and Vector3.new(0, 1, 4) or Vector3.new(0, 3, 0))
    end
end

local function unequipTool()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum then
        return
    end

    hum:UnequipTools()

    repeat
        task.wait()
    until not char:FindFirstChildWhichIsA("Tool")
end

local function takeBrainrot(model)
    if not model or not model.Parent then
        return false
    end

    local handle = model:WaitForChild("Handle", 3)
    if not handle or not handle:IsA("BasePart") then
        return false
    end

    local prompt = handle:WaitForChild("TakePrompt", 3)
    if not prompt then
        return false
    end

    local char = workspace:FindFirstChild(LocalPlayer.Name)
    if not char then
        return false
    end

    repeat
        task.wait()
    until prompt.Enabled and
        (char:FindFirstChild("HumanoidRootPart") and (char.HumanoidRootPart.Position - handle.Position).Magnitude <=
            prompt.MaxActivationDistance) and (LocalPlayer.GameplayPaused ~= true)

    repeat
        task.wait(0.500)
        fireproximityprompt(prompt)
    until model.Parent == char or not model.Parent

    return model.Parent == char
end

local function returnToBaseAndDrop(model)
    local base = getPlayerBase()
    if not base then
        warn("No base found")
        return
    end

    local cf = base.PrimaryPart and base.PrimaryPart.CFrame or base:GetPivot()
    teleportTo({
        CFrame = cf
    })

    local char = workspace:FindFirstChild(LocalPlayer.Name)
    if not char then
        return
    end

    repeat
        task.wait()
    until ((model:IsA("Tool") and model.Parent == char) or not model.Parent) and LocalPlayer.GameplayPaused ~= true

    unequipTool()
end

local function getPlayerMoney()
    return LocalPlayer:WaitForChild("leaderstats").Money
end

local function getBrainrotTier(name)
    return BrainrotModule.GetBrainrotClass(name)
end

local function getBrainrotUpgradeCost(slot)
    local costLabel = slot:FindFirstChild("Upgrade") and slot.Upgrade:FindFirstChild("SurfaceGui") and
                          slot.Upgrade.SurfaceGui:FindFirstChild("Frame") and
                          slot.Upgrade.SurfaceGui.Frame:FindFirstChild("Cost")
    if not costLabel then
        return math.huge
    end

    local value, suffix = costLabel.Text:match("%$(%d+%.?%d*)(%a*)")
    value = tonumber(value)
    if not value then
        return math.huge
    end

    local multipliers = {
        K = 1e3,
        M = 1e6,
        B = 1e9,
        T = 1e12,
        Qa = 1e15,
        Qi = 1e18,
        Sx = 1e21,
        Sp = 1e24
    }

    return value * (multipliers[suffix] or 1)
end

local function getUnlockedBaseSlotCount()
    local base = getPlayerBase()
    if not base then
        return 0
    end

    local slots = base:FindFirstChild("Slots")
    if not slots then
        return 0
    end

    local unlocked = 0

    for _, slot in ipairs(slots:GetChildren()) do
        if slot:GetAttribute("Locked") == false then
            unlocked = unlocked + 1
        end
    end

    return math.max(0, unlocked - 10)
end

local function getNextBaseUpgradeCost()
    local unlocked = getUnlockedBaseSlotCount()
    return SlotInfo.Costs[unlocked + 1]
end

local function getCarryLevel()
    return LocalPlayer:GetAttribute("CarryLevel") or 0
end

local function getNextCarryUpgradeCost()
    local level = getCarryLevel()
    return CarryInfo.Costs[level + 1]
end

local tiers = {"All"}
local BrainrotClassNames = {}

for i, name in ipairs(BrainrotModule.ClassNames) do
    BrainrotClassNames[i] = name
    tiers[#tiers + 1] = name
end

-- ========================= COMPONENTS =========================

SimpleUI:createSection(MainPage, "Auto Farm")

--[[
SimpleUI:createDropdown(MainPage, "Select Brainrot Rarity", BrainrotClassNames, nil, function(values)
    table.clear(SelectedRarities)
    for _, name in ipairs(values) do
        SelectedRarities[name] = true
    end
end, {
    MultiSelect = true
})

local AutoTakeToken = 0
SimpleUI:createToggle(MainPage, "Take Brainrots", false, function(state)
    AutoTakeBrainrots = state
    AutoTakeToken = AutoTakeToken + 1

    if not state then
        return
    end

    local myToken = AutoTakeToken

    task.spawn(function()
        while AutoTakeBrainrots and AutoTakeToken == myToken do
            local active = workspace:FindFirstChild("ActiveBrainrots")

            if active then
                local rarityList = {}

                for k, v in pairs(SelectedRarities) do
                    if v == true then
                        rarityList[#rarityList + 1] = k
                    end
                end

                for i = 1, #rarityList do
                    if not AutoTakeBrainrots or AutoTakeToken ~= myToken then
                        break
                    end

                    local className = rarityList[i]
                    local folder = active:FindFirstChild(className)

                    if folder then
                        local models = folder:GetChildren()

                        for j = 1, #models do
                            if not AutoTakeBrainrots or AutoTakeToken ~= myToken then
                                break
                            end

                            local model = models[j]

                            if model:IsA("Model") then
                                local pivot = model:GetPivot()
                                teleportTo({
                                    CFrame = pivot
                                }, true)

                                local success = takeBrainrot(model)
                                if success then
                                    returnToBaseAndDrop(model)
                                end
                            end
                        end
                    end
                end
            else
                task.wait(1)
            end

            task.wait(0.5)
        end
    end)
end)
]]

LoopFramework:registerTask("AutoClaimMoney", 120, function()
    if not AutoClaimMoney then
        return
    end

    local _, occupiedSlotsNumbers = getBaseSlots()
    if not occupiedSlotsNumbers then
        return
    end

    local count = 0
    for _, num in ipairs(occupiedSlotsNumbers) do
        if not AutoClaimMoney then
            break
        end
        collectSlotMoney("Slot" .. num)
        count = count + 1
        if count >= 5 then
            task.wait(1)
            count = 0
        end
    end
end)
SimpleUI:createToggle(MainPage, "Auto Collect Money", false, function(state)
    AutoClaimMoney = state
    LoopFramework:setTaskEnabled("AutoClaimMoney", state)
end, {
    Description = "Claim money from all the slots every 2 minutes"
})

SimpleUI:createSection(MainPage, "Auto Sell")

SimpleUI:createButton(MainPage, "Sell Inventory", function()
    SellAllRemote:InvokeServer()
end, {
    Description = "Sells EVERYTHING in your inventory"
})

SimpleUI:createButton(MainPage, "Sell Current Brainrot", function()
    SellToolRemote:InvokeServer()
end, {
    Description = "Sells the brainrot you're currently holding"
})

SimpleUI:createSection(UpgradesPage, "Brainrots Upgrades")

LoopFramework:registerTask("AutoUpgradeBrainrots", 1, function()
    if not (UpgradeConfig.Brainrot.All or UpgradeConfig.Brainrot.TierEnabled) then
        return
    end

    local slots = getBaseSlots()
    if not slots then
        return
    end

    local money = getPlayerMoney()

    for _, slot in ipairs(slots) do
        local tool = slot:FindFirstChildWhichIsA("Tool")
        if tool and tool:FindFirstChild("Handle") then
            local tier = getBrainrotTier(tool.Name)

            local allowed = UpgradeConfig.Brainrot.All or
                                (UpgradeConfig.Brainrot.TierEnabled and table.find(UpgradeConfig.Brainrot.Tier, tier))

            if allowed then
                local cost = getBrainrotUpgradeCost(slot)
                if money >= cost then
                    task.wait(0.25)
                    UpgradeBrainrotRemote:InvokeServer(slot.Name)
                    money = money - cost
                end
            end
        end
    end
end, 1)
SimpleUI:createToggle(UpgradesPage, "Upgrade all brainrots", false, function(state)
    UpgradeConfig.Brainrot.All = state
    LoopFramework:setTaskEnabled("AutoUpgradeBrainrots",
        UpgradeConfig.Brainrot.All or UpgradeConfig.Brainrot.TierEnabled)
end, {
    Description = "Automatically upgrades every brainrot you own."
})

SimpleUI:createDropdown(UpgradesPage, "Select tier(s)", BrainrotModule.ClassNames, {}, function(selected)
    UpgradeConfig.Brainrot.Tier = selected
end, {
    MultiSelect = true
})

SimpleUI:createToggle(UpgradesPage, "Upgrade selected tiers", false, function(state)
    UpgradeConfig.Brainrot.TierEnabled = state
    LoopFramework:setTaskEnabled("AutoUpgradeBrainrots",
        UpgradeConfig.Brainrot.All or UpgradeConfig.Brainrot.TierEnabled)
end, {
    Description = "Only upgrades brainrots from the tiers you select below."
})

SimpleUI:createSection(UpgradesPage, "Stats Upgrades")

LoopFramework:registerTask("AutoUpgradeStats", 5, function()
    if not (UpgradeConfig.Stats.BaseUpgrade or UpgradeConfig.Stats.CarryStat) then
        return
    end

    local money = getPlayerMoney().Value

    if UpgradeConfig.Stats.BaseUpgrade then
        local cost = getNextBaseUpgradeCost()
        if cost and money > cost then
            UpgradeBaseRemote:InvokeServer()
        end
    end

    if UpgradeConfig.Stats.CarryStat then
        local cost = getNextCarryUpgradeCost()
        if cost and money > cost then
            UpgradeCarryRemote:InvokeServer()
        end
    end
end, 2)

SimpleUI:createToggle(UpgradesPage, "Upgrade Base Slots", false, function(state)
    UpgradeConfig.Stats.BaseUpgrade = state
    LoopFramework:setTaskEnabled("AutoUpgradeStats", UpgradeConfig.Stats.BaseUpgrade or UpgradeConfig.Stats.CarryStat)
end)

SimpleUI:createToggle(UpgradesPage, "Upgrade Carry Slot", false, function(state)
    UpgradeConfig.Stats.CarryStat = state
    LoopFramework:setTaskEnabled("AutoUpgradeStats", UpgradeConfig.Stats.BaseUpgrade or UpgradeConfig.Stats.CarryStat)
end)

--[[
SimpleUI:createSection(MiscellaneousPage, "Tsunami")

local tsunamiConn
SimpleUI:createToggle(MiscellaneousPage, "Remove Tsunami", false, function(state)
    if state then
        local folder = workspace:FindFirstChild("ActiveTsunamis")
        if not folder then
            return
        end

        for _, v in folder:GetChildren() do
            if v:IsA("Model") then
                v:Destroy()
            end
        end

        tsunamiConn = folder.ChildAdded:Connect(function(child)
            if child:IsA("Model") then
                child:Destroy()
            end
        end)
    else
        if tsunamiConn then
            tsunamiConn:Disconnect()
            tsunamiConn = nil
        end
    end
end)

local neutralizeConn
SimpleUI:createToggle(MiscellaneousPage, "Neutralize Tsunami", true, function(state)
    local folder = workspace:FindFirstChild("ActiveTsunamis")
    if not folder then
        return
    end

    if state then
        for _, ti in ipairs(folder:GetDescendants()) do
            if ti:IsA("TouchTransmitter") or ti.Name == "TouchInterest" then
                ti:Destroy()
            end
        end

        neutralizeConn = folder.DescendantAdded:Connect(function(desc)
            if desc:IsA("TouchTransmitter") or desc.Name == "TouchInterest" then
                desc:Destroy()
            end
        end)
    else
        if neutralizeConn then
            neutralizeConn:Disconnect()
            neutralizeConn = nil
        end
    end
end, {
    Description = "Neutralizes tsunamis from dealing damage instead of deleting it"
})
]]

SimpleUI:createSection(MiscellaneousPage, "Interaction")

local instantPPConn
SimpleUI:createToggle(MiscellaneousPage, "Instant Proximity Prompts", true, function(state)
    if state then
        if not fireproximityprompt then
            return
        end

        if instantPPConn then
            instantPPConn:Disconnect()
        end

        instantPPConn = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
            local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ProximityPrompts")
            if gui then
                local actionText = gui:FindFirstChild("Prompt") and gui.Prompt:FindFirstChild("Frame") and
                                       gui.Prompt.Frame:FindFirstChild("TextFrame") and
                                       gui.Prompt.Frame.TextFrame:FindFirstChild("ActionText")

                if actionText and actionText.Text == "Gift" then
                    return
                end
            end

            fireproximityprompt(prompt)
        end)
    else
        if instantPPConn then
            instantPPConn:Disconnect()
            instantPPConn = nil
        end
    end
end, {
    Description = "Automatically completes proximity prompts except those labeled 'Gift'"
})

--[[
local vipConn
SimpleUI:createToggle(MiscellaneousPage, "Enable VIP walls", true, function(state)
    local folder = workspace:FindFirstChild("VIPWalls")
    if not folder then
        return
    end

    if state then
        for _, obj in folder:GetDescendants() do
            if obj:IsA("BasePart") then
                obj.CanCollide = false
                local ti = obj:FindFirstChildOfClass("TouchTransmitter")
                if ti then
                    ti:Destroy()
                end
            end
        end

        vipConn = folder.DescendantAdded:Connect(function(obj)
            if obj:IsA("BasePart") then
                obj.CanCollide = false
                local ti = obj:FindFirstChildOfClass("TouchTransmitter")
                if ti then
                    ti:Destroy()
                end
            end
        end)
    else
        if vipConn then
            vipConn:Disconnect()
            vipConn = nil
        end
    end
end)
]]
SimpleUI:createSection(OthersPage, "UI")

SimpleUI:createToggle(OthersPage, "Improve Backpack", true, function(state)
    for _, c in pairs(InventoryConns) do
        c:Disconnect()
    end
    InventoryConns = {}

    for btn, data in pairs(InventoryStyled) do
        if data.Stroke then
            data.Stroke:Destroy()
        end
        if data.Gradient then
            data.Gradient:Destroy()
        end
        if data.OriginalText and btn:FindFirstChild("ToolName") then
            btn.ToolName.Text = data.OriginalText
            btn.ToolName.RichText = false
        end
        InventoryStyled[btn] = nil
    end

    if not state then
        return
    end

    local function apply(btn)
        if InventoryStyled[btn] then
            return
        end

        local toolNameObj = btn:FindFirstChild("ToolName")
        if not toolNameObj or toolNameObj.Text == "" then
            return
        end

        local original = toolNameObj.Text
        local class = BrainrotModule.GetBrainrotClass(original)
        if not class then
            return
        end

        local color = BrainrotModule.ClassColours[class] or Color3.new(1, 1, 1)
        local hex = color:ToHex()

        toolNameObj.RichText = true
        toolNameObj.TextWrapped = true
        toolNameObj.TextYAlignment = Enum.TextYAlignment.Center
        toolNameObj.Text = "<font size=\"12\" color=\"#" .. hex .. "\">[" .. class:upper() .. "]</font>\n" ..
                               "<font size=\"16\">" .. original .. "</font>"

        local gradient = Instance.new("UIGradient")
        gradient.Rotation = 45
        gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, color),
                                            ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
                                            ColorSequenceKeypoint.new(1, color)})
        gradient.Parent = toolNameObj

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1
        stroke.Color = color
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = btn

        if not btn:FindFirstChildOfClass("UICorner") then
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = btn
        end

        InventoryStyled[btn] = {
            Stroke = stroke,
            Gradient = gradient,
            OriginalText = original
        }
    end

    local function hook(container)
        for _, child in ipairs(container:GetChildren()) do
            if child:IsA("ImageButton") or child:IsA("TextButton") then
                apply(child)
            end
        end

        InventoryConns[container] = container.ChildAdded:Connect(function(child)
            if child:IsA("ImageButton") or child:IsA("TextButton") then
                task.defer(apply, child)
            end
        end)

        InventoryConns[container.Name .. "_Removed"] = container.ChildRemoved:Connect(function(child)
            local data = InventoryStyled[child]
            if not data then
                return
            end
            if data.Stroke then
                data.Stroke:Destroy()
            end
            if data.Gradient then
                data.Gradient:Destroy()
            end
            if data.OriginalText and child:FindFirstChild("ToolName") then
                child.ToolName.Text = data.OriginalText
                child.ToolName.RichText = false
            end
            InventoryStyled[child] = nil
        end)
    end

    hook(InventoryGrid)
    hook(Hotbar)
end, {
    Description = "Adds thin rarity borders and displays item tier above the name"
})

SimpleUI:createSection(OthersPage, "Support")

SimpleUI:createButton(OthersPage, "Copy discord link", function()
    setclipboard("https://discord.gg/5BUTb4vYm3")
end)

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

SimpleUI:createSection(PlayerPage, "ESP")

SimpleUI:createToggle(PlayerPage, "PlayerESP", false, function(state)
    local P = ESP.Player
    P.Models = P.Models or {}
    P.Connections = P.Connections or {}

    local function attachCharacter(char, name)
        if P.Models[char] then
            return
        end
        local hrp = char:WaitForChild("HumanoidRootPart", 3)
        if not hrp then
            return
        end
        local bb = createBillboard(hrp, name, Color3.new(1, 1, 1))
        P.Models[char] = bb
    end

    local function cleanupCharacter(char)
        local bb = P.Models[char]
        if bb then
            bb:Destroy()
            P.Models[char] = nil
        end
    end

    local function hookPlayer(plr)
        if plr == LocalPlayer then
            return
        end

        if plr.Character then
            attachCharacter(plr.Character, plr.Name)
        end

        P.Connections["Added_" .. plr.UserId] = plr.CharacterAdded:Connect(function(char)
            attachCharacter(char, plr.Name)
        end)

        P.Connections["Removing_" .. plr.UserId] = plr.CharacterRemoving:Connect(cleanupCharacter)
    end

    local function unhookPlayer(plr)
        local a = P.Connections["Added_" .. plr.UserId]
        local r = P.Connections["Removing_" .. plr.UserId]
        if a then
            a:Disconnect()
            P.Connections["Added_" .. plr.UserId] = nil
        end
        if r then
            r:Disconnect()
            P.Connections["Removing_" .. plr.UserId] = nil
        end
        if plr.Character then
            cleanupCharacter(plr.Character)
        end
    end

    if state then
        for _, plr in ipairs(Players:GetPlayers()) do
            hookPlayer(plr)
        end

        P.Connections.PlayerAdded = Players.PlayerAdded:Connect(hookPlayer)
        P.Connections.PlayerRemoving = Players.PlayerRemoving:Connect(unhookPlayer)
    else
        for _, c in pairs(P.Connections) do
            if typeof(c) == "RBXScriptConnection" then
                c:Disconnect()
            end
        end

        for _, bb in pairs(P.Models) do
            if bb then
                bb:Destroy()
            end
        end

        P.Models = {}
        P.Connections = {}
    end
end)

local dropdown = SimpleUI:createDropdown(PlayerPage, "Brainrot Tier", tiers, {"All"}, function(values)
    ESP.Brainrot.SelectedTiers = {}
    for _, v in ipairs(values) do
        ESP.Brainrot.SelectedTiers[v] = true
    end
end, {
    Description = "Select brainrot tiers to highlight",
    MultiSelect = true
})

SimpleUI:createToggle(PlayerPage, "BrainrotESP", false, function(state)
    local B = ESP.Brainrot
    B.Enabled = state

    for _, hl in pairs(B.Models) do
        if hl then
            hl:Destroy()
        end
    end
    for _, c in pairs(B.Connections) do
        if typeof(c) == "RBXScriptConnection" then
            c:Disconnect()
        end
    end
    B.Models = {}
    B.Connections = {}

    if not state then
        return
    end

    local ActiveBrainrots = workspace:WaitForChild("ActiveBrainrots")

    local function allowed(tier)
        if B.SelectedTiers["All"] then
            return true
        end
        return B.SelectedTiers[tier] == true
    end

    local function attach(model, tier)
        if B.Models[model] then
            return
        end
        if not allowed(tier) then
            return
        end

        local hl = Instance.new("Highlight")
        hl.Adornee = model
        hl.FillColor = BrainrotModule.ClassColours[tier] or Color3.new(1, 1, 1)
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 0.7
        hl.OutlineColor = Color3.new(1, 1, 1)
        hl.Parent = model
        B.Models[model] = hl
    end

    local function cleanup(model)
        local hl = B.Models[model]
        if hl then
            hl:Destroy()
            B.Models[model] = nil
        end
    end

    local function refreshHighlights()
        for model, hl in pairs(B.Models) do
            local tier = model.Parent and model.Parent.Name
            if not allowed(tier) then
                cleanup(model)
            end
        end
        for _, tierFolder in ipairs(ActiveBrainrots:GetChildren()) do
            for _, model in ipairs(tierFolder:GetChildren()) do
                attach(model, tierFolder.Name)
            end
        end
    end

    for _, tierFolder in ipairs(ActiveBrainrots:GetChildren()) do
        for _, model in ipairs(tierFolder:GetChildren()) do
            attach(model, tierFolder.Name)
        end

        B.Connections[tierFolder] = tierFolder.ChildAdded:Connect(function(model)
            attach(model, tierFolder.Name)
        end)

        B.Connections[tierFolder.Name .. "_Removed"] = tierFolder.ChildRemoved:Connect(cleanup)
    end

    B.Connections.ActiveBrainrotsAdded = ActiveBrainrots.ChildAdded:Connect(function(tierFolder)
        for _, model in ipairs(tierFolder:GetChildren()) do
            attach(model, tierFolder.Name)
        end
        B.Connections[tierFolder] = tierFolder.ChildAdded:Connect(function(model)
            attach(model, tierFolder.Name)
        end)
        B.Connections[tierFolder.Name .. "_Removed"] = tierFolder.ChildRemoved:Connect(cleanup)
    end)

    B.Connections.ActiveBrainrotsRemoved = ActiveBrainrots.ChildRemoved:Connect(function(tierFolder)
        for _, model in ipairs(tierFolder:GetChildren()) do
            cleanup(model)
        end
        if B.Connections[tierFolder] then
            B.Connections[tierFolder]:Disconnect()
            B.Connections[tierFolder] = nil
        end
        local r = B.Connections[tierFolder.Name .. "_Removed"]
        if r then
            r:Disconnect()
            B.Connections[tierFolder.Name .. "_Removed"] = nil
        end
    end)

    dropdown.Changed:Connect(refreshHighlights)
end)

SimpleUI:createSection(PlayerPage, "Humanoid")

SimpleUI:createSlider(PlayerPage, "WalkSpeed", 10, 2000, localSpeed, function(value)
    if LocalPlayer then
        LocalPlayer:SetAttribute("CurrentSpeed", value)
    end
end)

SimpleUI:createSlider(PlayerPage, "Jump Power", 1, 500, jumpPower, function(val)
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
