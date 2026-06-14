--game/ServerScripts/GP/ProgrammerPanel.luau
local gethui = gethui or function()
    return game:GetService("CoreGui")
end
local protectgui = protectgui or function()
end
local cloneref = cloneref or clonereference or function(instance)
    return instance
end
local newcclosure = newcclosure or function(func)
    return func
end
local getcustomasset = getcustomasset or function(path)
    return ""
end

local SimpleUI = {}

SimpleUI.Version = "2.2.7"
SimpleUI.Loaded = SimpleUI.Loaded or {}
SimpleUI.Windows = SimpleUI.Windows or {}

local CoreGui = cloneref(game:GetService("CoreGui"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local TweenService = cloneref(game:GetService("TweenService"))
local Lighting = cloneref(game:GetService("Lighting"))
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))

local LocalPlayer = Players.LocalPlayer

SimpleUI.Constants = {
    Window = {
        MinSize = Vector2.new(600, 400),
        MaxSize = Vector2.new(1400, 900),
        DefaultAspectRatio = 1.6,
        TopBarHeight = 48,
        FooterHeight = 24,
        TabsWidthOpen = 0.22,
        ContentWidthOpen = 0.78,
        TabsWidthClosed = 55,
        ContentLeftOffsetClosed = 60,
        ContentWidthScaleClosed = 1,
        HorizontalPadding = 10,
        VerticalPadding = 10,
        DefaultScale = 0.75,
        MinScale = 0.5,
        MaxScale = 2,
        TabModes = {
            Fixed = "Fixed",
            Dynamic = "Dynamic",
            Closed = "Closed"
        },
        ResizeModes = {
            BottomRight = "BottomRight",
            Center = "Center"
        },
        TabDynamicThreshold = 2,
        TabIconSizeExpanded = 20,
        TabIconSizeCollapsed = 28,
        ClosedTabHorizontalPadding = 1,
        TabSeparatorGap = 1
    },
    Padding = {
        Small = 4,
        Medium = 8,
        Large = 10,
        ExtraLarge = 12
    },
    Spacing = {
        Tight = 2,
        Normal = 4,
        Relaxed = 6,
        Loose = 8
    },
    Corner = {
        None = 0,
        Small = 3,
        Medium = 4,
        Large = 6,
        HolyFuckingShit = 12,
        Round = 1
    },
    Animation = {
        Fast = 0.15,
        Normal = 0.2,
        Slow = 0.35,
        VerySlow = 0.4,
        Smooth = 0.25
    },
    ZIndex = {
        Background = 1,
        Base = 2,
        Content = 3,
        Control = 4,
        Overlay = 5,
        Modal = 250,
        Notification = 999
    }
}

SimpleUI.WindowControls = {
    MacOS = {
        ButtonSize = UDim2.new(0, 12, 0, 12),
        ButtonSpacing = 8,
        UseImages = false,
        Alignment = "Left",
        Colors = {
            Close = Color3.fromRGB(255, 95, 86),
            Maximize = Color3.fromRGB(40, 201, 64)
        }
    },
    Windows = {
        ButtonSize = UDim2.new(0, 32, 1, 0),
        ButtonSpacing = 0,
        UseImages = true,
        Alignment = "Right",
        Transparency = 1,
        Icons = {
            Maximize = {
                Image = "rbxassetid://9886659001",
                ColorKey = "TextPrimary",
                Size = UDim2.new(0, 16, 0, 16),
                HoverColor = Color3.fromRGB(60, 60, 60),
                PressedColor = Color3.fromRGB(80, 80, 80)
            },
            Close = {
                Image = "rbxassetid://10747384394",
                ColorKey = "TextPrimary",
                Size = UDim2.new(0, 16, 0, 16),
                HoverColor = Color3.fromRGB(232, 17, 35),
                PressedColor = Color3.fromRGB(180, 10, 25)
            }
        }
    }
}

SimpleUI.Themes = {
    Obsidian = {
        Primary = Color3.fromRGB(14, 15, 18),
        Secondary = Color3.fromRGB(24, 25, 30),
        SecondaryHover = Color3.fromRGB(34, 36, 42),
        SecondaryActive = Color3.fromRGB(48, 50, 58),
        SecondaryPressed = Color3.fromRGB(20, 21, 26),
        Tertiary = Color3.fromRGB(30, 32, 38),
        TertiaryHover = Color3.fromRGB(42, 44, 52),
        TertiaryActive = Color3.fromRGB(56, 58, 68),
        TertiaryPressed = Color3.fromRGB(26, 28, 34),
        Quaternary = Color3.fromRGB(18, 19, 24),
        QuaternaryHover = Color3.fromRGB(28, 29, 36),
        Separator = Color3.fromRGB(48, 50, 58),
        SeparatorTransparency = 0.15,
        BoxBackground = Color3.fromRGB(12, 13, 16),
        TextPrimary = Color3.fromRGB(240, 241, 245),
        TextSecondary = Color3.fromRGB(170, 173, 180),
        TextInactive = Color3.fromRGB(115, 117, 125),
        TextActive = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(168, 85, 247),
        TabAccent = Color3.fromRGB(192, 132, 252),
        TabIconActive = Color3.fromRGB(192, 132, 252),
        TabIconHover = Color3.fromRGB(220, 220, 230),
        TabIconInactive = Color3.fromRGB(115, 117, 125),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.02,
        TransparencySecondary = 0.75,
        TransparencyTertiary = 0.45
    },

    CatppuccinMocha = {
        Primary = Color3.fromRGB(30, 30, 46),
        Secondary = Color3.fromRGB(49, 50, 68),
        SecondaryHover = Color3.fromRGB(69, 71, 90),
        SecondaryActive = Color3.fromRGB(88, 91, 112),
        SecondaryPressed = Color3.fromRGB(40, 41, 58),
        Tertiary = Color3.fromRGB(59, 61, 81),
        TertiaryHover = Color3.fromRGB(79, 82, 107),
        TertiaryActive = Color3.fromRGB(98, 102, 133),
        TertiaryPressed = Color3.fromRGB(50, 52, 71),
        Quaternary = Color3.fromRGB(36, 37, 52),
        QuaternaryHover = Color3.fromRGB(54, 56, 76),
        Separator = Color3.fromRGB(88, 91, 112),
        SeparatorTransparency = 0.25,
        BoxBackground = Color3.fromRGB(28, 28, 44),
        TextPrimary = Color3.fromRGB(205, 214, 244),
        TextSecondary = Color3.fromRGB(166, 173, 200),
        TextInactive = Color3.fromRGB(127, 132, 156),
        TextActive = Color3.fromRGB(220, 228, 255),
        Accent = Color3.fromRGB(203, 166, 247),
        TabAccent = Color3.fromRGB(221, 189, 252),
        TabIconActive = Color3.fromRGB(221, 189, 252),
        TabIconHover = Color3.fromRGB(186, 194, 222),
        TabIconInactive = Color3.fromRGB(127, 132, 156),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.01,
        TransparencySecondary = 0.70,
        TransparencyTertiary = 0.45
    },

    TokyoNight = {
        Primary = Color3.fromRGB(26, 27, 38),
        Secondary = Color3.fromRGB(41, 46, 66),
        SecondaryHover = Color3.fromRGB(58, 64, 90),
        SecondaryActive = Color3.fromRGB(73, 81, 118),
        SecondaryPressed = Color3.fromRGB(35, 39, 56),
        Tertiary = Color3.fromRGB(52, 57, 79),
        TertiaryHover = Color3.fromRGB(70, 77, 111),
        TertiaryActive = Color3.fromRGB(86, 94, 140),
        TertiaryPressed = Color3.fromRGB(44, 48, 67),
        Quaternary = Color3.fromRGB(32, 36, 54),
        QuaternaryHover = Color3.fromRGB(48, 54, 78),
        Separator = Color3.fromRGB(73, 81, 118),
        SeparatorTransparency = 0.30,
        BoxBackground = Color3.fromRGB(24, 25, 36),
        TextPrimary = Color3.fromRGB(192, 202, 245),
        TextSecondary = Color3.fromRGB(158, 168, 218),
        TextInactive = Color3.fromRGB(115, 122, 168),
        TextActive = Color3.fromRGB(207, 216, 255),
        Accent = Color3.fromRGB(125, 207, 255),
        TabAccent = Color3.fromRGB(158, 219, 255),
        TabIconActive = Color3.fromRGB(158, 219, 255),
        TabIconHover = Color3.fromRGB(167, 177, 211),
        TabIconInactive = Color3.fromRGB(115, 122, 168),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.01,
        TransparencySecondary = 0.73,
        TransparencyTertiary = 0.45
    },

    Ember = {
        Primary = Color3.fromRGB(16, 10, 8),
        Secondary = Color3.fromRGB(28, 18, 14),
        SecondaryHover = Color3.fromRGB(40, 26, 20),
        SecondaryActive = Color3.fromRGB(56, 36, 28),
        SecondaryPressed = Color3.fromRGB(22, 14, 11),
        Tertiary = Color3.fromRGB(36, 23, 18),
        TertiaryHover = Color3.fromRGB(50, 33, 26),
        TertiaryActive = Color3.fromRGB(66, 44, 34),
        TertiaryPressed = Color3.fromRGB(30, 19, 15),
        Quaternary = Color3.fromRGB(20, 13, 10),
        QuaternaryHover = Color3.fromRGB(32, 21, 16),
        Separator = Color3.fromRGB(72, 48, 36),
        SeparatorTransparency = 0.20,
        BoxBackground = Color3.fromRGB(12, 8, 6),
        TextPrimary = Color3.fromRGB(245, 232, 220),
        TextSecondary = Color3.fromRGB(195, 168, 148),
        TextInactive = Color3.fromRGB(130, 105, 88),
        TextActive = Color3.fromRGB(255, 248, 240),
        Accent = Color3.fromRGB(255, 140, 60),
        TabAccent = Color3.fromRGB(255, 170, 100),
        TabIconActive = Color3.fromRGB(255, 170, 100),
        TabIconHover = Color3.fromRGB(220, 190, 165),
        TabIconInactive = Color3.fromRGB(130, 105, 88),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.02,
        TransparencySecondary = 0.72,
        TransparencyTertiary = 0.45
    },

    Slate = {
        Primary = Color3.fromRGB(15, 20, 25),
        Secondary = Color3.fromRGB(24, 32, 40),
        SecondaryHover = Color3.fromRGB(34, 44, 55),
        SecondaryActive = Color3.fromRGB(46, 60, 74),
        SecondaryPressed = Color3.fromRGB(19, 26, 33),
        Tertiary = Color3.fromRGB(30, 40, 50),
        TertiaryHover = Color3.fromRGB(42, 55, 68),
        TertiaryActive = Color3.fromRGB(56, 72, 88),
        TertiaryPressed = Color3.fromRGB(25, 33, 42),
        Quaternary = Color3.fromRGB(18, 24, 30),
        QuaternaryHover = Color3.fromRGB(28, 37, 46),
        Separator = Color3.fromRGB(52, 68, 84),
        SeparatorTransparency = 0.22,
        BoxBackground = Color3.fromRGB(11, 15, 19),
        TextPrimary = Color3.fromRGB(220, 232, 242),
        TextSecondary = Color3.fromRGB(158, 176, 194),
        TextInactive = Color3.fromRGB(100, 118, 136),
        TextActive = Color3.fromRGB(240, 248, 255),
        Accent = Color3.fromRGB(56, 189, 248),
        TabAccent = Color3.fromRGB(103, 210, 255),
        TabIconActive = Color3.fromRGB(103, 210, 255),
        TabIconHover = Color3.fromRGB(170, 200, 224),
        TabIconInactive = Color3.fromRGB(100, 118, 136),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.02,
        TransparencySecondary = 0.74,
        TransparencyTertiary = 0.46
    },

    Rosewood = {
        Primary = Color3.fromRGB(16, 9, 12),
        Secondary = Color3.fromRGB(28, 16, 22),
        SecondaryHover = Color3.fromRGB(40, 23, 32),
        SecondaryActive = Color3.fromRGB(55, 32, 44),
        SecondaryPressed = Color3.fromRGB(22, 13, 18),
        Tertiary = Color3.fromRGB(36, 21, 29),
        TertiaryHover = Color3.fromRGB(50, 30, 42),
        TertiaryActive = Color3.fromRGB(66, 40, 56),
        TertiaryPressed = Color3.fromRGB(30, 17, 24),
        Quaternary = Color3.fromRGB(19, 11, 15),
        QuaternaryHover = Color3.fromRGB(32, 19, 26),
        Separator = Color3.fromRGB(70, 42, 58),
        SeparatorTransparency = 0.20,
        BoxBackground = Color3.fromRGB(12, 7, 10),
        TextPrimary = Color3.fromRGB(246, 230, 236),
        TextSecondary = Color3.fromRGB(198, 168, 180),
        TextInactive = Color3.fromRGB(134, 106, 118),
        TextActive = Color3.fromRGB(255, 244, 248),
        Accent = Color3.fromRGB(251, 113, 133),
        TabAccent = Color3.fromRGB(255, 150, 168),
        TabIconActive = Color3.fromRGB(255, 150, 168),
        TabIconHover = Color3.fromRGB(220, 185, 198),
        TabIconInactive = Color3.fromRGB(134, 106, 118),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.02,
        TransparencySecondary = 0.72,
        TransparencyTertiary = 0.45
    },

    Forest = {
        Primary = Color3.fromRGB(10, 15, 12),
        Secondary = Color3.fromRGB(18, 27, 22),
        SecondaryHover = Color3.fromRGB(26, 39, 32),
        SecondaryActive = Color3.fromRGB(36, 54, 44),
        SecondaryPressed = Color3.fromRGB(14, 21, 17),
        Tertiary = Color3.fromRGB(23, 35, 28),
        TertiaryHover = Color3.fromRGB(33, 50, 40),
        TertiaryActive = Color3.fromRGB(44, 66, 54),
        TertiaryPressed = Color3.fromRGB(18, 28, 23),
        Quaternary = Color3.fromRGB(12, 18, 15),
        QuaternaryHover = Color3.fromRGB(22, 33, 27),
        Separator = Color3.fromRGB(44, 66, 54),
        SeparatorTransparency = 0.22,
        BoxBackground = Color3.fromRGB(8, 12, 10),
        TextPrimary = Color3.fromRGB(220, 240, 228),
        TextSecondary = Color3.fromRGB(158, 192, 170),
        TextInactive = Color3.fromRGB(98, 130, 112),
        TextActive = Color3.fromRGB(240, 255, 245),
        Accent = Color3.fromRGB(110, 231, 183),
        TabAccent = Color3.fromRGB(150, 246, 205),
        TabIconActive = Color3.fromRGB(150, 246, 205),
        TabIconHover = Color3.fromRGB(170, 210, 188),
        TabIconInactive = Color3.fromRGB(98, 130, 112),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.02,
        TransparencySecondary = 0.74,
        TransparencyTertiary = 0.46
    },

    Abyss = {
        Primary = Color3.fromRGB(5, 5, 10),
        Secondary = Color3.fromRGB(10, 10, 20),
        SecondaryHover = Color3.fromRGB(16, 16, 32),
        SecondaryActive = Color3.fromRGB(24, 24, 46),
        SecondaryPressed = Color3.fromRGB(8, 8, 16),
        Tertiary = Color3.fromRGB(14, 14, 28),
        TertiaryHover = Color3.fromRGB(22, 22, 44),
        TertiaryActive = Color3.fromRGB(32, 32, 60),
        TertiaryPressed = Color3.fromRGB(11, 11, 22),
        Quaternary = Color3.fromRGB(7, 7, 13),
        QuaternaryHover = Color3.fromRGB(14, 14, 26),
        Separator = Color3.fromRGB(36, 36, 72),
        SeparatorTransparency = 0.18,
        BoxBackground = Color3.fromRGB(3, 3, 7),
        TextPrimary = Color3.fromRGB(200, 210, 255),
        TextSecondary = Color3.fromRGB(140, 152, 210),
        TextInactive = Color3.fromRGB(80, 88, 140),
        TextActive = Color3.fromRGB(220, 228, 255),
        Accent = Color3.fromRGB(180, 120, 255),
        TabAccent = Color3.fromRGB(200, 155, 255),
        TabIconActive = Color3.fromRGB(200, 155, 255),
        TabIconHover = Color3.fromRGB(170, 175, 220),
        TabIconInactive = Color3.fromRGB(80, 88, 140),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.0,
        TransparencySecondary = 0.80,
        TransparencyTertiary = 0.50
    },

    NordAurora = {
        Primary = Color3.fromRGB(36, 40, 49),
        Secondary = Color3.fromRGB(49, 54, 66),
        SecondaryHover = Color3.fromRGB(62, 68, 83),
        SecondaryActive = Color3.fromRGB(76, 86, 106),
        SecondaryPressed = Color3.fromRGB(42, 46, 57),
        Tertiary = Color3.fromRGB(59, 66, 82),
        TertiaryHover = Color3.fromRGB(74, 84, 104),
        TertiaryActive = Color3.fromRGB(91, 103, 128),
        TertiaryPressed = Color3.fromRGB(50, 56, 70),
        Quaternary = Color3.fromRGB(42, 47, 58),
        QuaternaryHover = Color3.fromRGB(56, 63, 78),
        Separator = Color3.fromRGB(76, 86, 106),
        SeparatorTransparency = 0.28,
        BoxBackground = Color3.fromRGB(34, 38, 46),
        TextPrimary = Color3.fromRGB(236, 239, 244),
        TextSecondary = Color3.fromRGB(189, 196, 212),
        TextInactive = Color3.fromRGB(129, 138, 160),
        TextActive = Color3.fromRGB(250, 252, 255),
        Accent = Color3.fromRGB(136, 192, 208),
        TabAccent = Color3.fromRGB(163, 212, 225),
        TabIconActive = Color3.fromRGB(163, 212, 225),
        TabIconHover = Color3.fromRGB(199, 208, 222),
        TabIconInactive = Color3.fromRGB(129, 138, 160),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.01,
        TransparencySecondary = 0.70,
        TransparencyTertiary = 0.44
    },

    Dracula = {
        Primary = Color3.fromRGB(40, 42, 54),
        Secondary = Color3.fromRGB(52, 55, 70),
        SecondaryHover = Color3.fromRGB(66, 70, 90),
        SecondaryActive = Color3.fromRGB(82, 86, 110),
        SecondaryPressed = Color3.fromRGB(46, 48, 62),
        Tertiary = Color3.fromRGB(60, 64, 82),
        TertiaryHover = Color3.fromRGB(76, 81, 104),
        TertiaryActive = Color3.fromRGB(94, 100, 128),
        TertiaryPressed = Color3.fromRGB(52, 56, 72),
        Quaternary = Color3.fromRGB(46, 48, 62),
        QuaternaryHover = Color3.fromRGB(60, 64, 82),
        Separator = Color3.fromRGB(82, 86, 110),
        SeparatorTransparency = 0.26,
        BoxBackground = Color3.fromRGB(36, 38, 48),
        TextPrimary = Color3.fromRGB(248, 248, 242),
        TextSecondary = Color3.fromRGB(200, 200, 198),
        TextInactive = Color3.fromRGB(140, 140, 148),
        TextActive = Color3.fromRGB(255, 255, 250),
        Accent = Color3.fromRGB(189, 147, 249),
        TabAccent = Color3.fromRGB(207, 170, 255),
        TabIconActive = Color3.fromRGB(207, 170, 255),
        TabIconHover = Color3.fromRGB(210, 205, 225),
        TabIconInactive = Color3.fromRGB(140, 140, 148),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.01,
        TransparencySecondary = 0.70,
        TransparencyTertiary = 0.44
    },

    GruvboxDark = {
        Primary = Color3.fromRGB(40, 40, 40),
        Secondary = Color3.fromRGB(60, 56, 54),
        SecondaryHover = Color3.fromRGB(80, 73, 69),
        SecondaryActive = Color3.fromRGB(102, 92, 84),
        SecondaryPressed = Color3.fromRGB(50, 48, 45),
        Tertiary = Color3.fromRGB(69, 65, 62),
        TertiaryHover = Color3.fromRGB(90, 84, 79),
        TertiaryActive = Color3.fromRGB(112, 104, 97),
        TertiaryPressed = Color3.fromRGB(58, 55, 52),
        Quaternary = Color3.fromRGB(50, 48, 45),
        QuaternaryHover = Color3.fromRGB(68, 64, 60),
        Separator = Color3.fromRGB(102, 92, 84),
        SeparatorTransparency = 0.24,
        BoxBackground = Color3.fromRGB(32, 32, 32),
        TextPrimary = Color3.fromRGB(235, 219, 178),
        TextSecondary = Color3.fromRGB(189, 174, 147),
        TextInactive = Color3.fromRGB(124, 111, 100),
        TextActive = Color3.fromRGB(251, 241, 199),
        Accent = Color3.fromRGB(250, 189, 47),
        TabAccent = Color3.fromRGB(255, 210, 100),
        TabIconActive = Color3.fromRGB(255, 210, 100),
        TabIconHover = Color3.fromRGB(210, 195, 160),
        TabIconInactive = Color3.fromRGB(124, 111, 100),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.01,
        TransparencySecondary = 0.68,
        TransparencyTertiary = 0.43
    },

    Phantom = {
        Primary = Color3.fromRGB(6, 6, 8),
        Secondary = Color3.fromRGB(14, 14, 18),
        SecondaryHover = Color3.fromRGB(22, 22, 29),
        SecondaryActive = Color3.fromRGB(32, 32, 42),
        SecondaryPressed = Color3.fromRGB(10, 10, 13),
        Tertiary = Color3.fromRGB(19, 19, 26),
        TertiaryHover = Color3.fromRGB(28, 28, 38),
        TertiaryActive = Color3.fromRGB(39, 39, 52),
        TertiaryPressed = Color3.fromRGB(15, 15, 21),
        Quaternary = Color3.fromRGB(9, 9, 12),
        QuaternaryHover = Color3.fromRGB(18, 18, 24),
        Separator = Color3.fromRGB(46, 46, 62),
        SeparatorTransparency = 0.16,
        BoxBackground = Color3.fromRGB(4, 4, 6),
        TextPrimary = Color3.fromRGB(220, 222, 232),
        TextSecondary = Color3.fromRGB(152, 154, 172),
        TextInactive = Color3.fromRGB(90, 92, 110),
        TextActive = Color3.fromRGB(240, 242, 255),
        Accent = Color3.fromRGB(124, 124, 255),
        TabAccent = Color3.fromRGB(158, 158, 255),
        TabIconActive = Color3.fromRGB(158, 158, 255),
        TabIconHover = Color3.fromRGB(180, 180, 215),
        TabIconInactive = Color3.fromRGB(90, 92, 110),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.0,
        TransparencySecondary = 0.82,
        TransparencyTertiary = 0.52
    },

    TurboTeal = {
        Primary = Color3.fromRGB(8, 18, 20),
        Secondary = Color3.fromRGB(13, 30, 34),
        SecondaryHover = Color3.fromRGB(18, 44, 50),
        SecondaryActive = Color3.fromRGB(26, 60, 68),
        SecondaryPressed = Color3.fromRGB(10, 24, 27),
        Tertiary = Color3.fromRGB(16, 38, 44),
        TertiaryHover = Color3.fromRGB(24, 55, 63),
        TertiaryActive = Color3.fromRGB(33, 73, 83),
        TertiaryPressed = Color3.fromRGB(13, 31, 36),
        Quaternary = Color3.fromRGB(10, 22, 26),
        QuaternaryHover = Color3.fromRGB(18, 36, 42),
        Separator = Color3.fromRGB(36, 86, 100),
        SeparatorTransparency = 0.22,
        BoxBackground = Color3.fromRGB(6, 14, 16),
        TextPrimary = Color3.fromRGB(200, 240, 244),
        TextSecondary = Color3.fromRGB(140, 196, 205),
        TextInactive = Color3.fromRGB(80, 136, 146),
        TextActive = Color3.fromRGB(220, 250, 254),
        Accent = Color3.fromRGB(45, 212, 191),
        TabAccent = Color3.fromRGB(90, 230, 212),
        TabIconActive = Color3.fromRGB(90, 230, 212),
        TabIconHover = Color3.fromRGB(140, 205, 210),
        TabIconInactive = Color3.fromRGB(80, 136, 146),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.02,
        TransparencySecondary = 0.74,
        TransparencyTertiary = 0.46
    },

    Nebula = {
        Primary = Color3.fromRGB(12, 8, 22),
        Secondary = Color3.fromRGB(22, 14, 40),
        SecondaryHover = Color3.fromRGB(32, 21, 58),
        SecondaryActive = Color3.fromRGB(44, 30, 78),
        SecondaryPressed = Color3.fromRGB(17, 11, 32),
        Tertiary = Color3.fromRGB(28, 18, 52),
        TertiaryHover = Color3.fromRGB(40, 27, 74),
        TertiaryActive = Color3.fromRGB(54, 37, 98),
        TertiaryPressed = Color3.fromRGB(23, 15, 43),
        Quaternary = Color3.fromRGB(15, 10, 28),
        QuaternaryHover = Color3.fromRGB(26, 18, 48),
        Separator = Color3.fromRGB(72, 48, 130),
        SeparatorTransparency = 0.24,
        BoxBackground = Color3.fromRGB(9, 6, 17),
        TextPrimary = Color3.fromRGB(222, 210, 255),
        TextSecondary = Color3.fromRGB(172, 155, 218),
        TextInactive = Color3.fromRGB(110, 94, 158),
        TextActive = Color3.fromRGB(240, 232, 255),
        Accent = Color3.fromRGB(196, 100, 255),
        TabAccent = Color3.fromRGB(216, 140, 255),
        TabIconActive = Color3.fromRGB(216, 140, 255),
        TabIconHover = Color3.fromRGB(185, 162, 228),
        TabIconInactive = Color3.fromRGB(110, 94, 158),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.02,
        TransparencySecondary = 0.74,
        TransparencyTertiary = 0.47
    },

    Sakura = {
        Primary = Color3.fromRGB(20, 12, 16),
        Secondary = Color3.fromRGB(34, 20, 28),
        SecondaryHover = Color3.fromRGB(48, 29, 40),
        SecondaryActive = Color3.fromRGB(64, 39, 54),
        SecondaryPressed = Color3.fromRGB(27, 16, 22),
        Tertiary = Color3.fromRGB(43, 26, 36),
        TertiaryHover = Color3.fromRGB(59, 36, 50),
        TertiaryActive = Color3.fromRGB(76, 48, 66),
        TertiaryPressed = Color3.fromRGB(36, 22, 30),
        Quaternary = Color3.fromRGB(24, 15, 20),
        QuaternaryHover = Color3.fromRGB(38, 24, 32),
        Separator = Color3.fromRGB(90, 54, 74),
        SeparatorTransparency = 0.22,
        BoxBackground = Color3.fromRGB(15, 9, 12),
        TextPrimary = Color3.fromRGB(252, 228, 236),
        TextSecondary = Color3.fromRGB(210, 172, 188),
        TextInactive = Color3.fromRGB(148, 108, 126),
        TextActive = Color3.fromRGB(255, 242, 248),
        Accent = Color3.fromRGB(255, 145, 175),
        TabAccent = Color3.fromRGB(255, 178, 200),
        TabIconActive = Color3.fromRGB(255, 178, 200),
        TabIconHover = Color3.fromRGB(228, 185, 202),
        TabIconInactive = Color3.fromRGB(148, 108, 126),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.02,
        TransparencySecondary = 0.72,
        TransparencyTertiary = 0.45
    },

    Crimson = {
        Primary = Color3.fromRGB(18, 5, 5),
        Secondary = Color3.fromRGB(34, 9, 9),
        SecondaryHover = Color3.fromRGB(52, 14, 14),
        SecondaryActive = Color3.fromRGB(72, 20, 20),
        SecondaryPressed = Color3.fromRGB(26, 7, 7),
        Tertiary = Color3.fromRGB(44, 12, 12),
        TertiaryHover = Color3.fromRGB(62, 18, 18),
        TertiaryActive = Color3.fromRGB(82, 26, 26),
        TertiaryPressed = Color3.fromRGB(36, 10, 10),
        Quaternary = Color3.fromRGB(22, 7, 7),
        QuaternaryHover = Color3.fromRGB(38, 12, 12),
        Separator = Color3.fromRGB(90, 28, 28),
        SeparatorTransparency = 0.18,
        BoxBackground = Color3.fromRGB(12, 3, 3),
        TextPrimary = Color3.fromRGB(255, 224, 224),
        TextSecondary = Color3.fromRGB(210, 160, 160),
        TextInactive = Color3.fromRGB(148, 98, 98),
        TextActive = Color3.fromRGB(255, 240, 240),
        Accent = Color3.fromRGB(255, 55, 55),
        TabAccent = Color3.fromRGB(255, 100, 100),
        TabIconActive = Color3.fromRGB(255, 100, 100),
        TabIconHover = Color3.fromRGB(225, 170, 170),
        TabIconInactive = Color3.fromRGB(148, 98, 98),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.02,
        TransparencySecondary = 0.72,
        TransparencyTertiary = 0.45
    },

    Amber = {
        Primary = Color3.fromRGB(14, 11, 4),
        Secondary = Color3.fromRGB(26, 20, 6),
        SecondaryHover = Color3.fromRGB(40, 31, 9),
        SecondaryActive = Color3.fromRGB(56, 44, 13),
        SecondaryPressed = Color3.fromRGB(20, 16, 5),
        Tertiary = Color3.fromRGB(34, 27, 8),
        TertiaryHover = Color3.fromRGB(50, 40, 12),
        TertiaryActive = Color3.fromRGB(68, 54, 16),
        TertiaryPressed = Color3.fromRGB(28, 22, 6),
        Quaternary = Color3.fromRGB(17, 13, 4),
        QuaternaryHover = Color3.fromRGB(30, 24, 8),
        Separator = Color3.fromRGB(80, 62, 18),
        SeparatorTransparency = 0.20,
        BoxBackground = Color3.fromRGB(10, 8, 2),
        TextPrimary = Color3.fromRGB(255, 240, 190),
        TextSecondary = Color3.fromRGB(210, 185, 120),
        TextInactive = Color3.fromRGB(148, 124, 72),
        TextActive = Color3.fromRGB(255, 252, 220),
        Accent = Color3.fromRGB(255, 204, 0),
        TabAccent = Color3.fromRGB(255, 220, 60),
        TabIconActive = Color3.fromRGB(255, 220, 60),
        TabIconHover = Color3.fromRGB(220, 195, 140),
        TabIconInactive = Color3.fromRGB(148, 124, 72),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.02,
        TransparencySecondary = 0.72,
        TransparencyTertiary = 0.45
    },

    Dusk = {
        Primary = Color3.fromRGB(14, 10, 20),
        Secondary = Color3.fromRGB(26, 16, 36),
        SecondaryHover = Color3.fromRGB(40, 24, 52),
        SecondaryActive = Color3.fromRGB(56, 34, 70),
        SecondaryPressed = Color3.fromRGB(20, 13, 28),
        Tertiary = Color3.fromRGB(34, 21, 48),
        TertiaryHover = Color3.fromRGB(50, 31, 68),
        TertiaryActive = Color3.fromRGB(68, 43, 90),
        TertiaryPressed = Color3.fromRGB(28, 17, 40),
        Quaternary = Color3.fromRGB(17, 12, 24),
        QuaternaryHover = Color3.fromRGB(30, 21, 42),
        Separator = Color3.fromRGB(80, 50, 110),
        SeparatorTransparency = 0.20,
        BoxBackground = Color3.fromRGB(10, 7, 15),
        TextPrimary = Color3.fromRGB(248, 224, 210),
        TextSecondary = Color3.fromRGB(200, 165, 185),
        TextInactive = Color3.fromRGB(138, 108, 128),
        TextActive = Color3.fromRGB(255, 240, 225),
        Accent = Color3.fromRGB(255, 110, 60),
        TabAccent = Color3.fromRGB(255, 148, 80),
        TabIconActive = Color3.fromRGB(255, 148, 80),
        TabIconHover = Color3.fromRGB(215, 175, 185),
        TabIconInactive = Color3.fromRGB(138, 108, 128),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.02,
        TransparencySecondary = 0.73,
        TransparencyTertiary = 0.46
    },

    Verdant = {
        Primary = Color3.fromRGB(6, 18, 8),
        Secondary = Color3.fromRGB(10, 30, 13),
        SecondaryHover = Color3.fromRGB(16, 44, 20),
        SecondaryActive = Color3.fromRGB(22, 60, 28),
        SecondaryPressed = Color3.fromRGB(8, 24, 10),
        Tertiary = Color3.fromRGB(13, 38, 17),
        TertiaryHover = Color3.fromRGB(20, 55, 26),
        TertiaryActive = Color3.fromRGB(28, 74, 36),
        TertiaryPressed = Color3.fromRGB(10, 31, 14),
        Quaternary = Color3.fromRGB(8, 22, 10),
        QuaternaryHover = Color3.fromRGB(14, 36, 17),
        Separator = Color3.fromRGB(30, 90, 42),
        SeparatorTransparency = 0.20,
        BoxBackground = Color3.fromRGB(4, 13, 6),
        TextPrimary = Color3.fromRGB(200, 255, 210),
        TextSecondary = Color3.fromRGB(140, 205, 155),
        TextInactive = Color3.fromRGB(80, 140, 96),
        TextActive = Color3.fromRGB(220, 255, 228),
        Accent = Color3.fromRGB(50, 220, 80),
        TabAccent = Color3.fromRGB(90, 240, 118),
        TabIconActive = Color3.fromRGB(90, 240, 118),
        TabIconHover = Color3.fromRGB(148, 210, 162),
        TabIconInactive = Color3.fromRGB(80, 140, 96),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.02,
        TransparencySecondary = 0.74,
        TransparencyTertiary = 0.46
    },

    Tungsten = {
        Primary = Color3.fromRGB(20, 20, 20),
        Secondary = Color3.fromRGB(36, 36, 36),
        SecondaryHover = Color3.fromRGB(52, 52, 52),
        SecondaryActive = Color3.fromRGB(70, 70, 70),
        SecondaryPressed = Color3.fromRGB(28, 28, 28),
        Tertiary = Color3.fromRGB(46, 46, 46),
        TertiaryHover = Color3.fromRGB(64, 64, 64),
        TertiaryActive = Color3.fromRGB(84, 84, 84),
        TertiaryPressed = Color3.fromRGB(38, 38, 38),
        Quaternary = Color3.fromRGB(26, 26, 26),
        QuaternaryHover = Color3.fromRGB(42, 42, 42),
        Separator = Color3.fromRGB(80, 80, 80),
        SeparatorTransparency = 0.18,
        BoxBackground = Color3.fromRGB(14, 14, 14),
        TextPrimary = Color3.fromRGB(230, 230, 230),
        TextSecondary = Color3.fromRGB(170, 170, 170),
        TextInactive = Color3.fromRGB(108, 108, 108),
        TextActive = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(220, 180, 60),
        TabAccent = Color3.fromRGB(240, 205, 90),
        TabIconActive = Color3.fromRGB(240, 205, 90),
        TabIconHover = Color3.fromRGB(195, 190, 170),
        TabIconInactive = Color3.fromRGB(108, 108, 108),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.01,
        TransparencySecondary = 0.76,
        TransparencyTertiary = 0.48
    },

    Pearl = {
        Primary = Color3.fromRGB(248, 248, 250),
        Secondary = Color3.fromRGB(238, 238, 244),
        SecondaryHover = Color3.fromRGB(228, 228, 236),
        SecondaryActive = Color3.fromRGB(214, 214, 226),
        SecondaryPressed = Color3.fromRGB(232, 232, 240),
        Tertiary = Color3.fromRGB(224, 224, 232),
        TertiaryHover = Color3.fromRGB(210, 210, 222),
        TertiaryActive = Color3.fromRGB(196, 196, 212),
        TertiaryPressed = Color3.fromRGB(218, 218, 228),
        Quaternary = Color3.fromRGB(242, 242, 246),
        QuaternaryHover = Color3.fromRGB(232, 232, 238),
        Separator = Color3.fromRGB(200, 200, 216),
        SeparatorTransparency = 0.30,
        BoxBackground = Color3.fromRGB(255, 255, 255),
        TextPrimary = Color3.fromRGB(28, 28, 40),
        TextSecondary = Color3.fromRGB(80, 80, 108),
        TextInactive = Color3.fromRGB(148, 148, 172),
        TextActive = Color3.fromRGB(12, 12, 22),
        Accent = Color3.fromRGB(109, 40, 217),
        TabAccent = Color3.fromRGB(124, 58, 237),
        TabIconActive = Color3.fromRGB(109, 40, 217),
        TabIconHover = Color3.fromRGB(60, 60, 100),
        TabIconInactive = Color3.fromRGB(148, 148, 172),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.0,
        TransparencySecondary = 0.40,
        TransparencyTertiary = 0.20
    },

    Cloud = {
        Primary = Color3.fromRGB(244, 246, 252),
        Secondary = Color3.fromRGB(232, 236, 248),
        SecondaryHover = Color3.fromRGB(218, 224, 242),
        SecondaryActive = Color3.fromRGB(200, 210, 236),
        SecondaryPressed = Color3.fromRGB(226, 230, 244),
        Tertiary = Color3.fromRGB(214, 220, 240),
        TertiaryHover = Color3.fromRGB(198, 208, 234),
        TertiaryActive = Color3.fromRGB(180, 194, 228),
        TertiaryPressed = Color3.fromRGB(207, 214, 237),
        Quaternary = Color3.fromRGB(238, 241, 250),
        QuaternaryHover = Color3.fromRGB(226, 230, 244),
        Separator = Color3.fromRGB(186, 198, 232),
        SeparatorTransparency = 0.28,
        BoxBackground = Color3.fromRGB(252, 252, 255),
        TextPrimary = Color3.fromRGB(22, 28, 52),
        TextSecondary = Color3.fromRGB(72, 88, 140),
        TextInactive = Color3.fromRGB(140, 152, 196),
        TextActive = Color3.fromRGB(10, 14, 34),
        Accent = Color3.fromRGB(79, 70, 229),
        TabAccent = Color3.fromRGB(99, 90, 245),
        TabIconActive = Color3.fromRGB(79, 70, 229),
        TabIconHover = Color3.fromRGB(38, 48, 100),
        TabIconInactive = Color3.fromRGB(140, 152, 196),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.0,
        TransparencySecondary = 0.38,
        TransparencyTertiary = 0.18
    },

    Linen = {
        Primary = Color3.fromRGB(250, 246, 240),
        Secondary = Color3.fromRGB(240, 234, 224),
        SecondaryHover = Color3.fromRGB(228, 220, 208),
        SecondaryActive = Color3.fromRGB(212, 202, 188),
        SecondaryPressed = Color3.fromRGB(235, 228, 218),
        Tertiary = Color3.fromRGB(222, 214, 202),
        TertiaryHover = Color3.fromRGB(208, 198, 184),
        TertiaryActive = Color3.fromRGB(192, 180, 164),
        TertiaryPressed = Color3.fromRGB(215, 207, 195),
        Quaternary = Color3.fromRGB(246, 242, 236),
        QuaternaryHover = Color3.fromRGB(235, 229, 221),
        Separator = Color3.fromRGB(196, 182, 164),
        SeparatorTransparency = 0.26,
        BoxBackground = Color3.fromRGB(255, 252, 248),
        TextPrimary = Color3.fromRGB(40, 30, 20),
        TextSecondary = Color3.fromRGB(100, 80, 60),
        TextInactive = Color3.fromRGB(160, 140, 120),
        TextActive = Color3.fromRGB(20, 14, 8),
        Accent = Color3.fromRGB(180, 80, 40),
        TabAccent = Color3.fromRGB(204, 100, 56),
        TabIconActive = Color3.fromRGB(180, 80, 40),
        TabIconHover = Color3.fromRGB(70, 50, 30),
        TabIconInactive = Color3.fromRGB(160, 140, 120),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.0,
        TransparencySecondary = 0.35,
        TransparencyTertiary = 0.16
    },

    Parchment = {
        Primary = Color3.fromRGB(248, 240, 224),
        Secondary = Color3.fromRGB(236, 226, 208),
        SecondaryHover = Color3.fromRGB(222, 210, 190),
        SecondaryActive = Color3.fromRGB(206, 192, 170),
        SecondaryPressed = Color3.fromRGB(230, 219, 200),
        Tertiary = Color3.fromRGB(216, 204, 183),
        TertiaryHover = Color3.fromRGB(200, 186, 163),
        TertiaryActive = Color3.fromRGB(182, 166, 143),
        TertiaryPressed = Color3.fromRGB(208, 196, 176),
        Quaternary = Color3.fromRGB(242, 234, 218),
        QuaternaryHover = Color3.fromRGB(230, 220, 202),
        Separator = Color3.fromRGB(186, 168, 144),
        SeparatorTransparency = 0.24,
        BoxBackground = Color3.fromRGB(254, 248, 234),
        TextPrimary = Color3.fromRGB(44, 32, 14),
        TextSecondary = Color3.fromRGB(100, 78, 48),
        TextInactive = Color3.fromRGB(160, 136, 104),
        TextActive = Color3.fromRGB(26, 18, 6),
        Accent = Color3.fromRGB(140, 80, 20),
        TabAccent = Color3.fromRGB(168, 102, 36),
        TabIconActive = Color3.fromRGB(140, 80, 20),
        TabIconHover = Color3.fromRGB(60, 40, 12),
        TabIconInactive = Color3.fromRGB(160, 136, 104),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.0,
        TransparencySecondary = 0.32,
        TransparencyTertiary = 0.15
    },

    Sage = {
        Primary = Color3.fromRGB(238, 244, 240),
        Secondary = Color3.fromRGB(224, 234, 228),
        SecondaryHover = Color3.fromRGB(208, 222, 214),
        SecondaryActive = Color3.fromRGB(190, 208, 198),
        SecondaryPressed = Color3.fromRGB(218, 229, 222),
        Tertiary = Color3.fromRGB(206, 220, 212),
        TertiaryHover = Color3.fromRGB(188, 206, 196),
        TertiaryActive = Color3.fromRGB(168, 190, 178),
        TertiaryPressed = Color3.fromRGB(198, 214, 206),
        Quaternary = Color3.fromRGB(232, 240, 235),
        QuaternaryHover = Color3.fromRGB(218, 229, 222),
        Separator = Color3.fromRGB(164, 194, 176),
        SeparatorTransparency = 0.26,
        BoxBackground = Color3.fromRGB(248, 252, 250),
        TextPrimary = Color3.fromRGB(20, 40, 30),
        TextSecondary = Color3.fromRGB(60, 100, 80),
        TextInactive = Color3.fromRGB(120, 156, 140),
        TextActive = Color3.fromRGB(8, 22, 15),
        Accent = Color3.fromRGB(30, 130, 90),
        TabAccent = Color3.fromRGB(44, 158, 112),
        TabIconActive = Color3.fromRGB(30, 130, 90),
        TabIconHover = Color3.fromRGB(20, 60, 42),
        TabIconInactive = Color3.fromRGB(120, 156, 140),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.0,
        TransparencySecondary = 0.34,
        TransparencyTertiary = 0.16
    },

    Harajuku = {
        Primary = Color3.fromRGB(255, 240, 248),
        Secondary = Color3.fromRGB(255, 224, 240),
        SecondaryHover = Color3.fromRGB(255, 206, 230),
        SecondaryActive = Color3.fromRGB(254, 186, 218),
        SecondaryPressed = Color3.fromRGB(255, 216, 236),
        Tertiary = Color3.fromRGB(252, 210, 232),
        TertiaryHover = Color3.fromRGB(248, 190, 220),
        TertiaryActive = Color3.fromRGB(242, 168, 206),
        TertiaryPressed = Color3.fromRGB(251, 202, 227),
        Quaternary = Color3.fromRGB(255, 232, 244),
        QuaternaryHover = Color3.fromRGB(255, 218, 236),
        Separator = Color3.fromRGB(240, 160, 210),
        SeparatorTransparency = 0.28,
        BoxBackground = Color3.fromRGB(255, 248, 252),
        TextPrimary = Color3.fromRGB(100, 20, 60),
        TextSecondary = Color3.fromRGB(180, 60, 120),
        TextInactive = Color3.fromRGB(210, 140, 175),
        TextActive = Color3.fromRGB(70, 8, 40),
        Accent = Color3.fromRGB(255, 60, 140),
        TabAccent = Color3.fromRGB(255, 100, 168),
        TabIconActive = Color3.fromRGB(255, 60, 140),
        TabIconHover = Color3.fromRGB(90, 16, 52),
        TabIconInactive = Color3.fromRGB(210, 140, 175),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.0,
        TransparencySecondary = 0.34,
        TransparencyTertiary = 0.16
    },

    Pastel = {
        Primary = Color3.fromRGB(252, 244, 255),
        Secondary = Color3.fromRGB(244, 228, 255),
        SecondaryHover = Color3.fromRGB(234, 210, 255),
        SecondaryActive = Color3.fromRGB(222, 190, 252),
        SecondaryPressed = Color3.fromRGB(239, 220, 255),
        Tertiary = Color3.fromRGB(228, 200, 252),
        TertiaryHover = Color3.fromRGB(214, 178, 248),
        TertiaryActive = Color3.fromRGB(198, 154, 242),
        TertiaryPressed = Color3.fromRGB(222, 192, 250),
        Quaternary = Color3.fromRGB(248, 236, 255),
        QuaternaryHover = Color3.fromRGB(238, 220, 255),
        Separator = Color3.fromRGB(204, 158, 240),
        SeparatorTransparency = 0.30,
        BoxBackground = Color3.fromRGB(255, 250, 255),
        TextPrimary = Color3.fromRGB(52, 14, 80),
        TextSecondary = Color3.fromRGB(118, 48, 162),
        TextInactive = Color3.fromRGB(174, 120, 210),
        TextActive = Color3.fromRGB(32, 6, 52),
        Accent = Color3.fromRGB(188, 80, 255),
        TabAccent = Color3.fromRGB(210, 120, 255),
        TabIconActive = Color3.fromRGB(188, 80, 255),
        TabIconHover = Color3.fromRGB(56, 12, 90),
        TabIconInactive = Color3.fromRGB(174, 120, 210),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.0,
        TransparencySecondary = 0.35,
        TransparencyTertiary = 0.17
    },

    Bubblegum = {
        Primary = Color3.fromRGB(255, 238, 248),
        Secondary = Color3.fromRGB(255, 214, 238),
        SecondaryHover = Color3.fromRGB(255, 190, 226),
        SecondaryActive = Color3.fromRGB(252, 164, 212),
        SecondaryPressed = Color3.fromRGB(255, 204, 233),
        Tertiary = Color3.fromRGB(250, 178, 222),
        TertiaryHover = Color3.fromRGB(244, 154, 208),
        TertiaryActive = Color3.fromRGB(236, 128, 192),
        TertiaryPressed = Color3.fromRGB(248, 168, 216),
        Quaternary = Color3.fromRGB(255, 228, 243),
        QuaternaryHover = Color3.fromRGB(255, 210, 234),
        Separator = Color3.fromRGB(238, 130, 196),
        SeparatorTransparency = 0.26,
        BoxBackground = Color3.fromRGB(255, 246, 252),
        TextPrimary = Color3.fromRGB(96, 10, 56),
        TextSecondary = Color3.fromRGB(192, 40, 120),
        TextInactive = Color3.fromRGB(226, 130, 178),
        TextActive = Color3.fromRGB(64, 4, 36),
        Accent = Color3.fromRGB(255, 20, 120),
        TabAccent = Color3.fromRGB(255, 70, 155),
        TabIconActive = Color3.fromRGB(255, 20, 120),
        TabIconHover = Color3.fromRGB(80, 6, 44),
        TabIconInactive = Color3.fromRGB(226, 130, 178),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.0,
        TransparencySecondary = 0.34,
        TransparencyTertiary = 0.16
    },

    CottonCandy = {
        Primary = Color3.fromRGB(240, 248, 255),
        Secondary = Color3.fromRGB(220, 236, 255),
        SecondaryHover = Color3.fromRGB(198, 222, 255),
        SecondaryActive = Color3.fromRGB(174, 206, 255),
        SecondaryPressed = Color3.fromRGB(210, 230, 255),
        Tertiary = Color3.fromRGB(192, 218, 255),
        TertiaryHover = Color3.fromRGB(166, 202, 252),
        TertiaryActive = Color3.fromRGB(140, 184, 248),
        TertiaryPressed = Color3.fromRGB(180, 212, 254),
        Quaternary = Color3.fromRGB(230, 242, 255),
        QuaternaryHover = Color3.fromRGB(212, 230, 255),
        Separator = Color3.fromRGB(148, 196, 255),
        SeparatorTransparency = 0.28,
        BoxBackground = Color3.fromRGB(248, 252, 255),
        TextPrimary = Color3.fromRGB(10, 36, 80),
        TextSecondary = Color3.fromRGB(40, 100, 190),
        TextInactive = Color3.fromRGB(110, 158, 220),
        TextActive = Color3.fromRGB(4, 20, 56),
        Accent = Color3.fromRGB(80, 160, 255),
        TabAccent = Color3.fromRGB(116, 184, 255),
        TabIconActive = Color3.fromRGB(80, 160, 255),
        TabIconHover = Color3.fromRGB(8, 32, 80),
        TabIconInactive = Color3.fromRGB(110, 158, 220),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.0,
        TransparencySecondary = 0.35,
        TransparencyTertiary = 0.17
    },

    Matcha = {
        Primary = Color3.fromRGB(236, 248, 238),
        Secondary = Color3.fromRGB(214, 238, 218),
        SecondaryHover = Color3.fromRGB(190, 226, 196),
        SecondaryActive = Color3.fromRGB(164, 212, 172),
        SecondaryPressed = Color3.fromRGB(204, 233, 209),
        Tertiary = Color3.fromRGB(180, 220, 188),
        TertiaryHover = Color3.fromRGB(156, 206, 166),
        TertiaryActive = Color3.fromRGB(130, 190, 142),
        TertiaryPressed = Color3.fromRGB(170, 214, 178),
        Quaternary = Color3.fromRGB(226, 244, 228),
        QuaternaryHover = Color3.fromRGB(206, 234, 210),
        Separator = Color3.fromRGB(130, 196, 142),
        SeparatorTransparency = 0.28,
        BoxBackground = Color3.fromRGB(246, 254, 248),
        TextPrimary = Color3.fromRGB(10, 44, 18),
        TextSecondary = Color3.fromRGB(34, 110, 52),
        TextInactive = Color3.fromRGB(96, 164, 110),
        TextActive = Color3.fromRGB(4, 26, 10),
        Accent = Color3.fromRGB(60, 168, 84),
        TabAccent = Color3.fromRGB(88, 196, 112),
        TabIconActive = Color3.fromRGB(60, 168, 84),
        TabIconHover = Color3.fromRGB(10, 50, 20),
        TabIconInactive = Color3.fromRGB(96, 164, 110),
        FontPrimary = Enum.Font.GothamBold,
        FontSecondary = Enum.Font.GothamMedium,
        FontSizePrimary = 18,
        FontSizeSecondary = 16,
        TransparencyPrimary = 0.0,
        TransparencySecondary = 0.34,
        TransparencyTertiary = 0.16
    }
}

SimpleUI.Themes.DefaultTheme = SimpleUI.Themes.Obsidian

-- Helper frameworks
do
    SimpleUI.ErrorHandler = {}
    do
        local ErrorLevels = {
            SILENT = 0,
            WARN = 1,
            ERROR = 2,
            CRITICAL = 3
        }
        SimpleUI.ErrorHandler.Level = ErrorLevels.WARN
        SimpleUI.ErrorHandler.Levels = ErrorLevels
        local Colors = {
            [ErrorLevels.WARN] = "255,255,0",
            [ErrorLevels.ERROR] = "255,100,100",
            [ErrorLevels.CRITICAL] = "255,0,0"
        }

        RunService.Heartbeat:Connect(function()
            local Console = CoreGui:FindFirstChild("DevConsoleMaster")
            if Console then
                for _, v in pairs(Console:GetDescendants()) do
                    if v:IsA("TextLabel") then
                        v.RichText = true
                    end
                end
            end
        end)

        local function RichPrint(Color, Text)
            local RGB = Colors[Color] or "255,255,255"
            print('<font color="rgb(' .. RGB .. ')">' .. tostring(Text) .. '</font>')
        end
        local function FormatError(Context, Message, Level)
            local Prefix = ({
                [ErrorLevels.WARN] = "[SimpleUI:WARN]",
                [ErrorLevels.ERROR] = "[SimpleUI:ERROR]",
                [ErrorLevels.CRITICAL] = "[SimpleUI:CRITICAL]"
            })[Level] or "[SimpleUI]"
            return Prefix .. " " .. Context .. ": " .. Message
        end
        local function LogError(Context, Message, Level)
            if Level == ErrorLevels.SILENT then
                return
            end
            if Level < SimpleUI.ErrorHandler.Level then
                return
            end
            RichPrint(Level, FormatError(Context, Message, Level))
        end
        function SimpleUI.ErrorHandler:Wrap(Func, Context, DefaultReturn)
            return function(...)
                local Success, Result = pcall(Func, ...)
                if not Success then
                    LogError(Context, tostring(Result), ErrorLevels.ERROR)
                    return DefaultReturn
                end
                return Result
            end
        end

        function SimpleUI.ErrorHandler:Guard(Condition, Context, Message, Level)
            if not Condition then
                LogError(Context, Message, Level or ErrorLevels.WARN)
                return false
            end
            return true
        end

        function SimpleUI.ErrorHandler:ValidateType(Value, ExpectedType, ParamName, Context)
            local ActualType = typeof(Value)
            if ActualType ~= ExpectedType then
                LogError(Context,
                    "Invalid type for '" .. ParamName .. "': expected " .. ExpectedType .. ", got " .. ActualType,
                    ErrorLevels.WARN)
                return false
            end
            return true
        end

        function SimpleUI.ErrorHandler:ValidateRange(Value, Min, Max, ParamName, Context)
            if Value < Min or Value > Max then
                LogError(Context,
                    "'" .. ParamName .. "' out of range: " .. tostring(Value) .. " not in [" .. tostring(Min) .. ", " ..
                        tostring(Max) .. "]", ErrorLevels.WARN)
                return false
            end
            return true
        end

        function SimpleUI.ErrorHandler:ValidateInstance(Instance, ExpectedClass, Context)
            if not Instance then
                LogError(Context, "Instance is nil", ErrorLevels.WARN)
                return false
            end
            if not Instance:IsA(ExpectedClass) then
                LogError(Context, "Invalid instance type: expected " .. ExpectedClass .. ", got " .. Instance.ClassName,
                    ErrorLevels.WARN)
                return false
            end
            return true
        end

        function SimpleUI.ErrorHandler:ValidateOptions(Options, Required, Optional, Context)
            Options = Options or {}
            for _, Key in ipairs(Required or {}) do
                if Options[Key] == nil then
                    LogError(Context, "Missing required option: '" .. Key .. "'", ErrorLevels.WARN)
                    return false
                end
            end
            local Allowed = {}
            for _, Key in ipairs(Required or {}) do
                Allowed[Key] = true
            end
            for _, Key in ipairs(Optional or {}) do
                Allowed[Key] = true
            end
            for Key in pairs(Options) do
                if not Allowed[Key] then
                    LogError(Context, "Unknown option: '" .. Key .. "'", ErrorLevels.WARN)
                end
            end
            return true
        end

        function SimpleUI.ErrorHandler:Try(Func, Fallback)
            local Success, Result = pcall(Func)
            if not Success then
                return Fallback and Fallback() or nil
            end
            return Result
        end

        function SimpleUI.ErrorHandler:SetLevel(Level)
            self.Level = Level
        end
    end

    SimpleUI.Security = {}
    do
        local ProtectedFunctions = {}
        local HookedMetatables = {}
        function SimpleUI.Security:WrapFunction(Func)
            if not Func or type(Func) ~= "function" then
                return Func
            end
            if ProtectedFunctions[Func] then
                return ProtectedFunctions[Func]
            end
            local Protected = newcclosure(function(...)
                return Func(...)
            end)
            ProtectedFunctions[Func] = Protected
            return Protected
        end

        function SimpleUI.Security:SafeCallback(Callback, ...)
            if not (Callback and typeof(Callback) == "function") then
                return nil
            end
            local _, Result = xpcall(Callback, function(Error)
                if SimpleUI.ErrorHandler.Level >= SimpleUI.ErrorHandler.Levels.ERROR then
                    SimpleUI.ErrorHandler:Guard(false, "SafeCallback", tostring(Error),
                        SimpleUI.ErrorHandler.Levels.ERROR)
                end
                return Error
            end, ...)
            return Result
        end

        function SimpleUI.Security:ProtectMetatable(Object)
            if not Object or HookedMetatables[Object] then
                return false
            end
            local Success = pcall(function()
                local MT = getmetatable(Object)
                if not MT then
                    return
                end
                local OriginalIndex = MT.__index
                local OriginalNewIndex = MT.__newindex
                local OriginalNamecall = MT.__namecall
                if OriginalIndex then
                    MT.__index = newcclosure(function(self, Key)
                        if type(OriginalIndex) == "function" then
                            return OriginalIndex(self, Key)
                        else
                            return OriginalIndex[Key]
                        end
                    end)
                end
                if OriginalNewIndex then
                    MT.__newindex = newcclosure(function(self, Key, Value)
                        if type(OriginalNewIndex) == "function" then
                            return OriginalNewIndex(self, Key, Value)
                        else
                            OriginalNewIndex[Key] = Value
                        end
                    end)
                end
                if OriginalNamecall then
                    MT.__namecall = newcclosure(function(self, ...)
                        return OriginalNamecall(self, ...)
                    end)
                end
                HookedMetatables[Object] = {
                    OriginalIndex = OriginalIndex,
                    OriginalNewIndex = OriginalNewIndex,
                    OriginalNamecall = OriginalNamecall
                }
            end)
            return Success
        end
    end

    SimpleUI.EventProtection = {} -- Deprecated
    do
        local ProtectedEvents = {}
        function SimpleUI.EventProtection:Protect(Event)
            if not Event or ProtectedEvents[Event] then
                return false
            end
            ProtectedEvents[Event] = true
            local OriginalConnect = Event.Connect
            Event.Connect = newcclosure(function(self, ...)
                return OriginalConnect(self, ...)
            end)
            local OriginalWait = Event.Wait
            Event.Wait = newcclosure(function(self, ...)
                return OriginalWait(self, ...)
            end)
            return true
        end
    end

    SimpleUI.ConnectionRegistry = {}
    do
        function SimpleUI.ConnectionRegistry:New()
            local registry = {
                _connections = {}
            }

            function registry:Add(connection)
                if connection and typeof(connection) == "RBXScriptConnection" then
                    table.insert(self._connections, connection)
                end
                return connection
            end

            function registry:Remove(connection)
                for i, c in ipairs(self._connections) do
                    if c == connection then
                        if c.Connected then
                            c:Disconnect()
                        end
                        table.remove(self._connections, i)
                        return
                    end
                end
            end

            function registry:Cleanup()
                for _, c in ipairs(self._connections) do
                    if c.Connected then
                        c:Disconnect()
                    end
                end
                table.clear(self._connections)
            end

            return registry
        end
    end

    SimpleUI.MetatableProtection = {}
    do
        local ProtectedObjects = {}
        function SimpleUI.MetatableProtection:Protect(Object)
            if not Object or ProtectedObjects[Object] then
                return false
            end
            ProtectedObjects[Object] = true
            return true
        end

        function SimpleUI.MetatableProtection:ProtectUI(ScreenGui)
            if not ScreenGui then
                return false
            end
            self:Protect(ScreenGui)
            for _, Descendant in ipairs(ScreenGui:GetDescendants()) do
                if Descendant:IsA("GuiObject") then
                    self:Protect(Descendant)
                end
            end
            return true
        end
    end

    SimpleUI.Utility = {}
    do
        function SimpleUI.Utility:GetService(ServiceName)
            return cloneref(game:GetService(ServiceName))
        end

        function SimpleUI.Utility:IsMobile()
            return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
        end

        function SimpleUI.Utility:CreateInstance(ClassName, Properties, Parent)
            local Instance = Instance.new(ClassName)
            if Properties then
                for Property, Value in pairs(Properties) do
                    Instance[Property] = Value
                end
            end
            if Parent then
                Instance.Parent = Parent
            end
            return Instance
        end

        function SimpleUI.Utility:GenerateId()
            local charset =
                "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?/`~"
            local rng = Random.new(math.floor(os.clock() * 1e9) + math.floor(tick() * 1e6) + math.random(1, 1e9))
            local length = rng:NextInteger(24, 40)
            local output = table.create(length)
            for i = 1, length do
                local index = rng:NextInteger(1, #charset)
                output[i] = charset:sub(index, index)
            end
            return table.concat(output)
        end

        function SimpleUI.Utility:MergeTables(Base, Override)
            local Result = {}
            for Key, Value in pairs(Base or {}) do
                Result[Key] = type(Value) == "table" and self:MergeTables(Value, {}) or Value
            end
            for Key, Value in pairs(Override or {}) do
                if type(Value) == "table" and type(Result[Key]) == "table" then
                    Result[Key] = self:MergeTables(Result[Key], Value)
                else
                    Result[Key] = Value
                end
            end
            return Result
        end

        function SimpleUI.Utility:ApplyTheme(Properties, ThemeBindings, Theme)
            local Result = {}
            local Bindings = {}
            for Property, Value in pairs(Properties) do
                Result[Property] = Value
            end
            if ThemeBindings then
                for Property, ThemeKey in pairs(ThemeBindings) do
                    if Theme[ThemeKey] then
                        Result[Property] = Theme[ThemeKey]
                        Bindings[Property] = ThemeKey
                    end
                end
            end
            return Result, Bindings
        end

        function SimpleUI.Utility:GetWindowFromElement(Element)
            local Current = Element
            while Current do
                if Current:IsA("ScreenGui") and SimpleUI.Windows[Current] then
                    return SimpleUI.Windows[Current]
                end
                Current = Current.Parent
            end
            return nil
        end

        function SimpleUI.Utility:ParentUI(Element, TargetParent)
            local Success = pcall(function()
                local FinalParent
                pcall(protectgui, Element)
                FinalParent = gethui()
                if TargetParent then
                    if type(TargetParent) == "function" then
                        FinalParent = TargetParent()
                    else
                        FinalParent = TargetParent
                    end
                end
                Element.Parent = FinalParent
            end)
            if not (Success and Element.Parent) then
                Element.Parent = LocalPlayer:WaitForChild("CoreGui", math.huge)
            end
        end

        function SimpleUI.Utility:Tween(object, tweenInfo, properties)
            if not object or not object.Parent then
                return
            end
            TweenService:Create(object, tweenInfo, properties):Play()
        end
    end

    SimpleUI.SaveManager = {}
    do
        SimpleUI.SaveManager.Enabled = true
        SimpleUI.SaveManager.AutoSave = true
        SimpleUI.SaveManager.Folder = "SimpleUI"
        SimpleUI.SaveManager.FileName = tostring(game.PlaceId) .. ".json"
        SimpleUI.SaveManager.Values = {}
        SimpleUI.SaveManager.Loaded = false

        local function hasFilesystem()
            return type(readfile) == "function" and type(writefile) == "function" and type(isfile) == "function" and
                       type(makefolder) == "function" and type(isfolder) == "function"
        end

        local function splitPath(path)
            local parts = {}
            for part in tostring(path or ""):gmatch("[^/\\]+") do
                table.insert(parts, part)
            end
            return parts
        end

        local function ensureFolder(path)
            if not hasFilesystem() then
                return false
            end

            local current = ""
            for _, part in ipairs(splitPath(path)) do
                current = current == "" and part or (current .. "/" .. part)
                if not isfolder(current) then
                    local ok = pcall(makefolder, current)
                    if not ok then
                        return false
                    end
                end
            end
            return true
        end

        local function sanitizeKey(value)
            local text = tostring(value or "value")
            text = text:gsub("%s+", "_"):gsub("[^%w_%-%.:]", "")
            return text ~= "" and text or "value"
        end

        function SimpleUI.SaveManager:IsAvailable()
            return hasFilesystem()
        end

        function SimpleUI.SaveManager:Configure(options)
            options = options or {}
            if options.Enabled ~= nil then
                self.Enabled = options.Enabled == true
            end
            if options.AutoSave ~= nil then
                self.AutoSave = options.AutoSave == true
            end
            if type(options.Folder) == "string" and options.Folder ~= "" then
                self.Folder = options.Folder
            end
            if type(options.FileName) == "string" and options.FileName ~= "" then
                self.FileName = options.FileName
            end
            if type(options.File) == "string" and options.File ~= "" then
                self.FileName = options.File
            end
            self:Load()
            return self
        end

        function SimpleUI.SaveManager:GetPath()
            return self.Folder .. "/" .. self.FileName
        end

        function SimpleUI.SaveManager:Load()
            if self.Loaded then
                return self.Values
            end
            self.Loaded = true
            self.Values = {}

            if not self.Enabled or not self:IsAvailable() then
                return self.Values
            end

            local path = self:GetPath()
            if not isfile(path) then
                return self.Values
            end

            local ok, data = pcall(function()
                local body = readfile(path)
                if type(body) ~= "string" or body == "" then
                    return {}
                end
                return SimpleUI.Utility:GetService("HttpService"):JSONDecode(body)
            end)

            if ok and type(data) == "table" then
                self.Values = data
            end

            return self.Values
        end

        function SimpleUI.SaveManager:Save()
            if not self.Enabled or not self:IsAvailable() then
                return false
            end
            if not ensureFolder(self.Folder) then
                return false
            end

            local ok = pcall(function()
                local body = SimpleUI.Utility:GetService("HttpService"):JSONEncode(self.Values or {})
                writefile(self:GetPath(), body)
            end)
            return ok
        end

        function SimpleUI.SaveManager:Get(key, defaultValue)
            self:Load()
            if self.Values[key] == nil then
                return defaultValue
            end
            return self.Values[key]
        end

        function SimpleUI.SaveManager:Set(key, value)
            if not key then
                return false
            end
            self:Load()
            self.Values[key] = value
            if self.AutoSave then
                return self:Save()
            end
            return true
        end

        function SimpleUI.SaveManager:Remove(key)
            if not key then
                return false
            end
            self:Load()
            self.Values[key] = nil
            if self.AutoSave then
                return self:Save()
            end
            return true
        end

        function SimpleUI.SaveManager:GetBinding(options, componentType, label)
            options = options or {}
            local saveConfig = options.Save
            if saveConfig == nil then
                saveConfig = options.Persist
            end

            local enabled = false
            local key = options.SaveKey or options.Flag
            local applyCallback = true

            if type(saveConfig) == "table" then
                enabled = saveConfig.Enabled ~= false
                key = saveConfig.Key or saveConfig.Flag or saveConfig.Name or key
                if saveConfig.ApplyCallback ~= nil then
                    applyCallback = saveConfig.ApplyCallback == true
                end
            elseif saveConfig == true then
                enabled = true
            end

            if not enabled then
                return {
                    Enabled = false,
                    HasValue = false,
                    ApplyCallback = false
                }
            end

            key = key or (tostring(componentType or "Component") .. ":" .. sanitizeKey(label))
            self:Load()

            return {
                Enabled = self.Enabled and self:IsAvailable(),
                Key = key,
                HasValue = self.Values[key] ~= nil,
                Value = self.Values[key],
                ApplyCallback = applyCallback
            }
        end

        function SimpleUI.SaveManager:WriteBinding(binding, value)
            if not binding or not binding.Enabled or not binding.Key then
                return false
            end
            if value == nil then
                return self:Remove(binding.Key)
            end
            return self:Set(binding.Key, value)
        end
    end

    SimpleUI.ThemeManager = {}
    do
        function SimpleUI.ThemeManager:Initialize(Window)
            local EH = SimpleUI.ErrorHandler
            if not EH:ValidateType(Window, "table", "Window", "ThemeManager:Initialize") then
                return false
            end
            Window.ThemeData = {
                Elements = {},
                CurrentTheme = Window.Theme or SimpleUI.Themes.DefaultTheme
            }
            return true
        end

        function SimpleUI.ThemeManager:GetCurrentTheme(Window)
            local EH = SimpleUI.ErrorHandler
            if not Window then
                EH:Guard(false, "ThemeManager:GetCurrentTheme", "Window is nil, using DefaultTheme", EH.Levels.WARN)
                return SimpleUI.Themes.DefaultTheme
            end
            if not Window.ThemeData then
                EH:Guard(false, "ThemeManager:GetCurrentTheme", "ThemeData not initialized, using DefaultTheme",
                    EH.Levels.WARN)
                return SimpleUI.Themes.DefaultTheme
            end
            return Window.ThemeData.CurrentTheme
        end

        function SimpleUI.ThemeManager:RegisterElement(Window, Element, Bindings)
            local EH = SimpleUI.ErrorHandler
            if not Window or not Window.ThemeData then
                EH:Guard(false, "ThemeManager:RegisterElement", "Invalid window", EH.Levels.WARN)
                return false
            end
            if not Element then
                EH:Guard(false, "ThemeManager:RegisterElement", "Element is nil", EH.Levels.WARN)
                return false
            end
            if not EH:ValidateType(Bindings, "table", "Bindings", "ThemeManager:RegisterElement") then
                return false
            end
            for Property, ThemeKey in pairs(Bindings) do
                if EH:ValidateType(Property, "string", "Property", "ThemeManager:RegisterElement") then
                    local found = false
                    for _, existing in ipairs(Window.ThemeData.Elements) do
                        if existing.Element == Element and existing.Property == Property then
                            existing.ThemeKey = ThemeKey
                            found = true
                            break
                        end
                    end
                    if not found then
                        table.insert(Window.ThemeData.Elements, {
                            Element = Element,
                            Property = Property,
                            ThemeKey = ThemeKey
                        })
                    end
                end
            end
            return true
        end

        function SimpleUI.ThemeManager:RegisterMultiple(Window, Elements)
            local EH = SimpleUI.ErrorHandler
            if not Window then
                EH:Guard(false, "ThemeManager:RegisterMultiple", "Window is nil", EH.Levels.WARN)
                return false
            end
            if not EH:ValidateType(Elements, "table", "Elements", "ThemeManager:RegisterMultiple") then
                return false
            end
            for Element, Bindings in pairs(Elements) do
                EH:Try(function()
                    self:RegisterElement(Window, Element, Bindings)
                end)
            end
            return true
        end

        function SimpleUI.ThemeManager:ApplyToElement(Element, Property, ThemeKey, Theme, Animate)
            local EH = SimpleUI.ErrorHandler
            if not Element or not Element.Parent then
                return false
            end
            if type(ThemeKey) == "function" then
                return EH:Try(function()
                    ThemeKey(Element, Theme)
                    return true
                end, function()
                    return false
                end)
            end
            if not EH:ValidateType(Property, "string", "Property", "ThemeManager:ApplyToElement") then
                return false
            end
            local Value = Theme[ThemeKey]
            if Value == nil then
                EH:Guard(false, "ThemeManager:ApplyToElement",
                    string.format("Theme key '%s' not found", tostring(ThemeKey)), EH.Levels.WARN)
                return false
            end
            return EH:Try(function()
                if Animate and (Property:find("Color") or Property:find("Transparency")) then
                    TweenService:Create(Element,
                        TweenInfo.new(SimpleUI.Constants.Animation.Normal, Enum.EasingStyle.Quad), {
                            [Property] = Value
                        }):Play()
                else
                    Element[Property] = Value
                end
                return true
            end, function()
                EH:Guard(false, "ThemeManager:ApplyToElement", string.format("Failed to apply property '%s'", Property),
                    EH.Levels.WARN)
                return false
            end)
        end

        function SimpleUI.ThemeManager:SetTheme(Window, ThemeName, Animate)
            local EH = SimpleUI.ErrorHandler
            if not Window or not Window.ThemeData then
                EH:Guard(false, "ThemeManager:SetTheme", "Invalid window", EH.Levels.ERROR)
                return false
            end
            if not EH:ValidateType(ThemeName, "string", "ThemeName", "ThemeManager:SetTheme") then
                return false
            end
            local NewTheme = SimpleUI.Themes[ThemeName]
            if not NewTheme then
                EH:Guard(false, "ThemeManager:SetTheme", string.format("Theme '%s' not found", ThemeName),
                    EH.Levels.ERROR)
                return false
            end
            Window.ThemeData.CurrentTheme = NewTheme
            Window.Theme = NewTheme
            local alive = {}
            for _, Entry in ipairs(Window.ThemeData.Elements) do
                if Entry.Element and Entry.Element.Parent then
                    table.insert(alive, Entry)
                end
            end
            Window.ThemeData.Elements = alive
            local ProcessedElements = {}
            for _, Entry in ipairs(Window.ThemeData.Elements) do
                local Element = Entry.Element
                local Property = Entry.Property
                ProcessedElements[Element] = ProcessedElements[Element] or {}
                if not ProcessedElements[Element][Property] then
                    ProcessedElements[Element][Property] = true
                    EH:Try(function()
                        if type(Entry.ThemeKey) == "function" then
                            Entry.ThemeKey(Element, NewTheme)
                        else
                            self:ApplyToElement(Element, Property, Entry.ThemeKey, NewTheme, Animate)
                        end
                    end)
                end
            end
            return true
        end

        function SimpleUI.ThemeManager:GetThemeName(Window)
            local EH = SimpleUI.ErrorHandler
            if not Window or not Window.ThemeData then
                EH:Guard(false, "ThemeManager:GetThemeName", "Invalid window, defaulting to Secondary", EH.Levels.WARN)
                return "Secondary"
            end
            for Name, Theme in pairs(SimpleUI.Themes) do
                if Theme == Window.ThemeData.CurrentTheme then
                    return Name
                end
            end
            EH:Guard(false, "ThemeManager:GetThemeName", "Theme not found in registry, defaulting to Secondary",
                EH.Levels.WARN)
            return "Secondary"
        end
    end

    SimpleUI.ScrollManager = {}
    do
        function SimpleUI.ScrollManager:Update(Container)
            local EH = SimpleUI.ErrorHandler
            if not Container or not Container.Parent then
                return Container
            end
            if not (Container:IsA("Frame") or Container:IsA("ScrollingFrame")) then
                EH:Guard(false, "ScrollManager:Update", "Container must be Frame or ScrollingFrame", EH.Levels.WARN)
                return Container
            end
            local Layout = Container:FindFirstChildWhichIsA("UIListLayout")
            if not Layout then
                return Container
            end
            local Parent = Container.Parent
            if not Parent then
                return Container
            end
            local ContentHeight = Layout.AbsoluteContentSize.Y
            local AvailableHeight = Container.AbsoluteSize.Y
            local NeedsScrolling = ContentHeight > AvailableHeight
            local IsScrollFrame = Container:IsA("ScrollingFrame")
            if NeedsScrolling and not IsScrollFrame then
                local ScrollFrame = SimpleUI.Utility:CreateInstance("ScrollingFrame", {
                    Name = Container.Name,
                    Position = Container.Position,
                    Size = Container.Size,
                    AnchorPoint = Container.AnchorPoint,
                    BackgroundColor3 = Container.BackgroundColor3,
                    BackgroundTransparency = Container.BackgroundTransparency,
                    BorderSizePixel = 0,
                    BorderMode = Enum.BorderMode.Inset,
                    ZIndex = Container.ZIndex,
                    LayoutOrder = Container.LayoutOrder,
                    Visible = Container.Visible,
                    ClipsDescendants = true,
                    ScrollBarThickness = 0,
                    ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200),
                    ScrollBarImageTransparency = 1,
                    ScrollingDirection = Enum.ScrollingDirection.Y,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
                    ScrollingEnabled = true,
                    Active = true
                }, Parent)
                for _, Child in ipairs(Container:GetChildren()) do
                    Child.Parent = ScrollFrame
                end
                local ScreenGui = Parent
                while ScreenGui and not ScreenGui:IsA("ScreenGui") do
                    ScreenGui = ScreenGui.Parent
                end
                if ScreenGui and SimpleUI.Windows[ScreenGui] then
                    local Window = SimpleUI.Windows[ScreenGui]
                    if Window.Elements and Window.Elements.Pages then
                        for PageName, Page in pairs(Window.Elements.Pages) do
                            if Page == Container then
                                Window.Elements.Pages[PageName] = ScrollFrame
                                break
                            end
                        end
                    end
                    if Window.ActivePage == Container then
                        Window.ActivePage = ScrollFrame
                    end
                    if Window.Elements.TabsContainer == Container then
                        Window.Elements.TabsContainer = ScrollFrame
                    end
                end
                Container:Destroy()
                Container = ScrollFrame
            elseif not NeedsScrolling and IsScrollFrame then
                Container.ScrollBarThickness = 0
            elseif NeedsScrolling and IsScrollFrame then
                Container.ScrollBarImageTransparency = 1
            end
            if Layout and not Layout:GetAttribute("ScrollUpdateHooked") then
                Layout:SetAttribute("ScrollUpdateHooked", true)
                local UpdateQueued = false
                local LastContentSize = Layout.AbsoluteContentSize
                Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    if UpdateQueued or Layout.AbsoluteContentSize == LastContentSize then
                        return
                    end
                    LastContentSize = Layout.AbsoluteContentSize
                    UpdateQueued = true
                    task.defer(function()
                        UpdateQueued = false
                        if Container and Container.Parent then
                            SimpleUI.ScrollManager:Update(Container)
                        end
                    end)
                end)
            end
            return Container
        end
    end

    SimpleUI.WindowControlBuilder = {}
    do
        function SimpleUI.WindowControlBuilder:Create(ControlType, Style, Parent, Index, TotalControls)
            local Config = SimpleUI.WindowControls[Style]
            if not Config then
                return
            end
            local IconData = Config.Icons and Config.Icons[ControlType] or {}
            local Alignment = Config.Alignment or "Right"
            local BaseColor = Config.Colors and Config.Colors[ControlType] or Color3.fromRGB(45, 45, 45)
            local Spacing = Config.ButtonSpacing or 0
            local IsMobile = SimpleUI.Utility:IsMobile()
            local Position = Alignment == "Left" and
                                 UDim2.new(0, Index * (Config.ButtonSize.X.Offset + Spacing), 0.5, 0) or
                                 UDim2.new(1, -(TotalControls - Index) * (Config.ButtonSize.X.Offset + Spacing), 0.5, 0)
            local Button = SimpleUI.Utility:CreateInstance("TextButton", {
                Name = ControlType .. "Button",
                Size = Config.ButtonSize,
                Position = Position,
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = BaseColor,
                BackgroundTransparency = Config.Transparency or 0,
                Text = "",
                BorderSizePixel = 0,
                ClipsDescendants = true,
                AutoButtonColor = false,
                ZIndex = SimpleUI.Constants.ZIndex.Control
            }, Parent)
            if Config.UseImages and IconData.Image then
                SimpleUI.Utility:CreateInstance("ImageLabel", {
                    Size = IconData.Size or UDim2.new(0, 12, 0, 12),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    Image = IconData.Image,
                    ImageColor3 = IconData.Color or Color3.fromRGB(255, 255, 255),
                    ZIndex = SimpleUI.Constants.ZIndex.Control + 1
                }, Button)
            end
            SimpleUI.Utility:CreateInstance("UICorner", {
                CornerRadius = Alignment == "Left" and UDim.new(1, 0) or UDim.new(0, 0)
            }, Button)
            if not IsMobile then
                if IconData.HoverColor then
                    local IsHovering = false
                    Button.MouseEnter:Connect(function()
                        IsHovering = true
                        Button.BackgroundColor3 = IconData.HoverColor
                    end)
                    Button.MouseLeave:Connect(function()
                        IsHovering = false
                        Button.BackgroundColor3 = BaseColor
                    end)
                    if IconData.PressedColor then
                        Button.Activated:Connect(function()
                            Button.BackgroundColor3 = IconData.PressedColor
                            task.wait(0.1)
                            Button.BackgroundColor3 = IsHovering and IconData.HoverColor or BaseColor
                        end)
                    end
                end
            elseif IconData.PressedColor then
                Button.Activated:Connect(function()
                    Button.BackgroundColor3 = IconData.PressedColor
                    task.wait(0.1)
                    Button.BackgroundColor3 = BaseColor
                end)
            end
            self:BindActions(Button, ControlType, Parent)
            return Button
        end

        function SimpleUI.WindowControlBuilder:BindActions(Button, ControlType, TopBar)
            local EH = SimpleUI.ErrorHandler
            local ParentFrame = TopBar.Parent
            if not ParentFrame or not TopBar then
                EH:Guard(false, "WindowControlBuilder:BindActions", "Invalid frame references", EH.Levels.ERROR)
                return
            end
            if ControlType == "Close" then
                Button.Activated:Connect(function()
                    local ScreenGui = ParentFrame.Parent.Parent
                    if not ScreenGui then
                        return
                    end

                    local FadeDuration = SimpleUI.Constants.Animation.Slow
                    local TweenInfo = TweenInfo.new(FadeDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                    local Tweens = {}

                    for _, Object in ipairs(ScreenGui:GetDescendants()) do
                        if Object:IsA("GuiObject") then
                            local Properties = {
                                Position = UDim2.new(Object.Position.X.Scale - 1.5, Object.Position.X.Offset,
                                    Object.Position.Y.Scale, Object.Position.Y.Offset)
                            }

                            if Object:IsA("Frame") or Object:IsA("ScrollingFrame") or Object:IsA("TextButton") or
                                Object:IsA("TextLabel") then
                                Properties.BackgroundTransparency = 1
                            end
                            if Object:IsA("TextButton") or Object:IsA("TextLabel") then
                                Properties.TextTransparency = 1
                            end
                            if Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
                                Properties.ImageTransparency = 1
                            end

                            table.insert(Tweens, TweenService:Create(Object, TweenInfo, Properties))
                        end
                    end

                    for _, Tween in ipairs(Tweens) do
                        Tween:Play()
                    end

                    task.delay(FadeDuration, function()
                        SimpleUI.Windows[ScreenGui] = nil
                        ScreenGui:Destroy()
                    end)
                end)
            end
            if ControlType == "Maximize" then
                Button.Activated:Connect(function()
                    local ScreenGui = ParentFrame.Parent.Parent
                    if not ScreenGui then
                        return
                    end
                    local MainFrame = ScreenGui:FindFirstChild("MainFrame")
                    if not MainFrame then
                        return
                    end
                    if not MainFrame:GetAttribute("OriginalSize") then
                        MainFrame:SetAttribute("OriginalSize", MainFrame.Size)
                        MainFrame:SetAttribute("OriginalPosition", MainFrame.Position)
                        MainFrame:SetAttribute("OriginalAnchorPoint", MainFrame.AnchorPoint)
                    end
                    local IsMaximized = MainFrame:GetAttribute("Maximized") or false
                    MainFrame:SetAttribute("Maximized", not IsMaximized)

                    local TargetSize, TargetPosition, TargetAnchor
                    if not IsMaximized then
                        TargetSize = UDim2.new(0.95, 0, 0.95, 0)
                        TargetPosition = UDim2.new(0.5, 0, 0.5, 0)
                        TargetAnchor = Vector2.new(0.5, 0.5)
                    else
                        TargetSize = MainFrame:GetAttribute("OriginalSize")
                        TargetPosition = MainFrame:GetAttribute("OriginalPosition")
                        TargetAnchor = MainFrame:GetAttribute("OriginalAnchorPoint")
                    end

                    MainFrame.AnchorPoint = TargetAnchor
                    TweenService:Create(MainFrame, TweenInfo.new(SimpleUI.Constants.Animation.Normal,
                        Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = TargetSize,
                        Position = TargetPosition
                    }):Play()
                end)
            end
        end

        function SimpleUI.WindowControlBuilder:RegisterIconBindings(Window, ControlButtons, Options)
            local ControlStyle = Options.ControlStyle or "Windows"
            local Config = SimpleUI.WindowControls[ControlStyle]
            if not Config or not Config.Icons then
                return
            end
            local CurrentTheme = SimpleUI.ThemeManager:GetCurrentTheme(Window)
            for ControlType, Button in pairs(ControlButtons) do
                local IconData = Config.Icons[ControlType]
                if IconData and IconData.ColorKey then
                    local Icon = Button:FindFirstChildWhichIsA("ImageLabel")
                    if Icon then
                        local ColorValue = CurrentTheme[IconData.ColorKey]
                        if ColorValue then
                            Icon.ImageColor3 = ColorValue
                        end
                        SimpleUI.ThemeManager:RegisterElement(Window, Icon, {
                            ImageColor3 = function(Element, Theme)
                                local NewColorValue = Theme[IconData.ColorKey]
                                if NewColorValue then
                                    Element.ImageColor3 = NewColorValue
                                end
                            end
                        })
                    end
                end
            end
        end
    end

    SimpleUI.ComponentBuilder = {}
    do
        function SimpleUI.ComponentBuilder:CreateContainer(Config, Theme)
            if not SimpleUI.ErrorHandler:ValidateInstance(Config.Parent, "GuiObject", "ComponentBuilder:CreateContainer") then
                return nil
            end
            local IsDualScroll = Config.Parent:GetAttribute("IsDualScroll") or false
            local Container = SimpleUI.Utility:CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = Theme[Config.ColorTier or "Secondary"],
                BackgroundTransparency = Theme.TransparencySecondary,
                BorderSizePixel = 0,
                ZIndex = SimpleUI.Constants.ZIndex.Control
            }, Config.Parent)
            if Config.MinHeight then
                SimpleUI.Utility:CreateInstance("UISizeConstraint", {
                    MinSize = Vector2.new(0, Config.MinHeight)
                }, Container)
            end
            if Config.CornerRadius then
                SimpleUI.Utility:CreateInstance("UICorner", {
                    CornerRadius = UDim.new(0, Config.CornerRadius)
                }, Container)
            end
            local Padding = Config.Padding or {}
            if type(Padding) == "number" then
                Padding = {
                    Top = Padding,
                    Bottom = Padding,
                    Left = Padding,
                    Right = Padding
                }
            end
            if type(Padding) == "table" then
                for key, value in pairs(Padding) do
                    if type(value) ~= "number" then
                        Padding[key] = SimpleUI.Constants.Padding.Medium
                    end
                end
            end
            SimpleUI.Utility:CreateInstance("UIPadding", {
                PaddingTop = UDim.new(0, Padding.Top or SimpleUI.Constants.Padding.Medium),
                PaddingBottom = UDim.new(0, Padding.Bottom or SimpleUI.Constants.Padding.Medium),
                PaddingLeft = UDim.new(0, Padding.Left or SimpleUI.Constants.Padding.Large),
                PaddingRight = UDim.new(0, IsDualScroll and -8 or (Padding.Right or SimpleUI.Constants.Padding.Medium))
            }, Container)
            local TextZone, InteractiveZone, Layout
            if Config.Layout == "TextLeft" then
                TextZone = SimpleUI.Utility:CreateInstance("Frame", {
                    Size = UDim2.new(Config.TextWidth or 0.65, 0, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 1,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay
                }, Container)
                Layout = SimpleUI.Utility:CreateInstance("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    VerticalAlignment = Config.HasDescription and Enum.VerticalAlignment.Top or
                        Enum.VerticalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, SimpleUI.Constants.Spacing.Relaxed)
                }, TextZone)
                InteractiveZone = Container
            elseif Config.Layout == "Stacked" then
                local ContentFrame = SimpleUI.Utility:CreateInstance("Frame", {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay
                }, Container)
                Layout = SimpleUI.Utility:CreateInstance("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, Config.Spacing or SimpleUI.Constants.Spacing.Normal)
                }, ContentFrame)
                if not Config.HasDescription then
                    ContentFrame.Position = UDim2.new(0, 0, 0.5, 0)
                    ContentFrame.AnchorPoint = Vector2.new(0, 0.5)
                end
                TextZone = ContentFrame
                InteractiveZone = ContentFrame
            else
                TextZone = Container
                InteractiveZone = Container
            end
            return {
                Container = Container,
                TextZone = TextZone,
                InteractiveZone = InteractiveZone,
                Layout = Layout
            }
        end

        function SimpleUI.ComponentBuilder:CreateLabel(Parent, Text, Theme, Config)
            Config = Config or {}
            if Config and
                not SimpleUI.ErrorHandler:ValidateType(Config, "table", "Config", "ComponentBuilder:CreateLabel") then
                Config = {}
            end
            return SimpleUI.Utility:CreateInstance("TextLabel", {
                Size = UDim2.new(1, Config.WidthOffset or 0, 0, 0),
                BackgroundTransparency = 1,
                Text = Text or "",
                TextColor3 = Theme[Config.ColorTier or "TextPrimary"],
                TextSize = Config.Size or 14,
                Font = Theme[Config.Font or "FontSecondary"],
                TextXAlignment = Config.Align or Enum.TextXAlignment.Left,
                TextWrapped = true,
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = Config.Order or 1,
                ZIndex = SimpleUI.Constants.ZIndex.Overlay
            }, Parent)
        end

        function SimpleUI.ComponentBuilder:CreateDescription(Parent, Text, Theme, Order)
            if not Text or Text == "" then
                return nil
            end
            return self:CreateLabel(Parent, Text, Theme, {
                ColorTier = "TextSecondary",
                Size = 14,
                Order = Order or 2
            })
        end

        function SimpleUI.ComponentBuilder:UpdateDescriptionPadding(Zones, HasDescription)
            local Padding = Zones.Container:FindFirstChildOfClass("UIPadding")
            if not Padding then
                return
            end
            if HasDescription then
                Padding.PaddingTop = UDim.new(0, SimpleUI.Constants.Padding.Large)
                Padding.PaddingBottom = UDim.new(0, SimpleUI.Constants.Padding.Large)
                if Zones.Layout then
                    Zones.Layout.Padding = UDim.new(0, SimpleUI.Constants.Spacing.Tight)
                end
                if Zones.TextZone then
                    Zones.TextZone.Position = UDim2.new(0, 0, 0, 0)
                    Zones.TextZone.AnchorPoint = Vector2.new(0, 0)
                end
            else
                Padding.PaddingTop = UDim.new(0, 0)
                Padding.PaddingBottom = UDim.new(0, 0)
                if Zones.Layout then
                    Zones.Layout.Padding = UDim.new(0, 0)
                end
                if Zones.TextZone then
                    Zones.TextZone.Position = UDim2.new(0, 0, 0.5, 0)
                    Zones.TextZone.AnchorPoint = Vector2.new(0, 0.5)
                end
            end
        end
    end

    SimpleUI.DropdownManager = {}
    do
        function SimpleUI.DropdownManager:NormalizeOptions(Options)
            local EH = SimpleUI.ErrorHandler
            if not EH:ValidateType(Options, "table", "Options", "DropdownManager:NormalizeOptions") then
                return {}, {}
            end
            local Normalized = {}
            local DataMap = {}
            for Index, Option in ipairs(Options) do
                if type(Option) == "table" then
                    local DisplayText = Option.Text or Option.text or Option.Label or Option.label or tostring(Option)
                    Normalized[Index] = DisplayText
                    DataMap[DisplayText] = Option
                else
                    Normalized[Index] = tostring(Option)
                    DataMap[tostring(Option)] = Option
                end
            end
            return Normalized, DataMap
        end

        function SimpleUI.DropdownManager:InitializeSelection(DefaultValue, IsMultiSelect, DataMap)
            local EH = SimpleUI.ErrorHandler
            if IsMultiSelect then
                local Selected = {}
                if type(DefaultValue) == "table" then
                    if not EH:ValidateType(DefaultValue, "table", "DefaultValue", "DropdownManager:InitializeSelection") then
                        return Selected
                    end
                    for _, Value in ipairs(DefaultValue) do
                        local Normalized = type(Value) == "table" and
                                               (Value.Text or Value.text or Value.Label or Value.label or
                                                   tostring(Value)) or tostring(Value)
                        if DataMap[Normalized] then
                            Selected[Normalized] = true
                        end
                    end
                end
                return Selected
            else
                if DefaultValue then
                    local Normalized = type(DefaultValue) == "table" and
                                           (DefaultValue.Text or DefaultValue.text or DefaultValue.Label or
                                               DefaultValue.label or tostring(DefaultValue)) or tostring(DefaultValue)
                    return DataMap[Normalized] and Normalized or nil
                end
                return nil
            end
        end

        function SimpleUI.DropdownManager:GetSelectedData(Selection, IsMultiSelect, DataMap)
            if IsMultiSelect then
                local Selected = {}
                for Value, Enabled in pairs(Selection) do
                    if Enabled then
                        table.insert(Selected, DataMap[Value])
                    end
                end
                return Selected
            else
                return DataMap[Selection]
            end
        end

        function SimpleUI.DropdownManager:UpdateDisplayText(DisplayLabel, Selection, IsMultiSelect)
            local EH = SimpleUI.ErrorHandler
            if not DisplayLabel or not DisplayLabel.Parent then
                EH:Guard(false, "DropdownManager:UpdateDisplayText", "Invalid DisplayLabel", EH.Levels.WARN)
                return
            end
            EH:Try(function()
                if IsMultiSelect then
                    local Selected = {}
                    for Value, Enabled in pairs(Selection) do
                        if Enabled then
                            table.insert(Selected, Value)
                        end
                    end
                    DisplayLabel.Text = #Selected > 0 and table.concat(Selected, ", ") or "Select"
                else
                    DisplayLabel.Text = Selection or "Select"
                end
            end)
        end
    end

    SimpleUI.WindowBuilder = {}
    do
        function SimpleUI.WindowBuilder:CreateMainFrame(ScreenGui, Options, Theme)
            local MainFrameProperties, MainFrameBindings = SimpleUI.Utility:ApplyTheme({
                Name = "MainFrame",
                AnchorPoint = Vector2.new(0.5, 0.5),
                Active = true,
                AutoButtonColor = false,
                Position = Options.Position or UDim2.new(0.5, 0, 0.5, 0),
                Size = Options.Size or UDim2.new(0, 650, 0, 600),
                Text = "",
                BorderSizePixel = 0,
                ClipsDescendants = false
            }, {
                BackgroundColor3 = "Primary",
                BackgroundTransparency = "TransparencyPrimary"
            }, Theme)
            local MainFrame = SimpleUI.Utility:CreateInstance("TextButton", MainFrameProperties, ScreenGui)
            SimpleUI.Utility:CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, SimpleUI.Constants.Corner.Large)
            }, MainFrame)
            SimpleUI.Utility:CreateInstance("UISizeConstraint", {
                MinSize = Options.MinSize or SimpleUI.Constants.Window.MinSize,
                MaxSize = Options.MaxSize or SimpleUI.Constants.Window.MaxSize
            }, MainFrame)
            local UIScale = SimpleUI.Utility:CreateInstance("UIScale", {
                Name = "WindowScale",
                Scale = Options.DefaultScale or SimpleUI.Constants.Window.DefaultScale
            }, MainFrame)
            return MainFrame, UIScale, MainFrameBindings
        end

        function SimpleUI.WindowBuilder:CreateTopBar(Parent, Options, Theme)
            local TopBarHeight = Options.TopBarHeight or SimpleUI.Constants.Window.TopBarHeight
            local TopBar = SimpleUI.Utility:CreateInstance("Frame", {
                Name = "TopBar",
                Size = UDim2.new(1, 0, 0, TopBarHeight),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ZIndex = SimpleUI.Constants.ZIndex.Base,
                ClipsDescendants = false,
                Active = true
            }, Parent)
            local Sep
            local SepBindings
            local SepProps
            if Options.TopBarSeparator ~= false then
                SepProps, SepBindings = SimpleUI.Utility:ApplyTheme({
                    Name = "TopBarSeparator",
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, 0),
                    Size = UDim2.new(1, 0, 0, 1),
                    BorderSizePixel = 0,
                    ZIndex = TopBar.ZIndex + 1
                }, {
                    BackgroundColor3 = "Separator",
                    BackgroundTransparency = "SeparatorTransparency"
                }, Theme)
                Sep = SimpleUI.Utility:CreateInstance("Frame", SepProps, TopBar)
            end
            return TopBar, Sep, SepBindings
        end

        function SimpleUI.WindowBuilder:CreateTitleSection(TopBar, Options, Theme)
            local ControlStyle = Options.ControlStyle or "Windows"
            local HasBrand = Options.Brand ~= nil
            local BrandName = HasBrand and Options.Brand.Name or ""
            local BrandIcon = HasBrand and Options.Brand.Icon or nil

            local BaseLeftOffset = 10
            local IconSize = 40
            local IconGap = 12

            local BrandIconElement = nil
            local BrandInitialElement = nil

            if HasBrand then
                if BrandIcon and type(BrandIcon) == "table" and BrandIcon.Image then
                    local IconData = SimpleUI.IconManager:WrapIcon(BrandIcon)
                    BrandIconElement = SimpleUI.Utility:CreateInstance("ImageLabel", {
                        Name = "BrandIcon",
                        Size = UDim2.new(0, IconSize, 0, IconSize),
                        Position = UDim2.new(0, BaseLeftOffset, 0.5, 0),
                        AnchorPoint = Vector2.new(0, 0.5),
                        BackgroundTransparency = 1,
                        Image = IconData.Url,
                        ImageColor3 = Theme.TextPrimary,
                        ScaleType = Enum.ScaleType.Fit,
                        BorderSizePixel = 0,
                        ZIndex = SimpleUI.Constants.ZIndex.Content + 1
                    }, TopBar)
                else
                    local Initials = BrandName:sub(1, 1):upper()
                    BrandInitialElement = SimpleUI.Utility:CreateInstance("TextLabel", {
                        Name = "BrandInitial",
                        Size = UDim2.new(0, IconSize, 0, IconSize),
                        Position = UDim2.new(0, BaseLeftOffset, 0.5, 0),
                        AnchorPoint = Vector2.new(0, 0.5),
                        BackgroundTransparency = 1,
                        Text = Initials,
                        TextColor3 = Theme.TextPrimary,
                        Font = Enum.Font.GothamBold,
                        TextSize = 42,
                        BorderSizePixel = 0,
                        ZIndex = SimpleUI.Constants.ZIndex.Content
                    }, TopBar)
                end
            end

            local BrandTitleLabel = nil
            if HasBrand and BrandName and BrandName ~= "" then
                BrandTitleLabel = SimpleUI.Utility:CreateInstance("TextLabel", {
                    Name = "BrandTitle",
                    Size = UDim2.new(0, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    Position = UDim2.new(0, BaseLeftOffset + IconSize + IconGap, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundTransparency = 1,
                    Text = BrandName,
                    TextColor3 = Theme.TextPrimary,
                    Font = Theme.FontPrimary,
                    TextSize = 16,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextTransparency = 1,
                    ZIndex = SimpleUI.Constants.ZIndex.Content
                }, TopBar)

                SimpleUI.Utility:CreateInstance("UISizeConstraint", {
                    MaxSize = Vector2.new(200, math.huge)
                }, BrandTitleLabel)
            end

            local TabInfoContainer = SimpleUI.Utility:CreateInstance("Frame", {
                Name = "TabInfoContainer",
                Position = UDim2.new(0, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, 0, 0.7, 0),
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundTransparency = 1,
                ZIndex = SimpleUI.Constants.ZIndex.Content,
                ClipsDescendants = true,
                Visible = true
            }, TopBar)

            SimpleUI.Utility:CreateInstance("UIPadding", {
                PaddingLeft = UDim.new(0, 12),
                PaddingRight = UDim.new(0, 200)
            }, TabInfoContainer)

            SimpleUI.Utility:CreateInstance("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                Padding = UDim.new(0, 2)
            }, TabInfoContainer)

            local TabNameLabel = SimpleUI.Utility:CreateInstance("TextLabel", {
                Name = "TabNameLabel",
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = "Select Tab",
                TextColor3 = Theme.TextPrimary,
                Font = Theme.FontPrimary,
                TextSize = 16,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                LayoutOrder = 1,
                ZIndex = SimpleUI.Constants.ZIndex.Content
            }, TabInfoContainer)

            local TabDescLabel = SimpleUI.Utility:CreateInstance("TextLabel", {
                Name = "TabDescLabel",
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = "",
                TextColor3 = Theme.TextSecondary,
                Font = Theme.FontSecondary,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                LayoutOrder = 2,
                ZIndex = SimpleUI.Constants.ZIndex.Content
            }, TabInfoContainer)

            local ControlsContainer = SimpleUI.Utility:CreateInstance("Frame", {
                Name = "ControlsContainer",
                Position = UDim2.new(1, -10, 0.5, 0),
                AnchorPoint = Vector2.new(1, 0.5),
                Size = UDim2.new(0, 100, 0.7, 0),
                BackgroundTransparency = 1,
                ZIndex = SimpleUI.Constants.ZIndex.Content,
                ClipsDescendants = false
            }, TopBar)

            return TabInfoContainer, ControlsContainer, TabNameLabel, TabDescLabel, BrandIconElement,
                BrandInitialElement, BrandTitleLabel
        end

        function SimpleUI.WindowBuilder:CreateWindowControls(ControlsContainer, Options, Theme)
            local ControlStyle = Options.ControlStyle or "Windows"
            local Controls = Options.WindowControls or
                                 (ControlStyle == "Windows" and {"Maximize", "Close"} or {"Close", "Maximize"})
            local ControlButtons = {}
            if Controls then
                for Index, ControlType in ipairs(Controls) do
                    local Button = SimpleUI.WindowControlBuilder:Create(ControlType, ControlStyle, ControlsContainer,
                        Index - 1, #Controls)
                    if Button then
                        ControlButtons[ControlType] = Button
                    end
                end
            end
            return ControlButtons
        end

        function SimpleUI.WindowBuilder:CreateContentAreas(MainContainer, MainFrame, TopBar, Options)
            local Const = SimpleUI.Constants.Window
            local TabsWidth = Const.TabsWidthOpen
            local ContentWidth = Const.ContentWidthOpen
            local IsCollapsed = Options.IsCollapsed
            local HorizontalPadding = IsCollapsed and 4 or Options.HorizontalPadding or Const.HorizontalPadding
            local HasBrand = Options.Brand ~= nil

            local TabsContainer = SimpleUI.Utility:CreateInstance("ScrollingFrame", {
                Name = "TabsContainer",
                Position = UDim2.new(0, HorizontalPadding, 0, 0),
                Size = UDim2.new(TabsWidth, -(HorizontalPadding * 1.5), 1, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ZIndex = SimpleUI.Constants.ZIndex.Content,
                ClipsDescendants = true,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ScrollBarThickness = 0,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y
            }, MainContainer)
            SimpleUI.Utility:CreateInstance("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, SimpleUI.Constants.Padding.Large)
            }, TabsContainer)
            SimpleUI.Utility:CreateInstance("UIPadding", {
                PaddingTop = UDim.new(0, 0),
                PaddingBottom = UDim.new(0, 0),
                PaddingLeft = UDim.new(0, 2),
                PaddingRight = UDim.new(0, 1)
            }, TabsContainer)
            local Theme = SimpleUI.ThemeManager:GetCurrentTheme({
                ThemeData = {
                    CurrentTheme = SimpleUI.Themes.DefaultTheme
                }
            })
            local TabsSeparatorProperties, TabsSeparatorBindings = SimpleUI.Utility:ApplyTheme({
                Name = "TabsSeparator",
                Position = UDim2.new(TabsWidth, Const.TabSeparatorGap, 0, HasBrand and 0 or Const.TopBarHeight),
                Size = UDim2.new(0, 1, 1, HasBrand and 0 or -Const.TopBarHeight),
                BorderSizePixel = 0,
                ZIndex = SimpleUI.Constants.ZIndex.Content
            }, {
                BackgroundColor3 = "Separator",
                BackgroundTransparency = "SeparatorTransparency"
            }, Theme)
            local TabsSeparator = SimpleUI.Utility:CreateInstance("Frame", TabsSeparatorProperties, MainFrame)
            local ContentsContainer = SimpleUI.Utility:CreateInstance("Frame", {
                Name = "ContentsContainer",
                Position = UDim2.new(TabsWidth, HorizontalPadding, 0, 0),
                Size = UDim2.new(ContentWidth, -(HorizontalPadding * 2), 1, 0),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                ZIndex = SimpleUI.Constants.ZIndex.Content,
                ClipsDescendants = true
            }, MainContainer)
            SimpleUI.Utility:CreateInstance("UIPadding", {
                PaddingBottom = UDim.new(0, SimpleUI.Constants.Padding.Large),
                PaddingLeft = UDim.new(0, SimpleUI.Constants.Padding.Large),
                PaddingRight = UDim.new(0, SimpleUI.Constants.Padding.Large)
            }, ContentsContainer)
            return TabsContainer, ContentsContainer, TabsSeparator, TabsSeparatorBindings
        end

        function SimpleUI.WindowBuilder:CreateMainContainer(Parent, Options, Theme, TopBarHeight, FooterHeight)
            local VerticalPadding = Options.VerticalPadding or SimpleUI.Constants.Window.VerticalPadding
            local FooterOffset = (FooterHeight and FooterHeight > 0) and -(Options.FooterOverlap or 0) or 0
            local MainContainer = SimpleUI.Utility:CreateInstance("Frame", {
                Name = "MainContainer",
                Position = UDim2.new(0, 0, 0, TopBarHeight),
                Size = UDim2.new(1, 0, 1, -(TopBarHeight + FooterOffset)),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ZIndex = SimpleUI.Constants.ZIndex.Base,
                ClipsDescendants = true
            }, Parent)
            if Options.AcrylicEffect then
                local Blur = SimpleUI.Utility:CreateInstance("Frame", {
                    Name = "BlurBackground",
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 0.3,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    ZIndex = SimpleUI.Constants.ZIndex.Background
                }, MainContainer)
                SimpleUI.Utility:CreateInstance("UICorner", {
                    CornerRadius = UDim.new(0, SimpleUI.Constants.Corner.Large)
                }, Blur)
                pcall(function()
                    local BlurEffect = Instance.new("BlurEffect")
                    BlurEffect.Size = 24
                    BlurEffect.Parent = Lighting
                end)
            end
            SimpleUI.Utility:CreateInstance("UIPadding", {
                PaddingTop = UDim.new(0, VerticalPadding),
                PaddingBottom = UDim.new(0, VerticalPadding),
                PaddingLeft = UDim.new(0, 0),
                PaddingRight = UDim.new(0, 0)
            }, MainContainer)
            return MainContainer
        end

        function SimpleUI.WindowBuilder:SetupDragging(TopBar, MainFrame)
            local IsDragging = false
            local DragStart
            local StartPosition
            TopBar.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType ==
                    Enum.UserInputType.Touch then
                    IsDragging = true
                    DragStart = Input.Position
                    StartPosition = MainFrame.Position
                    Input:GetPropertyChangedSignal("UserInputState"):Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            IsDragging = false
                        end
                    end)
                end
            end)
            UserInputService.InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType ==
                    Enum.UserInputType.Touch then
                    IsDragging = false
                end
            end)
            UserInputService.InputChanged:Connect(function(Input)
                if IsDragging and
                    (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType ==
                        Enum.UserInputType.Touch) then
                    local CurrentPosition = Input.Position
                    local Delta = CurrentPosition - DragStart
                    MainFrame.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X,
                        StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
                end
            end)
        end

        function SimpleUI.WindowBuilder:CreateFooter(Parent, Options, Theme)
            if not Options.Footer then
                return nil, {}, nil
            end
            local FooterHeight = Options.FooterHeight or 20
            local FooterOverlap = Options.FooterOverlap or -10
            local FooterProperties, FooterBindings = SimpleUI.Utility:ApplyTheme({
                Name = "Footer",
                Position = UDim2.new(0, 0, 1, FooterOverlap),
                AnchorPoint = Vector2.new(0, 0),
                Size = UDim2.new(1, 0, 0, FooterHeight),
                BorderSizePixel = 0,
                ZIndex = SimpleUI.Constants.ZIndex.Overlay,
                ClipsDescendants = false
            }, {
                BackgroundColor3 = "Secondary",
                BackgroundTransparency = "TransparencyPrimary"
            }, Theme)
            local Footer = SimpleUI.Utility:CreateInstance("Frame", FooterProperties, Parent)
            SimpleUI.Utility:CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, SimpleUI.Constants.Corner.Large)
            }, Footer)
            local SeparatorBindings = {}
            if Options.FooterSeparator ~= false then
                local SepProps, SepBindings = SimpleUI.Utility:ApplyTheme({
                    Name = "FooterSeparator",
                    Position = UDim2.new(0, 0, 1, FooterOverlap),
                    Size = UDim2.new(1, 0, 0, 1),
                    BorderSizePixel = 0,
                    ZIndex = Footer.ZIndex + 1
                }, {
                    BackgroundColor3 = "Separator",
                    BackgroundTransparency = "SeparatorTransparency"
                }, Theme)
                local Separator = SimpleUI.Utility:CreateInstance("Frame", SepProps, Parent)
                if SepBindings then
                    SeparatorBindings = {
                        Element = Separator,
                        Bindings = SepBindings
                    }
                end
            end
            local ContentFrame = SimpleUI.Utility:CreateInstance("Frame", {
                Name = "FooterContent",
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, Options.CanResize and -24 or 0, 1, 0),
                BackgroundTransparency = 1,
                ZIndex = Footer.ZIndex + 1
            }, Footer)
            SimpleUI.Utility:CreateInstance("UIPadding", {
                PaddingLeft = UDim.new(0, SimpleUI.Constants.Padding.Large),
                PaddingRight = UDim.new(0, SimpleUI.Constants.Padding.Large),
                PaddingTop = UDim.new(0, SimpleUI.Constants.Padding.Medium),
                PaddingBottom = UDim.new(0, SimpleUI.Constants.Padding.Medium)
            }, ContentFrame)
            SimpleUI.Utility:CreateInstance("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Options.FooterAlignment or Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, SimpleUI.Constants.Spacing.Normal)
            }, ContentFrame)
            local ResizeContainer
            if Options.CanResize then
                ResizeContainer = SimpleUI.Utility:CreateInstance("Frame", {
                    Name = "FooterResizeArea",
                    AnchorPoint = Vector2.new(1, 1),
                    Position = UDim2.new(1, 1, 1, 1),
                    Size = UDim2.fromOffset(20, 20),
                    BackgroundTransparency = 1,
                    ZIndex = Footer.ZIndex + 3
                }, Footer)
            end
            return Footer, FooterBindings, ContentFrame, SeparatorBindings, ResizeContainer
        end

        function SimpleUI.WindowBuilder:PopulateFooter(Window, Options, Theme)
            if not Window.Elements.FooterContent or not Options.FooterItems then
                return
            end
            for _, Item in ipairs(Options.FooterItems) do
                if Item.Type == "Text" then
                    local TextProperties, TextBindings = SimpleUI.Utility:ApplyTheme({
                        Name = Item.Name or "FooterText",
                        LayoutOrder = Item.Order or 1,
                        Size = UDim2.new(0, 0, 1, 0),
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundTransparency = 1,
                        Text = Item.Text or "",
                        TextSize = Item.TextSize or 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        ZIndex = Window.Elements.Footer.ZIndex + 2
                    }, {
                        Font = "FontSecondary",
                        TextColor3 = Item.ColorTier or "TextSecondary"
                    }, Theme)
                    local Label = SimpleUI.Utility:CreateInstance("TextLabel", TextProperties,
                        Window.Elements.FooterContent)
                    if Item.Id then
                        Window.Elements[Item.Id] = Label
                    end
                    if TextBindings then
                        SimpleUI.ThemeManager:RegisterElement(Window, Label, TextBindings)
                    end
                elseif Item.Type == "Button" then
                    local ButtonProperties, ButtonBindings = SimpleUI.Utility:ApplyTheme({
                        Name = Item.Name or Item.Text or "FooterButton",
                        LayoutOrder = Item.Order or 1,
                        Size = UDim2.new(0, Item.Width or 80, 1, -8),
                        Text = Item.Text or "Button",
                        TextSize = Item.TextSize or 14,
                        BorderSizePixel = 0,
                        AutoButtonColor = false,
                        ZIndex = Window.Elements.Footer.ZIndex + 2
                    }, {
                        Font = "FontSecondary",
                        TextColor3 = "TextPrimary",
                        BackgroundColor3 = "Tertiary"
                    }, Theme)
                    local Button = SimpleUI.Utility:CreateInstance("TextButton", ButtonProperties,
                        Window.Elements.FooterContent)
                    SimpleUI.Utility:CreateInstance("UICorner", {
                        CornerRadius = UDim.new(0, SimpleUI.Constants.Corner.Medium)
                    }, Button)
                    if not SimpleUI.Utility:IsMobile() then
                        Button.MouseEnter:Connect(function()
                            TweenService:Create(Button, TweenInfo.new(0.15), {
                                BackgroundColor3 = Theme.TertiaryHover
                            }):Play()
                        end)
                        Button.MouseLeave:Connect(function()
                            TweenService:Create(Button, TweenInfo.new(0.15), {
                                BackgroundColor3 = Theme.Tertiary
                            }):Play()
                        end)
                    end
                    if Item.Callback then
                        Button.Activated:Connect(function()
                            TweenService:Create(Button, TweenInfo.new(0.1), {
                                BackgroundColor3 = Theme.TertiaryPressed
                            }):Play()
                            task.wait(0.1)
                            TweenService:Create(Button, TweenInfo.new(0.1), {
                                BackgroundColor3 = Theme.Tertiary
                            }):Play()
                            SimpleUI.ErrorHandler:Try(Item.Callback)
                        end)
                    end
                    if Item.Id then
                        Window.Elements[Item.Id] = Button
                    end
                    if ButtonBindings then
                        SimpleUI.ThemeManager:RegisterElement(Window, Button, ButtonBindings)
                    end
                elseif Item.Type == "Spacer" then
                    SimpleUI.Utility:CreateInstance("Frame", {
                        Name = "Spacer",
                        LayoutOrder = Item.Order or 1,
                        Size = UDim2.new(0, Item.Width or 10, 1, 0),
                        BackgroundTransparency = 1
                    }, Window.Elements.FooterContent)
                end
            end
        end

        function SimpleUI.WindowBuilder:SetupResizing(MainFrame, UIScale, Options, ResizeParent, ResizeMode, Theme)
            if not Options.CanResize or not ResizeParent then
                return nil, nil
            end

            local IsCenter = ResizeMode == SimpleUI.Constants.Window.ResizeModes.Center

            local ResizeHandle = SimpleUI.Utility:CreateInstance("TextButton", {
                Name = "ResizeHandle",
                Size = UDim2.fromOffset(16, 16),
                Position = UDim2.fromScale(1, 1),
                AnchorPoint = Vector2.new(1, 1),
                BackgroundTransparency = 0.8,
                BackgroundColor3 = Color3.fromRGB(100, 100, 110),
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
                ZIndex = SimpleUI.Constants.ZIndex.Modal
            }, ResizeParent)

            SimpleUI.Utility:CreateInstance("UICorner", {
                CornerRadius = UDim.new(1, 0)
            }, ResizeHandle)

            local IconImage = SimpleUI.Utility:CreateInstance("ImageLabel", {
                Size = UDim2.fromScale(0.7, 0.7),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Image = "rbxassetid://16898613613",
                ImageRectSize = Vector2.new(48, 48),
                ImageRectOffset = Vector2.new(967, 49),
                ImageColor3 = Theme.TextPrimary or Color3.fromRGB(200, 200, 210),
                ZIndex = SimpleUI.Constants.ZIndex.Modal + 1
            }, ResizeHandle)

            local StartPos
            local FrameSize
            local FramePos
            local Dragging = false
            local Changed

            ResizeHandle.InputBegan:Connect(function(input)
                if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~=
                    Enum.UserInputType.Touch then
                    return
                end

                StartPos = input.Position
                FrameSize = MainFrame.Size
                FramePos = MainFrame.Position
                Dragging = true

                if IsCenter then
                    MainFrame.AnchorPoint = Vector2.new(0, 0)
                    MainFrame.Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset - FrameSize.X.Offset / 2,
                        FramePos.Y.Scale, FramePos.Y.Offset - FrameSize.Y.Offset / 2)
                    FramePos = MainFrame.Position
                end

                Changed = input.Changed:Connect(function()
                    if input.UserInputState ~= Enum.UserInputState.End then
                        return
                    end

                    Dragging = false
                    if IsCenter then
                        local centerX = FramePos.X.Offset + MainFrame.Size.X.Offset / 2
                        local centerY = FramePos.Y.Offset + MainFrame.Size.Y.Offset / 2
                        MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                        MainFrame.Position = UDim2.new(FramePos.X.Scale, centerX, FramePos.Y.Scale, centerY)
                    end
                    if Changed and Changed.Connected then
                        Changed:Disconnect()
                        Changed = nil
                    end
                end)
            end)

            UserInputService.InputChanged:Connect(function(input)
                if not MainFrame.Visible then
                    Dragging = false
                    if Changed and Changed.Connected then
                        Changed:Disconnect()
                        Changed = nil
                    end
                    return
                end

                if Dragging and
                    (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType ==
                        Enum.UserInputType.Touch) then
                    local Delta = input.Position - StartPos

                    local newWidth = math.clamp(FrameSize.X.Offset + Delta.X, SimpleUI.Constants.Window.MinSize.X,
                        SimpleUI.Constants.Window.MaxSize.X)
                    local newHeight = math.clamp(FrameSize.Y.Offset + Delta.Y, SimpleUI.Constants.Window.MinSize.Y,
                        SimpleUI.Constants.Window.MaxSize.Y)

                    MainFrame.Size = UDim2.new(FrameSize.X.Scale, newWidth, FrameSize.Y.Scale, newHeight)
                end
            end)

            return ResizeHandle, IconImage, {
                [ResizeHandle] = {
                    BackgroundColor3 = "TextSecondary"
                },
                [IconImage] = {
                    ImageColor3 = "TextPrimary"
                }
            }
        end

        function SimpleUI.WindowBuilder:SetupScrollUpdates(WindowInstance)
            task.defer(function()
                local function UpdateContainers()
                    task.wait()
                    WindowInstance.Elements.TabsContainer = SimpleUI.ScrollManager:Update(WindowInstance.Elements
                                                                                              .TabsContainer)
                    if WindowInstance.ActivePage then
                        WindowInstance.ActivePage = SimpleUI.ScrollManager:Update(WindowInstance.ActivePage)
                    end
                end
                UpdateContainers()
                WindowInstance.Elements.TabsContainer.ChildAdded:Connect(UpdateContainers)
                WindowInstance.Elements.TabsContainer.ChildRemoved:Connect(UpdateContainers)
                WindowInstance.Elements.ContentsContainer.ChildAdded:Connect(function(Child)
                    if Child:IsA("Frame") then
                        local Layout = Child:FindFirstChildWhichIsA("UIListLayout")
                        if Layout then
                            Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                                if Child == WindowInstance.ActivePage then
                                    WindowInstance.ActivePage = SimpleUI.ScrollManager:Update(Child)
                                end
                            end)
                        end
                        local function UpdatePage()
                            if Child == WindowInstance.ActivePage then
                                task.wait()
                                WindowInstance.ActivePage = SimpleUI.ScrollManager:Update(Child)
                            end
                        end
                        Child.ChildAdded:Connect(UpdatePage)
                        Child.ChildRemoved:Connect(UpdatePage)
                    end
                end)
            end)
        end
    end

    SimpleUI.SectionManager = {}
    do
        function SimpleUI.SectionManager:CreateSimpleSection(Page, Text, Options, Theme, Window, Style)
            local LABEL_HEIGHT = 26
            local TEXT_SIZE = Options.TextSize or 19
            local LABEL_TEXT = Text or "Section"

            local StyleDefs = {
                sidebar = {
                    SectionHeight = LABEL_HEIGHT + 4,
                    Indent = 10
                },
                notch = {
                    SectionHeight = LABEL_HEIGHT + 4,
                    Indent = 16
                },
                filled = {
                    SectionHeight = LABEL_HEIGHT + 8,
                    Indent = 14
                },
                inset = {
                    SectionHeight = LABEL_HEIGHT + 6,
                    Indent = 10
                },
                stepped = {
                    SectionHeight = LABEL_HEIGHT + 10,
                    Indent = 8
                },
                panel = {
                    SectionHeight = LABEL_HEIGHT + 8,
                    Indent = 14
                }
            }

            local Def = StyleDefs[Style] or {
                SectionHeight = LABEL_HEIGHT + 4,
                Indent = 0
            }
            local SECTION_HEIGHT = Def.SectionHeight
            local INDENT = Def.Indent
            local LabelY = math.floor((SECTION_HEIGHT - LABEL_HEIGHT) / 2)

            local AccentElement, AccentBindings, ExtraElements = nil, {}, {}

            local Section = SimpleUI.Utility:CreateInstance("Frame", {
                Name = "Section",
                Size = UDim2.new(1, 0, 0, SECTION_HEIGHT),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ClipsDescendants = false,
                ZIndex = SimpleUI.Constants.ZIndex.Control
            }, Page)

            local LabelProperties, LabelBindings = SimpleUI.Utility:ApplyTheme({
                Size = UDim2.new(1, -INDENT, 0, LABEL_HEIGHT),
                Position = UDim2.new(0, INDENT, 0, LabelY),
                Text = LABEL_TEXT,
                TextSize = TEXT_SIZE,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                ZIndex = SimpleUI.Constants.ZIndex.Overlay
            }, {
                Font = "FontPrimary",
                TextColor3 = "TextActive"
            }, Theme)
            local Label = SimpleUI.Utility:CreateInstance("TextLabel", LabelProperties, Section)

            if Style == "sidebar" then
                local Thickness = Options.BarThickness or 3
                local BarProps, BarBindings = SimpleUI.Utility:ApplyTheme({
                    Size = UDim2.new(0, Thickness, 0, LABEL_HEIGHT),
                    Position = UDim2.new(0, 0, 0, LabelY),
                    BorderSizePixel = 0,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay
                }, {
                    BackgroundColor3 = "Accent"
                }, Theme)
                local Bar = SimpleUI.Utility:CreateInstance("Frame", BarProps, Section)
                SimpleUI.Utility:CreateInstance("UICorner", {
                    CornerRadius = UDim.new(1, 0)
                }, Bar)
                AccentElement, AccentBindings = Bar, BarBindings

            elseif Style == "notch" then
                local NOTCH_SIZE = 6
                local NotchProps, NotchBindings = SimpleUI.Utility:ApplyTheme({
                    Size = UDim2.new(0, NOTCH_SIZE, 0, NOTCH_SIZE),
                    Position = UDim2.new(0, 2, 0, LabelY + math.floor((LABEL_HEIGHT - NOTCH_SIZE) / 2)),
                    Rotation = 45,
                    BorderSizePixel = 0,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay
                }, {
                    BackgroundColor3 = "Accent"
                }, Theme)
                local Notch = SimpleUI.Utility:CreateInstance("Frame", NotchProps, Section)
                AccentElement, AccentBindings = Notch, NotchBindings

            elseif Style == "filled" then
                local STRIPE_WIDTH = Options.StripeWidth or 4

                local BgProps, BgBindings = SimpleUI.Utility:ApplyTheme({
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 0.88,
                    BorderSizePixel = 0,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay - 2
                }, {
                    BackgroundColor3 = "Accent"
                }, Theme)
                local Bg = SimpleUI.Utility:CreateInstance("Frame", BgProps, Section)
                SimpleUI.Utility:CreateInstance("UICorner", {
                    CornerRadius = UDim.new(0, 4)
                }, Bg)
                SimpleUI.Utility:CreateInstance("UIGradient", {
                    Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),
                                                       NumberSequenceKeypoint.new(0.6, 0),
                                                       NumberSequenceKeypoint.new(1, 1)}),
                    Rotation = 0
                }, Bg)

                local StripeProps, StripeBindings = SimpleUI.Utility:ApplyTheme({
                    Size = UDim2.new(0, STRIPE_WIDTH, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    BorderSizePixel = 0,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay - 1
                }, {
                    BackgroundColor3 = "Accent"
                }, Theme)
                local Stripe = SimpleUI.Utility:CreateInstance("Frame", StripeProps, Section)
                SimpleUI.Utility:CreateInstance("UICorner", {
                    CornerRadius = UDim.new(0, 2)
                }, Stripe)

                AccentElement, AccentBindings = Stripe, StripeBindings
                table.insert(ExtraElements, {
                    Element = Bg,
                    Bindings = BgBindings
                })

            elseif Style == "inset" then
                local FillProps, FillBindings = SimpleUI.Utility:ApplyTheme({
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 0.92,
                    BorderSizePixel = 0,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay - 2
                }, {
                    BackgroundColor3 = "Accent"
                }, Theme)
                local Fill = SimpleUI.Utility:CreateInstance("Frame", FillProps, Section)

                local TopProps, TopBindings = SimpleUI.Utility:ApplyTheme({
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 0.5,
                    BorderSizePixel = 0,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay - 1
                }, {
                    BackgroundColor3 = "Accent"
                }, Theme)
                local TopLine = SimpleUI.Utility:CreateInstance("Frame", TopProps, Section)

                local BotProps, BotBindings = SimpleUI.Utility:ApplyTheme({
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 1, -1),
                    BackgroundTransparency = 0.5,
                    BorderSizePixel = 0,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay - 1
                }, {
                    BackgroundColor3 = "Accent"
                }, Theme)
                local BotLine = SimpleUI.Utility:CreateInstance("Frame", BotProps, Section)

                AccentElement, AccentBindings = TopLine, TopBindings
                table.insert(ExtraElements, {
                    Element = BotLine,
                    Bindings = BotBindings
                })
                table.insert(ExtraElements, {
                    Element = Fill,
                    Bindings = FillBindings
                })

            elseif Style == "stepped" then
                local LINE_Y = SECTION_HEIGHT - 3
                local CAP_HEIGHT = 3
                local CAP_WIDTH = Options.CapWidth or 36

                local CapProps, CapBindings = SimpleUI.Utility:ApplyTheme({
                    Size = UDim2.new(0, CAP_WIDTH, 0, CAP_HEIGHT),
                    Position = UDim2.new(0, 0, 0, LINE_Y - CAP_HEIGHT + 1),
                    BorderSizePixel = 0,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay
                }, {
                    BackgroundColor3 = "Accent"
                }, Theme)
                local Cap = SimpleUI.Utility:CreateInstance("Frame", CapProps, Section)
                SimpleUI.Utility:CreateInstance("UICorner", {
                    CornerRadius = UDim.new(0, 2)
                }, Cap)

                local HairProps, HairBindings = SimpleUI.Utility:ApplyTheme({
                    Size = UDim2.new(1, -CAP_WIDTH, 0, 1),
                    Position = UDim2.new(0, CAP_WIDTH, 0, LINE_Y),
                    BackgroundTransparency = 0.55,
                    BorderSizePixel = 0,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay - 1
                }, {
                    BackgroundColor3 = "Accent"
                }, Theme)
                local Hair = SimpleUI.Utility:CreateInstance("Frame", HairProps, Section)

                AccentElement, AccentBindings = Cap, CapBindings
                table.insert(ExtraElements, {
                    Element = Hair,
                    Bindings = HairBindings
                })

            elseif Style == "panel" then
                local STRIPE_WIDTH = Options.StripeWidth or 3

                local BgProps, BgBindings = SimpleUI.Utility:ApplyTheme({
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 0.78,
                    BorderSizePixel = 0,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay - 2
                }, {
                    BackgroundColor3 = "Accent"
                }, Theme)
                local Bg = SimpleUI.Utility:CreateInstance("Frame", BgProps, Section)
                SimpleUI.Utility:CreateInstance("UIGradient", {
                    Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),
                                                       NumberSequenceKeypoint.new(0.45, 0),
                                                       NumberSequenceKeypoint.new(1, 1)}),
                    Rotation = 0
                }, Bg)

                local StripeProps, StripeBindings = SimpleUI.Utility:ApplyTheme({
                    Size = UDim2.new(0, STRIPE_WIDTH, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    BorderSizePixel = 0,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay - 1
                }, {
                    BackgroundColor3 = "Accent"
                }, Theme)
                local Stripe = SimpleUI.Utility:CreateInstance("Frame", StripeProps, Section)

                local BottomProps, BottomBindings = SimpleUI.Utility:ApplyTheme({
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 1, -1),
                    BackgroundTransparency = 0.65,
                    BorderSizePixel = 0,
                    ZIndex = SimpleUI.Constants.ZIndex.Overlay - 1
                }, {
                    BackgroundColor3 = "Accent"
                }, Theme)
                local Bottom = SimpleUI.Utility:CreateInstance("Frame", BottomProps, Section)

                AccentElement, AccentBindings = Stripe, StripeBindings
                table.insert(ExtraElements, {
                    Element = Bg,
                    Bindings = BgBindings
                })
                table.insert(ExtraElements, {
                    Element = Bottom,
                    Bindings = BottomBindings
                })
            end

            if Window then
                local Batch = {
                    [Label] = LabelBindings
                }
                if AccentElement then
                    Batch[AccentElement] = AccentBindings
                end
                for _, Entry in ipairs(ExtraElements) do
                    Batch[Entry.Element] = Entry.Bindings
                end
                SimpleUI.ThemeManager:RegisterMultiple(Window, Batch)
            end

            return {
                SetText = function(self, NewText)
                    Label.Text = NewText
                end,

                SetTextSize = function(self, Size)
                    Label.TextSize = Size
                end,

                SetVisible = function(self, Visible)
                    Section.Visible = Visible
                end,

                GetElements = function(self)
                    return {
                        Section = Section,
                        Label = Label,
                        Accent = AccentElement
                    }
                end
            }
        end

        function SimpleUI.SectionManager:CreateBoxSection(Page, Text, Options, Theme, Window)
            if not Page or not Page.Parent then
                SimpleUI.ErrorHandler:Guard(false, "CreateBoxSection", "Page is nil or unparented",
                    SimpleUI.ErrorHandler.Levels.ERROR)
                return nil
            end
            Options = type(Options) == "table" and Options or {}
            Theme = type(Theme) == "table" and Theme or SimpleUI.Themes.DefaultTheme
            Text = type(Text) == "string" and Text or "Section"

            local U = SimpleUI.Utility
            local TM = SimpleUI.ThemeManager
            local CORNER = SimpleUI.Constants.Corner.Medium
            local PAD = SimpleUI.Constants.Padding
            local ZI = SimpleUI.Constants.ZIndex
            local HEADER_H = 36
            local TWEEN_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local IsExpanded = Options.DefaultExpanded ~= false

            local function GetWindowScale()
                if Window and Window.Scale and typeof(Window.Scale) == "Instance" then
                    local ok, scale = pcall(function()
                        return Window.Scale.Scale
                    end)
                    if ok and type(scale) == "number" and scale > 0 then
                        return scale
                    end
                end
                return 1
            end

            local function Tween(Object, Properties)
                if not Object or not Object.Parent then
                    return
                end
                local ok, err = pcall(function()
                    TweenService:Create(Object, TWEEN_INFO, Properties):Play()
                end)
                if not ok then
                    SimpleUI.ErrorHandler:Guard(false, "CreateBoxSection:Tween", tostring(err),
                        SimpleUI.ErrorHandler.Levels.WARN)
                end
            end

            local Section = U:CreateInstance("Frame", {
                Name = "BoxSection",
                Size = UDim2.new(1, 0, 0, HEADER_H),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ClipsDescendants = false,
                ZIndex = ZI.Control
            }, Page)

            local Border = U:CreateInstance("Frame", {
                Name = "Border",
                Size = UDim2.new(1, 0, 0, HEADER_H),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundColor3 = Theme.BoxBackground or Theme.Secondary,
                BackgroundTransparency = Theme.TransparencySecondary,
                BorderSizePixel = 0,
                ZIndex = ZI.Control
            }, Section)
            U:CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, CORNER)
            }, Border)

            local Stroke = U:CreateInstance("UIStroke", {
                Color = Theme.Separator,
                Thickness = 1,
                Transparency = Theme.SeparatorTransparency,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }, Border)

            local HeaderContainer = U:CreateInstance("Frame", {
                Name = "HeaderContainer",
                Size = UDim2.new(1, 0, 0, HEADER_H),
                BackgroundTransparency = 1,
                ZIndex = ZI.Control + 1
            }, Border)
            U:CreateInstance("UIPadding", {
                PaddingLeft = UDim.new(0, PAD.Medium),
                PaddingRight = UDim.new(0, PAD.Medium)
            }, HeaderContainer)

            local HeaderContent = U:CreateInstance("Frame", {
                Name = "HeaderContent",
                Size = UDim2.new(1, -(20 + PAD.Medium), 1, 0),
                BackgroundTransparency = 1,
                ZIndex = ZI.Control + 1
            }, HeaderContainer)
            U:CreateInstance("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, PAD.Medium)
            }, HeaderContent)

            local IconContainer = nil
            if Options.Icon then
                IconContainer = U:CreateInstance("Frame", {
                    Name = "IconContainer",
                    Size = UDim2.new(0, 20, 0, 20),
                    BackgroundTransparency = 1,
                    ZIndex = ZI.Control + 1,
                    LayoutOrder = 1
                }, HeaderContent)

                local rawIcon = Options.Icon
                local iconData = SimpleUI.IconManager:WrapIcon(
                    type(rawIcon) == "table" and rawIcon or {
                        Image = rawIcon
                    })

                if iconData then
                    U:CreateInstance("ImageLabel", {
                        Name = "Icon",
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Image = iconData.Url,
                        ImageColor3 = (type(rawIcon) == "table" and rawIcon.ImageColor3) or Theme.TextPrimary,
                        ImageRectOffset = iconData.ImageRectOffset,
                        ImageRectSize = iconData.ImageRectSize,
                        ZIndex = ZI.Control + 1
                    }, IconContainer)
                end
            end

            local Title = U:CreateInstance("TextLabel", {
                Name = "Title",
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = Text,
                TextColor3 = Theme.TextActive,
                Font = Theme.FontPrimary,
                TextSize = type(Options.TextSize) == "number" and Options.TextSize or 15,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = ZI.Control + 1,
                LayoutOrder = 2
            }, HeaderContent)

            local Arrow = U:CreateInstance("ImageLabel", {
                Name = "Arrow",
                Size = UDim2.new(0, 12, 0, 12),
                Position = UDim2.new(1, 0, 0.5, 0),
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundTransparency = 1,
                Image = "rbxassetid://10709790948",
                ImageColor3 = Theme.TextPrimary,
                Rotation = IsExpanded and 0 or -90,
                ZIndex = ZI.Control + 1
            }, HeaderContainer)

            local Content = U:CreateInstance("Frame", {
                Name = "Content",
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, HEADER_H),
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                ZIndex = ZI.Control + 1
            }, Border)

            Content:SetAttribute("IsDualScroll", false)

            local ContentPadding = U:CreateInstance("UIPadding", {
                PaddingTop = UDim.new(0, PAD.Medium),
                PaddingBottom = UDim.new(0, PAD.Large),
                PaddingLeft = UDim.new(0, PAD.Medium),
                PaddingRight = UDim.new(0, PAD.Medium)
            }, Content)

            local ListLayout = U:CreateInstance("UIListLayout", {
                Padding = UDim.new(0, SimpleUI.Constants.Spacing.Loose),
                SortOrder = Enum.SortOrder.LayoutOrder
            }, Content)

            local ClickButton = U:CreateInstance("TextButton", {
                Name = "ClickButton",
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
                ZIndex = ZI.Modal
            }, HeaderContainer)

            local function CalculateContentHeight()
                local scale = GetWindowScale()
                local logicalContent = ListLayout.AbsoluteContentSize.Y / scale
                return logicalContent + ContentPadding.PaddingTop.Offset + ContentPadding.PaddingBottom.Offset
            end

            local function SetExpandedSize()
                if not IsExpanded then
                    return
                end
                local contentH = CalculateContentHeight()
                local totalH = HEADER_H + contentH
                Tween(Content, {
                    Size = UDim2.new(1, 0, 0, contentH)
                })
                Tween(Border, {
                    Size = UDim2.new(1, 0, 0, totalH)
                })
                Tween(Section, {
                    Size = UDim2.new(1, 0, 0, totalH)
                })
            end

            local function SetCollapsedSize()
                Tween(Content, {
                    Size = UDim2.new(1, 0, 0, 0)
                })
                Tween(Border, {
                    Size = UDim2.new(1, 0, 0, HEADER_H)
                })
                Tween(Section, {
                    Size = UDim2.new(1, 0, 0, HEADER_H)
                })
            end

            local ToggleDebounce = false

            local function Toggle()
                if ToggleDebounce then
                    return
                end
                ToggleDebounce = true
                task.delay(0.1, function()
                    ToggleDebounce = false
                end)

                IsExpanded = not IsExpanded
                Tween(Arrow, {
                    Rotation = IsExpanded and 0 or -90
                })
                if IsExpanded then
                    SetExpandedSize()
                else
                    SetCollapsedSize()
                end
            end

            ClickButton.Activated:Connect(Toggle)

            local resizePending = false
            local function RequestResize()
                if not IsExpanded or resizePending then
                    return
                end
                resizePending = true
                task.defer(function()
                    resizePending = false
                    if Section.Parent then
                        SetExpandedSize()
                    end
                end)
            end

            Content.ChildAdded:Connect(RequestResize)
            Content.ChildRemoved:Connect(RequestResize)
            ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(RequestResize)

            if Window and Window.Scale and typeof(Window.Scale) == "Instance" then
                Window.Scale:GetPropertyChangedSignal("Scale"):Connect(function()
                    if IsExpanded and Section.Parent then
                        local contentH = CalculateContentHeight()
                        local totalH = HEADER_H + contentH
                        Content.Size = UDim2.new(1, 0, 0, contentH)
                        Border.Size = UDim2.new(1, 0, 0, totalH)
                        Section.Size = UDim2.new(1, 0, 0, totalH)
                    end
                end)
            end

            if IsExpanded then
                task.defer(SetExpandedSize)
            end

            if Window then
                local themeTargets = {
                    [Border] = {
                        BackgroundColor3 = "BoxBackground",
                        BackgroundTransparency = "TransparencySecondary"
                    },
                    [Stroke] = {
                        Color = "Separator",
                        Transparency = "SeparatorTransparency"
                    },
                    [Title] = {
                        TextColor3 = "TextActive",
                        Font = "FontPrimary"
                    },
                    [Arrow] = {
                        ImageColor3 = "TextPrimary"
                    }
                }

                if IconContainer then
                    local iconEl = IconContainer:FindFirstChild("Icon")
                    if iconEl then
                        local hasExplicitColor = type(Options.Icon) == "table" and Options.Icon.ImageColor3 ~= nil
                        if not hasExplicitColor then
                            themeTargets[iconEl] = {
                                ImageColor3 = "TextPrimary"
                            }
                        end
                    end
                end

                TM:RegisterMultiple(Window, themeTargets)
            end

            return {
                Container = Content,
                Section = Section,
                Header = HeaderContainer,
                Title = Title,
                Arrow = Arrow,
                IconContainer = IconContainer,

                SetExpanded = function(_, value)
                    if type(value) ~= "boolean" then
                        return
                    end
                    if value ~= IsExpanded then
                        Toggle()
                    end
                end,

                IsExpanded = function()
                    return IsExpanded
                end,

                Refresh = function()
                    if IsExpanded then
                        SetExpandedSize()
                    end
                end,

                SetTitle = function(_, newText)
                    if type(newText) == "string" then
                        Title.Text = newText
                    end
                end
            }
        end
    end

    SimpleUI.IconManager = {}
    do
        function SimpleUI.IconManager:WrapIcon(IconInput)
            if not IconInput then
                return nil
            end

            if type(IconInput) == "table" and IconInput.Image then
                return {
                    Url = IconInput.Image,
                    ImageRectOffset = IconInput.ImageRectOffset or Vector2.zero,
                    ImageRectSize = IconInput.ImageRectSize or Vector2.zero
                }
            end

            return {
                Url = tostring(IconInput),
                ImageRectOffset = Vector2.zero,
                ImageRectSize = Vector2.zero
            }
        end
    end

    SimpleUI.NotificationManager = {}
    do
        local ActiveNotifications = {}

        function SimpleUI.NotificationManager:Initialize()
            if self.Initialized then
                return
            end
            self.Initialized = true
            self.Container = nil
            self.ScreenGui = nil
        end

        function SimpleUI.NotificationManager:GetScreenGui()
            if self.ScreenGui and self.ScreenGui.Parent then
                return self.ScreenGui
            end

            local ScreenGui = SimpleUI.Utility:CreateInstance("ScreenGui", {
                Name = SimpleUI.Utility:GenerateId(),
                ResetOnSpawn = false,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                DisplayOrder = SimpleUI.Constants.ZIndex.Notification
            })

            SimpleUI.Utility:ParentUI(ScreenGui)
            self.ScreenGui = ScreenGui
            return ScreenGui
        end

        function SimpleUI.NotificationManager:GetContainer()
            if self.Container and self.Container.Parent then
                return self.Container
            end

            local ScreenGui = self:GetScreenGui()
            local Scale = SimpleUI.Utility:IsMobile() and 0.5 or 1

            local Parent = SimpleUI.Utility:CreateInstance("Frame", {
                Name = SimpleUI.Utility:GenerateId(),
                Size = UDim2.fromScale(1, 1),
                Position = UDim2.fromScale(0, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ZIndex = SimpleUI.Constants.ZIndex.Notification
            }, ScreenGui)

            SimpleUI.Utility:CreateInstance("UIScale", {
                Scale = Scale
            }, Parent)

            self.Container = Parent

            local Holder = SimpleUI.Utility:CreateInstance("Frame", {
                Name = SimpleUI.Utility:GenerateId(),
                Position = UDim2.new(1, -20, 0, 20),
                AnchorPoint = Vector2.new(1, 0),
                Size = UDim2.new(0, 360, 1, -40),
                BackgroundTransparency = 1,
                ZIndex = SimpleUI.Constants.ZIndex.Notification
            }, Parent)

            SimpleUI.Utility:CreateInstance("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10)
            }, Holder)

            pcall(protectgui, Parent)

            return Parent
        end

        function SimpleUI.NotificationManager:GetHolder()
            local Container = self:GetContainer()
            for _, Child in ipairs(Container:GetChildren()) do
                if Child:IsA("Frame") then
                    local Layout = Child:FindFirstChildOfClass("UIListLayout")
                    if Layout then
                        return Child
                    end
                end
            end
            return Container
        end

        function SimpleUI.NotificationManager:CreateNotificationUI(Config)
            local Theme = SimpleUI.Themes.Obsidian
            local Holder = self:GetHolder()
            local IsMobile = SimpleUI.Utility:IsMobile()
            local HasDuration = Config.Duration and Config.Duration > 0

            local TypeColors = {
                Default = Theme.Accent,
                Info = Color3.fromRGB(30, 144, 255),
                Success = Color3.fromRGB(40, 187, 109),
                Warning = Color3.fromRGB(255, 193, 7),
                Error = Color3.fromRGB(220, 60, 69)
            }
            local TypeTags = {
                Default = "NOTICE",
                Info = "INFO",
                Success = "SUCCESS",
                Warning = "WARNING",
                Error = "ERROR"
            }

            local Accent = TypeColors[Config.Type] or Config.Color or Theme.Accent
            local LightAccent = Accent:Lerp(Color3.new(1, 1, 1), 0.4)
            local TagText = Config.Tag or TypeTags[Config.Type] or "NOTICE"
            local BasePad = IsMobile and 8 or 10
            local SidePad = IsMobile and 10 or 12

            local Notification = SimpleUI.Utility:CreateInstance("Frame", {
                Name = SimpleUI.Utility:GenerateId(),
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundColor3 = Theme.Secondary,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ClipsDescendants = false,
                ZIndex = SimpleUI.Constants.ZIndex.Notification,
                LayoutOrder = tick()
            }, Holder)

            local AccentBar = SimpleUI.Utility:CreateInstance("Frame", {
                Name = SimpleUI.Utility:GenerateId(),
                Size = UDim2.new(0, 3, 1, 0),
                BackgroundColor3 = Accent,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ZIndex = SimpleUI.Constants.ZIndex.Notification + 1
            }, Notification)

            local Shadow = SimpleUI.Utility:CreateInstance("ImageLabel", {
                Name = SimpleUI.Utility:GenerateId(),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = UDim2.new(1, 20, 1, 20),
                BackgroundTransparency = 1,
                Image = "rbxassetid://7717391613",
                ImageColor3 = Color3.new(0, 0, 0),
                ImageTransparency = 1,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                ZIndex = SimpleUI.Constants.ZIndex.Notification - 1
            }, Notification)

            local Content = SimpleUI.Utility:CreateInstance("Frame", {
                Name = SimpleUI.Utility:GenerateId(),
                Position = UDim2.new(0, 3, 0, 0),
                Size = UDim2.new(1, -3, 1, 0),
                BackgroundTransparency = 1,
                ZIndex = SimpleUI.Constants.ZIndex.Notification + 2
            }, Notification)

            SimpleUI.Utility:CreateInstance("UIPadding", {
                PaddingTop = UDim.new(0, BasePad),
                PaddingBottom = UDim.new(0, BasePad),
                PaddingLeft = UDim.new(0, SidePad),
                PaddingRight = UDim.new(0, IsMobile and 26 or 30)
            }, Content)

            local TextContainer = SimpleUI.Utility:CreateInstance("Frame", {
                Name = SimpleUI.Utility:GenerateId(),
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                ZIndex = SimpleUI.Constants.ZIndex.Notification + 2
            }, Content)

            SimpleUI.Utility:CreateInstance("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, IsMobile and 2 or 3)
            }, TextContainer)

            local TitleRow = SimpleUI.Utility:CreateInstance("Frame", {
                Name = SimpleUI.Utility:GenerateId(),
                Size = UDim2.new(1, Config.Closable ~= false and -(IsMobile and 22 or 26) or 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = 1,
                ZIndex = SimpleUI.Constants.ZIndex.Notification + 2
            }, TextContainer)

            SimpleUI.Utility:CreateInstance("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5)
            }, TitleRow)

            local TitleLabel = SimpleUI.Utility:CreateInstance("TextLabel", {
                Name = SimpleUI.Utility:GenerateId(),
                Size = UDim2.new(0, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                Text = Config.Title or "Notification",
                TextColor3 = Theme.TextActive,
                TextTransparency = 1,
                TextSize = IsMobile and 12 or 13,
                Font = Theme.FontPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = false,
                RichText = true,
                LineHeight = 1.1,
                LayoutOrder = 1,
                ZIndex = SimpleUI.Constants.ZIndex.Notification + 3
            }, TitleRow)

            local Tag = SimpleUI.Utility:CreateInstance("TextLabel", {
                Name = SimpleUI.Utility:GenerateId(),
                Size = UDim2.new(0, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundColor3 = Accent,
                BackgroundTransparency = 1,
                Text = TagText,
                TextColor3 = LightAccent,
                TextTransparency = 1,
                TextSize = IsMobile and 8 or 9,
                Font = Theme.FontPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = 2,
                ZIndex = SimpleUI.Constants.ZIndex.Notification + 3
            }, TitleRow)

            SimpleUI.Utility:CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, 3)
            }, Tag)
            SimpleUI.Utility:CreateInstance("UIPadding", {
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 5),
                PaddingTop = UDim.new(0, 2),
                PaddingBottom = UDim.new(0, 2)
            }, Tag)

            local DescriptionLabel = nil
            if Config.Description then
                DescriptionLabel = SimpleUI.Utility:CreateInstance("TextLabel", {
                    Name = SimpleUI.Utility:GenerateId(),
                    Size = UDim2.new(1, Config.Closable ~= false and -(IsMobile and 22 or 26) or 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    Text = Config.Description,
                    TextColor3 = Theme.TextSecondary,
                    TextTransparency = 1,
                    TextSize = IsMobile and 11 or 12,
                    Font = Theme.FontSecondary,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    RichText = true,
                    LineHeight = 1.2,
                    LayoutOrder = 2,
                    ZIndex = SimpleUI.Constants.ZIndex.Notification + 3
                }, TextContainer)
            end

            if Config.Closable ~= false then
                local CloseBtn = SimpleUI.Utility:CreateInstance("TextButton", {
                    Name = SimpleUI.Utility:GenerateId(),
                    Position = UDim2.new(1, 0, 0, 0),
                    AnchorPoint = Vector2.new(1, 0),
                    Size = UDim2.new(0, IsMobile and 16 or 18, 0, IsMobile and 16 or 18),
                    BackgroundTransparency = 1,
                    Text = "×",
                    Font = Theme.FontPrimary,
                    TextSize = IsMobile and 18 or 20,
                    TextColor3 = Theme.TextInactive,
                    TextTransparency = 1,
                    AutoButtonColor = false,
                    ZIndex = SimpleUI.Constants.ZIndex.Notification + 5
                }, Content)

                CloseBtn.MouseEnter:Connect(function()
                    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {
                        TextColor3 = Color3.fromRGB(255, 85, 85),
                        Rotation = 90
                    }):Play()
                end)
                CloseBtn.MouseLeave:Connect(function()
                    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {
                        TextColor3 = Theme.TextInactive,
                        Rotation = 0
                    }):Play()
                end)
                CloseBtn.Activated:Connect(function()
                    SimpleUI.NotificationManager:Dismiss(Notification)
                end)
            end

            if Config.Callback then
                local ClickArea = SimpleUI.Utility:CreateInstance("TextButton", {
                    Name = SimpleUI.Utility:GenerateId(),
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = SimpleUI.Constants.ZIndex.Notification
                }, Notification)

                ClickArea.Activated:Connect(function()
                    SimpleUI.ErrorHandler:Try(function()
                        Config.Callback(Notification)
                    end)
                end)
                ClickArea.MouseEnter:Connect(function()
                    TweenService:Create(Notification, TweenInfo.new(0.15), {
                        BackgroundColor3 = Theme.SecondaryHover
                    }):Play()
                end)
                ClickArea.MouseLeave:Connect(function()
                    TweenService:Create(Notification, TweenInfo.new(0.15), {
                        BackgroundColor3 = Theme.Secondary
                    }):Play()
                end)
            end

            task.defer(function()
                task.wait()

                local TextH = 0
                for _, Child in ipairs(TextContainer:GetChildren()) do
                    if Child:IsA("TextLabel") or Child:IsA("Frame") then
                        TextH = TextH + Child.AbsoluteSize.Y
                    end
                end
                local Layout = TextContainer:FindFirstChildOfClass("UIListLayout")
                local ChildCount = 0
                for _, Child in ipairs(TextContainer:GetChildren()) do
                    if Child:IsA("TextLabel") or Child:IsA("Frame") then
                        ChildCount = ChildCount + 1
                    end
                end
                if Layout and ChildCount > 1 then
                    TextH = TextH + Layout.Padding.Offset * (ChildCount - 1)
                end

                local MinH = IsMobile and 38 or 42
                local CardH = math.max(TextH + BasePad * 2, MinH)
                local BarH = HasDuration and 2 or 0

                Notification.Size = UDim2.new(1, 0, 0, CardH + BarH)
                Notification.Position = UDim2.new(0, 0, 0, 0)
                Notification.BackgroundTransparency = 1
                Shadow.ImageTransparency = 1

                for _, Child in ipairs(Notification:GetDescendants()) do
                    if Child:IsA("TextLabel") or Child:IsA("TextButton") then
                        Child.TextTransparency = 1
                    elseif Child:IsA("ImageLabel") and Child.Name ~= Shadow.Name then
                        Child.ImageTransparency = 1
                    elseif Child:IsA("Frame") and Child ~= Notification then
                        Child.BackgroundTransparency = 1
                    end
                end

                local SlideInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                local Tweens = {}

                table.insert(Tweens, TweenService:Create(Notification, SlideInfo, {
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 0
                }))
                table.insert(Tweens, TweenService:Create(Shadow, SlideInfo, {
                    ImageTransparency = 0.75
                }))
                table.insert(Tweens, TweenService:Create(AccentBar, SlideInfo, {
                    BackgroundTransparency = 0
                }))
                table.insert(Tweens, TweenService:Create(Tag, SlideInfo, {
                    TextTransparency = 0,
                    BackgroundTransparency = 0.78
                }))

                for _, Child in ipairs(Notification:GetDescendants()) do
                    if Child:IsA("TextLabel") and Child.Name ~= Tag.Name then
                        table.insert(Tweens, TweenService:Create(Child, SlideInfo, {
                            TextTransparency = 0
                        }))
                    elseif Child:IsA("TextButton") then
                        table.insert(Tweens, TweenService:Create(Child, SlideInfo, {
                            TextTransparency = 0
                        }))
                    end
                end

                for _, Tween in ipairs(Tweens) do
                    Tween:Play()
                end

                if HasDuration then
                    local ProgressBar = SimpleUI.Utility:CreateInstance("Frame", {
                        Name = SimpleUI.Utility:GenerateId(),
                        Position = UDim2.new(0, 0, 1, -BarH),
                        Size = UDim2.new(1, 0, 0, BarH),
                        BackgroundColor3 = Accent,
                        BorderSizePixel = 0,
                        ZIndex = SimpleUI.Constants.ZIndex.Notification + 4
                    }, Notification)

                    TweenService:Create(ProgressBar, TweenInfo.new(Config.Duration, Enum.EasingStyle.Linear), {
                        Size = UDim2.new(0, 0, 0, BarH)
                    }):Play()

                    task.delay(Config.Duration, function()
                        if Notification and Notification.Parent then
                            SimpleUI.NotificationManager:Dismiss(Notification)
                        end
                    end)
                end
            end)

            return {
                Container = Notification,
                Title = TitleLabel,
                Description = DescriptionLabel,
                Tag = Tag,
                Content = Content,
                AccentBar = AccentBar
            }
        end

        function SimpleUI.NotificationManager:Dismiss(Notification)
            if not Notification or not Notification.Parent then
                return false
            end

            local FadeInfo = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            local Shadow = Notification:FindFirstChild("Shadow")
            local Tweens = {}

            table.insert(Tweens, TweenService:Create(Notification, FadeInfo, {
                BackgroundTransparency = 1
            }))
            if Shadow then
                table.insert(Tweens, TweenService:Create(Shadow, FadeInfo, {
                    ImageTransparency = 1
                }))
            end

            for _, o in ipairs(Notification:GetDescendants()) do
                if o:IsA("TextLabel") or o:IsA("TextButton") then
                    table.insert(Tweens, TweenService:Create(o, FadeInfo, {
                        TextTransparency = 1,
                        BackgroundTransparency = 1
                    }))
                elseif o:IsA("ImageLabel") and o ~= Shadow then
                    table.insert(Tweens, TweenService:Create(o, FadeInfo, {
                        ImageTransparency = 1
                    }))
                elseif o:IsA("Frame") and o ~= Notification then
                    table.insert(Tweens, TweenService:Create(o, FadeInfo, {
                        BackgroundTransparency = 1
                    }))
                end
            end

            for _, Tween in ipairs(Tweens) do
                Tween:Play()
            end

            task.delay(0.35, function()
                if not Notification or not Notification.Parent then
                    return
                end
                TweenService:Create(Notification, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                    {
                        Size = UDim2.new(1, 0, 0, 0)
                    }):Play()
                task.wait(0.15)
                if Notification and Notification.Parent then
                    Notification:Destroy()
                end
            end)

            return true
        end

        function SimpleUI.NotificationManager:DismissAll()
            local Holder = self:GetHolder()
            local ToRemove = {}
            for _, Child in ipairs(Holder:GetChildren()) do
                if Child:IsA("Frame") then
                    table.insert(ToRemove, Child)
                end
            end
            for _, Child in ipairs(ToRemove) do
                self:Dismiss(Child)
            end
        end
    end

    SimpleUI.MarkdownParser = {}
    do
        function SimpleUI.MarkdownParser:ConvertToRichText(Markdown)
            local Text = Markdown
            Text = Text:gsub("### (.-)\n", '<font size="18"><b>%1</b></font>\n')
            Text = Text:gsub("## (.-)\n", '<font size="20"><b>%1</b></font>\n')
            Text = Text:gsub("# (.-)\n", '<font size="22"><b>%1</b></font>\n')
            Text = Text:gsub("%*%*%*(.-)%*%*%*", "<b><i>%1</i></b>")
            Text = Text:gsub("%*%*(.-)%*%*", "<b>%1</b>")
            Text = Text:gsub("%*(.-)%*", "<i>%1</i>")
            Text = Text:gsub("__(.-)__", "<b>%1</b>")
            Text = Text:gsub("_(.-)_", "<i>%1</i>")
            Text = Text:gsub("~~(.-)~~", "<s>%1</s>")
            Text = Text:gsub("`([^`]+)`",
                '<font face="RobotoMono"><stroke color="rgb(50,50,60)" joins="miter" thickness="3" transparency="0">%1</stroke></font>')
            Text = Text:gsub("```(.-)```", function(Code)
                return
                    '<font face="RobotoMono" size="13"><stroke color="rgb(50,50,60)" joins="miter" thickness="3" transparency="0">' ..
                        Code .. '</stroke></font>'
            end)
            Text = Text:gsub("%[(.-)%]%((.-)%)", '<font color="rgb(100,150,255)"><u>%1</u></font>')
            Text = Text:gsub("^%- (.-)\n", "• %1\n")
            Text = Text:gsub("\n%- (.-)\n", "\n• %1\n")
            Text = Text:gsub("\n%- (.-)", "\n• %1")
            Text = Text:gsub("^%* (.-)\n", "• %1\n")
            Text = Text:gsub("\n%* (.-)\n", "\n• %1\n")
            Text = Text:gsub("\n%* (.-)", "\n• %1")
            Text = Text:gsub("^%d+%. (.-)\n", "%1\n")
            Text = Text:gsub("\n%d+%. (.-)\n", "\n%1\n")
            Text = Text:gsub("%-%-%-+", "────────────────────────")
            Text = Text:gsub("%*%*%*+", "────────────────────────")
            return Text
        end
    end
end

function SimpleUI:CreateWindow(options)
    options = options or {}

    local theme = type(options.Theme) == "string" and (self.Themes[options.Theme] or self.Themes.DefaultTheme) or
                      type(options.Theme) == "table" and options.Theme or self.Themes.DefaultTheme

    local scale = math.clamp(options.DefaultScale or self.Constants.Window.DefaultScale, self.Constants.Window.MinScale,
        self.Constants.Window.MaxScale)

    local screenGui = self.Utility:CreateInstance("ScreenGui", {
        Name = options.Name or self.Utility:GenerateId(),
        ResetOnSpawn = false,
        DisplayOrder = options.DisplayOrder or 1,
        IgnoreGuiInset = options.IgnoreGuiInset or false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    self.Utility:ParentUI(screenGui)

    local mainFrame, uiScale, mainFrameBindings = self.WindowBuilder:CreateMainFrame(screenGui, options, theme)
    local topBarHeight = options.TopBarHeight or self.Constants.Window.TopBarHeight
    local footerHeight = options.Footer and (options.FooterHeight or 10) or 0

    local topBar, topBarSeparator, topBarSeparatorBindings = self.WindowBuilder:CreateTopBar(mainFrame, options, theme)

    local tabInfoContainer, controlsContainer, tabNameLabel, tabDescLabel, brandIconElement, brandInitialElement,
        brandTitleLabel = self.WindowBuilder:CreateTitleSection(topBar, options, theme)

    local controlButtons = self.WindowBuilder:CreateWindowControls(controlsContainer, options, theme)

    local footer, footerBindings, footerContent, separatorBindings, resizeContainer =
        self.WindowBuilder:CreateFooter(mainFrame, options, theme)
    local ResizeMode = options.ResizeMode or self.Constants.Window.ResizeModes.BottomRight

    local mainContainer = self.WindowBuilder:CreateMainContainer(mainFrame, options, theme, topBarHeight, footerHeight)

    local tabsContainer, contentsContainer, tabsSeparator, tabsSeparatorBindings =
        self.WindowBuilder:CreateContentAreas(mainContainer, mainFrame, topBar, options)

    local window = {
        _connections = SimpleUI.ConnectionRegistry:New(),
        Theme = theme,
        TabMode = options.TabMode or self.Constants.Window.TabModes.Fixed,
        TabsExpanded = true,
        ActiveTab = nil,
        ActivePage = nil,
        TabCallbacks = {},
        Scale = uiScale,
        Elements = {
            ScreenGui = screenGui,
            MainFrame = mainFrame,
            TopBar = topBar,
            TabInfoContainer = tabInfoContainer,
            TitleLabel = tabNameLabel,
            SubtitleLabel = tabDescLabel,
            BrandIcon = brandIconElement,
            BrandInitial = brandInitialElement,
            BrandTitle = brandTitleLabel,
            ControlsContainer = controlsContainer,
            ControlButtons = controlButtons,
            Footer = footer,
            FooterContent = footerContent,
            FooterResizeArea = resizeContainer,
            MainContainer = mainContainer,
            TabsContainer = tabsContainer,
            TabsSeparator = tabsSeparator,
            ContentsContainer = contentsContainer,
            Tabs = {},
            Pages = {}
        },

        GetScale = function()
            return uiScale.Scale
        end,

        SetScale = function(self, value, animate)
            value = math.clamp(tonumber(value) or 1, SimpleUI.Constants.Window.MinScale,
                SimpleUI.Constants.Window.MaxScale)

            if animate then
                TweenService:Create(uiScale, TweenInfo.new(SimpleUI.Constants.Animation.Normal, Enum.EasingStyle.Sine,
                    Enum.EasingDirection.Out), {
                    Scale = value
                }):Play()
            else
                uiScale.Scale = value
            end
        end,

        SetTheme = function(self, themeName, animate)
            if type(themeName) ~= "string" then
                return
            end
            SimpleUI.ThemeManager:SetTheme(self, themeName, animate ~= false)
        end,

        GetTheme = function(self)
            return SimpleUI.ThemeManager:GetThemeName(self)
        end,

        SetTabMode = function(self, mode, animate, threshold)
            threshold = threshold or SimpleUI.Constants.Window.TabDynamicThreshold
            local modes = SimpleUI.Constants.Window.TabModes

            if not modes[mode] then
                SimpleUI.ErrorHandler:Guard(false, "SetTabMode",
                    string.format("Invalid tab mode '%s', using Dynamic", tostring(mode)),
                    SimpleUI.ErrorHandler.Levels.WARN)
                mode = modes.Dynamic
            end

            self.TabMode = mode
            local duration = SimpleUI.Constants.Animation.Smooth
            local const = SimpleUI.Constants.Window

            local function updateTopBarLayout(expanded, tweenDuration)
                if not tabsSeparator then
                    return
                end

                local hasBrand = options.Brand ~= nil
                local xScale, xOffset

                if expanded then
                    xScale = const.TabsWidthOpen
                    xOffset = const.TabSeparatorGap
                    if tabNameLabel then
                        TweenService:Create(tabNameLabel, TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad), {
                            TextTransparency = 1
                        }):Play()
                    end
                    if tabDescLabel then
                        TweenService:Create(tabDescLabel, TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad), {
                            TextTransparency = 1
                        }):Play()
                    end
                    TweenService:Create(tabsSeparator,
                        TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = UDim2.new(0, 1, 1, -topBarHeight),
                            Position = UDim2.new(xScale, xOffset, 0, topBarHeight)
                        }):Play()

                    if brandTitleLabel then
                        TweenService:Create(brandTitleLabel, TweenInfo.new(tweenDuration * 0.8, Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out), {
                            TextTransparency = 0
                        }):Play()
                    end

                    if tabInfoContainer then
                        TweenService:Create(tabInfoContainer, TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out), {
                            Position = UDim2.new(xScale, xOffset + 1, 0.5, 0)
                        }):Play()
                    end
                else
                    xOffset = const.TabsWidthClosed + const.ClosedTabHorizontalPadding + const.TabSeparatorGap

                    if tabNameLabel then
                        TweenService:Create(tabNameLabel, TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad), {
                            TextTransparency = 0
                        }):Play()
                    end
                    if tabDescLabel then
                        TweenService:Create(tabDescLabel, TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad), {
                            TextTransparency = 0
                        }):Play()
                    end

                    TweenService:Create(tabsSeparator,
                        TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = UDim2.new(0, 1, 1, hasBrand and 0 or -topBarHeight),
                            Position = UDim2.new(0, xOffset, 0, hasBrand and 0 or topBarHeight)
                        }):Play()

                    if brandTitleLabel then
                        TweenService:Create(brandTitleLabel, TweenInfo.new(tweenDuration * 0.5, Enum.EasingStyle.Quad,
                            Enum.EasingDirection.In), {
                            TextTransparency = 1
                        }):Play()
                    end

                    if tabInfoContainer then
                        TweenService:Create(tabInfoContainer, TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out), {
                            Position = UDim2.new(0, xOffset + 1, 0.5, 0)
                        }):Play()
                    end
                end
            end

            local function setExpanded(expanded, tweenDuration)
                self.TabsExpanded = expanded
                tweenDuration = tweenDuration and duration or 0

                updateTopBarLayout(expanded, tweenDuration)

                local hPad = const.HorizontalPadding
                local tabsSize, tabsPos, contentsPos, contentsSize

                if expanded then
                    tabsSize = UDim2.new(const.TabsWidthOpen, -(hPad * 0.5), 1, 0)
                    tabsPos = UDim2.new(0, hPad * 0.5, 0, 0)
                    contentsPos = UDim2.new(const.TabsWidthOpen, hPad, 0, 0)
                    contentsSize = UDim2.new(const.ContentWidthOpen, -(hPad * 2), 1, 0)
                else
                    local contentLeft = const.ContentLeftOffsetClosed
                    tabsSize = UDim2.new(0, const.TabsWidthClosed, 1, 0)
                    tabsPos = UDim2.new(0, const.ClosedTabHorizontalPadding, 0, 0)
                    contentsPos = UDim2.new(0, contentLeft, 0, 0)
                    contentsSize = UDim2.new(1, -(contentLeft + hPad), 1, 0)
                end

                TweenService:Create(tabsContainer,
                    TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = tabsSize,
                        Position = tabsPos
                    }):Play()

                TweenService:Create(contentsContainer,
                    TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = contentsPos,
                        Size = contentsSize
                    }):Play()

                for _, tabData in pairs(self.Elements.Tabs) do
                    if type(tabData) == "table" and tabData.Container then

                        local isActive = tabData.Container == self.ActiveTab

                        if not isActive then
                            local currentTheme = SimpleUI.ThemeManager:GetCurrentTheme(self)
                            local targetColor = expanded and currentTheme.Secondary or currentTheme.Secondary
                            local targetTransparency = expanded and (currentTheme.TransparencySecondary or 0.8) or 1

                            TweenService:Create(tabData.Container, TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad),
                                {
                                    BackgroundColor3 = targetColor,
                                    BackgroundTransparency = targetTransparency
                                }):Play()
                        end

                        TweenService:Create(tabData.Container, TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad), {
                            Size = UDim2.new(1, -8, 0, expanded and 32 or 44)
                        }):Play()

                        if tabData.Icon then
                            local iconSize = expanded and const.TabIconSizeExpanded or 24
                            TweenService:Create(tabData.Icon, TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad), {
                                Size = UDim2.new(0, iconSize, 0, iconSize)
                            }):Play()
                        end

                        if tabData.TextLabel then
                            if expanded then
                                tabData.TextLabel.Visible = true
                                TweenService:Create(tabData.TextLabel,
                                    TweenInfo.new(tweenDuration * 0.5, Enum.EasingStyle.Quad), {
                                        TextTransparency = 0
                                    }):Play()
                            else
                                TweenService:Create(tabData.TextLabel,
                                    TweenInfo.new(tweenDuration * 0.5, Enum.EasingStyle.Quad), {
                                        TextTransparency = 1
                                    }):Play()
                                task.delay(tweenDuration * 0.5, function()
                                    if not self.TabsExpanded then
                                        tabData.TextLabel.Visible = false
                                    end
                                end)
                            end
                        end

                        if tabData.ContentContainer then
                            TweenService:Create(tabData.ContentContainer,
                                TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad), expanded and {
                                    Position = UDim2.new(0, 0, 0, 0),
                                    AnchorPoint = Vector2.new(0, 0)
                                } or {
                                    Position = UDim2.new(0.5, 0, 0.5, 0),
                                    AnchorPoint = Vector2.new(0.5, 0.5)
                                }):Play()
                        end

                        if tabData.AccentLine then
                            local isActive = tabData.Container == self.ActiveTab
                            if isActive then
                                TweenService:Create(tabData.AccentLine,
                                    TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad), {
                                        BackgroundTransparency = expanded and 1 or 0
                                    }):Play()
                            end
                        end
                    end
                end

                task.delay(tweenDuration, function()
                    for _, tabData in pairs(self.Elements.Tabs) do
                        if type(tabData) == "table" and tabData.RefreshVisuals then
                            tabData.RefreshVisuals()
                        end
                    end
                end)
            end

            if mode == modes.Fixed then
                setExpanded(true, animate)
            elseif mode == modes.Closed then
                setExpanded(false, animate)
            elseif mode == modes.Dynamic then
                setExpanded(false, animate)
                local mouseInside = false
                local expandConnection = nil

                local function scheduleExpand()
                    if expandConnection then
                        expandConnection:Disconnect()
                    end
                    expandConnection = task.spawn(function()
                        task.wait(threshold)
                        if mouseInside and self.TabMode == modes.Dynamic then
                            setExpanded(true, true)
                        end
                        expandConnection = nil
                    end)
                end

                tabsContainer.MouseEnter:Connect(function()
                    if self.TabMode ~= modes.Dynamic then
                        return
                    end
                    mouseInside = true
                    scheduleExpand()
                end)

                tabsContainer.MouseLeave:Connect(function()
                    mouseInside = false
                    if expandConnection then
                        task.cancel(expandConnection)
                        expandConnection = nil
                    end
                    if self.TabMode == modes.Dynamic then
                        setExpanded(false, true)
                    end
                end)
            end
        end,

        AddFooterText = function(self, config)
            if not footer or not footerContent then
                return nil
            end
            config = config or {}

            local currentTheme = SimpleUI.ThemeManager:GetCurrentTheme(self)
            local properties, bindings = SimpleUI.Utility:ApplyTheme({
                Name = config.Name or "FooterText",
                LayoutOrder = config.Order or 1,
                Size = UDim2.new(0, 0, 1, 0),
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundTransparency = 1,
                Text = config.Text or "",
                TextSize = config.TextSize or 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = footer.ZIndex + 2
            }, {
                Font = "FontSecondary",
                TextColor3 = config.ColorTier or "TextSecondary"
            }, currentTheme)

            local label = SimpleUI.Utility:CreateInstance("TextLabel", properties, footerContent)
            if bindings then
                SimpleUI.ThemeManager:RegisterElement(self, label, bindings)
            end
            return label
        end,

        SetFooterText = function(self, element, newText)
            if element and element:IsA("TextLabel") then
                element.Text = tostring(newText)
            end
        end,

        AddFooterButton = function(self, config)
            if not footer or not footerContent then
                return nil
            end
            config = config or {}

            local currentTheme = SimpleUI.ThemeManager:GetCurrentTheme(self)
            local buttonText = config.Text or "Button"
            local callback = config.Callback or function()
            end

            local properties, bindings = SimpleUI.Utility:ApplyTheme({
                Name = config.Name or buttonText,
                LayoutOrder = config.Order or 1,
                Size = UDim2.new(0, config.Width or 80, 1, -8),
                Text = buttonText,
                TextSize = config.TextSize or 14,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                ZIndex = footer.ZIndex + 2
            }, {
                Font = "FontSecondary",
                TextColor3 = "TextPrimary",
                BackgroundColor3 = "Tertiary"
            }, currentTheme)

            local button = SimpleUI.Utility:CreateInstance("TextButton", properties, footerContent)
            SimpleUI.Utility:CreateInstance("UICorner", {
                CornerRadius = UDim.new(0, SimpleUI.Constants.Corner.Medium)
            }, button)

            if not SimpleUI.Utility:IsMobile() then
                button.MouseEnter:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.15), {
                        BackgroundColor3 = currentTheme.TertiaryHover
                    }):Play()
                end)
                button.MouseLeave:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.15), {
                        BackgroundColor3 = currentTheme.Tertiary
                    }):Play()
                end)
            end

            button.Activated:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.1), {
                    BackgroundColor3 = currentTheme.TertiaryPressed
                }):Play()
                task.wait(0.1)
                TweenService:Create(button, TweenInfo.new(0.1), {
                    BackgroundColor3 = currentTheme.Tertiary
                }):Play()
                SimpleUI.ErrorHandler:Try(function()
                    SimpleUI.Security:SafeCallback(callback())
                end)
            end)

            if bindings then
                SimpleUI.ThemeManager:RegisterElement(self, button, bindings)
            end
            return button
        end,

        ClearFooter = function(self)
            if footerContent then
                for _, child in ipairs(footerContent:GetChildren()) do
                    if not child:IsA("UIListLayout") then
                        child:Destroy()
                    end
                end
            end
        end,

        SetFooterAlignment = function(self, alignment)
            if footerContent then
                local layout = footerContent:FindFirstChildOfClass("UIListLayout")
                if layout then
                    layout.HorizontalAlignment = alignment
                end
            end
        end,

        Hide = function(self)
            mainFrame.Visible = false
        end,

        Show = function(self)
            mainFrame.Visible = true
        end,

        Toggle = function(self)
            mainFrame.Visible = not mainFrame.Visible
        end,

        Destroy = function(self)
            self._connections:Cleanup()
            SimpleUI.Windows[screenGui] = nil
            screenGui:Destroy()
        end,

        IsVisible = function(self)
            return mainFrame.Visible
        end,

        SetOpacity = function(self, value, animate)
            value = math.clamp(tonumber(value) or 1, 0, 1)
            local tweenDuration = animate and SimpleUI.Constants.Animation.Normal or 0

            for _, element in ipairs({topBar, mainContainer, footer}) do
                if element then
                    local originalTransparency = element:GetAttribute("OriginalTransparency")
                    if not originalTransparency then
                        originalTransparency = element.BackgroundTransparency
                        element:SetAttribute("OriginalTransparency", originalTransparency)
                    end

                    local newTransparency = 1 - ((1 - originalTransparency) * value)

                    if animate then
                        TweenService:Create(element, TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad), {
                            BackgroundTransparency = newTransparency
                        }):Play()
                    else
                        element.BackgroundTransparency = newTransparency
                    end
                end
            end
        end,

        EnableBlur = function(self, intensity)
            pcall(function()
                intensity = math.clamp(tonumber(intensity) or 24, 0, 56)
                local existing = Lighting:FindFirstChild("SimpleUIBlur")
                if existing then
                    existing.Size = intensity
                else
                    local blur = Instance.new("BlurEffect")
                    blur.Name = "SimpleUIBlur"
                    blur.Size = intensity
                    blur.Parent = Lighting
                end
            end)
        end,

        DisableBlur = function(self)
            pcall(function()
                local existing = Lighting:FindFirstChild("SimpleUIBlur")
                if existing then
                    existing:Destroy()
                end
            end)
        end
    }

    self.Windows[screenGui] = window
    self.ThemeManager:Initialize(window)

    if mainFrameBindings then
        self.ThemeManager:RegisterElement(window, mainFrame, mainFrameBindings)
    end
    if footer and footerBindings then
        self.ThemeManager:RegisterElement(window, footer, footerBindings)
    end
    if separatorBindings and separatorBindings.Element then
        self.ThemeManager:RegisterElement(window, separatorBindings.Element, separatorBindings.Bindings)
    end
    if topBarSeparatorBindings then
        self.ThemeManager:RegisterElement(window, topBarSeparator, topBarSeparatorBindings)
    end
    if tabsSeparatorBindings then
        self.ThemeManager:RegisterElement(window, tabsSeparator, tabsSeparatorBindings)
    end

    if tabNameLabel then
        self.ThemeManager:RegisterElement(window, tabNameLabel, {
            TextColor3 = "TextPrimary",
            Font = "FontPrimary"
        })
    end

    if tabDescLabel then
        self.ThemeManager:RegisterElement(window, tabDescLabel, {
            TextColor3 = "TextSecondary",
            Font = "FontSecondary"
        })
    end

    if brandTitleLabel then
        self.ThemeManager:RegisterElement(window, brandTitleLabel, {
            TextColor3 = "TextPrimary",
            Font = "FontPrimary"
        })
    end

    if brandInitialElement then
        self.ThemeManager:RegisterElement(window, brandInitialElement, {
            TextColor3 = "TextPrimary"
        })
    end

    self.WindowControlBuilder:RegisterIconBindings(window, controlButtons, options)

    self.WindowBuilder:SetupDragging(topBar, mainFrame)

    local resizeHandle, resizeIcon, resizeBindings = self.WindowBuilder:SetupResizing(mainFrame, uiScale, options,
        window.Elements.FooterResizeArea, ResizeMode, theme)

    self.WindowBuilder:SetupScrollUpdates(window)

    if resizeBindings then
        self.ThemeManager:RegisterMultiple(window, resizeBindings)
    end

    for _, methodName in ipairs({"Destroy", "SetTheme", "SetScale", "Hide", "Show", "Toggle", "IsVisible", "SetTitle",
                                 "SetSubtitle", "AddFooterButton", "ClearFooter", "SetFooterAlignment", "SetOpacity",
                                 "EnableBlur", "DisableBlur", "SetTabMode", "PopulateFooter"}) do
        if window[methodName] then
            window[methodName] = self.Security:WrapFunction(window[methodName])
        end
    end

    if footer and options.FooterItems then
        self.WindowBuilder:PopulateFooter(window, options, theme)
    end

    if options.StartHidden then
        mainFrame.Visible = false
    end

    if options.TabMode then
        window:SetTabMode(options.TabMode, true, options.TabDynamicThreshold)
    end

    if options.InitialOpacity then
        window:SetOpacity(options.InitialOpacity, false)
    end

    return window
end

function SimpleUI:CreateTab(Window, Name, Options)
    if not Window or not Window.Elements or not Window.Elements.TabsContainer then
        return
    end
    Options = Options or {}
    local Theme = self.ThemeManager:GetCurrentTheme(Window)
    local IsMobile = self.Utility:IsMobile()

    if not Window.TabActivationLock then
        Window.TabActivationLock = false
    end

    local Tab = self.Utility:CreateInstance("TextButton", {
        Name = Name,
        Size = UDim2.new(1, -8, 0, Window.TabsExpanded and 32 or 44),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = self.Constants.ZIndex.Content,
        LayoutOrder = #Window.Elements.Tabs
    }, Window.Elements.TabsContainer)
    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, self.Constants.Corner.Medium)
    }, Tab)

    local AccentLine = self.Utility:CreateInstance("Frame", {
        Name = "AccentLine",
        Size = UDim2.new(0, 2, 0, 24),
        Position = UDim2.new(0, -4, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.TabAccent or Theme.Accent,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = self.Constants.ZIndex.Control + 2
    }, Tab)
    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, AccentLine)

    local ContentContainer = self.Utility:CreateInstance("Frame", {
        Name = "ContentContainer",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0, 0),
        BackgroundTransparency = 1,
        ZIndex = self.Constants.ZIndex.Content + 1
    }, Tab)
    self.Utility:CreateInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8)
    }, ContentContainer)
    self.Utility:CreateInstance("UIPadding", {
        PaddingLeft = UDim.new(0, self.Constants.Padding.Large),
        PaddingRight = UDim.new(0, self.Constants.Padding.Large)
    }, ContentContainer)

    local Icon = nil
    local IconSize = 0

    if Options.Icon and type(Options.Icon) == "table" and Options.Icon.Image then
        IconSize = Window.TabsExpanded and self.Constants.Window.TabIconSizeExpanded or 24
        local IconData = self.IconManager:WrapIcon(Options.Icon)

        Icon = self.Utility:CreateInstance("ImageLabel", {
            Name = "TabIcon",
            Image = IconData.Url,
            ImageColor3 = Theme.TextInactive,
            Size = UDim2.new(0, IconSize, 0, IconSize),
            ImageTransparency = 0,
            ImageRectOffset = IconData.ImageRectOffset,
            ImageRectSize = IconData.ImageRectSize,
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            ZIndex = self.Constants.ZIndex.Control
        }, ContentContainer)
    end

    local TextLabel = self.Utility:CreateInstance("TextLabel", {
        Name = "TabText",
        Text = Name,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -(IconSize > 0 and (IconSize + 8) or 0), 1, 0),
        AutomaticSize = Enum.AutomaticSize.None,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Font = Theme.FontSecondary,
        TextColor3 = Theme.TextInactive,
        LayoutOrder = 2,
        ZIndex = self.Constants.ZIndex.Control
    }, ContentContainer)

    local Page = self:CreatePage(Window, Name, Options)

    local TabState = {
        IsHovering = false
    }

    local function UpdateActiveBrandDisplay(TabName, TabOptions)
        local TabNameLabel = Window.Elements.TitleLabel
        local TabDescLabel = Window.Elements.SubtitleLabel

        if TabNameLabel then
            TabNameLabel.Text = TabName
        end
        if TabDescLabel then
            TabDescLabel.Text = TabOptions.Description or ""
        end
    end

    local function RefreshTabVisuals()
        local CurrentTheme = self.ThemeManager:GetCurrentTheme(Window)
        local IsCollapsed = not Window.TabsExpanded
        local IsActive = Window.ActiveTab == Tab

        if IsActive then
            Tab.BackgroundColor3 = CurrentTheme.SecondaryActive
            Tab.BackgroundTransparency = 0
            TextLabel.TextColor3 = CurrentTheme.TextActive
            if Icon then
                Icon.ImageColor3 = CurrentTheme.TabIconActive or CurrentTheme.TextActive
            end
            if IsCollapsed then
                AccentLine.BackgroundTransparency = 0
            else
                AccentLine.BackgroundTransparency = 1
            end
            UpdateActiveBrandDisplay(Name, Options)
        elseif TabState.IsHovering then
            Tab.BackgroundColor3 = CurrentTheme.Secondary
            Tab.BackgroundTransparency = 0
            TextLabel.TextColor3 = CurrentTheme.TextPrimary
            if Icon then
                Icon.ImageColor3 = CurrentTheme.TabIconHover or CurrentTheme.TextPrimary
            end
            AccentLine.BackgroundTransparency = 1
        else
            if IsCollapsed then
                Tab.BackgroundColor3 = CurrentTheme.Secondary
                Tab.BackgroundTransparency = 1
            else
                Tab.BackgroundColor3 = CurrentTheme.Secondary
                Tab.BackgroundTransparency = CurrentTheme.TransparencySecondary or 0.8
            end
            TextLabel.TextColor3 = CurrentTheme.TextInactive
            if Icon then
                Icon.ImageColor3 = CurrentTheme.TabIconInactive or CurrentTheme.TextInactive
            end
            AccentLine.BackgroundTransparency = 1
        end
    end

    if not IsMobile then
        Tab.MouseEnter:Connect(function()
            if Window.ActiveTab ~= Tab then
                TabState.IsHovering = true
                RefreshTabVisuals()
            end
        end)
        Tab.MouseLeave:Connect(function()
            TabState.IsHovering = false
            RefreshTabVisuals()
        end)
    end

    Tab.Activated:Connect(function()
        if Window.TabActivationLock then
            return
        end
        if Window.ActiveTab == Tab then
            return
        end

        Window.TabActivationLock = true

        if Window.ActivePage then
            local pageToHide = Window.ActivePage
            if type(pageToHide) == "table" and pageToHide.Container then
                pageToHide = pageToHide.Container
            end
            pageToHide.Visible = false
        end

        Window.ActiveTab = Tab

        local CurrentPage = Window.Elements.ContentsContainer:FindFirstChild(Name .. "Page")
        if CurrentPage then
            Page = CurrentPage
            if type(Page) == "table" and Page._isDualScroll then
                Page.Left = self.ScrollManager:Update(Page.Left)
                Page.Right = self.ScrollManager:Update(Page.Right)
            else
                Page = self.ScrollManager:Update(Page)
            end
            Window.Elements.Pages[Name] = Page
        end
        Window.ActivePage = Page
        local pageToShow = Window.ActivePage
        if type(pageToShow) == "table" and pageToShow.Container then
            pageToShow = pageToShow.Container
        end
        pageToShow.Visible = true

        for TabName, TabData in pairs(Window.Elements.Tabs) do
            TabData.State.IsHovering = false
            TabData.RefreshVisuals()
        end

        task.delay(0.15, function()
            Window.TabActivationLock = false
        end)
    end)

    Window.Elements.Tabs[Name] = {
        Container = Tab,
        Icon = Icon,
        ContentContainer = ContentContainer,
        TextLabel = TextLabel,
        AccentLine = AccentLine,
        Page = Page,
        RefreshVisuals = RefreshTabVisuals,
        State = TabState
    }

    local ThemeBindings = {
        [AccentLine] = {
            BackgroundColor3 = function(Element, CurrentTheme)
                Element.BackgroundColor3 = CurrentTheme.TabAccent or CurrentTheme.Accent
            end
        },
        [TextLabel] = {
            Font = "FontSecondary"
        },
        [Tab] = {
            BackgroundColor3 = function(Element, CurrentTheme)
                RefreshTabVisuals()
            end,
            BackgroundTransparency = function(Element, CurrentTheme)
                RefreshTabVisuals()
            end
        }
    }

    if Icon then
        ThemeBindings[Icon] = {
            ImageColor3 = function(Element, CurrentTheme)
                RefreshTabVisuals()
            end
        }
    end

    if Window then
        self.ThemeManager:RegisterMultiple(Window, ThemeBindings)
    end

    if not Window.ActiveTab then
        Window.ActiveTab = Tab
        Window.ActivePage = Page
        local pageToShow = Window.ActivePage
        if type(pageToShow) == "table" and pageToShow.Container then
            pageToShow = pageToShow.Container
        end
        pageToShow.Visible = true
    else
        Page.Visible = false
    end

    RefreshTabVisuals()

    return {
        Tab = Tab,
        Page = Page,
        Icon = Icon,
        AccentLine = AccentLine
    }
end

function SimpleUI:CreatePage(Window, Name, Options)
    if not Window or not Window.Elements or not Window.Elements.ContentsContainer then
        return
    end
    Options = Options or {}
    local IsDualScroll = Options.DualScroll or false

    if not IsDualScroll then
        local Page = self.Utility:CreateInstance("Frame", {
            Name = Name .. "Page",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = self.Constants.ZIndex.Content,
            ClipsDescendants = false
        }, Window.Elements.ContentsContainer)
        self.Utility:CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, self.Constants.Spacing.Loose)
        }, Page)
        self.Utility:CreateInstance("UIPadding", {
            PaddingTop = UDim.new(0, 2),
            PaddingBottom = UDim.new(0, 0),
            PaddingLeft = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 2)
        }, Page)
        Window.Elements.Pages[Name] = Page
        task.defer(function()
            if Window.ActivePage then
                local pageToUpdate = Window.ActivePage
                if type(pageToUpdate) == "table" and pageToUpdate.Container then
                    pageToUpdate = pageToUpdate.Container
                end
                Window.ActivePage = self.ScrollManager:Update(pageToUpdate)
            end
        end)
        return Page
    else
        local PageContainer = self.Utility:CreateInstance("Frame", {
            Name = Name .. "Page",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = self.Constants.ZIndex.Content,
            ClipsDescendants = false
        }, Window.Elements.ContentsContainer)

        self.Utility:CreateInstance("UIPadding", {
            PaddingTop = UDim.new(0, 2),
            PaddingBottom = UDim.new(0, 0),
            PaddingLeft = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 2)
        }, PageContainer)

        self.Utility:CreateInstance("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        }, PageContainer)

        local LeftPage = self.Utility:CreateInstance("Frame", {
            Name = Name .. "PageLeft",
            Size = UDim2.new(0.5, -4, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = self.Constants.ZIndex.Content,
            ClipsDescendants = false,
            LayoutOrder = 1
        }, PageContainer)

        self.Utility:CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, self.Constants.Spacing.Loose)
        }, LeftPage)

        self.Utility:CreateInstance("UIPadding", {
            PaddingTop = UDim.new(0, 2),
            PaddingBottom = UDim.new(0, 2),
            PaddingLeft = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 2)
        }, LeftPage)
        local RightPage = self.Utility:CreateInstance("Frame", {
            Name = Name .. "PageRight",
            Size = UDim2.new(0.5, -4, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = self.Constants.ZIndex.Content,
            ClipsDescendants = false,
            LayoutOrder = 2
        }, PageContainer)

        self.Utility:CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, self.Constants.Spacing.Loose)
        }, RightPage)

        self.Utility:CreateInstance("UIPadding", {
            PaddingTop = UDim.new(0, 2),
            PaddingBottom = UDim.new(0, 2),
            PaddingLeft = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 2)
        }, RightPage)
        local PageWrapper = {
            Container = PageContainer,
            Left = LeftPage,
            Right = RightPage,
            _isDualScroll = true
        }

        Window.Elements.Pages[Name] = PageWrapper

        task.defer(function()
            PageWrapper.Left = self.ScrollManager:Update(PageWrapper.Left)
            PageWrapper.Right = self.ScrollManager:Update(PageWrapper.Right)
        end)

        return PageWrapper
    end
end

function SimpleUI:CreateSection(Page, Text, Options)
    if not Page then
        return
    end
    Options = Options or {}
    local Theme = self.ThemeManager:GetCurrentTheme(self.Utility:GetWindowFromElement(Page))
    local Window = self.Utility:GetWindowFromElement(Page)
    local Style = Options.Style or "solid"

    if Style == "box" then
        return self.SectionManager:CreateBoxSection(Page, Text, Options, Theme, Window)
    else
        return self.SectionManager:CreateSimpleSection(Page, Text, Options, Theme, Window, Style)
    end
end

function SimpleUI:CreateButton(Page, Text, Callback, Options)
    local EH = self.ErrorHandler
    if not EH:ValidateInstance(Page, "GuiObject", "CreateButton") then
        return nil
    end
    if not EH:ValidateType(Text, "string", "Text", "CreateButton") then
        Text = "Button"
    end
    if Callback then
        Callback = (EH:ValidateType(Callback, "function", "Callback", "CreateButton") == false) and nil or Callback
    end
    Options = Options or {}
    local Theme = self.ThemeManager:GetCurrentTheme(self.Utility:GetWindowFromElement(Page))
    local IsMobile = self.Utility:IsMobile()
    local Window = self.Utility:GetWindowFromElement(Page)
    local HasDescription = Options.Description and Options.Description ~= ""

    local Zones = self.ComponentBuilder:CreateContainer({
        Parent = Page,
        Layout = "TextLeft",
        TextWidth = 0.85,
        MinHeight = 35,
        Padding = HasDescription and {
            Top = self.Constants.Padding.Large,
            Bottom = self.Constants.Padding.Large,
            Left = self.Constants.Padding.Large,
            Right = self.Constants.Padding.Small
        } or {
            Top = 2,
            Bottom = 2,
            Left = self.Constants.Padding.Large,
            Right = self.Constants.Padding.Small
        },
        Spacing = HasDescription and self.Constants.Spacing.Tight or 0,
        HasDescription = HasDescription,
        CornerRadius = self.Constants.Corner.Medium,
        ColorTier = "Secondary"
    }, Theme)

    local Title = self.ComponentBuilder:CreateLabel(Zones.TextZone, Text, Theme, {
        ColorTier = "TextPrimary",
        Size = 15,
        Order = 1
    })

    local Description = HasDescription and
                            self.ComponentBuilder:CreateDescription(Zones.TextZone, Options.Description, Theme, 2) or
                            nil

    local ArrowContainer = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(0.15, -self.Constants.Padding.Large, 1, 0),
        Position = UDim2.new(0.85, 0, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = self.Constants.ZIndex.Overlay
    }, Zones.Container)

    local Arrow = self.Utility:CreateInstance("ImageLabel", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://113826256227095",
        ImageRectOffset = Vector2.new(448, 192),
        ImageRectSize = Vector2.new(64, 64),
        ImageColor3 = Theme.TextPrimary,
        ZIndex = self.Constants.ZIndex.Overlay
    }, ArrowContainer)

    local ThemeBindings = {
        [Zones.Container] = {
            BackgroundColor3 = "Secondary",
            BackgroundTransparency = "TransparencySecondary"
        },
        [Title] = {
            TextColor3 = "TextPrimary",
            Font = "FontSecondary"
        },
        [Arrow] = {
            ImageColor3 = "TextPrimary"
        }
    }
    if Description then
        ThemeBindings[Description] = {
            TextColor3 = "TextSecondary",
            Font = "FontSecondary"
        }
    end
    if Window then
        self.ThemeManager:RegisterMultiple(Window, ThemeBindings)
    end

    local State = "Base"
    local IsHeld = false

    local function UpdateButtonState(NewState)
        local CurrentTheme = Window and self.ThemeManager:GetCurrentTheme(Window) or Theme
        local ColorGoal = CurrentTheme.Secondary
        local ArrowOffset = 0

        if NewState == "Hover" then
            ColorGoal = CurrentTheme.SecondaryHover
            ArrowOffset = -2
        elseif NewState == "Pressed" then
            ColorGoal = CurrentTheme.SecondaryPressed
            ArrowOffset = 2
        end

        TweenService:Create(Zones.Container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            BackgroundColor3 = ColorGoal
        }):Play()

        TweenService:Create(Arrow, TweenInfo.new(0.15, Enum.EasingStyle.Back, NewState == "Pressed" and
            Enum.EasingDirection.In or Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -10 + ArrowOffset, 0.5, 0)
        }):Play()
    end

    local InteractButton = self.Utility:CreateInstance("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        ZIndex = self.Constants.ZIndex.Modal
    }, Zones.Container)

    if not IsMobile then
        InteractButton.MouseEnter:Connect(function()
            if not IsHeld then
                State = "Hover"
                UpdateButtonState(State)
            end
        end)
        InteractButton.MouseLeave:Connect(function()
            if IsHeld then
                IsHeld = false
            end
            State = "Base"
            UpdateButtonState(State)
        end)
        InteractButton.MouseButton1Down:Connect(function()
            IsHeld = true
            State = "Pressed"
            UpdateButtonState(State)
        end)
        InteractButton.MouseButton1Up:Connect(function()
            if IsHeld then
                IsHeld = false
                State = "Hover"
                UpdateButtonState(State)
                if Callback then
                    EH:Try(Callback)
                end
            end
        end)
    else
        InteractButton.Activated:Connect(function()
            State = "Pressed"
            UpdateButtonState(State)
            task.delay(0.15, function()
                State = "Base"
                UpdateButtonState(State)
            end)
            if Callback then
                EH:Try(Callback)
            end
        end)
    end

    return {
        SetTitle = function(self, NewText)
            if EH:ValidateType(NewText, "string", "NewText", "Button:SetTitle") then
                Title.Text = NewText
            end
        end,
        SetDescription = function(self, NewDescription)
            local HadDescription = Description ~= nil and Description.Visible
            local HasNewDescription = NewDescription and NewDescription ~= ""
            if Description and NewDescription then
                Description.Text = NewDescription
                Description.Visible = true
            elseif Description and not NewDescription then
                Description.Visible = false
            elseif not Description and NewDescription then
                Description = SimpleUI.ComponentBuilder:CreateDescription(Zones.TextZone, NewDescription, Theme, 2)
                if Window then
                    SimpleUI.ThemeManager:RegisterElement(Window, Description, {
                        TextColor3 = "TextSecondary",
                        Font = "FontSecondary"
                    })
                end
            end
            if HadDescription ~= HasNewDescription then
                SimpleUI.ComponentBuilder:UpdateDescriptionPadding(Zones, HasNewDescription)
            end
        end,
        SetCallback = function(self, NewCallback)
            if EH:ValidateType(NewCallback, "function", "NewCallback", "Button:SetCallback") then
                Callback = NewCallback
            end
        end,
        SetVisible = function(self, Visible)
            if EH:ValidateType(Visible, "boolean", "Visible", "Button:SetVisible") then
                Zones.Container.Visible = Visible
            end
        end,
        GetElements = function(self)
            return {
                Container = Zones.Container,
                Title = Title,
                Description = Description,
                Arrow = Arrow
            }
        end,
        GetState = function(self)
            return State
        end
    }
end

function SimpleUI:CreateToggle(Page, Text, DefaultValue, Callback, Options)
    local EH = self.ErrorHandler
    if not EH:ValidateInstance(Page, "GuiObject", "CreateToggle") then
        return nil
    end
    if not EH:ValidateType(Text, "string", "Text", "CreateToggle") then
        Text = "Toggle"
    end
    if DefaultValue ~= nil and not EH:ValidateType(DefaultValue, "boolean", "DefaultValue", "CreateToggle") then
        DefaultValue = false
    end
    if Callback then
        Callback = (EH:ValidateType(Callback, "function", "Callback", "CreateToggle") == false) and nil or Callback
    end
    Options = Options or {}
    local SaveBinding = self.SaveManager:GetBinding(Options, "Toggle", Text)
    if SaveBinding.Enabled and type(SaveBinding.Value) == "boolean" then
        DefaultValue = SaveBinding.Value
    end
    local Theme = self.ThemeManager:GetCurrentTheme(self.Utility:GetWindowFromElement(Page))
    local Window = self.Utility:GetWindowFromElement(Page)
    local HasDescription = Options.Description and Options.Description ~= ""

    local Zones = self.ComponentBuilder:CreateContainer({
        Parent = Page,
        Layout = "TextLeft",
        TextWidth = 0.75,
        MinHeight = 35,
        Padding = HasDescription and {
            Top = self.Constants.Padding.Large,
            Bottom = self.Constants.Padding.Large,
            Left = self.Constants.Padding.Large,
            Right = self.Constants.Padding.Small
        } or {
            Top = 2,
            Bottom = 2,
            Left = self.Constants.Padding.Large,
            Right = self.Constants.Padding.Small
        },
        Spacing = HasDescription and self.Constants.Spacing.Tight or 0,
        HasDescription = HasDescription,
        CornerRadius = self.Constants.Corner.Medium,
        ColorTier = "Secondary"
    }, Theme)

    local Label = self.ComponentBuilder:CreateLabel(Zones.TextZone, Text, Theme, {
        ColorTier = "TextPrimary",
        Size = 14,
        Order = 1
    })

    local Description = HasDescription and
                            self.ComponentBuilder:CreateDescription(Zones.TextZone, Options.Description, Theme, 2) or
                            nil

    local SwitchContainer = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(0.25, -self.Constants.Padding.Large, 1, 0),
        Position = UDim2.new(0.75, 0, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = self.Constants.ZIndex.Overlay
    }, Zones.Container)

    local Switch = self.Utility:CreateInstance("TextButton", {
        Size = UDim2.new(0, 44, 0, 22),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Theme.SecondaryPressed,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = self.Constants.ZIndex.Overlay
    }, SwitchContainer)

    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, Switch)

    local Indicator = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0, 2, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.TextInactive,
        BorderSizePixel = 0,
        ZIndex = self.Constants.ZIndex.Modal
    }, Switch)

    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, Indicator)

    local State = DefaultValue or false

    local function UpdateToggle(Animate)
        local CurrentTheme = Window and self.ThemeManager:GetCurrentTheme(Window) or Theme
        local PositionGoal = State and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
        local ColorGoal = State and CurrentTheme.Accent or CurrentTheme.SecondaryPressed
        local IndicatorColorGoal = State and CurrentTheme.TextActive or CurrentTheme.TextInactive

        if Animate then
            TweenService:Create(Indicator, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = PositionGoal
            }):Play()
            TweenService:Create(Switch, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = ColorGoal
            }):Play()
            TweenService:Create(Indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = IndicatorColorGoal
            }):Play()
        else
            Indicator.Position = PositionGoal
            Switch.BackgroundColor3 = ColorGoal
            Indicator.BackgroundColor3 = IndicatorColorGoal
        end
    end

    local ThemeBindings = {
        [Zones.Container] = {
            BackgroundColor3 = "Secondary",
            BackgroundTransparency = "TransparencySecondary"
        },
        [Label] = {
            TextColor3 = "TextPrimary",
            Font = "FontSecondary"
        },
        [Switch] = {
            BackgroundColor3 = function()
                UpdateToggle(false)
            end
        },
        [Indicator] = {
            BackgroundColor3 = function()
                UpdateToggle(false)
            end
        }
    }
    if Description then
        ThemeBindings[Description] = {
            TextColor3 = "TextSecondary",
            Font = "FontSecondary"
        }
    end
    if Window then
        self.ThemeManager:RegisterMultiple(Window, ThemeBindings)
    end

    UpdateToggle(false)

    if Callback and ((SaveBinding.HasValue and SaveBinding.ApplyCallback) or (not SaveBinding.HasValue and State)) then
        EH:Try(function()
            Callback(State)
        end)
    end

    Switch.Activated:Connect(function()
        State = not State
        UpdateToggle(true)
        SimpleUI.SaveManager:WriteBinding(SaveBinding, State)
        if Callback then
            EH:Try(function()
                Callback(State)
            end)
        end
    end)

    return {
        GetState = function(self)
            return State
        end,
        SetState = function(self, Value)
            if EH:ValidateType(Value, "boolean", "Value", "Toggle:SetState") then
                State = Value
                UpdateToggle(true)
                SimpleUI.SaveManager:WriteBinding(SaveBinding, State)
            end
        end,
        SetDescription = function(self, NewDescription)
            local HadDescription = Description ~= nil and Description.Visible
            local HasNewDescription = NewDescription and NewDescription ~= ""
            if Description and NewDescription then
                Description.Text = NewDescription
                Description.Visible = true
            elseif Description and not NewDescription then
                Description.Visible = false
            elseif not Description and NewDescription then
                Description = SimpleUI.ComponentBuilder:CreateDescription(Zones.TextZone, NewDescription, Theme, 2)
                if Window then
                    SimpleUI.ThemeManager:RegisterElement(Window, Description, {
                        TextColor3 = "TextSecondary",
                        Font = "FontSecondary"
                    })
                end
            end
            if HadDescription ~= HasNewDescription then
                SimpleUI.ComponentBuilder:UpdateDescriptionPadding(Zones, HasNewDescription)
            end
        end,
        GetElements = function(self)
            return {
                Container = Zones.Container,
                Label = Label,
                Description = Description,
                Switch = Switch,
                Indicator = Indicator
            }
        end
    }
end

function SimpleUI:CreateTextInput(Page, Text, DefaultValue, Callback, Options)
    local EH = self.ErrorHandler
    if not EH:ValidateInstance(Page, "GuiObject", "CreateTextInput") then
        return nil
    end
    if not EH:ValidateType(Text, "string", "Text", "CreateTextInput") then
        Text = "Input"
    end
    if DefaultValue and not EH:ValidateType(DefaultValue, "string", "DefaultValue", "CreateTextInput") then
        DefaultValue = ""
    end
    if Callback then
        Callback = (EH:ValidateType(Callback, "function", "Callback", "CreateTextInput") == false) and nil or Callback
    end

    Options = Options or {}
    local SaveBinding = self.SaveManager:GetBinding(Options, "TextInput", Text)
    if SaveBinding.Enabled and type(SaveBinding.Value) == "string" then
        DefaultValue = SaveBinding.Value
    end
    local InputType = Options.Type or "Text"
    local ValidTypes = {
        Text = true,
        Numbers = true,
        Decimals = true,
        Alphanumeric = true
    }
    if not ValidTypes[InputType] then
        InputType = "Text"
    end

    local Theme = self.ThemeManager:GetCurrentTheme(self.Utility:GetWindowFromElement(Page))
    local IsMobile = self.Utility:IsMobile()
    local Window = self.Utility:GetWindowFromElement(Page)
    local HasDescription = Options.Description and Options.Description ~= ""

    local Zones = self.ComponentBuilder:CreateContainer({
        Parent = Page,
        Layout = "TextLeft",
        TextWidth = 0.55,
        MinHeight = 35,
        Padding = HasDescription and {
            Top = self.Constants.Padding.Large,
            Bottom = self.Constants.Padding.Large,
            Left = self.Constants.Padding.Large,
            Right = self.Constants.Padding.Small
        } or {
            Top = 2,
            Bottom = 2,
            Left = self.Constants.Padding.Large,
            Right = self.Constants.Padding.Small
        },
        Spacing = HasDescription and self.Constants.Spacing.Tight or 0,
        HasDescription = HasDescription,
        CornerRadius = self.Constants.Corner.Medium,
        ColorTier = "Secondary"
    }, Theme)

    local Label = self.ComponentBuilder:CreateLabel(Zones.TextZone, Text, Theme, {
        ColorTier = "TextPrimary",
        Size = 14,
        Order = 1
    })

    local Description = HasDescription and
                            self.ComponentBuilder:CreateDescription(Zones.TextZone, Options.Description, Theme, 2) or
                            nil

    local InputContainer = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(0.45, -self.Constants.Padding.Large, 1, 0),
        Position = UDim2.new(0.55, 0, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = self.Constants.ZIndex.Overlay
    }, Zones.Container)

    local InputBox = self.Utility:CreateInstance("TextBox", {
        Size = UDim2.new(1, -10, 0, 32),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Text = DefaultValue or "",
        PlaceholderText = Options.Placeholder or "Enter text...",
        TextColor3 = Theme.TextPrimary,
        PlaceholderColor3 = Theme.TextSecondary,
        TextSize = 13,
        Font = Theme.FontSecondary,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        ZIndex = self.Constants.ZIndex.Overlay
    }, InputContainer)

    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, self.Constants.Corner.Medium)
    }, InputBox)

    self.Utility:CreateInstance("UIPadding", {
        PaddingLeft = UDim.new(0, self.Constants.Padding.Medium),
        PaddingRight = UDim.new(0, self.Constants.Padding.Medium)
    }, InputBox)

    local Underline = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        ZIndex = self.Constants.ZIndex.Modal
    }, InputBox)

    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, Underline)

    local ErrorLabel = self.Utility:CreateInstance("TextLabel", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = Color3.fromRGB(255, 100, 100),
        TextSize = 11,
        Font = Theme.FontSecondary,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextWrapped = true,
        Visible = false,
        ZIndex = self.Constants.ZIndex.Overlay
    }, InputContainer)

    local ThemeBindings = {
        [Zones.Container] = {
            BackgroundColor3 = "Secondary",
            BackgroundTransparency = "TransparencySecondary"
        },
        [Label] = {
            TextColor3 = "TextPrimary",
            Font = "FontSecondary"
        },
        [InputBox] = {
            TextColor3 = "TextPrimary",
            PlaceholderColor3 = "TextSecondary",
            BackgroundColor3 = "Tertiary",
            Font = "FontSecondary"
        },
        [Underline] = {
            BackgroundColor3 = "Tertiary"
        }
    }
    if Description then
        ThemeBindings[Description] = {
            TextColor3 = "TextSecondary",
            Font = "FontSecondary"
        }
    end
    if Window then
        self.ThemeManager:RegisterMultiple(Window, ThemeBindings)
    end

    local IsFocused = false
    local LastValidValue = DefaultValue or ""

    local ValidationPatterns = {
        Numbers = "^%-?%d+$",
        Decimals = "^%-?%d*%.?%d*$",
        Alphanumeric = "^[%a%d]+$"
    }

    local function validateInput(inputValue)
        if InputType == "Text" then
            return true
        end
        if inputValue == "" or (InputType == "Decimals" and inputValue == "-") then
            return true
        end

        local pattern = ValidationPatterns[InputType]
        return pattern and string.match(inputValue, pattern) ~= nil
    end

    local function showError(message)
        ErrorLabel.Text = message
        ErrorLabel.Visible = true
        TweenService:Create(InputBox, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = Color3.fromRGB(100, 40, 40)
        }):Play()
    end

    local function clearError()
        ErrorLabel.Visible = false
        local CurrentTheme = Window and self.ThemeManager:GetCurrentTheme(Window) or Theme
        TweenService:Create(InputBox, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = CurrentTheme.Tertiary
        }):Play()
    end

    local function updateHover(state)
        if IsFocused then
            return
        end
        local CurrentTheme = Window and self.ThemeManager:GetCurrentTheme(Window) or Theme
        TweenService:Create(InputBox, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            BackgroundColor3 = state and CurrentTheme.TertiaryHover or CurrentTheme.Tertiary
        }):Play()
    end

    InputBox:GetPropertyChangedSignal("Text"):Connect(function()
        local currentText = InputBox.Text
        if not validateInput(currentText) then
            InputBox.Text = LastValidValue
            showError("Invalid " .. InputType)
        else
            LastValidValue = currentText
            if IsFocused then
                clearError()
            end
        end
    end)

    InputBox.Focused:Connect(function()
        IsFocused = true
        clearError()
        local CurrentTheme = Window and self.ThemeManager:GetCurrentTheme(Window) or Theme
        TweenService:Create(Underline, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            BackgroundColor3 = CurrentTheme.Accent,
            Size = UDim2.new(1, 0, 0, 3)
        }):Play()
        TweenService:Create(InputBox, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = CurrentTheme.TertiaryHover
        }):Play()
    end)

    InputBox.FocusLost:Connect(function()
        IsFocused = false
        local CurrentTheme = Window and self.ThemeManager:GetCurrentTheme(Window) or Theme
        TweenService:Create(Underline, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            BackgroundColor3 = CurrentTheme.TertiaryPressed,
            Size = UDim2.new(1, 0, 0, 2)
        }):Play()
        updateHover(false)
        if validateInput(InputBox.Text) then
            SimpleUI.SaveManager:WriteBinding(SaveBinding, InputBox.Text)
            if Callback then
                EH:Try(function()
                    Callback(InputBox.Text)
                end)
            end
        else
            InputBox.Text = LastValidValue
        end
    end)

    if not IsMobile then
        InputBox.MouseEnter:Connect(function()
            updateHover(true)
        end)
        InputBox.MouseLeave:Connect(function()
            updateHover(false)
        end)
    end

    if SaveBinding.HasValue and SaveBinding.ApplyCallback and Callback then
        EH:Try(function()
            Callback(InputBox.Text)
        end)
    end

    return {
        GetValue = function(self)
            return InputBox.Text
        end,
        SetValue = function(self, Value)
            if EH:ValidateType(Value, "string", "Value", "TextInput:SetValue") and validateInput(Value) then
                InputBox.Text = Value
                LastValidValue = Value
                clearError()
                SimpleUI.SaveManager:WriteBinding(SaveBinding, Value)
            end
        end,
        SetPlaceholder = function(self, Placeholder)
            if EH:ValidateType(Placeholder, "string", "Placeholder", "TextInput:SetPlaceholder") then
                InputBox.PlaceholderText = Placeholder
            end
        end,
        Clear = function(self)
            InputBox.Text = ""
            LastValidValue = ""
            clearError()
            SimpleUI.SaveManager:WriteBinding(SaveBinding, "")
        end,
        GetInputType = function(self)
            return InputType
        end,
        SetInputType = function(self, NewType)
            if ValidTypes[NewType] then
                InputType = NewType
                clearError()
            end
        end,
        SetDescription = function(self, NewDescription)
            local HadDescription = Description ~= nil and Description.Visible
            local HasNewDescription = NewDescription and NewDescription ~= ""
            if Description and NewDescription then
                Description.Text = NewDescription
                Description.Visible = true
            elseif Description and not NewDescription then
                Description.Visible = false
            elseif not Description and NewDescription then
                Description = SimpleUI.ComponentBuilder:CreateDescription(Zones.TextZone, NewDescription, Theme, 2)
                if Window then
                    SimpleUI.ThemeManager:RegisterElement(Window, Description, {
                        TextColor3 = "TextSecondary",
                        Font = "FontSecondary"
                    })
                end
            end
            if HadDescription ~= HasNewDescription then
                SimpleUI.ComponentBuilder:UpdateDescriptionPadding(Zones, HasNewDescription)
            end
        end,
        GetElements = function(self)
            return {
                Container = Zones.Container,
                Label = Label,
                Description = Description,
                InputBox = InputBox,
                Underline = Underline,
                ErrorLabel = ErrorLabel
            }
        end
    }
end

function SimpleUI:CreateKeybind(Page, Text, DefaultKey, Callback, Options)
    local EH = self.ErrorHandler
    if not EH:ValidateInstance(Page, "GuiObject", "CreateKeybind") then
        return nil
    end
    if not EH:ValidateType(Text, "string", "Text", "CreateKeybind") then
        Text = "Keybind"
    end
    if DefaultKey and typeof(DefaultKey) ~= "EnumItem" then
        EH:Guard(false, "CreateKeybind", "DefaultKey must be a KeyCode Enum", EH.Levels.WARN)
        DefaultKey = nil
    elseif DefaultKey and DefaultKey.EnumType ~= Enum.KeyCode then
        EH:Guard(false, "CreateKeybind", "DefaultKey must be a KeyCode (not " .. tostring(DefaultKey.EnumType) .. ")",
            EH.Levels.WARN)
        DefaultKey = nil
    end
    if Callback then
        Callback = (EH:ValidateType(Callback, "function", "Callback", "CreateKeybind") == false) and nil or Callback
    end
    Options = Options or {}
    local SaveBinding = self.SaveManager:GetBinding(Options, "Keybind", Text)
    if SaveBinding.Enabled and type(SaveBinding.Value) == "string" then
        local SavedKey = Enum.KeyCode[SaveBinding.Value]
        if SavedKey then
            DefaultKey = SavedKey
        end
    end
    local Theme = self.ThemeManager:GetCurrentTheme(self.Utility:GetWindowFromElement(Page))
    local IsMobile = self.Utility:IsMobile()
    local Window = self.Utility:GetWindowFromElement(Page)
    local HasDescription = Options.Description and Options.Description ~= ""

    local Zones = self.ComponentBuilder:CreateContainer({
        Parent = Page,
        Layout = "TextLeft",
        TextWidth = 0.65,
        MinHeight = 35,
        Padding = HasDescription and {
            Top = self.Constants.Padding.Large,
            Bottom = self.Constants.Padding.Large,
            Left = self.Constants.Padding.Large,
            Right = self.Constants.Padding.Small
        } or {
            Top = 2,
            Bottom = 2,
            Left = self.Constants.Padding.Large,
            Right = self.Constants.Padding.Small
        },
        Spacing = HasDescription and self.Constants.Spacing.Tight or 0,
        HasDescription = HasDescription,
        CornerRadius = self.Constants.Corner.Medium,
        ColorTier = "Secondary"
    }, Theme)

    local Label = self.ComponentBuilder:CreateLabel(Zones.TextZone, Text, Theme, {
        ColorTier = "TextPrimary",
        Size = 14,
        Order = 1
    })

    local Description = HasDescription and
                            self.ComponentBuilder:CreateDescription(Zones.TextZone, Options.Description, Theme, 2) or
                            nil

    local DisplayContainer = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(0.35, -self.Constants.Padding.Large, 1, 0),
        Position = UDim2.new(0.65, 0, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = self.Constants.ZIndex.Overlay
    }, Zones.Container)

    local Display = self.Utility:CreateInstance("TextButton", {
        Size = UDim2.new(1, -10, 0, 32),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = self.Constants.ZIndex.Overlay
    }, DisplayContainer)

    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, self.Constants.Corner.Medium)
    }, Display)

    self.Utility:CreateInstance("UIPadding", {
        PaddingLeft = UDim.new(0, self.Constants.Padding.Medium),
        PaddingRight = UDim.new(0, self.Constants.Padding.Medium)
    }, Display)

    local DisplayLabel = self.Utility:CreateInstance("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = Theme.TextPrimary,
        TextSize = 13,
        Font = Theme.FontSecondary,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = self.Constants.ZIndex.Modal
    }, Display)

    local ThemeBindings = {
        [Zones.Container] = {
            BackgroundColor3 = "Secondary",
            BackgroundTransparency = "TransparencySecondary"
        },
        [Label] = {
            TextColor3 = "TextPrimary",
            Font = "FontSecondary"
        },
        [DisplayLabel] = {
            TextColor3 = "TextPrimary",
            Font = "FontSecondary"
        }
    }
    if Description then
        ThemeBindings[Description] = {
            TextColor3 = "TextSecondary",
            Font = "FontSecondary"
        }
    end
    if Window then
        self.ThemeManager:RegisterMultiple(Window, ThemeBindings)
    end

    local CurrentKey = DefaultKey
    local IsListening = false
    local BindConnection
    local InputConnection

    local function UpdateDisplay()
        local CurrentTheme = Window and self.ThemeManager:GetCurrentTheme(Window) or Theme
        if IsListening then
            DisplayLabel.Text = "Press a key..."
            TweenService:Create(Display, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = CurrentTheme.Accent
            }):Play()
            TweenService:Create(DisplayLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                TextColor3 = CurrentTheme.TextActive
            }):Play()
        else
            DisplayLabel.Text = CurrentKey and CurrentKey.Name or "None"
            TweenService:Create(Display, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = CurrentTheme.Tertiary
            }):Play()
            TweenService:Create(DisplayLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                TextColor3 = CurrentTheme.TextPrimary
            }):Play()
        end
    end

    local function SetupBind()
        if BindConnection then
            BindConnection:Disconnect()
        end
        if CurrentKey and Callback then
            BindConnection = UserInputService.InputBegan:Connect(
                function(Input, GameProcessed)
                    if not GameProcessed and Input.KeyCode == CurrentKey then
                        EH:Try(function()
                            Callback(CurrentKey)
                        end)
                    end
                end)
        end
    end

    Display.Activated:Connect(function()
        if IsListening then
            return
        end
        IsListening = true
        UpdateDisplay()
        InputConnection = UserInputService.InputBegan:Connect(
            function(Input, GameProcessed)
                if Input.UserInputType == Enum.UserInputType.Keyboard then
                    CurrentKey = Input.KeyCode
                    IsListening = false
                    if InputConnection then
                        InputConnection:Disconnect()
                        InputConnection = nil
                    end
                    UpdateDisplay()
                    SetupBind()
                    SimpleUI.SaveManager:WriteBinding(SaveBinding, CurrentKey and CurrentKey.Name or nil)
                end
            end)
    end)

    if not IsMobile then
        Display.MouseEnter:Connect(function()
            if not IsListening then
                local CurrentTheme = Window and self.ThemeManager:GetCurrentTheme(Window) or Theme
                TweenService:Create(Display, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = CurrentTheme.TertiaryHover
                }):Play()
            end
        end)
        Display.MouseLeave:Connect(function()
            if not IsListening then
                local CurrentTheme = Window and self.ThemeManager:GetCurrentTheme(Window) or Theme
                TweenService:Create(Display, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = CurrentTheme.Tertiary
                }):Play()
            end
        end)
    end

    UpdateDisplay()
    SetupBind()

    if Window then
        self.ThemeManager:RegisterElement(Window, Display, {
            BackgroundColor3 = function(Element, Theme)
                if not IsListening then
                    Element.BackgroundColor3 = Theme.Tertiary
                end
            end
        })
    end

    return {
        GetKey = function(self)
            return CurrentKey
        end,
        SetKey = function(self, Key)
            if Key and typeof(Key) ~= "EnumItem" then
                EH:Guard(false, "Keybind:SetKey", "Key must be a KeyCode Enum", EH.Levels.WARN)
                return
            end
            CurrentKey = Key
            UpdateDisplay()
            SetupBind()
            SimpleUI.SaveManager:WriteBinding(SaveBinding, CurrentKey and CurrentKey.Name or nil)
        end,
        Clear = function(self)
            CurrentKey = nil
            UpdateDisplay()
            if BindConnection then
                BindConnection:Disconnect()
                BindConnection = nil
            end
            SimpleUI.SaveManager:WriteBinding(SaveBinding, nil)
        end,
        SetDescription = function(self, NewDescription)
            local HadDescription = Description ~= nil and Description.Visible
            local HasNewDescription = NewDescription and NewDescription ~= ""
            if Description and NewDescription then
                Description.Text = NewDescription
                Description.Visible = true
            elseif Description and not NewDescription then
                Description.Visible = false
            elseif not Description and NewDescription then
                Description = SimpleUI.ComponentBuilder:CreateDescription(Zones.TextZone, NewDescription, Theme, 2)
                if Window then
                    SimpleUI.ThemeManager:RegisterElement(Window, Description, {
                        TextColor3 = "TextSecondary",
                        Font = "FontSecondary"
                    })
                end
            end
            if HadDescription ~= HasNewDescription then
                SimpleUI.ComponentBuilder:UpdateDescriptionPadding(Zones, HasNewDescription)
            end
        end,
        GetElements = function(self)
            return {
                Container = Zones.Container,
                Label = Label,
                Description = Description,
                Display = Display,
                DisplayLabel = DisplayLabel
            }
        end
    }
end

function SimpleUI:CreateSlider(Page, Text, Min, Max, DefaultValue, Callback, Options)
    local EH = self.ErrorHandler
    if not EH:ValidateInstance(Page, "GuiObject", "CreateSlider") then
        return nil
    end
    if not EH:ValidateType(Text, "string", "Text", "CreateSlider") then
        Text = "Slider"
    end
    if not EH:ValidateType(Min, "number", "Min", "CreateSlider") then
        Min = 0
    end
    if not EH:ValidateType(Max, "number", "Max", "CreateSlider") then
        Max = 100
    end
    if Min >= Max then
        EH:Guard(false, "CreateSlider", "Min must be less than Max, swapping values", EH.Levels.WARN)
        Min, Max = Max, Min
    end
    if DefaultValue then
        if not EH:ValidateType(DefaultValue, "number", "DefaultValue", "CreateSlider") then
            DefaultValue = Min
        else
            DefaultValue = math.clamp(DefaultValue, Min, Max)
        end
    else
        DefaultValue = Min
    end
    if Callback then
        Callback = (EH:ValidateType(Callback, "function", "Callback", "CreateSlider") == false) and nil or Callback
    end
    Options = Options or {}
    local SaveBinding = self.SaveManager:GetBinding(Options, "Slider", Text)
    if SaveBinding.Enabled and type(SaveBinding.Value) == "number" then
        DefaultValue = math.clamp(SaveBinding.Value, Min, Max)
    end
    local Theme = self.ThemeManager:GetCurrentTheme(self.Utility:GetWindowFromElement(Page))
    local Window = self.Utility:GetWindowFromElement(Page)
    local Increment = Options.Increment or 1
    if not EH:ValidateType(Increment, "number", "Increment", "CreateSlider") then
        Increment = 1
    elseif Increment <= 0 then
        EH:Guard(false, "CreateSlider", "Increment must be positive, using 1", EH.Levels.WARN)
        Increment = 1
    end
    local HasDescription = Options.Description and Options.Description ~= ""
    local Zones = self.ComponentBuilder:CreateContainer({
        Parent = Page,
        Layout = "Stacked",
        MinHeight = 50,
        Padding = HasDescription and {
            Top = self.Constants.Padding.Large,
            Bottom = self.Constants.Padding.Large,
            Left = self.Constants.Padding.Large,
            Right = self.Constants.Padding.Small
        } or {
            Top = 2,
            Bottom = 2,
            Left = self.Constants.Padding.Large,
            Right = self.Constants.Padding.Small
        },
        Spacing = HasDescription and self.Constants.Spacing.Normal or self.Constants.Spacing.Tight,
        HasDescription = HasDescription,
        CornerRadius = self.Constants.Corner.Medium,
        ColorTier = "Secondary"
    }, Theme)
    local LabelContainer = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        ZIndex = self.Constants.ZIndex.Overlay
    }, Zones.TextZone)
    local Label = self.ComponentBuilder:CreateLabel(LabelContainer, Text, Theme, {
        ColorTier = "TextPrimary",
        Size = 14,
        WidthOffset = -60
    })
    local ValueLabel = self.Utility:CreateInstance("TextLabel", {
        Size = UDim2.new(0, 50, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Text = tostring(DefaultValue or Min),
        TextColor3 = Theme.TextSecondary,
        TextSize = 13,
        Font = Theme.FontSecondary,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = self.Constants.ZIndex.Overlay
    }, LabelContainer)
    local Description = HasDescription and
                            self.ComponentBuilder:CreateDescription(Zones.TextZone, Options.Description, Theme, 2) or
                            nil
    local TrackContainer = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 24),
        BackgroundTransparency = 1,
        LayoutOrder = 3,
        ZIndex = self.Constants.ZIndex.Overlay
    }, Zones.TextZone)
    local Track = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 4),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.TertiaryPressed,
        BorderSizePixel = 0,
        ZIndex = self.Constants.ZIndex.Overlay
    }, TrackContainer)
    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, Track)
    local Fill = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        ZIndex = self.Constants.ZIndex.Modal
    }, Track)
    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, Fill)
    local Thumb = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.TextActive,
        BorderSizePixel = 0,
        ZIndex = self.Constants.ZIndex.Notification
    }, Track)
    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, Thumb)
    local ThemeBindings = {
        [Zones.Container] = {
            BackgroundColor3 = "Secondary",
            BackgroundTransparency = "TransparencySecondary"
        },
        [Label] = {
            TextColor3 = "TextPrimary",
            Font = "FontSecondary"
        },
        [ValueLabel] = {
            TextColor3 = "TextSecondary",
            Font = "FontSecondary"
        },
        [Track] = {
            BackgroundColor3 = "TertiaryPressed"
        },
        [Fill] = {
            BackgroundColor3 = "Accent"
        },
        [Thumb] = {
            BackgroundColor3 = "TextActive"
        }
    }
    if Description then
        ThemeBindings[Description] = {
            TextColor3 = "TextSecondary",
            Font = "FontSecondary"
        }
    end
    if Window then
        self.ThemeManager:RegisterMultiple(Window, ThemeBindings)
    end
    local IsDragging = false
    local Value = DefaultValue or Min
    local function RoundToIncrement(Number)
        return math.floor(Number / Increment + 0.5) * Increment
    end
    local function UpdateSlider(NewValue)
        Value = math.clamp(RoundToIncrement(NewValue), Min, Max)
        local Percent = (Value - Min) / (Max - Min)
        Fill.Size = UDim2.new(Percent, 0, 1, 0)
        Thumb.Position = UDim2.new(Percent, 0, 0.5, 0)
        ValueLabel.Text = tostring(Value)
        SimpleUI.SaveManager:WriteBinding(SaveBinding, Value)
        if Callback then
            EH:Try(function()
                Callback(Value)
            end)
        end
    end
    local function HandleInput(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            IsDragging = true
            local Percent = math.clamp((Input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
            UpdateSlider(Min + (Max - Min) * Percent)
        end
    end
    Track.InputBegan:Connect(HandleInput)
    Thumb.InputBegan:Connect(HandleInput)
    UserInputService.InputChanged:Connect(function(Input)
        if IsDragging and
            (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
            local Percent = math.clamp((Input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
            UpdateSlider(Min + (Max - Min) * Percent)
        end
    end)
    UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            IsDragging = false
        end
    end)
    UpdateSlider(Value)
    return {
        GetValue = function(self)
            return Value
        end,
        SetValue = function(self, NewValue)
            if EH:ValidateType(NewValue, "number", "NewValue", "Slider:SetValue") then
                UpdateSlider(NewValue)
            end
        end,
        SetMin = function(self, NewMin)
            if EH:ValidateType(NewMin, "number", "NewMin", "Slider:SetMin") then
                if NewMin < Max then
                    Min = NewMin
                    UpdateSlider(Value)
                else
                    EH:Guard(false, "Slider:SetMin", "Min must be less than Max", EH.Levels.WARN)
                end
            end
        end,
        SetMax = function(self, NewMax)
            if EH:ValidateType(NewMax, "number", "NewMax", "Slider:SetMax") then
                if NewMax > Min then
                    Max = NewMax
                    UpdateSlider(Value)
                else
                    EH:Guard(false, "Slider:SetMax", "Max must be greater than Min", EH.Levels.WARN)
                end
            end
        end,
        SetDescription = function(self, NewDescription)
            local HadDescription = Description ~= nil and Description.Visible
            local HasNewDescription = NewDescription and NewDescription ~= ""
            if Description and NewDescription then
                Description.Text = NewDescription
                Description.Visible = true
            elseif Description and not NewDescription then
                Description.Visible = false
            elseif not Description and NewDescription then
                Description = SimpleUI.ComponentBuilder:CreateDescription(Zones.TextZone, NewDescription, Theme, 2)
                if Window then
                    SimpleUI.ThemeManager:RegisterElement(Window, Description, {
                        TextColor3 = "TextSecondary",
                        Font = "FontSecondary"
                    })
                end
            end
            if HadDescription ~= HasNewDescription then
                SimpleUI.ComponentBuilder:UpdateDescriptionPadding(Zones, HasNewDescription)
            end
        end,
        GetElements = function(self)
            return {
                Container = Zones.Container,
                Label = Label,
                ValueLabel = ValueLabel,
                Description = Description,
                Track = Track,
                Fill = Fill,
                Thumb = Thumb
            }
        end
    }
end

function SimpleUI:CreateParagraph(Page, Title, Fields, Options)
    local EH = self.ErrorHandler
    if not EH:ValidateInstance(Page, "GuiObject", "CreateParagraph") then
        return nil
    end
    if not EH:ValidateType(Title, "string", "Title", "CreateParagraph") then
        Title = "Paragraph"
    end
    if Fields and not EH:ValidateType(Fields, "table", "Fields", "CreateParagraph") then
        Fields = {}
    end
    Options = Options or {}
    local Theme = self.ThemeManager:GetCurrentTheme(self.Utility:GetWindowFromElement(Page))
    local Window = self.Utility:GetWindowFromElement(Page)
    local Container = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = Theme.TransparencySecondary,
        BorderSizePixel = 0,
        ZIndex = self.Constants.ZIndex.Control
    }, Page)
    if not Container then
        EH:Guard(false, "CreateParagraph", "Failed to create container", EH.Levels.ERROR)
        return nil
    end
    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, self.Constants.Corner.Medium)
    }, Container)
    self.Utility:CreateInstance("UIPadding", {
        PaddingTop = UDim.new(0, self.Constants.Padding.Large),
        PaddingBottom = UDim.new(0, self.Constants.Padding.Large),
        PaddingLeft = UDim.new(0, self.Constants.Padding.Large),
        PaddingRight = UDim.new(0, self.Constants.Padding.Large)
    }, Container)
    local ContentFrame = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        ZIndex = self.Constants.ZIndex.Overlay
    }, Container)
    self.Utility:CreateInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, self.Constants.Spacing.Normal)
    }, ContentFrame)
    local TitleLabel = self.Utility:CreateInstance("TextLabel", {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = Title or "Paragraph",
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutomaticSize = Enum.AutomaticSize.Y,
        TextWrapped = true,
        LayoutOrder = 0,
        ZIndex = self.Constants.ZIndex.Overlay,
        TextColor3 = Theme.TextActive,
        Font = Theme.FontPrimary
    }, ContentFrame)
    local ThemeBindings = {
        [Container] = {
            BackgroundColor3 = function(Element, CurrentTheme)
                Element.BackgroundColor3 = CurrentTheme.Secondary
            end,
            BackgroundTransparency = function(Element, CurrentTheme)
                Element.BackgroundTransparency = CurrentTheme.TransparencySecondary
            end
        },
        [TitleLabel] = {
            TextColor3 = function(Element, CurrentTheme)
                Element.TextColor3 = CurrentTheme.TextActive
            end,
            Font = "FontPrimary"
        }
    }
    if Window then
        self.ThemeManager:RegisterMultiple(Window, ThemeBindings)
    end
    local FieldElements = {}
    local FieldCounter = 0
    local function CreateField(FieldData, LayoutOrder)
        if type(FieldData) ~= "table" and type(FieldData) ~= "string" then
            EH:Guard(false, "Paragraph:CreateField", "Invalid field data type", EH.Levels.WARN)
            return nil
        end
        FieldCounter = FieldCounter + 1
        local FieldId = "Field_" .. FieldCounter
        local IsSubField = FieldData.IsSubField or false
        local FieldText = type(FieldData) == "string" and FieldData or (FieldData.Text or "")
        if not EH:ValidateType(FieldText, "string", "FieldText", "Paragraph:CreateField") then
            FieldText = ""
        end
        local CurrentTheme = Window and self.ThemeManager:GetCurrentTheme(Window) or Theme
        local Field = self.Utility:CreateInstance("TextLabel", {
            Size = UDim2.new(1, IsSubField and -20 or 0, 0, 0),
            Position = IsSubField and UDim2.new(0, 20, 0, 0) or UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = FieldText,
            TextSize = IsSubField and 13 or 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextWrapped = true,
            LayoutOrder = LayoutOrder or (FieldCounter + 1),
            ZIndex = self.Constants.ZIndex.Overlay,
            TextColor3 = IsSubField and CurrentTheme.TextSecondary or CurrentTheme.TextActive,
            Font = CurrentTheme.FontSecondary
        }, ContentFrame)
        if not Field then
            EH:Guard(false, "Paragraph:CreateField", "Failed to create field", EH.Levels.WARN)
            return nil
        end
        if Window then
            self.ThemeManager:RegisterElement(Window, Field, {
                TextColor3 = function(Element, CurrentTheme)
                    Element.TextColor3 = IsSubField and CurrentTheme.TextSecondary or CurrentTheme.TextActive
                end,
                Font = "FontSecondary"
            })
        end
        FieldElements[FieldId] = {
            Element = Field,
            Data = type(FieldData) == "table" and FieldData or {
                Text = FieldData,
                IsSubField = false
            },
            Id = FieldId
        }
        return FieldId, Field
    end
    if Fields and type(Fields) == "table" then
        for Index, FieldData in ipairs(Fields) do
            EH:Try(function()
                CreateField(FieldData, Index)
            end)
        end
    end
    return {
        AddField = function(self, Text, IsSubField, Position)
            if not EH:ValidateType(Text, "string", "Text", "Paragraph:AddField") then
                return nil
            end
            return EH:Try(function()
                return CreateField({
                    Text = Text,
                    IsSubField = IsSubField or false
                }, Position or (FieldCounter + 2))
            end)
        end,
        RemoveField = function(self, FieldId)
            if not EH:ValidateType(FieldId, "string", "FieldId", "Paragraph:RemoveField") then
                return false
            end
            if not FieldElements[FieldId] then
                EH:Guard(false, "Paragraph:RemoveField", string.format("Field '%s' not found", FieldId), EH.Levels.WARN)
                return false
            end
            return EH:Try(function()
                FieldElements[FieldId].Element:Destroy()
                FieldElements[FieldId] = nil
                return true
            end, function()
                return false
            end)
        end,
        SetField = function(self, FieldId, Text)
            if not EH:ValidateType(FieldId, "string", "FieldId", "Paragraph:SetField") then
                return false
            end
            if not EH:ValidateType(Text, "string", "Text", "Paragraph:SetField") then
                return false
            end
            if not FieldElements[FieldId] then
                EH:Guard(false, "Paragraph:SetField", string.format("Field '%s' not found", FieldId), EH.Levels.WARN)
                return false
            end
            return EH:Try(function()
                FieldElements[FieldId].Element.Text = Text
                FieldElements[FieldId].Data.Text = Text
                return true
            end, function()
                return false
            end)
        end,
        GetField = function(self, FieldId)
            if not EH:ValidateType(FieldId, "string", "FieldId", "Paragraph:GetField") then
                return nil
            end
            return FieldElements[FieldId] and FieldElements[FieldId].Data.Text or nil
        end,
        FindField = function(self, SearchText)
            if not EH:ValidateType(SearchText, "string", "SearchText", "Paragraph:FindField") then
                return nil
            end
            for Id, FieldData in pairs(FieldElements) do
                if FieldData.Data.Text:find(SearchText, 1, true) then
                    return Id, FieldData.Data.Text
                end
            end
            return nil
        end,
        GetAllFields = function(self)
            local Result = {}
            for Id, FieldData in pairs(FieldElements) do
                table.insert(Result, {
                    Id = Id,
                    Text = FieldData.Data.Text,
                    IsSubField = FieldData.Data.IsSubField
                })
            end
            return Result
        end,
        SetFields = function(self, NewFields)
            if not EH:ValidateType(NewFields, "table", "NewFields", "Paragraph:SetFields") then
                return false
            end
            return EH:Try(function()
                for Id, FieldData in pairs(FieldElements) do
                    FieldData.Element:Destroy()
                end
                FieldElements = {}
                FieldCounter = 0
                if NewFields and type(NewFields) == "table" then
                    for Index, FieldData in ipairs(NewFields) do
                        CreateField(FieldData, Index)
                    end
                end
                return true
            end, function()
                return false
            end)
        end,
        ClearFields = function(self)
            return EH:Try(function()
                for Id, FieldData in pairs(FieldElements) do
                    FieldData.Element:Destroy()
                end
                FieldElements = {}
                FieldCounter = 0
                return true
            end, function()
                return false
            end)
        end,
        SetTitle = function(self, NewTitle)
            if not EH:ValidateType(NewTitle, "string", "NewTitle", "Paragraph:SetTitle") then
                return false
            end
            TitleLabel.Text = NewTitle
            return true
        end,
        GetFieldCount = function(self)
            local Count = 0
            for _ in pairs(FieldElements) do
                Count = Count + 1
            end
            return Count
        end,
        GetElements = function(self)
            return {
                Container = Container,
                ContentFrame = ContentFrame,
                TitleLabel = TitleLabel,
                Fields = FieldElements
            }
        end
    }
end

function SimpleUI:CreateDropdown(Page, Text, Options, DefaultValue, Callback, DropdownOptions)
    local EH = self.ErrorHandler
    if not EH:ValidateInstance(Page, "GuiObject", "CreateDropdown") then
        return nil
    end
    if not EH:ValidateType(Text, "string", "Text", "CreateDropdown") then
        Text = "Dropdown"
    end
    if not EH:ValidateType(Options, "table", "Options", "CreateDropdown") then
        Options = {}
    end
    if #Options == 0 then
        EH:Guard(false, "CreateDropdown", "Options array is empty", EH.Levels.WARN)
    end
    if Callback and not EH:ValidateType(Callback, "function", "Callback", "CreateDropdown") then
        Callback = nil
    end
    DropdownOptions = DropdownOptions or {}
    local Theme = self.ThemeManager:GetCurrentTheme(self.Utility:GetWindowFromElement(Page))
    local IsMobile = self.Utility:IsMobile()
    local Window = self.Utility:GetWindowFromElement(Page)
    local IsMultiSelect = DropdownOptions.MultiSelect or false
    local ChangedEvent = Instance.new("BindableEvent")
    local HasDescription = DropdownOptions.Description and DropdownOptions.Description ~= ""
    local SaveBinding = self.SaveManager:GetBinding(DropdownOptions, "Dropdown", Text)
    if SaveBinding.Enabled then
        if IsMultiSelect and type(SaveBinding.Value) == "table" then
            DefaultValue = SaveBinding.Value
        elseif not IsMultiSelect and type(SaveBinding.Value) == "string" then
            DefaultValue = SaveBinding.Value
        end
    end

    local Zones = self.ComponentBuilder:CreateContainer({
        Parent = Page,
        Layout = "TextLeft",
        TextWidth = 0.55,
        MinHeight = 35,
        Padding = HasDescription and {
            Top = self.Constants.Padding.Large,
            Bottom = self.Constants.Padding.Large,
            Left = self.Constants.Padding.Large,
            Right = self.Constants.Padding.Small
        } or {
            Top = 2,
            Bottom = 2,
            Left = self.Constants.Padding.Large,
            Right = self.Constants.Padding.Small
        },
        Spacing = HasDescription and self.Constants.Spacing.Tight or 0,
        HasDescription = HasDescription,
        CornerRadius = self.Constants.Corner.Medium,
        ColorTier = "Secondary"
    }, Theme)

    local Label = self.ComponentBuilder:CreateLabel(Zones.TextZone, Text, Theme, {
        ColorTier = "TextPrimary",
        Size = 14,
        Order = 1
    })

    local Description = HasDescription and
                            self.ComponentBuilder:CreateDescription(Zones.TextZone, DropdownOptions.Description, Theme,
            2) or nil

    local DisplayContainer = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(0.45, -self.Constants.Padding.Large, 1, 0),
        Position = UDim2.new(0.55, 0, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = self.Constants.ZIndex.Overlay
    }, Zones.Container)

    local Display = self.Utility:CreateInstance("TextButton", {
        Size = UDim2.new(1, -10, 0, 32),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = self.Constants.ZIndex.Overlay
    }, DisplayContainer)

    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, self.Constants.Corner.Medium)
    }, Display)

    local DisplayLabel = self.Utility:CreateInstance("TextLabel", {
        Size = UDim2.new(1, -32, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = Theme.TextPrimary,
        TextSize = 13,
        Font = Theme.FontSecondary,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = self.Constants.ZIndex.Modal
    }, Display)

    local Arrow = self.Utility:CreateInstance("ImageLabel", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://10709790948",
        ImageColor3 = Theme.TextPrimary,
        ZIndex = self.Constants.ZIndex.Modal
    }, Display)

    local ThemeBindings = {
        [Zones.Container] = {
            BackgroundColor3 = "Secondary",
            BackgroundTransparency = "TransparencySecondary"
        },
        [Label] = {
            TextColor3 = "TextPrimary",
            Font = "FontSecondary"
        },
        [Display] = {
            BackgroundColor3 = "Tertiary"
        },
        [DisplayLabel] = {
            TextColor3 = "TextPrimary",
            Font = "FontSecondary"
        },
        [Arrow] = {
            ImageColor3 = "TextPrimary"
        }
    }
    if Description then
        ThemeBindings[Description] = {
            TextColor3 = "TextSecondary",
            Font = "FontSecondary"
        }
    end
    if Window then
        self.ThemeManager:RegisterMultiple(Window, ThemeBindings)
    end

    local ScreenGui = Page
    while ScreenGui do
        if ScreenGui:IsA("ScreenGui") then
            break
        end
        ScreenGui = ScreenGui.Parent
    end
    if not ScreenGui then
        EH:Guard(false, "CreateDropdown", "Failed to find ScreenGui parent", EH.Levels.ERROR)
        return nil
    end

    local ListContainer = self.Utility:CreateInstance("Frame", {
        Size = UDim2.new(0, Display.AbsoluteSize.X, 0, 0),
        BackgroundColor3 = Theme.Tertiary,
        BackgroundTransparency = Theme.TransparencyPrimary,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = self.Constants.ZIndex.Modal,
        ClipsDescendants = true
    }, ScreenGui)

    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, self.Constants.Corner.Medium)
    }, ListContainer)

    local SearchBox = self.Utility:CreateInstance("TextBox", {
        Size = UDim2.new(1, -8, 0, 30),
        Position = UDim2.new(0, 4, 0, 4),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        Text = "",
        PlaceholderText = "Search...",
        TextColor3 = Theme.TextPrimary,
        PlaceholderColor3 = Theme.TextSecondary,
        TextSize = 13,
        Font = Theme.FontSecondary,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        Visible = false,
        ZIndex = self.Constants.ZIndex.Modal + 1
    }, ListContainer)

    self.Utility:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, self.Constants.Corner.Medium)
    }, SearchBox)

    self.Utility:CreateInstance("UIPadding", {
        PaddingLeft = UDim.new(0, self.Constants.Padding.Medium),
        PaddingRight = UDim.new(0, self.Constants.Padding.Medium)
    }, SearchBox)

    if Window then
        self.ThemeManager:RegisterMultiple(Window, {
            [ListContainer] = {
                BackgroundColor3 = "Tertiary",
                BackgroundTransparency = "TransparencyPrimary"
            },
            [SearchBox] = {
                BackgroundColor3 = "Tertiary",
                TextColor3 = "TextPrimary",
                PlaceholderColor3 = "TextSecondary",
                Font = "FontSecondary"
            }
        })
    end

    local ScrollList = self.Utility:CreateInstance("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -38),
        Position = UDim2.new(0, 0, 0, 38),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        ScrollBarImageColor3 = Theme.TextSecondary,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = self.Constants.ZIndex.Modal + 1,
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    }, ListContainer)

    self.Utility:CreateInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, self.Constants.Spacing.Tight)
    }, ScrollList)

    self.Utility:CreateInstance("UIPadding", {
        PaddingTop = UDim.new(0, IsMobile and 0 or 1),
        PaddingBottom = UDim.new(0, IsMobile and 0 or 1),
        PaddingLeft = UDim.new(0, IsMobile and 0 or 1),
        PaddingRight = UDim.new(0, IsMobile and 0 or 1)
    }, ScrollList)

    local NormalizedOptions, OptionDataMap = self.DropdownManager:NormalizeOptions(Options)
    local SelectedValues = self.DropdownManager:InitializeSelection(DefaultValue, IsMultiSelect, OptionDataMap)
    local IsOpen = false
    local IsToggling = false
    local InputBlocker = nil
    local TargetHeight = 0
    local HasSearch = false
    local InputConnection
    local DisplayState = "Base"

    local function UpdateDisplayColor()
        local CurrentTheme = Window and self.ThemeManager:GetCurrentTheme(Window) or Theme
        local ColorGoal = CurrentTheme.Tertiary
        local ArrowRotation = 0

        if DisplayState == "Hover" then
            ColorGoal = CurrentTheme.TertiaryHover
        elseif DisplayState == "Active" then
            ColorGoal = CurrentTheme.TertiaryActive
            ArrowRotation = 180
        elseif DisplayState == "Pressed" then
            ColorGoal = CurrentTheme.TertiaryPressed
        end

        TweenService:Create(Display, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            BackgroundColor3 = ColorGoal
        }):Play()

        TweenService:Create(Arrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Rotation = ArrowRotation
        }):Play()
    end

    if not IsMobile then
        Display.MouseEnter:Connect(function()
            if not IsOpen then
                DisplayState = "Hover"
                UpdateDisplayColor()
            end
        end)
        Display.MouseLeave:Connect(function()
            if not IsOpen then
                DisplayState = "Base"
                UpdateDisplayColor()
            end
        end)
        Display.MouseButton1Down:Connect(function()
            DisplayState = "Pressed"
            UpdateDisplayColor()
        end)
        Display.MouseButton1Up:Connect(function()
            if not IsOpen then
                DisplayState = "Hover"
            end
            UpdateDisplayColor()
        end)
    end

    local function CloseDropdown()
        if InputBlocker then
            InputBlocker:Destroy()
            InputBlocker = nil
        end
        if not IsOpen then
            return
        end
        IsOpen = false
        DisplayState = "Base"
        UpdateDisplayColor()

        TweenService:Create(ListContainer, TweenInfo.new(self.Constants.Animation.Fast, Enum.EasingStyle.Quad,
            Enum.EasingDirection.In), {
            Size = UDim2.new(0, Display.AbsoluteSize.X, 0, 0)
        }):Play()
        task.wait(self.Constants.Animation.Fast)
        ListContainer.Visible = false
        SearchBox.Text = ""

        if InputConnection then
            InputConnection:Disconnect()
            InputConnection = nil
        end
    end

    local function UpdateDisplay()
        self.DropdownManager:UpdateDisplayText(DisplayLabel, SelectedValues, IsMultiSelect)
    end

    local function SerializeSelection()
        if IsMultiSelect then
            local values = {}
            for OptionText, Selected in pairs(SelectedValues) do
                if Selected then
                    table.insert(values, OptionText)
                end
            end
            table.sort(values)
            return values
        end
        return SelectedValues
    end

    local function FilterOptions(Query)
        Query = Query:lower()
        for _, Child in ipairs(ScrollList:GetChildren()) do
            if Child:IsA("Frame") then
                local OptionButton = Child:FindFirstChild("TextButton")
                if OptionButton then
                    if Query == "" or OptionButton.Text:lower():find(Query, 1, true) then
                        Child.Visible = true
                    else
                        Child.Visible = false
                    end
                end
            end
        end
    end

    local function UpdateListPosition()
        local DisplayPos = Display.AbsolutePosition
        local DisplaySize = Display.AbsoluteSize
        local ScreenSize = ScreenGui.AbsoluteSize
        local BaseMaxHeight = 160
        local Layout = ScrollList:FindFirstChildOfClass("UIListLayout")
        local ContentHeight = Layout and Layout.AbsoluteContentSize.Y + 16 or 0
        HasSearch = ContentHeight > BaseMaxHeight
        SearchBox.Visible = HasSearch

        if HasSearch then
            ScrollList.Size = UDim2.new(1, 0, 1, -38)
            ScrollList.Position = UDim2.new(0, 0, 0, 38)
        else
            ScrollList.Size = UDim2.new(1, 0, 1, 0)
            ScrollList.Position = UDim2.new(0, 0, 0, 0)
        end

        TargetHeight = math.min(BaseMaxHeight, ContentHeight) + (HasSearch and 38 or 0)

        local YPos = DisplayPos.Y + DisplaySize.Y + 4
        if YPos + TargetHeight > ScreenSize.Y then
            YPos = DisplayPos.Y - TargetHeight - 4
        end

        ListContainer.Size = UDim2.new(0, DisplaySize.X, 0, 0)
        ListContainer.Position = UDim2.new(0, DisplayPos.X, 0, YPos)
    end

    local function CreateOption(OptionText, Index)
        local CurrentTheme = Window and self.ThemeManager:GetCurrentTheme(Window) or Theme
        local OptionContainer = self.Utility:CreateInstance("Frame", {
            Size = UDim2.new(1, -8, 0, IsMobile and 24 or 30),
            BackgroundTransparency = 1,
            ZIndex = self.Constants.ZIndex.Modal + 2,
            LayoutOrder = Index
        }, ScrollList)

        local OptionButton = self.Utility:CreateInstance("TextButton", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundColor3 = CurrentTheme.Tertiary,
            BorderSizePixel = 0,
            Text = OptionText,
            TextColor3 = CurrentTheme.TextPrimary,
            TextSize = IsMobile and 8 or 13,
            Font = CurrentTheme.FontSecondary,
            TextTruncate = Enum.TextTruncate.SplitWord,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutoButtonColor = false,
            ZIndex = self.Constants.ZIndex.Modal + 3
        }, OptionContainer)

        self.Utility:CreateInstance("UICorner", {
            CornerRadius = UDim.new(0, self.Constants.Corner.Small)
        }, OptionButton)

        self.Utility:CreateInstance("UIPadding", {
            PaddingLeft = UDim.new(0, IsMobile and 4 or 6),
            PaddingRight = UDim.new(0, IsMobile and 2 or self.Constants.Padding.Small)
        }, OptionButton)

        local Indicator = self.Utility:CreateInstance("Frame", {
            Size = UDim2.new(0, IsMobile and 1 or 2, 0.35, 0),
            Position = UDim2.new(0, IsMobile and 0.1 or 2, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = CurrentTheme.Accent,
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = self.Constants.ZIndex.Modal + 4
        }, OptionContainer)

        self.Utility:CreateInstance("UICorner", {
            CornerRadius = UDim.new(1, 0)
        }, Indicator)

        if Window then
            self.ThemeManager:RegisterElement(Window, OptionButton, {
                BackgroundColor3 = "Tertiary",
                TextColor3 = "TextPrimary",
                Font = "FontSecondary"
            })
            self.ThemeManager:RegisterElement(Window, Indicator, {
                BackgroundColor3 = "Accent"
            })
        end

        if IsMultiSelect then
            local function UpdateIndicator()
                Indicator.Visible = SelectedValues[OptionText] or false
            end
            OptionButton.Activated:Connect(function()
                SelectedValues[OptionText] = not SelectedValues[OptionText]
                UpdateIndicator()
                UpdateDisplay()
                local Selected = SimpleUI.DropdownManager:GetSelectedData(SelectedValues, IsMultiSelect, OptionDataMap)
                SimpleUI.SaveManager:WriteBinding(SaveBinding, SerializeSelection())
                if Callback then
                    EH:Try(function()
                        Callback(Selected)
                    end)
                end
                ChangedEvent:Fire(Selected)
            end)
            UpdateIndicator()
        else
            Indicator.Visible = SelectedValues == OptionText
            OptionButton.Activated:Connect(function()
                for _, Child in ipairs(ScrollList:GetChildren()) do
                    if Child:IsA("Frame") then
                        local Ind = Child:FindFirstChild("Frame")
                        if Ind then
                            Ind.Visible = false
                        end
                    end
                end
                SelectedValues = OptionText
                Indicator.Visible = true
                UpdateDisplay()
                CloseDropdown()
                local Selected = SimpleUI.DropdownManager:GetSelectedData(SelectedValues, IsMultiSelect, OptionDataMap)
                SimpleUI.SaveManager:WriteBinding(SaveBinding, SerializeSelection())
                if Callback then
                    EH:Try(function()
                        Callback(Selected)
                    end)
                end
                ChangedEvent:Fire(Selected)
            end)
        end

        if not IsMobile then
            OptionButton.MouseEnter:Connect(function()
                local CurrentTheme = Window and SimpleUI.ThemeManager:GetCurrentTheme(Window) or Theme
                TweenService:Create(OptionButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = CurrentTheme.TertiaryHover
                }):Play()
            end)
            OptionButton.MouseLeave:Connect(function()
                local CurrentTheme = Window and SimpleUI.ThemeManager:GetCurrentTheme(Window) or Theme
                TweenService:Create(OptionButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = CurrentTheme.Tertiary
                }):Play()
            end)
            OptionButton.MouseButton1Down:Connect(function()
                local CurrentTheme = Window and SimpleUI.ThemeManager:GetCurrentTheme(Window) or Theme
                OptionButton.BackgroundColor3 = CurrentTheme.TertiaryPressed
            end)
            OptionButton.MouseButton1Up:Connect(function()
                local CurrentTheme = Window and SimpleUI.ThemeManager:GetCurrentTheme(Window) or Theme
                OptionButton.BackgroundColor3 = CurrentTheme.TertiaryHover
            end)
        end
    end

    for Index, OptionText in ipairs(NormalizedOptions) do
        CreateOption(OptionText, Index)
    end

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        FilterOptions(SearchBox.Text)
    end)

    UpdateDisplay()
    UpdateDisplayColor()

    if SaveBinding.HasValue and SaveBinding.ApplyCallback and Callback then
        EH:Try(function()
            Callback(SimpleUI.DropdownManager:GetSelectedData(SelectedValues, IsMultiSelect, OptionDataMap))
        end)
    end

    Display.Activated:Connect(function()
        if IsToggling then
            return
        end
        IsToggling = true
        if IsOpen then
            CloseDropdown()
        else
            IsOpen = true
            InputBlocker = EH:Try(function()
                return self.Utility:CreateInstance("TextButton", {
                    Name = "DropdownInputBlocker",
                    Size = UDim2.fromScale(1, 1),
                    Position = UDim2.fromScale(0, 0),
                    Text = "",
                    BackgroundTransparency = 1,
                    AutoButtonColor = false,
                    ZIndex = self.Constants.ZIndex.Modal - 1
                }, ScreenGui)
            end)
            if InputBlocker then
                InputBlocker.Activated:Connect(function()
                    CloseDropdown()
                end)
            end
            DisplayState = "Active"
            UpdateDisplayColor()
            UpdateListPosition()
            ListContainer.Visible = true
            TweenService:Create(ListContainer, TweenInfo.new(self.Constants.Animation.Normal, Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out), {
                Size = UDim2.new(0, Display.AbsoluteSize.X, 0, TargetHeight)
            }):Play()
            task.wait()
            InputConnection = UserInputService.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType ==
                    Enum.UserInputType.Touch then
                    local MousePos = Input.Position
                    local ListPos = ListContainer.AbsolutePosition
                    local ListSize = ListContainer.AbsoluteSize
                    local DisplayPos = Display.AbsolutePosition
                    local DisplaySize = Display.AbsoluteSize
                    local InList = MousePos.X >= ListPos.X and MousePos.X <= ListPos.X + ListSize.X and MousePos.Y >=
                                       ListPos.Y and MousePos.Y <= ListPos.Y + ListSize.Y
                    local InDisplay = MousePos.X >= DisplayPos.X and MousePos.X <= DisplayPos.X + DisplaySize.X and
                                          MousePos.Y >= DisplayPos.Y and MousePos.Y <= DisplayPos.Y + DisplaySize.Y
                    if not InList and not InDisplay and not IsToggling then
                        CloseDropdown()
                    end
                end
            end)
        end
        task.wait(0.1)
        IsToggling = false
    end)

    return {
        GetValue = function(self)
            return SimpleUI.DropdownManager:GetSelectedData(SelectedValues, IsMultiSelect, OptionDataMap)
        end,
        SetValue = function(self, Value)
            if IsMultiSelect then
                SelectedValues = {}
                if EH:ValidateType(Value, "table", "Value", "Dropdown:SetValue") then
                    for _, V in ipairs(Value) do
                        local Normalized = type(V) == "table" and
                                               (V.Text or V.text or V.Label or V.label or tostring(V)) or tostring(V)
                        if OptionDataMap[Normalized] then
                            SelectedValues[Normalized] = true
                        end
                    end
                end
            else
                local Normalized = type(Value) == "table" and
                                       (Value.Text or Value.text or Value.Label or Value.label or tostring(Value)) or
                                       tostring(Value)
                if OptionDataMap[Normalized] then
                    SelectedValues = Normalized
                end
            end
            for _, Child in ipairs(ScrollList:GetChildren()) do
                if Child:IsA("Frame") then
                    local Ind = Child:FindFirstChild("Frame")
                    local Opt = Child:FindFirstChild("TextButton")
                    if Ind and Opt then
                        if IsMultiSelect then
                            Ind.Visible = SelectedValues[Opt.Text] or false
                        else
                            Ind.Visible = SelectedValues == Opt.Text
                        end
                    end
                end
            end
            UpdateDisplay()
            SimpleUI.SaveManager:WriteBinding(SaveBinding, SerializeSelection())
            ChangedEvent:Fire(Value)
            if Callback then
                EH:Try(function()
                    Callback(SimpleUI.DropdownManager:GetSelectedData(SelectedValues, IsMultiSelect, OptionDataMap))
                end)
            end
        end,
        SetOptions = function(self, NewOptions)
            if not EH:ValidateType(NewOptions, "table", "NewOptions", "Dropdown:SetOptions") then
                return
            end
            for _, Child in ipairs(ScrollList:GetChildren()) do
                if Child:IsA("Frame") then
                    Child:Destroy()
                end
            end
            Options = NewOptions
            NormalizedOptions, OptionDataMap = SimpleUI.DropdownManager:NormalizeOptions(Options)
            for Index, OptionText in ipairs(NormalizedOptions) do
                CreateOption(OptionText, Index)
            end
            if IsMultiSelect then
                local ValidSelected = {}
                for Value, Enabled in pairs(SelectedValues) do
                    if OptionDataMap[Value] then
                        ValidSelected[Value] = Enabled
                    end
                end
                SelectedValues = ValidSelected
            else
                if not OptionDataMap[SelectedValues] and NormalizedOptions[1] then
                    SelectedValues = nil
                end
            end
            UpdateDisplay()
        end,
        SetDescription = function(self, NewDescription)
            local HadDescription = Description ~= nil and Description.Visible
            local HasNewDescription = NewDescription and NewDescription ~= ""
            if Description and NewDescription then
                Description.Text = NewDescription
                Description.Visible = true
            elseif Description and not NewDescription then
                Description.Visible = false
            elseif not Description and NewDescription then
                Description = SimpleUI.ComponentBuilder:CreateDescription(Zones.TextZone, NewDescription, Theme, 2)
                if Window then
                    SimpleUI.ThemeManager:RegisterElement(Window, Description, {
                        TextColor3 = "TextSecondary",
                        Font = "FontSecondary"
                    })
                end
            end
            if HadDescription ~= HasNewDescription then
                SimpleUI.ComponentBuilder:UpdateDescriptionPadding(Zones, HasNewDescription)
            end
        end,
        Close = function(self)
            CloseDropdown()
        end,
        GetElements = function(self)
            return {
                Container = Zones.Container,
                Label = Label,
                Description = Description,
                Display = Display,
                DisplayLabel = DisplayLabel,
                Arrow = Arrow,
                ListContainer = ListContainer,
                SearchBox = SearchBox,
                ScrollList = ScrollList
            }
        end,
        Changed = ChangedEvent.Event
    }
end

function SimpleUI:CreateNotification(Options)
    local EH = self.ErrorHandler
    Options = Options or {}
    if not EH:ValidateType(Options, "table", "Options", "CreateNotification") then
        Options = {}
    end

    local Title = Options.Title
    if not EH:ValidateType(Title, "string", "Title", "CreateNotification") then
        Title = "Notification"
    end

    local Description = Options.Description
    if Description and not EH:ValidateType(Description, "string", "Description", "CreateNotification") then
        Description = nil
    end

    local Duration = Options.Duration or 5
    if not EH:ValidateType(Duration, "number", "Duration", "CreateNotification") then
        Duration = 5
    else
        Duration = math.clamp(Duration, 0, 300)
    end

    local Tag = Options.Tag
    if Tag and not EH:ValidateType(Tag, "string", "Tag", "CreateNotification") then
        Tag = nil
    end

    local Type = Options.Type
    if Type and not EH:ValidateType(Type, "string", "Type", "CreateNotification") then
        Type = nil
    end

    local Theme = type(Options.Theme) == "string" and (self.Themes[Options.Theme] or self.Themes.DefaultTheme) or
                      type(Options.Theme) == "table" and Options.Theme or self.Themes.DefaultTheme

    local Color = Options.Color
    if Color and typeof(Color) ~= "Color3" then
        Color = Theme.Accent
    else
        Color = Color or Theme.Accent
    end

    local Callback = Options.Callback
    if Callback and not EH:ValidateType(Callback, "function", "Callback", "CreateNotification") then
        Callback = nil
    end

    local Closable = Options.Closable ~= false

    self.NotificationManager:Initialize()

    local NotificationUI = self.NotificationManager:CreateNotificationUI({
        Title = Title,
        Description = Description,
        Theme = Theme,
        Color = Color,
        Type = Type,
        Tag = Tag,
        Callback = Callback,
        Closable = Closable,
        Duration = Duration
    })

    return {
        Dismiss = function(self)
            SimpleUI.NotificationManager:Dismiss(NotificationUI.Container)
        end,
        SetTitle = function(self, NewTitle)
            if EH:ValidateType(NewTitle, "string", "NewTitle", "Notification:SetTitle") then
                NotificationUI.Title.Text = NewTitle
            end
        end,
        SetDescription = function(self, NewDescription)
            if NotificationUI.Description then
                if NewDescription and
                    EH:ValidateType(NewDescription, "string", "NewDescription", "Notification:SetDescription") then
                    NotificationUI.Description.Text = NewDescription
                    NotificationUI.Description.Visible = true
                else
                    NotificationUI.Description.Visible = false
                end
            end
        end,
        SetTag = function(self, NewTag)
            if EH:ValidateType(NewTag, "string", "NewTag", "Notification:SetTag") and NotificationUI.Tag then
                NotificationUI.Tag.Text = NewTag
            end
        end,
        GetElements = function(self)
            return {
                Container = NotificationUI.Container,
                Card = NotificationUI.Card,
                Title = NotificationUI.Title,
                Description = NotificationUI.Description,
                Tag = NotificationUI.Tag,
                Content = NotificationUI.Content,
                ProgressFill = NotificationUI.ProgressFill
            }
        end
    }
end

local function getStorage()
    local registry = getgenv().__PrereqStorageRegistry
    if not registry then
        return nil
    end

    for k, v in pairs(getgenv()) do
        if type(k) == "userdata" and v == true and registry[k] then
            return k
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

local SimpleUI = getPrerequisite("SimpleUI")
local LoopFramework = getPrerequisite("LoopFramework")

SimpleUI:CreateNotification({
    Title = "Validated!",
    Type = "Success",
    Description = "Pre-requisites validated, script will start soon! Powered by SimpleUI",
    Duration = 3,
})

local Services = {
    Players = SimpleUI.Utility:GetService("Players"),
    ReplicatedStorage = SimpleUI.Utility:GetService("ReplicatedStorage"),
    Workspace = SimpleUI.Utility:GetService("Workspace"),
    Lighting = SimpleUI.Utility:GetService("Lighting"),
}

local Player = Services.Players.LocalPlayer
local Characters = Services.Workspace:WaitForChild("Characters")
local DroppedItems = Services.Workspace:WaitForChild("DroppedItems")
local Structures = Services.Workspace:WaitForChild("Structures")
local Map = Services.Workspace:WaitForChild("Map")
local MapTiles = Map:WaitForChild("Tiles")
local MapCrates = Map:WaitForChild("Crates")
local Survivors = Map:WaitForChild("Survivors")
local ReplicatedStorage = Services.ReplicatedStorage
local ReplicatedTools = ReplicatedStorage:WaitForChild("Tools")
local ReplicatedItems = ReplicatedStorage:WaitForChild("Items")
local PlayerGui = Player:WaitForChild("PlayerGui")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local InteractionRemotes = Remotes:WaitForChild("Interaction")
local PickUpItemRemote = InteractionRemotes:WaitForChild("PickUpItem")

local LocalCharacter, HumanoidRootPart

local function bindCharacter(char)
    LocalCharacter = Characters:WaitForChild(Player.Name)
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end

bindCharacter(Player.Character or Player.CharacterAdded:Wait())
Player.CharacterAdded:Connect(bindCharacter)

-- ========================
-- STATE
-- ========================

local SelectAllOption = "All"

local State = {
    AutoPickupAmmo = false,
    AutoPickupFood = false,
    AutoPickupFoodHunger = 70,
    AutoPickupAmmoSelected = {},
    AutoPickupAmmoLimits = {},
    AutoMelee = false,
    AutoMeleeZombies = true,
    AutoMeleePiles = true,
    AutoMeleeBarrels = true,
    AutoFuel = false,
    AutoShredder = false,
    AutoFood = false,
    AutoTeleportCooldown = 0.08,
    PickupLimit = 12,
    PickupRadius = 12,
    EspMasterRadius = 500,
    ObjectiveRadius = 0,
    FuelItemESP = false,
    FoodItemESP = false,
    MedicalItemESP = false,
    RangedItemESP = false,
    AmmoItemESP = false,
    MeleeItemESP = false,
    BackpackItemESP = false,
    ArmorItemESP = false,
    ThrowableItemESP = false,
    AbilityItemESP = false,
    WorldItemESP = false,
    ZombieESP = false,
    SurvivorESP = false,
    GeneratorESP = false,
    ScrapPileESP = false,
    RadioTowerESP = false,
    PowerPlantESP = false,
    CrateESP = false,
    BarrelESP = false,
    ZombieSelected = SelectAllOption,
    ZombieRadius = 0,
    SurvivorRadius = 0,
    BarrelRadius = 0,
    CrateRadius = 0,
    InstantProximityPrompt = false,
    EnvironmentFogEnd = math.clamp(Services.Lighting.FogEnd, 0, 100000),
    EnvironmentAtmosphereDensity = 0,
    EnvironmentClockTime = Services.Lighting.ClockTime,
    EnvironmentBrightness = math.clamp(Services.Lighting.Brightness, 0, 5),
    EnvironmentGlobalShadows = Services.Lighting.GlobalShadows,
}

do
    local atmosphere = Services.Lighting:FindFirstChildWhichIsA("Atmosphere")
    if atmosphere then
        State.EnvironmentAtmosphereDensity = math.clamp(atmosphere.Density, 0, 1)
    end
end

local ItemEspClasses = {
    Fuel = {
        Name = "Fuel",
        StateKey = "FuelItemESP",
        SelectedKey = "FuelItemSelected",
        RadiusKey = "FuelItemRadius",
        Folder = ReplicatedItems:WaitForChild("Fuel"),
        Radar = false,
        FillColor    = Color3.fromRGB(210, 140, 30),
        OutlineColor = Color3.fromRGB(255, 215, 100),
        TextColor    = Color3.fromRGB(255, 205, 75),
    },
    Food = {
        Name = "Food",
        StateKey = "FoodItemESP",
        SelectedKey = "FoodItemSelected",
        RadiusKey = "FoodItemRadius",
        Folder = ReplicatedItems:WaitForChild("Food"),
        Radar = true,
        FillColor    = Color3.fromRGB(50, 175, 55),
        OutlineColor = Color3.fromRGB(140, 255, 130),
        TextColor    = Color3.fromRGB(110, 255, 100),
    },
    Medical = {
        Name = "Medical",
        StateKey = "MedicalItemESP",
        SelectedKey = "MedicalItemSelected",
        RadiusKey = "MedicalItemRadius",
        Folder = ReplicatedTools:WaitForChild("Medical"),
        Radar = true,
        FillColor    = Color3.fromRGB(15, 155, 185),
        OutlineColor = Color3.fromRGB(90, 235, 255),
        TextColor    = Color3.fromRGB(70, 225, 255),
    },
    Ranged = {
        Name = "Guns",
        StateKey = "RangedItemESP",
        SelectedKey = "RangedItemSelected",
        RadiusKey = "RangedItemRadius",
        Folder = ReplicatedTools:WaitForChild("Guns"),
        Radar = true,
        FillColor    = Color3.fromRGB(205, 40, 60),
        OutlineColor = Color3.fromRGB(255, 95, 115),
        TextColor    = Color3.fromRGB(255, 110, 130),
    },
    Ammo = {
        Name = "Ammo",
        StateKey = "AmmoItemESP",
        SelectedKey = "AmmoItemSelected",
        RadiusKey = "AmmoItemRadius",
        Folder = ReplicatedItems:WaitForChild("Ammo"),
        Radar = true,
        FillColor    = Color3.fromRGB(215, 180, 35),
        OutlineColor = Color3.fromRGB(255, 238, 90),
        TextColor    = Color3.fromRGB(255, 232, 70),
    },
    Melee = {
        Name = "Melee",
        StateKey = "MeleeItemESP",
        SelectedKey = "MeleeItemSelected",
        RadiusKey = "MeleeItemRadius",
        Folder = ReplicatedTools:WaitForChild("Melee"),
        Radar = false,
        FillColor    = Color3.fromRGB(195, 95, 25),
        OutlineColor = Color3.fromRGB(255, 165, 70),
        TextColor    = Color3.fromRGB(255, 160, 55),
    },
    Backpack = {
        Name = "Backpack",
        StateKey = "BackpackItemESP",
        SelectedKey = "BackpackItemSelected",
        RadiusKey = "BackpackItemRadius",
        Folder = ReplicatedTools:WaitForChild("Backpacks"),
        Radar = false,
        FillColor    = Color3.fromRGB(25, 165, 75),
        OutlineColor = Color3.fromRGB(85, 255, 150),
        TextColor    = Color3.fromRGB(70, 255, 140),
    },
    Armor = {
        Name = "Armor",
        StateKey = "ArmorItemESP",
        SelectedKey = "ArmorItemSelected",
        RadiusKey = "ArmorItemRadius",
        Folder = ReplicatedItems:WaitForChild("Armor"),
        Radar = false,
        FillColor    = Color3.fromRGB(75, 110, 160),
        OutlineColor = Color3.fromRGB(155, 200, 250),
        TextColor    = Color3.fromRGB(165, 210, 255),
    },
    Throwables = {
        Name = "Throwables",
        StateKey = "ThrowableItemESP",
        SelectedKey = "ThrowableItemSelected",
        RadiusKey = "ThrowableItemRadius",
        Folder = ReplicatedTools:WaitForChild("Consumable"),
        Radar = true,
        FillColor    = Color3.fromRGB(170, 155, 25),
        OutlineColor = Color3.fromRGB(240, 228, 70),
        TextColor    = Color3.fromRGB(245, 228, 55),
    },
    Ability = {
        Name = "Ability",
        StateKey = "AbilityItemESP",
        SelectedKey = "AbilityItemSelected",
        RadiusKey = "AbilityItemRadius",
        Folder = ReplicatedTools:WaitForChild("Abilities"),
        Radar = false,
        FillColor    = Color3.fromRGB(145, 55, 210),
        OutlineColor = Color3.fromRGB(215, 135, 255),
        TextColor    = Color3.fromRGB(210, 125, 255),
    },
    World = {
        Name = "World Loot",
        StateKey = "WorldItemESP",
        SelectedKey = "WorldItemSelected",
        RadiusKey = "WorldItemRadius",
        Radar = false,
        FillColor    = Color3.fromRGB(50, 95, 210),
        OutlineColor = Color3.fromRGB(145, 190, 255),
        TextColor    = Color3.fromRGB(135, 185, 255),
    },
}

local ItemEspClassNames = {
    "Fuel",
    "Food",
    "Medical",
    "Ranged",
    "Ammo",
    "Melee",
    "Backpack",
    "Armor",
    "Throwables",
    "Ability",
}

for _, className in ipairs(ItemEspClassNames) do
    local itemClass = ItemEspClasses[className]
    State[itemClass.SelectedKey] = SelectAllOption
    State[itemClass.RadiusKey] = 0
end

local UtilityModule = {}
do
    function UtilityModule.notify(title, description, notificationType)
        SimpleUI:CreateNotification({
            Title = title,
            Description = description,
            Type = notificationType or "Info",
            Duration = 3,
        })
    end

    function UtilityModule.getRootPart()
        if HumanoidRootPart and HumanoidRootPart.Parent then
            return HumanoidRootPart
        end
        local currentCharacter = Player.Character
        return currentCharacter and currentCharacter:FindFirstChild("HumanoidRootPart")
    end

    function UtilityModule.getItemBasePart(item)
        if not item then
            return nil
        end
        if item:IsA("BasePart") then
            return item
        end
        return item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart", true)
    end

    function UtilityModule.getItemPosition(item)
        local part = UtilityModule.getItemBasePart(item)
        return part and part.Position
    end

    function UtilityModule.getChildNames(folder)
        local names = { SelectAllOption }
        if folder then
            for _, child in ipairs(folder:GetChildren()) do
                names[#names + 1] = child.Name
            end
        end
        table.sort(names, function(a, b)
            if a == SelectAllOption then
                return true
            end
            if b == SelectAllOption then
                return false
            end
            return string.lower(a) < string.lower(b)
        end)
        return names
    end

    function UtilityModule.getAmmoAttributeName(itemName)
        if not itemName then
            return nil
        end
        if string.sub(itemName, -5) == " Ammo" then
            return string.sub(itemName, 1, -6)
        end
        return itemName
    end
end

local MainModule = {}
do
    local AutoTeleportProcessed = {}
    local AutoTeleportBusy = false
    local AutoPickupBusy = false
    local AutoMeleeBusy = false
    local LastAutoMeleeHit = 0

    -- Cached folder refs so we don't FindFirstChild on every tick
    local FolderAmmo     = ReplicatedItems:WaitForChild("Ammo")
    local FolderFuel     = ReplicatedItems:WaitForChild("Fuel")
    local FolderFood     = ReplicatedItems:WaitForChild("Food")
    local FolderResources = ReplicatedItems:FindFirstChild("Resources")

    -- Cached OverlapParams — creating one per tick was wasteful
    local TeleportOverlapParams = OverlapParams.new()

    -- Cached melee tool state; updated via events, not polled every tick
    local CachedMeleeTool = nil
    local CachedSwingRemote = nil
    local CachedHitRemote = nil

    local function onToolEquipped(tool)
        if not tool:IsA("Tool") then return end
        local hitRemote = tool:FindFirstChild("HitTargets")
        local swingRemote = tool:FindFirstChild("Swing")
        if hitRemote and swingRemote then
            CachedMeleeTool = tool
            CachedHitRemote = hitRemote
            CachedSwingRemote = swingRemote
        end
    end

    local function onToolUnequipped(tool)
        if tool == CachedMeleeTool then
            CachedMeleeTool = nil
            CachedHitRemote = nil
            CachedSwingRemote = nil
        end
    end

    local function bindMeleeToolEvents(character)
        CachedMeleeTool = nil
        CachedSwingRemote = nil
        CachedHitRemote = nil
        for _, child in ipairs(character:GetChildren()) do
            onToolEquipped(child)
        end
        character.ChildAdded:Connect(onToolEquipped)
        character.ChildRemoved:Connect(onToolUnequipped)
    end

    -- Wire up on existing character and future respawns
    local initialChar = Player.Character or LocalCharacter
    if initialChar then
        bindMeleeToolEvents(initialChar)
    end
    Player.CharacterAdded:Connect(bindMeleeToolEvents)

    local function getNetworkOwnershipRemote(item)
        local drag = item and item:FindFirstChild("ItemDrag")
        if not drag then
            return nil
        end
        return drag:FindFirstChild("RequestNetworkOwnership")
    end

    local function getStatNumber(stats, statName, fallback)
        local value = stats and stats:FindFirstChild(statName)
        if value then
            local ok, result = pcall(function()
                return value.Value
            end)
            if ok and type(result) == "number" then
                return result
            end
        end
        local attr = stats and stats:GetAttribute(statName)
        if type(attr) == "number" then
            return attr
        end
        return fallback
    end

    local function modelIsAliveTarget(model)
        if not model or not model:IsA("Model") then
            return false
        end
        if model == LocalCharacter or model.Name == Player.Name then
            return false
        end
        -- Humanoid is a direct child of character models, no deep search needed
        local humanoid = model:FindFirstChild("Humanoid")
        if humanoid and humanoid.Health <= 0 then
            return false
        end
        return true
    end

    local function addMeleeCandidate(candidates, seen, target, rootPosition, range)
        if not target or seen[target] then
            return
        end
        local position = UtilityModule.getItemPosition(target)
        if not position then
            return
        end
        local distance = (position - rootPosition).Magnitude
        if distance > range then
            return
        end
        seen[target] = true
        candidates[#candidates + 1] = {
            Model = target,
            Distance = distance,
        }
    end

    local function folderHasItemName(folder, itemName)
        return folder and itemName and folder:FindFirstChild(itemName) ~= nil
    end

    local function getPlayerAmmoAmount(ammoName)
        local ammoConfig = Player:FindFirstChild("Ammo")
        local attributeName = UtilityModule.getAmmoAttributeName(ammoName)
        if not ammoConfig or not attributeName then
            return 0
        end
        local amount = ammoConfig:GetAttribute(attributeName)
        if type(amount) == "number" then
            return amount
        end
        return 0
    end

    local function isAmmoAutoPickupAllowed(item)
        if not State.AutoPickupAmmo then
            return false
        end
        if not folderHasItemName(FolderAmmo, item.Name) or not State.AutoPickupAmmoSelected[item.Name] then
            return false
        end
        local limit = State.AutoPickupAmmoLimits[item.Name] or 0
        return getPlayerAmmoAmount(item.Name) <= limit
    end

    local function isFoodAutoPickupAllowed(item)
        if not State.AutoPickupFood then
            return false
        end
        if not folderHasItemName(FolderFood, item.Name) then
            return false
        end
        local character = Player.Character
        local hunger = character and character:GetAttribute("Hunger")
        return type(hunger) == "number" and hunger <= State.AutoPickupFoodHunger
    end

    local function getGeneratorPosition()
        local generator = Structures:FindFirstChild("Generator")
        local mainPart = generator and generator:FindFirstChild("MainPart")
        return mainPart and (mainPart.Position + Vector3.new(0, 5, 0)) or nil
    end

    local function getShredderPosition()
        local crafting = Services.Workspace:FindFirstChild("Crafting")
        local shredder = crafting and crafting:FindFirstChild("Shredder")
        local mainPart = shredder and shredder:FindFirstChild("MainPart")
        return mainPart and (mainPart.Position + Vector3.new(0, 5, 0)) or nil
    end

    local function getFoodDropPosition()
        local generator = Structures:FindFirstChild("Generator")
        local zoneVisual = generator and generator:FindFirstChild("ZoneVisual")
        return zoneVisual and (zoneVisual.Position + Vector3.new(-20, 0, 20)) or nil
    end

    local function getAutoTeleportDestination(item)
        if State.AutoFuel and folderHasItemName(FolderFuel, item.Name) then
            return getGeneratorPosition(), "Auto Fuel"
        end

        if State.AutoShredder and folderHasItemName(FolderResources, item.Name) then
            return getShredderPosition(), "Auto Shredder"
        end

        if State.AutoFood and folderHasItemName(FolderFood, item.Name) then
            if isFoodAutoPickupAllowed(item) then
                return nil, nil
            end
            return getFoodDropPosition(), "Auto Food"
        end

        return nil, nil
    end

    local function getRelayPosition(homePosition, playerPosition)
        local bestPosition = nil
        local bestHomeDistance = nil

        for _, tile in ipairs(MapTiles:GetChildren()) do
            if tile.Name == "StraightRoad" or tile.Name == "TSection" then
                local tilePosition = UtilityModule.getItemPosition(tile)
                if tilePosition and (tilePosition - playerPosition).Magnitude <= 500 then
                    local homeDistance = (tilePosition - homePosition).Magnitude
                    if not bestHomeDistance or homeDistance < bestHomeDistance then
                        bestHomeDistance = homeDistance
                        bestPosition = tilePosition + Vector3.new(0, 5, 0)
                    end
                end
            end
        end

        return bestPosition
    end

    local function resolveAutoTeleportPosition(homePosition, playerPosition)
        if (homePosition - playerPosition).Magnitude <= 500 then
            return homePosition
        end
        return getRelayPosition(homePosition, playerPosition)
    end

    function MainModule.processAutomaticPickups()
        if AutoPickupBusy or not (State.AutoPickupAmmo or State.AutoPickupFood) then
            return
        end

        local root = UtilityModule.getRootPart()
        if not root then
            return
        end

        local candidates = {}
        for _, item in ipairs(DroppedItems:GetChildren()) do
            local position = UtilityModule.getItemPosition(item)
            if position and (isAmmoAutoPickupAllowed(item) or isFoodAutoPickupAllowed(item)) then
                local distance = (position - root.Position).Magnitude
                if distance <= State.PickupRadius then
                    candidates[#candidates + 1] = { Item = item, Distance = distance }
                end
            end
        end

        if #candidates == 0 then
            return
        end

        table.sort(candidates, function(a, b)
            return a.Distance < b.Distance
        end)

        AutoPickupBusy = true
        task.spawn(function()
            local requested = 0
            for _, candidate in ipairs(candidates) do
                if requested >= State.PickupLimit then
                    break
                end
                if candidate.Item.Parent == DroppedItems
                    and (isAmmoAutoPickupAllowed(candidate.Item) or isFoodAutoPickupAllowed(candidate.Item))
                then
                    requested = requested + 1
                    PickUpItemRemote:FireServer(candidate.Item)
                    task.wait(0.05)
                end
            end
            AutoPickupBusy = false
        end)
    end

    function MainModule.processAutomaticTeleports()
        if AutoTeleportBusy or not (State.AutoFuel or State.AutoShredder or State.AutoFood) then
            return
        end

        local root = UtilityModule.getRootPart()
        if not root then
            return
        end

        local parts = Services.Workspace:GetPartBoundsInRadius(root.Position, State.PickupRadius, TeleportOverlapParams)
        local queued = {}
        local seen = {}

        for _, part in ipairs(parts) do
            local item = part:FindFirstAncestorWhichIsA("Model")
            if item and item.Parent == DroppedItems and not seen[item] and (not AutoTeleportProcessed[item] or os.clock() - AutoTeleportProcessed[item] > 5) then
                seen[item] = true
                local homePosition = getAutoTeleportDestination(item)
                local primary = UtilityModule.getItemBasePart(item)
                local remote = getNetworkOwnershipRemote(item)
                if homePosition and primary and remote then
                    local targetPosition = resolveAutoTeleportPosition(homePosition, root.Position)
                    if targetPosition then
                        queued[#queued + 1] = {
                            Item = item,
                            Primary = primary,
                            Remote = remote,
                            Position = targetPosition,
                        }
                    end
                end
            end
        end

        if #queued == 0 then
            return
        end

        AutoTeleportBusy = true
        task.spawn(function()
            for _, request in ipairs(queued) do
                if request.Item.Parent == DroppedItems and request.Primary.Parent and request.Remote.Parent then
                    pcall(function()
                        request.Remote:FireServer(request.Primary)
                    end)
                    task.wait(State.AutoTeleportCooldown)
                    if request.Primary.Parent then
                        request.Primary.CFrame = CFrame.new(request.Position)
                        AutoTeleportProcessed[request.Item] = os.clock()
                    end
                    task.wait(State.AutoTeleportCooldown)
                end
            end
            AutoTeleportBusy = false
        end)
    end

    function MainModule.processAutoMelee()
        if AutoMeleeBusy or not State.AutoMelee then
            return
        end

        -- No melee tool equipped — nothing to do
        local tool = CachedMeleeTool
        if not tool or not tool.Parent then
            return
        end

        local hitRemote = CachedHitRemote
        if not hitRemote or not hitRemote.Parent then
            -- Try re-resolving in case it was added after equip
            hitRemote = tool:FindFirstChild("HitTargets")
            CachedHitRemote = hitRemote
        end
        if not hitRemote then
            return
        end

        local root = UtilityModule.getRootPart()
        local stats = tool:FindFirstChild("Stats")
        if not root or not stats then
            return
        end

        local range = getStatNumber(stats, "Range", 0)
        local maxHit = math.floor(getStatNumber(stats, "MaxHit", 1))
        local animSpeed = getStatNumber(stats, "AnimSpeed", 1)
        if range <= 0 or maxHit <= 0 then
            return
        end

        local now = os.clock()
        local cooldown = math.max(0.12, 0.35 / math.max(animSpeed, 0.1))
        if now - LastAutoMeleeHit < cooldown then
            return
        end

        local candidates = {}
        local seen = {}
        local rootPosition = root.Position

        if State.AutoMeleeZombies then
            for _, character in ipairs(Characters:GetChildren()) do
                if modelIsAliveTarget(character) then
                    addMeleeCandidate(candidates, seen, character, rootPosition, range)
                end
            end
        end

        if State.AutoMeleePiles or State.AutoMeleeBarrels then
            for _, structure in ipairs(Structures:GetChildren()) do
                if State.AutoMeleePiles and structure.Name == "Scrap Pile" then
                    addMeleeCandidate(candidates, seen, structure, rootPosition, range)
                elseif State.AutoMeleeBarrels and structure.Name == "Barrel" then
                    addMeleeCandidate(candidates, seen, structure, rootPosition, range)
                end
            end
        end

        if #candidates == 0 then
            return
        end

        table.sort(candidates, function(a, b)
            return a.Distance < b.Distance
        end)

        local targets = {}
        for _, candidate in ipairs(candidates) do
            targets[#targets + 1] = candidate.Model
            if #targets >= maxHit then
                break
            end
        end

        if #targets == 0 then
            return
        end

        AutoMeleeBusy = true
        LastAutoMeleeHit = now
        task.spawn(function()
            for _, target in ipairs(targets) do
                pcall(function()
                    if CachedSwingRemote and CachedSwingRemote.Parent then
                        CachedSwingRemote:FireServer()
                    end
                end)
                task.wait(0.07)
                pcall(function()
                    hitRemote:FireServer({ target })
                end)
                task.wait(0.05)
            end
            AutoMeleeBusy = false
        end)
    end

    DroppedItems.ChildRemoved:Connect(function(item)
        AutoTeleportProcessed[item] = nil
    end)
end

local MiscModule = {}
do
    local originalPromptDurations = {}
    local promptConnections = {}
    local originalAtmosphere = Services.Lighting:FindFirstChildWhichIsA("Atmosphere")
    local createdAtmosphere = nil
    local originalEnvironment = {
        FogEnd = Services.Lighting.FogEnd,
        Brightness = Services.Lighting.Brightness,
        ClockTime = Services.Lighting.ClockTime,
        GlobalShadows = Services.Lighting.GlobalShadows,
        Atmosphere = originalAtmosphere,
        AtmosphereDensity = originalAtmosphere and originalAtmosphere.Density or nil,
    }

    local function trackConnection(connection)
        promptConnections[#promptConnections + 1] = connection
    end

    local function disconnectPromptConnections()
        for index = #promptConnections, 1, -1 do
            local connection = promptConnections[index]
            if connection then
                connection:Disconnect()
            end
            promptConnections[index] = nil
        end
    end

    local function applyInstantPrompt(prompt)
        if not prompt or not prompt:IsA("ProximityPrompt") then
            return
        end

        if originalPromptDurations[prompt] == nil then
            originalPromptDurations[prompt] = prompt.HoldDuration
        end

        prompt.HoldDuration = 0
    end

    local function scanContainer(container)
        if not container then
            return
        end

        for _, descendant in ipairs(container:GetDescendants()) do
            applyInstantPrompt(descendant)
        end
    end

    function MiscModule.refreshInstantProximityPrompts()
        scanContainer(Services.Workspace)
        scanContainer(PlayerGui)
    end

    function MiscModule.setInstantProximityPrompt(enabled)
        State.InstantProximityPrompt = enabled
        disconnectPromptConnections()

        if enabled then
            MiscModule.refreshInstantProximityPrompts()

            trackConnection(Services.Workspace.DescendantAdded:Connect(function(descendant)
                task.defer(function()
                    if State.InstantProximityPrompt then
                        applyInstantPrompt(descendant)
                        scanContainer(descendant)
                    end
                end)
            end))

            trackConnection(PlayerGui.DescendantAdded:Connect(function(descendant)
                task.defer(function()
                    if State.InstantProximityPrompt then
                        applyInstantPrompt(descendant)
                        scanContainer(descendant)
                    end
                end)
            end))

            UtilityModule.notify("Instant Prompts", "Proximity prompts now complete instantly.", "Success")
            return
        end

        for prompt, duration in pairs(originalPromptDurations) do
            if prompt and prompt.Parent then
                pcall(function()
                    prompt.HoldDuration = duration
                end)
            end
            originalPromptDurations[prompt] = nil
        end

        UtilityModule.notify("Instant Prompts", "Proximity prompt hold durations restored.", "Info")
    end

    local function getAtmosphere(createIfMissing)
        local atmosphere = Services.Lighting:FindFirstChildWhichIsA("Atmosphere")
        if not atmosphere and createIfMissing then
            atmosphere = Instance.new("Atmosphere")
            atmosphere.Name = "SimpleScriptsAtmosphere"
            atmosphere.Density = 0
            atmosphere.Parent = Services.Lighting
            createdAtmosphere = atmosphere
        end
        return atmosphere
    end

    function MiscModule.setFogDistance(value)
        State.EnvironmentFogEnd = value
        Services.Lighting.FogEnd = value
    end

    function MiscModule.setAtmosphereDensity(value)
        State.EnvironmentAtmosphereDensity = value
        local atmosphere = getAtmosphere(value > 0)
        if atmosphere then
            atmosphere.Density = math.clamp(value, 0, 1)
        end
    end

    function MiscModule.setClockTime(value)
        State.EnvironmentClockTime = value
        Services.Lighting.ClockTime = value
    end

    function MiscModule.setBrightness(value)
        State.EnvironmentBrightness = value
        Services.Lighting.Brightness = value
    end

    function MiscModule.setGlobalShadows(enabled)
        State.EnvironmentGlobalShadows = enabled
        Services.Lighting.GlobalShadows = enabled
    end

    function MiscModule.resetEnvironment()
        Services.Lighting.FogEnd = originalEnvironment.FogEnd
        Services.Lighting.Brightness = originalEnvironment.Brightness
        Services.Lighting.ClockTime = originalEnvironment.ClockTime
        Services.Lighting.GlobalShadows = originalEnvironment.GlobalShadows

        State.EnvironmentFogEnd = math.clamp(originalEnvironment.FogEnd, 0, 100000)
        State.EnvironmentBrightness = math.clamp(originalEnvironment.Brightness, 0, 5)
        State.EnvironmentClockTime = originalEnvironment.ClockTime
        State.EnvironmentGlobalShadows = originalEnvironment.GlobalShadows

        if originalEnvironment.Atmosphere and originalEnvironment.Atmosphere.Parent then
            originalEnvironment.Atmosphere.Density = originalEnvironment.AtmosphereDensity
            State.EnvironmentAtmosphereDensity = math.clamp(originalEnvironment.AtmosphereDensity or 0, 0, 1)
        elseif createdAtmosphere and createdAtmosphere.Parent then
            createdAtmosphere:Destroy()
            createdAtmosphere = nil
            State.EnvironmentAtmosphereDensity = 0
        end

        UtilityModule.notify("Environment", "Restored the original local lighting values.", "Info")
    end
end

local EspModule = {}
do
    local ItemHighlights = {}
    local CharacterHighlights = {}
    local SurvivorHighlights = {}
    local GeneratorHighlights = {}
    local ScrapPileHighlights = {}
    local RadioTowerHighlights = {}
    local PowerPlantHighlights = {}
    local BarrelHighlights = {}
    local CrateHighlights = {}

    -- item → itemClass: populated once on ChildAdded, never recomputed per-tick
    local ItemDataCache = {}

    local function randomInstanceName()
        local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        local len = math.random(8, 14)
        local t = table.create(len)
        for i = 1, len do
            local idx = math.random(1, #chars)
            t[i] = chars:sub(idx, idx)
        end
        return table.concat(t)
    end

    local function getDistanceFromRoot(target)
        local root = UtilityModule.getRootPart()
        local position = UtilityModule.getItemPosition(target)
        if not root or not position then
            return nil
        end
        return (position - root.Position).Magnitude
    end

    local function getEspRadius(radiusKey)
        local override = radiusKey and State[radiusKey] or 0
        if override and override > 0 then
            return override
        end
        return State.EspMasterRadius
    end

    local function isWithinEspRadius(target, radiusKey)
        local radius = getEspRadius(radiusKey)
        if not radius or radius <= 0 then
            return true
        end
        local distance = getDistanceFromRoot(target)
        return distance ~= nil and distance <= radius
    end

    local function selectedNameMatches(selectedKey, itemName)
        local selected = State[selectedKey]
        return not selected or selected == SelectAllOption or selected == itemName
    end

    local function getItemEspClass(item)
        for _, className in ipairs(ItemEspClassNames) do
            local itemClass = ItemEspClasses[className]
            if itemClass.Folder and itemClass.Folder:FindFirstChild(item.Name) then
                return itemClass
            end
        end
        return ItemEspClasses.World
    end

    local function itemClassIsActiveForName(itemClass, itemName)
        return State[itemClass.StateKey] and selectedNameMatches(itemClass.SelectedKey, itemName)
    end

    local function itemClassMatchesDroppedItem(itemClass, item)
        return itemClass.Folder
            and itemClass.Folder:FindFirstChild(item.Name)
            and itemClassIsActiveForName(itemClass, item.Name)
    end

    local function getDropValueName(valueObject)
        if not valueObject then
            return nil
        end
        local ok, value = pcall(function()
            return valueObject.Value
        end)
        if not ok or not value then
            return nil
        end
        if type(value) == "string" then
            return value
        end
        local okName, valueName = pcall(function()
            return value.Name
        end)
        if okName and valueName then
            return tostring(valueName)
        end
        return tostring(value)
    end

    local function getBarrelDropNames(barrel)
        local drops = barrel and barrel:FindFirstChild("Drops")
        local names = {}
        if not drops then
            return names
        end
        for _, child in ipairs(drops:GetChildren()) do
            local itemName = getDropValueName(child)
            if itemName then
                names[#names + 1] = itemName
            end
        end
        return names
    end

    local function getMatchingBarrelItemClass(barrel)
        for _, itemName in ipairs(getBarrelDropNames(barrel)) do
            for _, className in ipairs(ItemEspClassNames) do
                local itemClass = ItemEspClasses[className]
                if itemClass.Folder
                    and itemClass.Folder:FindFirstChild(itemName)
                    and itemClassIsActiveForName(itemClass, itemName)
                then
                    return itemClass, itemName
                end
            end
        end
        return nil, nil
    end

    local function isPowerPlant(model)
        if not model or not model:IsA("Model") then
            return false
        end
        return model:FindFirstChild("Power Box")
            and model:FindFirstChild("PowerPlantScript", true)
            and model:FindFirstChild("ProgressDisplay", true)
    end

    local function isRadioTower(model)
        return model
            and model:IsA("Model")
            and model.Name == "Radio Tower"
            and model:FindFirstChild("CircuitBox", true) ~= nil
    end

    local function removeHighlight(cache, target)
        local esp = cache[target]
        if not esp then
            return
        end
        if esp.Highlight then
            esp.Highlight:Destroy()
        end
        if esp.Label then
            esp.Label:Destroy()
        end
        cache[target] = nil
    end

    -- Labels are disabled beyond this distance to eliminate UI layout cost
    local LabelCullDistance = 100

    local function createEspLabel(target, text, textColor)
        local adornee = UtilityModule.getItemBasePart(target)
        if not adornee then return nil end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = randomInstanceName()
        billboard.Adornee = adornee
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.fromOffset(220, 20)
        billboard.StudsOffsetWorldSpace = Vector3.new(0, 3.2, 0)
        billboard.Parent = Services.Workspace.CurrentCamera

        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Size = UDim2.fromScale(1, 1)
        label.Font = Enum.Font.GothamBold
        label.Text = text
        label.TextColor3 = textColor
        label.TextSize = 14
        label.TextStrokeColor3 = Color3.fromRGB(15, 15, 15)
        label.TextStrokeTransparency = 0.08
        label.Parent = billboard

        return billboard
    end

    local function updateEspLabel(esp, target, text, textColor)
        if not esp.Label then
            esp.Label = createEspLabel(target, text, textColor)
            return
        end
        local label = esp.Label:FindFirstChildWhichIsA("TextLabel")
        if label then
            label.Text = text
            label.TextColor3 = textColor
        end
    end

    local function removeEspLabel(esp)
        if esp and esp.Label then
            esp.Label:Destroy()
            esp.Label = nil
        end
    end

    local function setHighlight(cache, target, enabled, fillColor, outlineColor, labelText, labelColor)
        if not enabled then
            removeHighlight(cache, target)
            return
        end

        local esp = cache[target]
        if esp then
            if esp.Highlight then
                esp.Highlight.FillColor = fillColor
                esp.Highlight.OutlineColor = outlineColor
            end
            if labelText then
                updateEspLabel(esp, target, labelText, labelColor)
            else
                removeEspLabel(esp)
            end
            return
        end

        local highlight = Instance.new("Highlight")
        highlight.Name = randomInstanceName()
        highlight.Adornee = target
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = fillColor
        highlight.FillTransparency = 0.65
        highlight.OutlineColor = outlineColor
        highlight.OutlineTransparency = 0
        highlight.Parent = Services.Workspace.CurrentCamera
        esp = { Highlight = highlight }
        cache[target] = esp
        if labelText then
            updateEspLabel(esp, target, labelText, labelColor)
        end
    end

    function EspModule.refreshItemHighlight(item)
        local itemClass = ItemDataCache[item] or getItemEspClass(item)
        ItemDataCache[item] = itemClass
        setHighlight(
            ItemHighlights,
            item,
            itemClassMatchesDroppedItem(itemClass, item)
            and isWithinEspRadius(item, itemClass.RadiusKey),
            itemClass.FillColor,
            itemClass.OutlineColor,
            item.Name,
            itemClass.TextColor
        )
    end

    function EspModule.refreshItemHighlights()
        local root = UtilityModule.getRootPart()
        local rootPos = root and root.Position

        for item, itemClass in pairs(ItemDataCache) do
            local enabled = item.Parent == DroppedItems
                and itemClassMatchesDroppedItem(itemClass, item)
                and isWithinEspRadius(item, itemClass.RadiusKey)
            setHighlight(ItemHighlights, item, enabled, itemClass.FillColor, itemClass.OutlineColor, item.Name, itemClass.TextColor)

            -- Cull label beyond LabelCullDistance — disables UI layout, keeps instance alive
            local esp = ItemHighlights[item]
            if esp and esp.Label and rootPos then
                local pos = UtilityModule.getItemPosition(item)
                esp.Label.Enabled = pos ~= nil and (pos - rootPos).Magnitude <= LabelCullDistance
            end
        end

        for item in pairs(ItemHighlights) do
            if not ItemDataCache[item] then
                removeHighlight(ItemHighlights, item)
            end
        end
    end

    function EspModule.refreshCharacterHighlight(character)
        local isOtherCharacter = character ~= LocalCharacter and character.Name ~= Player.Name
        setHighlight(
            CharacterHighlights,
            character,
            State.ZombieESP
            and isOtherCharacter
            and selectedNameMatches("ZombieSelected", character.Name)
            and isWithinEspRadius(character, "ZombieRadius"),
            Color3.fromRGB(190, 30, 50),
            Color3.fromRGB(255, 80, 100),
            character.Name,
            Color3.fromRGB(255, 100, 120)
        )
    end

    function EspModule.refreshCharacterHighlights()
        for _, character in ipairs(Characters:GetChildren()) do
            EspModule.refreshCharacterHighlight(character)
        end
        local root = UtilityModule.getRootPart()
        for character, esp in pairs(CharacterHighlights) do
            if not character.Parent
                or not State.ZombieESP
                or character == LocalCharacter
                or character.Name == Player.Name
                or not selectedNameMatches("ZombieSelected", character.Name)
                or not isWithinEspRadius(character, "ZombieRadius")
            then
                removeHighlight(CharacterHighlights, character)
            elseif esp.Label and root then
                local pos = UtilityModule.getItemPosition(character)
                esp.Label.Enabled = pos ~= nil and (pos - root.Position).Magnitude <= LabelCullDistance
            end
        end
    end

    function EspModule.refreshSurvivorHighlight(survivor)
        setHighlight(
            SurvivorHighlights,
            survivor,
            State.SurvivorESP and isWithinEspRadius(survivor, "SurvivorRadius"),
            Color3.fromRGB(20, 165, 230),
            Color3.fromRGB(95, 225, 255),
            survivor.Name,
            Color3.fromRGB(135, 235, 255)
        )
    end

    function EspModule.refreshSurvivorHighlights()
        for _, survivor in ipairs(Survivors:GetChildren()) do
            EspModule.refreshSurvivorHighlight(survivor)
        end
        local root = UtilityModule.getRootPart()
        for survivor, esp in pairs(SurvivorHighlights) do
            if not survivor.Parent or not State.SurvivorESP or not isWithinEspRadius(survivor, "SurvivorRadius") then
                removeHighlight(SurvivorHighlights, survivor)
            elseif esp.Label and root then
                local pos = UtilityModule.getItemPosition(survivor)
                esp.Label.Enabled = pos ~= nil and (pos - root.Position).Magnitude <= LabelCullDistance
            end
        end
    end

    function EspModule.refreshGeneratorHighlight(generator)
        setHighlight(
            GeneratorHighlights,
            generator,
            State.GeneratorESP and generator.Name == "Generator" and isWithinEspRadius(generator, "ObjectiveRadius"),
            Color3.fromRGB(55, 175, 255),
            Color3.fromRGB(175, 230, 255),
            "Generator",
            Color3.fromRGB(155, 225, 255)
        )
    end

    function EspModule.refreshGeneratorHighlights()
        for _, structure in ipairs(Structures:GetChildren()) do
            if structure.Name == "Generator" then
                EspModule.refreshGeneratorHighlight(structure)
            end
        end
        for generator in pairs(GeneratorHighlights) do
            if not generator.Parent
                or not State.GeneratorESP
                or generator.Name ~= "Generator"
                or not isWithinEspRadius(generator, "ObjectiveRadius")
            then
                removeHighlight(GeneratorHighlights, generator)
            end
        end
    end

    function EspModule.refreshScrapPileHighlight(scrapPile)
        setHighlight(
            ScrapPileHighlights,
            scrapPile,
            State.ScrapPileESP and scrapPile.Name == "Scrap Pile" and isWithinEspRadius(scrapPile, "ObjectiveRadius"),
            Color3.fromRGB(155, 100, 50),
            Color3.fromRGB(225, 175, 105),
            "Scrap Pile",
            Color3.fromRGB(235, 185, 115)
        )
    end

    function EspModule.refreshScrapPileHighlights()
        for _, structure in ipairs(Structures:GetChildren()) do
            if structure.Name == "Scrap Pile" then
                EspModule.refreshScrapPileHighlight(structure)
            end
        end
        for scrapPile in pairs(ScrapPileHighlights) do
            if not scrapPile.Parent
                or not State.ScrapPileESP
                or scrapPile.Name ~= "Scrap Pile"
                or not isWithinEspRadius(scrapPile, "ObjectiveRadius")
            then
                removeHighlight(ScrapPileHighlights, scrapPile)
            end
        end
    end

    function EspModule.refreshRadioTowerHighlight(tileModel)
        setHighlight(
            RadioTowerHighlights,
            tileModel,
            State.RadioTowerESP and isRadioTower(tileModel) and isWithinEspRadius(tileModel, "ObjectiveRadius"),
            Color3.fromRGB(110, 75, 240),
            Color3.fromRGB(190, 160, 255),
            "Radio Tower",
            Color3.fromRGB(195, 165, 255)
        )
    end

    function EspModule.refreshRadioTowerHighlights()
        for _, tileModel in ipairs(MapTiles:GetChildren()) do
            EspModule.refreshRadioTowerHighlight(tileModel)
        end
        for tileModel in pairs(RadioTowerHighlights) do
            if not tileModel.Parent
                or not State.RadioTowerESP
                or not isRadioTower(tileModel)
                or not isWithinEspRadius(tileModel, "ObjectiveRadius")
            then
                removeHighlight(RadioTowerHighlights, tileModel)
            end
        end
    end

    function EspModule.refreshPowerPlantHighlight(tileModel)
        setHighlight(
            PowerPlantHighlights,
            tileModel,
            State.PowerPlantESP and isPowerPlant(tileModel) and isWithinEspRadius(tileModel, "ObjectiveRadius"),
            Color3.fromRGB(210, 160, 0),
            Color3.fromRGB(255, 225, 55),
            "Power Plant",
            Color3.fromRGB(255, 230, 90)
        )
    end

    function EspModule.refreshPowerPlantHighlights()
        for _, tileModel in ipairs(MapTiles:GetChildren()) do
            EspModule.refreshPowerPlantHighlight(tileModel)
        end
        for tileModel in pairs(PowerPlantHighlights) do
            if not tileModel.Parent
                or not State.PowerPlantESP
                or not isPowerPlant(tileModel)
                or not isWithinEspRadius(tileModel, "ObjectiveRadius")
            then
                removeHighlight(PowerPlantHighlights, tileModel)
            end
        end
    end

    function EspModule.refreshBarrelHighlight(barrel)
        local itemClass, itemName = getMatchingBarrelItemClass(barrel)
        local showFromContents = itemClass ~= nil
        local enabled = barrel.Name == "Barrel"
            and (State.BarrelESP or showFromContents)
            and isWithinEspRadius(barrel, "BarrelRadius")

        local labelText = "Barrel"
        local labelColor = Color3.fromRGB(255, 150, 80)
        if itemClass and itemName then
            labelText = itemName
            labelColor = itemClass.TextColor
        end

        setHighlight(
            BarrelHighlights,
            barrel,
            enabled,
            itemClass and itemClass.FillColor or Color3.fromRGB(185, 70, 28),
            itemClass and itemClass.OutlineColor or Color3.fromRGB(255, 140, 70),
            labelText,
            labelColor
        )
    end

    function EspModule.refreshBarrelHighlights()
        for _, structure in ipairs(Structures:GetChildren()) do
            if structure.Name == "Barrel" then
                EspModule.refreshBarrelHighlight(structure)
            end
        end
        for barrel in pairs(BarrelHighlights) do
            local itemClass = getMatchingBarrelItemClass(barrel)
            if not barrel.Parent
                or barrel.Name ~= "Barrel"
                or not (State.BarrelESP or itemClass)
                or not isWithinEspRadius(barrel, "BarrelRadius")
            then
                removeHighlight(BarrelHighlights, barrel)
            end
        end
    end

    function EspModule.refreshCrateHighlight(crate)
        setHighlight(
            CrateHighlights,
            crate,
            State.CrateESP and crate.Name == "Default" and isWithinEspRadius(crate, "CrateRadius"),
            Color3.fromRGB(120, 88, 55),
            Color3.fromRGB(205, 165, 105),
            "Crate",
            Color3.fromRGB(220, 180, 120)
        )
    end

    function EspModule.refreshCrateHighlights()
        for _, crate in ipairs(MapCrates:GetChildren()) do
            EspModule.refreshCrateHighlight(crate)
        end
        for crate in pairs(CrateHighlights) do
            if not crate.Parent
                or not State.CrateESP
                or crate.Name ~= "Default"
                or not isWithinEspRadius(crate, "CrateRadius")
            then
                removeHighlight(CrateHighlights, crate)
            end
        end
    end

    function EspModule.refreshStructureHighlights()
        EspModule.refreshGeneratorHighlights()
        EspModule.refreshScrapPileHighlights()
        EspModule.refreshRadioTowerHighlights()
        EspModule.refreshBarrelHighlights()
        EspModule.refreshPowerPlantHighlights()
        EspModule.refreshCrateHighlights()
    end

    function EspModule.refreshAll()
        EspModule.refreshItemHighlights()
        EspModule.refreshCharacterHighlights()
        EspModule.refreshSurvivorHighlights()
        EspModule.refreshStructureHighlights()
    end

    -- Seed cache for items already in the world at script load
    for _, item in ipairs(DroppedItems:GetChildren()) do
        ItemDataCache[item] = getItemEspClass(item)
    end

    DroppedItems.ChildAdded:Connect(function(item)
        task.defer(function()
            ItemDataCache[item] = getItemEspClass(item)
            EspModule.refreshItemHighlight(item)
        end)
    end)
    DroppedItems.ChildRemoved:Connect(function(item)
        ItemDataCache[item] = nil
        removeHighlight(ItemHighlights, item)
    end)

    Characters.ChildAdded:Connect(function(character)
        task.defer(EspModule.refreshCharacterHighlight, character)
    end)
    Characters.ChildRemoved:Connect(function(character)
        removeHighlight(CharacterHighlights, character)
    end)

    Structures.ChildAdded:Connect(function(structure)
        task.defer(EspModule.refreshBarrelHighlight, structure)
        task.defer(EspModule.refreshGeneratorHighlight, structure)
        task.defer(EspModule.refreshScrapPileHighlight, structure)
    end)
    Structures.ChildRemoved:Connect(function(structure)
        removeHighlight(BarrelHighlights, structure)
        removeHighlight(GeneratorHighlights, structure)
        removeHighlight(ScrapPileHighlights, structure)
    end)

    MapTiles.ChildAdded:Connect(function(tileModel)
        task.defer(EspModule.refreshPowerPlantHighlight, tileModel)
        task.defer(EspModule.refreshRadioTowerHighlight, tileModel)
    end)
    MapTiles.ChildRemoved:Connect(function(tileModel)
        removeHighlight(PowerPlantHighlights, tileModel)
        removeHighlight(RadioTowerHighlights, tileModel)
    end)

    MapCrates.ChildAdded:Connect(function(crate)
        task.defer(EspModule.refreshCrateHighlight, crate)
    end)
    MapCrates.ChildRemoved:Connect(function(crate)
        removeHighlight(CrateHighlights, crate)
    end)

    Survivors.ChildAdded:Connect(function(survivor)
        task.defer(EspModule.refreshSurvivorHighlight, survivor)
    end)
    Survivors.ChildRemoved:Connect(function(survivor)
        removeHighlight(SurvivorHighlights, survivor)
    end)
end

local MobileUIModule = {}
do
    function MobileUIModule.createToggleButton(window, forceMobile)
        if not forceMobile and not SimpleUI.Utility:IsMobile() then
            return
        end

        local TweenService = SimpleUI.Utility:GetService("TweenService")
        local UserInputService = SimpleUI.Utility:GetService("UserInputService")

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
        toggleButton.Parent = window.Elements.ScreenGui

        local dragging = false
        local dragStart, startPos
        local hasMoved = false
        local normalSize = UDim2.new(0, 40, 0, 40)
        local pressSize = UDim2.new(0, 50, 0, 50)
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

        if toggleButton and TweenService then
            toggleButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType ==
                    Enum.UserInputType.Touch then
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
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType ==
                    Enum.UserInputType.Touch then
                    dragging = false
                    TweenService:Create(toggleButton, tweenInfo, {
                        Size = normalSize
                    }):Play()
                    if not hasMoved then
                        if window.IsVisible() then
                            window.Hide()
                        else
                            window.Show()
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
                        toggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                    end
                end
            end)
        end
    end
end

-- ========================
-- WINDOW
-- ========================

local window = SimpleUI:CreateWindow({
    Brand = {
        Name = "SimpleScripts",
    },
    DefaultScale = SimpleUI.Utility:IsMobile() and 0.50 or 0.75,
    TabMode = "Dynamic",
    CanResize = true,
    Footer = true,
    FooterItems = {
        {
            Type = "Text",
            Text = "SimpleUI v" .. SimpleUI.Version .. " - discord.gg/5BUTb4vYm3",
            ColorTier = "TextSecondary",
            Order = 1,
        },
    },
    StartHidden = false,
    IgnoreGuiInset = false,
    DisplayOrder = 1,
})

-- ========================
-- TABS
-- ========================

local Tabs = {
    Main = SimpleUI:CreateTab(window, "Main", {
        Description = "Auto farm",
        Icon = {
            Image = "rbxassetid://10734975692",
            Size = UDim2.new(0, 16, 0, 16),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        },
        DualScroll = true,
    }),
    Items = SimpleUI:CreateTab(window, "Items", {
        Description = "Item automation",
        Icon = {
            Image = "rbxassetid://16898613044",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(771, 955),
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        },
        DualScroll = true,
    }),
    ESP = SimpleUI:CreateTab(window, "ESP", {
        Description = "Important world and character highlights",
        Icon = {
            Image = "rbxassetid://10734963191",
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        },
        DualScroll = true,
    }),
    Miscellaneous = SimpleUI:CreateTab(window, "Miscellaneous", {
        Description = "Interaction and environment controls",
        Icon = {
            Image = "rbxassetid://16898613869",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(820, 906),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        },
        DualScroll = true,
    }),
    Settings = SimpleUI:CreateTab(window, "Settings", {
        Description = "Interface customization and control configuration",
        Icon = {
            Image = "rbxassetid://16898613777",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(771, 257),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        },
    }),
}

-- ========================
-- MAIN TAB
-- ========================

local function initializeMainTab()
    local page = Tabs.Main.Page.Left

    SimpleUI:CreateSection(page, "Auto Melee")

    SimpleUI:CreateToggle(page, "Auto Melee", false, function(enabled)
        State.AutoMelee = enabled
    end, {
        Description = "Attacks nearby selected models with the equipped melee tool.",
        Save = {
            Key = "sta.main.auto_melee.enabled",
        },
    })

    SimpleUI:CreateToggle(page, "Melee Zombies", State.AutoMeleeZombies, function(enabled)
        State.AutoMeleeZombies = enabled
    end, {
        Description = "Includes hostile character models in Auto Melee targets.",
        Save = {
            Key = "sta.main.auto_melee.zombies",
        },
    })

    SimpleUI:CreateToggle(page, "Melee Scrap Piles", State.AutoMeleePiles, function(enabled)
        State.AutoMeleePiles = enabled
    end, {
        Description = "Includes scrap piles in Auto Melee targets.",
        Save = {
            Key = "sta.main.auto_melee.piles",
        },
    })

    SimpleUI:CreateToggle(page, "Melee Barrels", State.AutoMeleeBarrels, function(enabled)
        State.AutoMeleeBarrels = enabled
    end, {
        Description = "Includes barrels in Auto Melee targets.",
        Save = {
            Key = "sta.main.auto_melee.barrels",
        },
    })
end

-- ========================
-- ITEMS TAB
-- ========================

local function initializeItemsTab()
    local page = Tabs.Items.Page.Left
    local serverPage = Tabs.Items.Page.Right

    SimpleUI:CreateSection(page, "Auto Consume")

    local ammoSliderControls = {}
    local ammoOptions = UtilityModule.getChildNames(ItemEspClasses.Ammo.Folder)
    for index = #ammoOptions, 1, -1 do
        if ammoOptions[index] == SelectAllOption then
            table.remove(ammoOptions, index)
        end
    end

    local function refreshAmmoLimitSliders()
        for ammoName, slider in pairs(ammoSliderControls) do
            local elements = slider.GetElements and slider:GetElements()
            if elements and elements.Container then
                elements.Container.Visible = State.AutoPickupAmmoSelected[ammoName] == true
            end
        end
    end

    SimpleUI:CreateToggle(page, "Auto Consume Food", false, function(enabled)
        State.AutoPickupFood = enabled
    end, {
        Description = "Consumes nearby food when hunger is at or below the threshold.",
        Save = {
            Key = "sta.main.auto_pickup_food",
        },
    })

    SimpleUI:CreateSlider(page, "Food Hunger Threshold", 30, 100, State.AutoPickupFoodHunger, function(value)
        State.AutoPickupFoodHunger = value
    end, {
        Increment = 1,
        Description = "Food consumption starts when your character Hunger attribute is at or below this value.",
        Save = {
            Key = "sta.main.auto_pickup_food_hunger",
        },
    })

    SimpleUI:CreateToggle(page, "Auto Pickup Ammo", false, function(enabled)
        State.AutoPickupAmmo = enabled
    end, {
        Description = "Picks up selected nearby ammo while your current amount is at or below its limit.",
        Save = {
            Key = "sta.main.auto_pickup_ammo",
        },
    })

    SimpleUI:CreateDropdown(
        page,
        "Ammo Types",
        ammoOptions,
        {},
        function(values)
            State.AutoPickupAmmoSelected = {}
            if type(values) == "table" then
                for _, value in ipairs(values) do
                    State.AutoPickupAmmoSelected[tostring(value)] = true
                end
            end
            refreshAmmoLimitSliders()
        end,
        {
            MultiSelect = true,
            Description = "Choose which ammo drops should be picked up automatically.",
            Save = {
                Key = "sta.main.auto_pickup_ammo_types",
            },
        }
    )

    for _, ammoName in ipairs(ammoOptions) do
        State.AutoPickupAmmoLimits[ammoName] = State.AutoPickupAmmoLimits[ammoName] or 100
        ammoSliderControls[ammoName] = SimpleUI:CreateSlider(
            page,
            ammoName .. " Max Ammo",
            100,
            2000,
            State.AutoPickupAmmoLimits[ammoName],
            function(value)
                State.AutoPickupAmmoLimits[ammoName] = value
            end,
            {
                Increment = 1,
                Description = "Stops pickup once your current " .. UtilityModule.getAmmoAttributeName(ammoName) .. " ammo is above this value.",
                Save = {
                    Key = "sta.main.auto_pickup_ammo_limit." .. ammoName,
                },
            }
        )
    end
    refreshAmmoLimitSliders()

    SimpleUI:CreateSection(serverPage, "Automatic TP")

    SimpleUI:CreateToggle(serverPage, "Auto Fuel", false, function(enabled)
        State.AutoFuel = enabled
    end, {
        Description = "Moves nearby dropped fuel items to the generator or a valid road relay point.",
        Save = {
            Key = "sta.main.auto_fuel",
        },
    })

    SimpleUI:CreateToggle(serverPage, "Auto Shredder", false, function(enabled)
        State.AutoShredder = enabled
    end, {
        Description = "Moves nearby dropped resource items to the shredder or a valid road relay point.",
        Save = {
            Key = "sta.main.auto_shredder",
        },
    })

    SimpleUI:CreateToggle(serverPage, "Auto Food", false, function(enabled)
        State.AutoFood = enabled
    end, {
        Description = "Moves nearby dropped food items to the generator-side food drop or a valid road relay point.",
        Save = {
            Key = "sta.main.auto_food",
        },
    })
end

-- ========================
-- ESP TAB
-- ========================

local function initializeEspTab()
    local page = Tabs.ESP.Page.Left
    local worldPage = Tabs.ESP.Page.Right

    local radiusSection = SimpleUI:CreateSection(page, "ESP Radius", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://16898613699",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(257, 967)
        }
    })

    SimpleUI:CreateSlider(radiusSection.Container, "Master ESP Radius", 0, 2500, State.EspMasterRadius, function(value)
        State.EspMasterRadius = value
        EspModule.refreshAll()
    end, {
        Increment = 25,
        Description = "Global ESP range. Set to 0 for unlimited range.",
        Save = {
            Key = "sta.esp.master_radius",
        },
    })

    SimpleUI:CreateSlider(radiusSection.Container, "Objective ESP Radius Override", 0, 2500, State.ObjectiveRadius, function(value)
        State.ObjectiveRadius = value
        EspModule.refreshStructureHighlights()
    end, {
        Increment = 25,
        Description = "Set above 0 to use a separate range for generator, power, scrap, and radio objectives.",
        Save = {
            Key = "sta.esp.objective_radius",
        },
    })

    SimpleUI:CreateButton(radiusSection.Container, "Refresh ESP", EspModule.refreshAll, {
        Description = "Rebuilds all active ESP labels after world, dropdown, or radius changes.",
    })

    local fuelFoodSection = SimpleUI:CreateSection(page, "Fuel & Food", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://16898613353",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(196, 967)
        }
    })

    SimpleUI:CreateToggle(fuelFoodSection.Container, "Fuel ESP", false, function(enabled)
        State.FuelItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks fuel and refuel items so they are easier to spot while looting.",
        Save = {
            Key = "sta.esp.fuel.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        fuelFoodSection.Container,
        "Fuel ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Fuel.Folder),
        State.FuelItemSelected,
        function(value)
            State.FuelItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one fuel item to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.fuel.selected",
            },
        })

    SimpleUI:CreateToggle(fuelFoodSection.Container, "Food ESP", false, function(enabled)
        State.FoodItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks edible loot for quick health and hunger recovery runs.",
        Save = {
            Key = "sta.esp.food.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        fuelFoodSection.Container,
        "Food ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Food.Folder),
        State.FoodItemSelected,
        function(value)
            State.FoodItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one food item to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.food.selected",
            },
        })

    SimpleUI:CreateSlider(
        fuelFoodSection.Container,
        "Food ESP Radius Override",
        0,
        1500,
        State.FoodItemRadius,
        function(value)
            State.FoodItemRadius = value
            EspModule.refreshItemHighlights()
        end,
        { Increment = 25, Description =
        "Set above 0 to override the master ESP radius for this radar-supported category.",
            Save = {
                Key = "sta.esp.food.radius",
            },
        })

    local medicalSection = SimpleUI:CreateSection(page, "Medical Consumables", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://16898612819",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(820, 404)
        },
    })

    SimpleUI:CreateToggle(medicalSection.Container, "Medical ESP", false, function(enabled)
        State.MedicalItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks healing tools and medical supplies before you get close.",
        Save = {
            Key = "sta.esp.medical.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        medicalSection.Container,
        "Medical ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Medical.Folder),
        State.MedicalItemSelected,
        function(value)
            State.MedicalItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one medical item to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.medical.selected",
            },
        })

    SimpleUI:CreateSlider(
        medicalSection.Container,
        "Medical ESP Radius Override",
        0,
        1500,
        State.MedicalItemRadius,
        function(value)
            State.MedicalItemRadius = value
            EspModule.refreshItemHighlights()
        end,
        { Increment = 25, Description =
        "Set above 0 to override the master ESP radius for this radar-supported category.",
            Save = {
                Key = "sta.esp.medical.radius",
            },
        })

    local gunsAmmoSection = SimpleUI:CreateSection(page, "Guns & Ammo", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://80521479530593",
            Size = UDim2.new(0, 16, 0, 16),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        }
    })

    SimpleUI:CreateToggle(gunsAmmoSection.Container, "Gun ESP", false, function(enabled)
        State.RangedItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks ranged weapons so upgrades are easier to compare at a distance.",
        Save = {
            Key = "sta.esp.guns.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        gunsAmmoSection.Container,
        "Gun ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Ranged.Folder),
        State.RangedItemSelected,
        function(value)
            State.RangedItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one gun to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.guns.selected",
            },
        })

    SimpleUI:CreateSlider(
        gunsAmmoSection.Container,
        "Gun ESP Radius Override",
        0,
        1500,
        State.RangedItemRadius,
        function(value)
            State.RangedItemRadius = value
            EspModule.refreshItemHighlights()
        end,
        { Increment = 25, Description =
        "Set above 0 to override the master ESP radius for this radar-supported category.",
            Save = {
                Key = "sta.esp.guns.radius",
            },
        })

    SimpleUI:CreateToggle(gunsAmmoSection.Container, "Ammo ESP", false, function(enabled)
        State.AmmoItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks ammunition drops so you can restock without checking every item.",
        Save = {
            Key = "sta.esp.ammo.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        gunsAmmoSection.Container,
        "Ammo ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Ammo.Folder),
        State.AmmoItemSelected,
        function(value)
            State.AmmoItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one ammo type to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.ammo.selected",
            },
        })

    SimpleUI:CreateSlider(
        gunsAmmoSection.Container,
        "Ammo ESP Radius Override",
        0,
        1500,
        State.AmmoItemRadius,
        function(value)
            State.AmmoItemRadius = value
            EspModule.refreshItemHighlights()
        end,
        { Increment = 25, Description =
        "Set above 0 to override the master ESP radius for this radar-supported category.",
            Save = {
                Key = "sta.esp.ammo.radius",
            },
        })

    local extraToolsSection = SimpleUI:CreateSection(page, "Extra Tools", {
        Style = "box",
        DefaultExpanded = false,
    })

    SimpleUI:CreateToggle(extraToolsSection.Container, "Melee ESP", false, function(enabled)
        State.MeleeItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks melee weapons and barrels that can drop the selected melee item.",
        Save = {
            Key = "sta.esp.melee.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        extraToolsSection.Container,
        "Melee ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Melee.Folder),
        State.MeleeItemSelected,
        function(value)
            State.MeleeItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one melee weapon to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.melee.selected",
            },
        })

    SimpleUI:CreateToggle(extraToolsSection.Container, "Backpack ESP", false, function(enabled)
        State.BackpackItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks backpack drops so storage upgrades stand out.",
        Save = {
            Key = "sta.esp.backpack.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        extraToolsSection.Container,
        "Backpack ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Backpack.Folder),
        State.BackpackItemSelected,
        function(value)
            State.BackpackItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one backpack to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.backpack.selected",
            },
        })

    SimpleUI:CreateToggle(extraToolsSection.Container, "Ability ESP", false, function(enabled)
        State.AbilityItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks ability tools so rare utility drops are easier to notice.",
        Save = {
            Key = "sta.esp.ability.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        extraToolsSection.Container,
        "Ability ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Ability.Folder),
        State.AbilityItemSelected,
        function(value)
            State.AbilityItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one ability tool to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.ability.selected",
            },
        })

    local armorThrowablesSection = SimpleUI:CreateSection(worldPage, "Armor & Throwables", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://16898613777",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(869, 0)
        }
    })

    SimpleUI:CreateToggle(armorThrowablesSection.Container, "Armor ESP", false, function(enabled)
        State.ArmorItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks armor drops so defensive upgrades are easier to grab.",
        Save = {
            Key = "sta.esp.armor.enabled",
        },
    })

    SimpleUI:CreateToggle(armorThrowablesSection.Container, "Throwable ESP", false, function(enabled)
        State.ThrowableItemESP = enabled
        EspModule.refreshItemHighlights()
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks throwable consumables for combat and utility planning.",
        Save = {
            Key = "sta.esp.throwable.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        armorThrowablesSection.Container,
        "Throwable ESP Selection",
        UtilityModule.getChildNames(ItemEspClasses.Throwables.Folder),
        State.ThrowableItemSelected,
        function(value)
            State.ThrowableItemSelected = value or SelectAllOption
            EspModule.refreshItemHighlights()
            EspModule.refreshBarrelHighlights()
        end, {
            Description = "Choose one throwable to highlight, or keep All for the whole category.",
            Save = {
                Key = "sta.esp.throwable.selected",
            },
        })

    SimpleUI:CreateSlider(
        armorThrowablesSection.Container,
        "Throwable ESP Radius Override",
        0,
        1500,
        State.ThrowableItemRadius,
        function(value)
            State.ThrowableItemRadius = value
            EspModule.refreshItemHighlights()
        end,
        { Increment = 25, Description =
        "Set above 0 to override the master ESP radius for this radar-supported category.",
            Save = {
                Key = "sta.esp.throwable.radius",
            },
        })

    local characterSection = SimpleUI:CreateSection(worldPage, "Zombies & Survivors", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://140171186759671",
            Size = UDim2.new(0, 16, 0, 16),
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        },
    })

    SimpleUI:CreateToggle(characterSection.Container, "Zombie ESP", false, function(enabled)
        State.ZombieESP = enabled
        EspModule.refreshCharacterHighlights()
    end, {
        Description = "Marks nearby hostile character models before they reach you.",
        Save = {
            Key = "sta.esp.zombie.enabled",
        },
    })

    SimpleUI:CreateDropdown(
        characterSection.Container,
        "Zombie Selection",
        UtilityModule.getChildNames(Characters),
        State.ZombieSelected,
        function(value)
            State.ZombieSelected = value or SelectAllOption
            EspModule.refreshCharacterHighlights()
        end, {
            Description = "Choose one zombie name to highlight, or keep All for every match.",
            Save = {
                Key = "sta.esp.zombie.selected",
            },
        })

    SimpleUI:CreateSlider(
        characterSection.Container,
        "Zombie Radius Override",
        0,
        1500,
        State.ZombieRadius,
        function(value)
        State.ZombieRadius = value
        EspModule.refreshCharacterHighlights()
    end, {
        Increment = 25,
        Description = "Set above 0 to override the master ESP radius for zombies.",
        Save = {
            Key = "sta.esp.zombie.radius",
        },
    })

    SimpleUI:CreateToggle(characterSection.Container, "Survivor ESP", false, function(enabled)
        State.SurvivorESP = enabled
        EspModule.refreshSurvivorHighlights()
    end, {
        Description = "Marks survivor NPCs so escort and rescue targets are easier to track.",
        Save = {
            Key = "sta.esp.survivor.enabled",
        },
    })

    SimpleUI:CreateSlider(
        characterSection.Container,
        "Survivor Radius Override",
        0,
        1500,
        State.SurvivorRadius,
        function(value)
        State.SurvivorRadius = value
        EspModule.refreshSurvivorHighlights()
    end, {
        Increment = 25,
        Description = "Set above 0 to override the master ESP radius for survivors.",
        Save = {
            Key = "sta.esp.survivor.radius",
        },
    })

    local structuresSection = SimpleUI:CreateSection(worldPage, "Objectives & Structures", {
        Style = "box",
        DefaultExpanded = false,
        Icon = {
            Image = "rbxassetid://16898613044",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(355, 967)
        }
    })

    SimpleUI:CreateToggle(structuresSection.Container, "Generator ESP", false, function(enabled)
        State.GeneratorESP = enabled
        EspModule.refreshGeneratorHighlights()
    end, {
        Description = "Marks the active generator and repair prompt area.",
        Save = {
            Key = "sta.esp.generator.enabled",
        },
    })

    SimpleUI:CreateToggle(structuresSection.Container, "Scrap Pile ESP", false, function(enabled)
        State.ScrapPileESP = enabled
        EspModule.refreshScrapPileHighlights()
    end, {
        Description = "Marks scrap piles so repair materials are easier to farm.",
        Save = {
            Key = "sta.esp.scrap_pile.enabled",
        },
    })

    SimpleUI:CreateToggle(structuresSection.Container, "Radio Tower ESP", false, function(enabled)
        State.RadioTowerESP = enabled
        EspModule.refreshRadioTowerHighlights()
    end, {
        Description = "Marks the radio tower objective and circuit box location.",
        Save = {
            Key = "sta.esp.radio_tower.enabled",
        },
    })

    SimpleUI:CreateToggle(structuresSection.Container, "Barrel ESP", false, function(enabled)
        State.BarrelESP = enabled
        EspModule.refreshBarrelHighlights()
    end, {
        Description = "Marks barrels, including barrels that can contain selected highlighted loot.",
        Save = {
            Key = "sta.esp.barrel.enabled",
        },
    })

    SimpleUI:CreateSlider(
        structuresSection.Container,
        "Barrel Radius Override",
        0,
        1500,
        State.BarrelRadius,
        function(value)
        State.BarrelRadius = value
        EspModule.refreshBarrelHighlights()
    end, {
        Increment = 25,
        Description = "Set above 0 to override the master ESP radius for barrels.",
        Save = {
            Key = "sta.esp.barrel.radius",
        },
    })

    SimpleUI:CreateToggle(structuresSection.Container, "Power Plant ESP", false, function(enabled)
        State.PowerPlantESP = enabled
        EspModule.refreshPowerPlantHighlights()
    end, {
        Description = "Marks power plant objectives and repair points.",
        Save = {
            Key = "sta.esp.power_plant.enabled",
        },
    })

    SimpleUI:CreateToggle(structuresSection.Container, "Crate ESP", false, function(enabled)
        State.CrateESP = enabled
        EspModule.refreshCrateHighlights()
    end, {
        Description = "Marks loot crates so unopened supply points stand out.",
        Save = {
            Key = "sta.esp.crate.enabled",
        },
    })

    SimpleUI:CreateSlider(
        structuresSection.Container,
        "Crate Radius Override",
        0,
        1500,
        State.CrateRadius,
        function(value)
        State.CrateRadius = value
        EspModule.refreshCrateHighlights()
    end, {
        Increment = 25,
        Description = "Set above 0 to override the master ESP radius for crates.",
        Save = {
            Key = "sta.esp.crate.radius",
        },
    })

end

-- ========================
-- MISCELLANEOUS TAB
-- ========================

local function initializeMiscellaneousTab()
    local page = Tabs.Miscellaneous.Page
    local interactionPage = page.Left
    local utilityPage = page.Right

    local interactionSection = SimpleUI:CreateSection(interactionPage, "Interaction", {
        Style = "box",
        DefaultExpanded = true,
        Icon = {
            Image = "rbxassetid://16898613613",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(771, 710),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        },
    })

    SimpleUI:CreateToggle(interactionSection.Container, "Instant Proximity Prompt", false, function(enabled)
        MiscModule.setInstantProximityPrompt(enabled)
    end, {
        Description = "Makes hold prompts complete immediately while enabled.",
        Save = {
            Key = "sta.misc.instant_proximity_prompt",
        },
    })

    local environmentSection = SimpleUI:CreateSection(utilityPage, "Environment", {
        Style = "box",
        DefaultExpanded = true,
        Icon = {
            Image = "rbxassetid://16898613044",
            Size = UDim2.new(0, 16, 0, 16),
            ImageRectSize = Vector2.new(48, 48),
            ImageRectOffset = Vector2.new(514, 918),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
        },
    })

    SimpleUI:CreateSlider(
        environmentSection.Container,
        "Fog Distance",
        0,
        100000,
        State.EnvironmentFogEnd,
        MiscModule.setFogDistance,
        {
            Increment = 500,
            Description = "Controls how far local fog reaches before the world fades out.",
            Save = {
                Key = "sta.misc.environment.fog_distance",
            },
        }
    )

    SimpleUI:CreateSlider(
        environmentSection.Container,
        "Atmosphere Density",
        0,
        1,
        State.EnvironmentAtmosphereDensity,
        MiscModule.setAtmosphereDensity,
        {
            Increment = 0.01,
            Description = "Adjusts haze thickness for clearer or heavier weather.",
            Save = {
                Key = "sta.misc.environment.atmosphere_density",
            },
        }
    )

    SimpleUI:CreateSlider(
        environmentSection.Container,
        "Time of Day",
        0,
        24,
        State.EnvironmentClockTime,
        MiscModule.setClockTime,
        {
            Increment = 0.25,
            Description = "Changes local lighting time without touching game progress.",
            Save = {
                Key = "sta.misc.environment.time_of_day",
            },
        }
    )

    SimpleUI:CreateSlider(
        environmentSection.Container,
        "Brightness",
        0,
        5,
        State.EnvironmentBrightness,
        MiscModule.setBrightness,
        {
            Increment = 0.1,
            Description = "Adjusts scene brightness for dark interiors and night areas.",
            Save = {
                Key = "sta.misc.environment.brightness",
            },
        }
    )

    SimpleUI:CreateToggle(environmentSection.Container, "Global Shadows", State.EnvironmentGlobalShadows, function(enabled)
        MiscModule.setGlobalShadows(enabled)
    end, {
        Description = "Toggles local world shadows for cleaner visibility.",
        Save = {
            Key = "sta.misc.environment.global_shadows",
        },
    })

    SimpleUI:CreateButton(environmentSection.Container, "Reset Local Environment", MiscModule.resetEnvironment, {
        Description = "Restores the lighting values from when the script started.",
    })

end

-- ========================
-- SETTINGS TAB
-- ========================

local function initializeSettingsTab()
    local page = Tabs.Settings.Page

    SimpleUI:CreateSection(page, "Interface Customization")

    SimpleUI:CreateSlider(page, "Interface Scale", 0.5, 2, window.GetScale(), function(value)
        window:SetScale(value, true)
    end, {
        Increment = 0.001,
        Save = {
            Key = "sta.settings.interface_scale",
        },
    })

    local themes = {}
    for name in pairs(SimpleUI.Themes) do
        themes[#themes + 1] = name
    end

    SimpleUI:CreateDropdown(page, "Select Color Theme", themes, nil, function(val)
        window:SetTheme(val, true)
    end, {
        Description = "Choose from " .. (#themes > 0 and #themes or "a variety of") .. " available themes.",
        Save = {
            Key = "sta.settings.theme",
        },
    })

    if not SimpleUI.Utility:IsMobile() then
        SimpleUI:CreateKeybind(page, "Toggle Interface Visibility", Enum.KeyCode.Q, function(key)
            window.Toggle()
        end, {
            Save = {
                Key = "sta.settings.toggle_keybind",
            },
        })
    end
end

-- ========================
-- RUNTIME
-- ========================

LoopFramework:registerTask("ESP Refresh", 1, EspModule.refreshAll, 1)

LoopFramework:registerTask("Nearby Pickup", 0.25, function()
    if not (State.AutoPickupAmmo or State.AutoPickupFood) then
        return
    end

    MainModule.processAutomaticPickups()
end, 2)

LoopFramework:registerTask("Automatic TP", 0.1, MainModule.processAutomaticTeleports, 3)
LoopFramework:registerTask("Auto Melee", 0.08, MainModule.processAutoMelee, 4)
LoopFramework:start(0.05)

initializeMainTab()
initializeItemsTab()
initializeEspTab()
initializeMiscellaneousTab()
initializeSettingsTab()

if SimpleUI.Utility:IsMobile() and MobileUIModule and MobileUIModule.createToggleButton then
    MobileUIModule.createToggleButton(window)
end