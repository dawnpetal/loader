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
    local theme = options.Theme or self.Themes.Monokai
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
    mainContainer.Active = true

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

    gui.DisplayOrder = 0 

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
                if callback then
                    local selected = {}
                    for v, enabled in pairs(selectedValues) do
                        if enabled then
                            table.insert(selected, optionDataMap[v])
                        end
                    end
                    callback(selected)
                end
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
        close = closeDropdown
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
    Name = "SimpleUI",
    TitleLabel = {
        Properties = {
            Text = "Prospecting!"
        }
    },
    Subtitle = "by SimpleScripts"
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
    collect:InvokeServer(1)
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
                createNotification("Distance is too long, try again while being closer to the target", 10)
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
            createNotification(messages.general.noPan)
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
            createNotification(messages.general.noScript)
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
                -- createNotification(msgs.success)
                break
            end
            if not isInValidRegion("Deposit") then
                -- createNotification(msgs.leftRegion)
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
                createNotification(messages.general.legitWIP, 3)
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
        createNotification(messages.general.invalidAction)
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
    HumanoidRootPart.CFrame = CFrame.new(Map.EventStuff["The Void"].Model.ExitPortal.CFrame.Position +
                                             Vector3.new(0, 3, 0))
    local maxWait = tick() + 7
    repeat
        task.wait(0.1)
    until (LocalPlayer:GetAttribute("CurrentArea") == "Fortune River" and LocalPlayer:GetAttribute("GameplayPaused") ==
        false) or tick() > maxWait
    if LocalPlayer:GetAttribute("CurrentArea") ~= "Fortune River" then
        createNotification("Failed to exit The Void properly.", 5)
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
        createNotification("No merchant found after exiting void.", 5)
        HumanoidRootPart.CFrame = CFrame.new(Map.EventStuff.VoidPortal.Part.CFrame.Position + Vector3.new(0, 3, 0))
        return false
    end
    createNotification("Found merchant, teleporting and selling...", 5)
    local sellSuccess = teleportToTarget(closestHrp.Position, {
        Mode = "Critical",
        FireRemoteFunc = function()
            createNotification("Selling all valuables...", 3)
            return SimpleUI:getService("ReplicatedStorage").Remotes.Shop.SellAll:InvokeServer()
        end,
        Timeout = 90
    })
    if sellSuccess then
        local success
        task.wait(3)
        createNotification("Returning to The Void...", 5)
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
        createNotification("No merchant found nearby.", 5)
        return false
    end

    applyDefaults(config, mode)

    if mode == "Tween" then
        local completed = false
        local successSell = false
        config.OnStart = function()
            createNotification("Tweening to merchant...", 5)
        end
        config.OnComplete = function()
            task.wait(1)
            local _, finalDistance = getClosestMerchant()
            if finalDistance and finalDistance <= requiredDistance then
                executeSell()
                successSell = true
            else
                createNotification("Could not reach merchant via tween.", 5)
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
        createNotification("Please select a " .. itemType .. " first!", 5)
        return
    end
    local name, rest = selectedOption:match("^(.-)%s*[%-%–—]%s*(.+)$")
    if not name or not rest then
        createNotification("Error: Invalid item format!", 5)
        return
    end
    local currency, value = rest:match("^([^0-9]+)([%d%.%a]+)$")
    if not currency or not value then
        createNotification("Error: Invalid item format!", 5)
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
                createNotification("Triggered purchase for " .. name .. " for " .. price .. "!", 5)
                remote:InvokeServer(shopItem)
            else
                createNotification("Error: Could not find item or ShopItem!", 5)
            end
        end,
        onCancel = function()
            createNotification("Purchase cancelled", 5)
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

--[[
local WebhookTab = SimpleUI:createTab(window, "Webhook", {
    Icon = {
        Image = "rbxassetid://16898613869",
        Size = UDim2.new(0, 16, 0, 16),
        ImageRectSize = Vector2.new(48, 48),
        ImageRectOffset = Vector2.new(967, 196),
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
})
local WebhookPage = WebhookTab.page

local SettingsTab = SimpleUI:createTab(window, "Settings", {
    Icon = {
        Image = "rbxassetid://10734950309",
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }
})
local SettingsPage = SettingsTab.page
]]

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
        createNotification("✅ Sand location set")
    else
        createNotification("❌ Must be at dig location")
    end
end, {
    Description = "Stand where you want to dig and then press this button to save the location."
})

SimpleUI:createButton(MainPage, "Set Wash location", function()
    if getRegion(HumanoidRootPart) == "Water" then
        AutoFarmState.waterCFrame = HumanoidRootPart.CFrame
        createNotification("✅ Wash location set")
    else
        createNotification("❌ Must be at wash location")
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

SimpleUI:createButton(ShopPage, "Open amazong", function ()
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

SimpleUI:createSlider(OthersPage, "UI Scale", 0.5, 2, 1, function(value)
    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then
        return
    end

    local boostsUI = playerGui:FindFirstChild("MainUI") and playerGui.MainUI:FindFirstChild("Boosts")
    local bottomRight = playerGui:FindFirstChild("MainUI") and playerGui.MainUI:FindFirstChild("BottomRight")

    if boostsUI then
        local uiScale = boostsUI:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
        uiScale.Parent = boostsUI
        SimpleUI:getService("TweenService"):Create(uiScale,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = value
            }):Play()
    end

    if bottomRight then
        local uiScaleBR = bottomRight:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
        uiScaleBR.Parent = bottomRight
        SimpleUI:getService("TweenService"):Create(uiScaleBR,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = value
            }):Play()
    end
end, {
    Increment = 0.001
})
