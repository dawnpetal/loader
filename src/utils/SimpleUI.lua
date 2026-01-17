local SimpleUI = {}

SimpleUI.Services = {}

SimpleUI.Themes = {
    Obsidian = {
        PrimaryColor = Color3.fromRGB(8, 8, 10),
        SecondaryColor = Color3.fromRGB(18, 18, 22),
        SecondaryColorHover = Color3.fromRGB(28, 28, 34),
        SecondaryColorActive = Color3.fromRGB(38, 38, 46),
        SecondaryColorMouse1Down = Color3.fromRGB(12, 12, 16),
        TertiaryColor = Color3.fromRGB(24, 24, 30),
        TertiaryColorHover = Color3.fromRGB(34, 34, 42),
        TertiaryColorActive = Color3.fromRGB(44, 44, 54),
        TertiaryColorMouse1Down = Color3.fromRGB(16, 16, 20),
        TextInactive = Color3.fromRGB(160, 160, 165),
        TextActive = Color3.fromRGB(245, 245, 250),
        TextPrimary = Color3.fromRGB(225, 225, 230),
        TextSecondary = Color3.fromRGB(140, 140, 145),
        AccentColor = Color3.fromRGB(138, 180, 248),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.01,
        SecondaryTransparency = 0.45
    },

    MidnightPurple = {
        PrimaryColor = Color3.fromRGB(18, 15, 25),
        SecondaryColor = Color3.fromRGB(28, 24, 38),
        SecondaryColorHover = Color3.fromRGB(38, 32, 50),
        SecondaryColorActive = Color3.fromRGB(50, 42, 65),
        SecondaryColorMouse1Down = Color3.fromRGB(22, 18, 30),
        TertiaryColor = Color3.fromRGB(35, 30, 46),
        TertiaryColorHover = Color3.fromRGB(46, 39, 60),
        TertiaryColorActive = Color3.fromRGB(60, 51, 78),
        TertiaryColorMouse1Down = Color3.fromRGB(26, 22, 34),
        TextInactive = Color3.fromRGB(165, 155, 180),
        TextActive = Color3.fromRGB(240, 235, 255),
        TextPrimary = Color3.fromRGB(220, 212, 238),
        TextSecondary = Color3.fromRGB(140, 130, 160),
        AccentColor = Color3.fromRGB(180, 140, 255),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.02,
        SecondaryTransparency = 0.50
    },

    DeepRose = {
        PrimaryColor = Color3.fromRGB(22, 15, 18),
        SecondaryColor = Color3.fromRGB(35, 26, 30),
        SecondaryColorHover = Color3.fromRGB(48, 36, 42),
        SecondaryColorActive = Color3.fromRGB(62, 48, 55),
        SecondaryColorMouse1Down = Color3.fromRGB(28, 20, 24),
        TertiaryColor = Color3.fromRGB(42, 32, 38),
        TertiaryColorHover = Color3.fromRGB(56, 44, 50),
        TertiaryColorActive = Color3.fromRGB(72, 58, 65),
        TertiaryColorMouse1Down = Color3.fromRGB(32, 24, 28),
        TextInactive = Color3.fromRGB(180, 160, 170),
        TextActive = Color3.fromRGB(255, 240, 248),
        TextPrimary = Color3.fromRGB(235, 220, 228),
        TextSecondary = Color3.fromRGB(155, 135, 145),
        AccentColor = Color3.fromRGB(255, 150, 200),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.02,
        SecondaryTransparency = 0.52
    },

    OceanDepth = {
        PrimaryColor = Color3.fromRGB(12, 18, 24),
        SecondaryColor = Color3.fromRGB(20, 30, 42),
        SecondaryColorHover = Color3.fromRGB(28, 42, 58),
        SecondaryColorActive = Color3.fromRGB(38, 56, 76),
        SecondaryColorMouse1Down = Color3.fromRGB(16, 24, 34),
        TertiaryColor = Color3.fromRGB(25, 38, 52),
        TertiaryColorHover = Color3.fromRGB(35, 52, 70),
        TertiaryColorActive = Color3.fromRGB(47, 68, 90),
        TertiaryColorMouse1Down = Color3.fromRGB(18, 28, 40),
        TextInactive = Color3.fromRGB(160, 175, 195),
        TextActive = Color3.fromRGB(240, 248, 255),
        TextPrimary = Color3.fromRGB(220, 235, 250),
        TextSecondary = Color3.fromRGB(135, 155, 175),
        AccentColor = Color3.fromRGB(110, 200, 255),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.02,
        SecondaryTransparency = 0.50
    },

    ForestNight = {
        PrimaryColor = Color3.fromRGB(15, 20, 17),
        SecondaryColor = Color3.fromRGB(24, 32, 28),
        SecondaryColorHover = Color3.fromRGB(34, 45, 38),
        SecondaryColorActive = Color3.fromRGB(46, 60, 51),
        SecondaryColorMouse1Down = Color3.fromRGB(18, 24, 21),
        TertiaryColor = Color3.fromRGB(30, 40, 34),
        TertiaryColorHover = Color3.fromRGB(42, 55, 47),
        TertiaryColorActive = Color3.fromRGB(56, 72, 62),
        TertiaryColorMouse1Down = Color3.fromRGB(22, 28, 25),
        TextInactive = Color3.fromRGB(165, 180, 172),
        TextActive = Color3.fromRGB(245, 255, 250),
        TextPrimary = Color3.fromRGB(225, 240, 232),
        TextSecondary = Color3.fromRGB(140, 160, 148),
        AccentColor = Color3.fromRGB(120, 220, 170),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.02,
        SecondaryTransparency = 0.50
    },

    VelvetRed = {
        PrimaryColor = Color3.fromRGB(24, 12, 14),
        SecondaryColor = Color3.fromRGB(38, 20, 24),
        SecondaryColorHover = Color3.fromRGB(52, 28, 34),
        SecondaryColorActive = Color3.fromRGB(68, 38, 46),
        SecondaryColorMouse1Down = Color3.fromRGB(30, 16, 20),
        TertiaryColor = Color3.fromRGB(46, 26, 32),
        TertiaryColorHover = Color3.fromRGB(62, 36, 44),
        TertiaryColorActive = Color3.fromRGB(80, 48, 58),
        TertiaryColorMouse1Down = Color3.fromRGB(34, 20, 26),
        TextInactive = Color3.fromRGB(185, 160, 168),
        TextActive = Color3.fromRGB(255, 240, 245),
        TextPrimary = Color3.fromRGB(238, 220, 228),
        TextSecondary = Color3.fromRGB(160, 135, 145),
        AccentColor = Color3.fromRGB(255, 110, 145),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.02,
        SecondaryTransparency = 0.52
    },

    Slate = {
        PrimaryColor = Color3.fromRGB(22, 24, 28),
        SecondaryColor = Color3.fromRGB(34, 37, 42),
        SecondaryColorHover = Color3.fromRGB(46, 50, 56),
        SecondaryColorActive = Color3.fromRGB(60, 65, 72),
        SecondaryColorMouse1Down = Color3.fromRGB(28, 30, 34),
        TertiaryColor = Color3.fromRGB(42, 46, 52),
        TertiaryColorHover = Color3.fromRGB(56, 61, 68),
        TertiaryColorActive = Color3.fromRGB(72, 78, 86),
        TertiaryColorMouse1Down = Color3.fromRGB(32, 34, 38),
        TextInactive = Color3.fromRGB(160, 165, 172),
        TextActive = Color3.fromRGB(245, 248, 252),
        TextPrimary = Color3.fromRGB(225, 230, 236),
        TextSecondary = Color3.fromRGB(135, 142, 150),
        AccentColor = Color3.fromRGB(130, 180, 245),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.02,
        SecondaryTransparency = 0.48
    },

    WarmCocoa = {
        PrimaryColor = Color3.fromRGB(26, 22, 18),
        SecondaryColor = Color3.fromRGB(40, 34, 28),
        SecondaryColorHover = Color3.fromRGB(54, 46, 38),
        SecondaryColorActive = Color3.fromRGB(70, 60, 50),
        SecondaryColorMouse1Down = Color3.fromRGB(32, 26, 22),
        TertiaryColor = Color3.fromRGB(48, 42, 34),
        TertiaryColorHover = Color3.fromRGB(64, 56, 46),
        TertiaryColorActive = Color3.fromRGB(82, 72, 60),
        TertiaryColorMouse1Down = Color3.fromRGB(36, 30, 24),
        TextInactive = Color3.fromRGB(180, 165, 150),
        TextActive = Color3.fromRGB(255, 248, 240),
        TextPrimary = Color3.fromRGB(235, 225, 212),
        TextSecondary = Color3.fromRGB(155, 140, 125),
        AccentColor = Color3.fromRGB(225, 165, 115),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.02,
        SecondaryTransparency = 0.52
    },

    SakuraDream = {
        PrimaryColor = Color3.fromRGB(215, 200, 205),
        SecondaryColor = Color3.fromRGB(200, 185, 190),
        SecondaryColorHover = Color3.fromRGB(190, 175, 180),
        SecondaryColorActive = Color3.fromRGB(178, 163, 168),
        SecondaryColorMouse1Down = Color3.fromRGB(168, 153, 158),
        TertiaryColor = Color3.fromRGB(185, 170, 175),
        TertiaryColorHover = Color3.fromRGB(173, 158, 163),
        TertiaryColorActive = Color3.fromRGB(160, 145, 150),
        TertiaryColorMouse1Down = Color3.fromRGB(150, 135, 140),
        TextInactive = Color3.fromRGB(95, 80, 85),
        TextActive = Color3.fromRGB(50, 35, 40),
        TextPrimary = Color3.fromRGB(65, 50, 55),
        TextSecondary = Color3.fromRGB(110, 95, 100),
        AccentColor = Color3.fromRGB(235, 130, 170),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0,
        SecondaryTransparency = 0.15
    },

    LavenderMist = {
        PrimaryColor = Color3.fromRGB(210, 205, 220),
        SecondaryColor = Color3.fromRGB(195, 190, 205),
        SecondaryColorHover = Color3.fromRGB(185, 180, 195),
        SecondaryColorActive = Color3.fromRGB(173, 168, 183),
        SecondaryColorMouse1Down = Color3.fromRGB(163, 158, 173),
        TertiaryColor = Color3.fromRGB(180, 175, 190),
        TertiaryColorHover = Color3.fromRGB(168, 163, 178),
        TertiaryColorActive = Color3.fromRGB(155, 150, 165),
        TertiaryColorMouse1Down = Color3.fromRGB(145, 140, 155),
        TextInactive = Color3.fromRGB(85, 80, 95),
        TextActive = Color3.fromRGB(40, 35, 50),
        TextPrimary = Color3.fromRGB(55, 50, 65),
        TextSecondary = Color3.fromRGB(100, 95, 110),
        AccentColor = Color3.fromRGB(155, 120, 210),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0,
        SecondaryTransparency = 0.12
    },

    MintCream = {
        PrimaryColor = Color3.fromRGB(205, 218, 215),
        SecondaryColor = Color3.fromRGB(190, 203, 200),
        SecondaryColorHover = Color3.fromRGB(180, 193, 190),
        SecondaryColorActive = Color3.fromRGB(168, 181, 178),
        SecondaryColorMouse1Down = Color3.fromRGB(158, 171, 168),
        TertiaryColor = Color3.fromRGB(175, 188, 185),
        TertiaryColorHover = Color3.fromRGB(163, 176, 173),
        TertiaryColorActive = Color3.fromRGB(150, 163, 160),
        TertiaryColorMouse1Down = Color3.fromRGB(140, 153, 150),
        TextInactive = Color3.fromRGB(75, 90, 85),
        TextActive = Color3.fromRGB(30, 45, 40),
        TextPrimary = Color3.fromRGB(45, 60, 55),
        TextSecondary = Color3.fromRGB(95, 110, 105),
        AccentColor = Color3.fromRGB(90, 180, 150),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0,
        SecondaryTransparency = 0.14
    },

    PeachSorbet = {
        PrimaryColor = Color3.fromRGB(220, 205, 200),
        SecondaryColor = Color3.fromRGB(205, 190, 185),
        SecondaryColorHover = Color3.fromRGB(195, 180, 175),
        SecondaryColorActive = Color3.fromRGB(183, 168, 163),
        SecondaryColorMouse1Down = Color3.fromRGB(173, 158, 153),
        TertiaryColor = Color3.fromRGB(190, 175, 170),
        TertiaryColorHover = Color3.fromRGB(178, 163, 158),
        TertiaryColorActive = Color3.fromRGB(165, 150, 145),
        TertiaryColorMouse1Down = Color3.fromRGB(155, 140, 135),
        TextInactive = Color3.fromRGB(90, 75, 70),
        TextActive = Color3.fromRGB(45, 30, 25),
        TextPrimary = Color3.fromRGB(60, 45, 40),
        TextSecondary = Color3.fromRGB(105, 90, 85),
        AccentColor = Color3.fromRGB(235, 145, 120),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0,
        SecondaryTransparency = 0.13
    },

    SkyBloom = {
        PrimaryColor = Color3.fromRGB(205, 215, 225),
        SecondaryColor = Color3.fromRGB(190, 200, 210),
        SecondaryColorHover = Color3.fromRGB(180, 190, 200),
        SecondaryColorActive = Color3.fromRGB(168, 178, 188),
        SecondaryColorMouse1Down = Color3.fromRGB(158, 168, 178),
        TertiaryColor = Color3.fromRGB(175, 185, 195),
        TertiaryColorHover = Color3.fromRGB(163, 173, 183),
        TertiaryColorActive = Color3.fromRGB(150, 160, 170),
        TertiaryColorMouse1Down = Color3.fromRGB(140, 150, 160),
        TextInactive = Color3.fromRGB(75, 85, 95),
        TextActive = Color3.fromRGB(30, 40, 50),
        TextPrimary = Color3.fromRGB(45, 55, 65),
        TextSecondary = Color3.fromRGB(95, 105, 115),
        AccentColor = Color3.fromRGB(115, 165, 220),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0,
        SecondaryTransparency = 0.12
    },

    AmberGlow = {
        PrimaryColor = Color3.fromRGB(24, 18, 10),
        SecondaryColor = Color3.fromRGB(38, 30, 18),
        SecondaryColorHover = Color3.fromRGB(52, 42, 26),
        SecondaryColorActive = Color3.fromRGB(68, 56, 36),
        SecondaryColorMouse1Down = Color3.fromRGB(30, 22, 14),
        TertiaryColor = Color3.fromRGB(46, 38, 22),
        TertiaryColorHover = Color3.fromRGB(62, 52, 32),
        TertiaryColorActive = Color3.fromRGB(80, 68, 44),
        TertiaryColorMouse1Down = Color3.fromRGB(34, 26, 16),
        TextInactive = Color3.fromRGB(185, 170, 145),
        TextActive = Color3.fromRGB(255, 248, 235),
        TextPrimary = Color3.fromRGB(238, 228, 210),
        TextSecondary = Color3.fromRGB(160, 145, 120),
        AccentColor = Color3.fromRGB(255, 190, 100),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.02,
        SecondaryTransparency = 0.52
    },

    EmeraldNight = {
        PrimaryColor = Color3.fromRGB(10, 18, 14),
        SecondaryColor = Color3.fromRGB(18, 30, 24),
        SecondaryColorHover = Color3.fromRGB(26, 42, 34),
        SecondaryColorActive = Color3.fromRGB(36, 56, 46),
        SecondaryColorMouse1Down = Color3.fromRGB(14, 22, 18),
        TertiaryColor = Color3.fromRGB(22, 36, 28),
        TertiaryColorHover = Color3.fromRGB(32, 50, 40),
        TertiaryColorActive = Color3.fromRGB(44, 66, 54),
        TertiaryColorMouse1Down = Color3.fromRGB(16, 26, 20),
        TextInactive = Color3.fromRGB(165, 190, 175),
        TextActive = Color3.fromRGB(245, 255, 248),
        TextPrimary = Color3.fromRGB(225, 245, 235),
        TextSecondary = Color3.fromRGB(140, 165, 150),
        AccentColor = Color3.fromRGB(110, 245, 180),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.02,
        SecondaryTransparency = 0.52
    },

    RubyDepth = {
        PrimaryColor = Color3.fromRGB(20, 10, 12),
        SecondaryColor = Color3.fromRGB(34, 18, 22),
        SecondaryColorHover = Color3.fromRGB(48, 26, 32),
        SecondaryColorActive = Color3.fromRGB(64, 36, 44),
        SecondaryColorMouse1Down = Color3.fromRGB(26, 14, 18),
        TertiaryColor = Color3.fromRGB(42, 22, 28),
        TertiaryColorHover = Color3.fromRGB(58, 32, 40),
        TertiaryColorActive = Color3.fromRGB(76, 44, 54),
        TertiaryColorMouse1Down = Color3.fromRGB(30, 16, 22),
        TextInactive = Color3.fromRGB(190, 160, 170),
        TextActive = Color3.fromRGB(255, 245, 248),
        TextPrimary = Color3.fromRGB(245, 230, 235),
        TextSecondary = Color3.fromRGB(165, 135, 145),
        AccentColor = Color3.fromRGB(255, 95, 135),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.02,
        SecondaryTransparency = 0.52
    },

    TwilightIndigo = {
        PrimaryColor = Color3.fromRGB(16, 18, 28),
        SecondaryColor = Color3.fromRGB(26, 30, 45),
        SecondaryColorHover = Color3.fromRGB(36, 42, 60),
        SecondaryColorActive = Color3.fromRGB(48, 56, 78),
        SecondaryColorMouse1Down = Color3.fromRGB(20, 22, 34),
        TertiaryColor = Color3.fromRGB(32, 38, 54),
        TertiaryColorHover = Color3.fromRGB(44, 52, 72),
        TertiaryColorActive = Color3.fromRGB(58, 68, 92),
        TertiaryColorMouse1Down = Color3.fromRGB(24, 28, 40),
        TextInactive = Color3.fromRGB(165, 170, 190),
        TextActive = Color3.fromRGB(245, 248, 255),
        TextPrimary = Color3.fromRGB(225, 230, 248),
        TextSecondary = Color3.fromRGB(140, 145, 165),
        AccentColor = Color3.fromRGB(145, 165, 255),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.02,
        SecondaryTransparency = 0.50
    },

    ElectricTeal = {
        PrimaryColor = Color3.fromRGB(10, 18, 20),
        SecondaryColor = Color3.fromRGB(18, 30, 34),
        SecondaryColorHover = Color3.fromRGB(26, 42, 48),
        SecondaryColorActive = Color3.fromRGB(36, 56, 64),
        SecondaryColorMouse1Down = Color3.fromRGB(14, 22, 26),
        TertiaryColor = Color3.fromRGB(22, 36, 42),
        TertiaryColorHover = Color3.fromRGB(32, 50, 58),
        TertiaryColorActive = Color3.fromRGB(44, 66, 76),
        TertiaryColorMouse1Down = Color3.fromRGB(16, 26, 30),
        TextInactive = Color3.fromRGB(160, 185, 190),
        TextActive = Color3.fromRGB(240, 255, 252),
        TextPrimary = Color3.fromRGB(220, 242, 245),
        TextSecondary = Color3.fromRGB(135, 160, 165),
        AccentColor = Color3.fromRGB(100, 230, 210),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.02,
        SecondaryTransparency = 0.52
    },

    NeonViolet = {
        PrimaryColor = Color3.fromRGB(20, 12, 24),
        SecondaryColor = Color3.fromRGB(34, 22, 40),
        SecondaryColorHover = Color3.fromRGB(48, 32, 56),
        SecondaryColorActive = Color3.fromRGB(64, 44, 74),
        SecondaryColorMouse1Down = Color3.fromRGB(26, 16, 30),
        TertiaryColor = Color3.fromRGB(42, 28, 50),
        TertiaryColorHover = Color3.fromRGB(58, 40, 68),
        TertiaryColorActive = Color3.fromRGB(76, 54, 88),
        TertiaryColorMouse1Down = Color3.fromRGB(30, 20, 36),
        TextInactive = Color3.fromRGB(185, 165, 195),
        TextActive = Color3.fromRGB(255, 245, 255),
        TextPrimary = Color3.fromRGB(240, 228, 250),
        TextSecondary = Color3.fromRGB(160, 140, 170),
        AccentColor = Color3.fromRGB(200, 120, 255),
        PrimaryFont = Enum.Font.GothamBold,
        PrimaryFontSize = 18,
        SecondaryFont = Enum.Font.GothamMedium,
        SecondaryFontSize = 16,
        PrimaryTransparency = 0.02,
        SecondaryTransparency = 0.52
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
        local service = game:GetService(name)
        if cloneref then
            local success, cloned = pcall(cloneref, service)
            if success and cloned then
                service = cloned
            end
        end
        self.Services[name] = service
    end
    return self.Services[name]
end

function SimpleUI:_getSafeContainer()
    local function thing(bruh)
        local ok, dead = pcall(bruh)
        if ok and dead then
            local fr = Instance.new("Frame")
            return pcall(function()
                fr.Parent = dead
                fr:Destroy()
            end) and dead or nil
        end
    end

    if typeof(gethui) == "function" and thing(gethui) then
        return thing(gethui)
    end

    local based = set_thread_identity or setthreadidentity or setidentity
    if based then
        pcall(based, 8)
    end

    local core = game:GetService("CoreGui")
    for _, method in ipairs({function()
        return cloneref and cloneref(core)
    end, function()
        return core
    end, function()
        local kore
        task.defer(function()
            kore = core
        end)
        return kore
    end}) do
        if thing(method) then
            return thing(method)
        end
    end

    warn("CoreGui restricted, using player gui (detectable) your executor isn't sigma")
    return game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

function SimpleUI:_generateIdentifier(prefix)
    local chars = "ACEGIKMOQSUWYZbdfhjlnprtvxz!@#$%^&*()_+-=[];',.123456789"
    local result = prefix or ""
    local seed = tick() * math.random(1, 1000000)
    math.randomseed(seed)
    for i = 1, math.random(16, 24) do
        local rand = math.random(1, #chars)
        result = result .. chars:sub(rand, rand)
    end
    return result
end

function SimpleUI:_lockMetatable(tbl)
    if not setreadonly or not getrawmetatable then
        return tbl
    end

    local mt = getrawmetatable(tbl) or {}

    mt.__metatable = "The metatable is locked"

    local originalIndex = mt.__index
    mt.__index = function(t, k)
        if checkcaller and not checkcaller() then
            return nil
        end

        if type(originalIndex) == "function" then
            return originalIndex(t, k)
        else
            return originalIndex[k]
        end
    end

    setrawmetatable(tbl, mt)
    if setreadonly then
        setreadonly(mt, true)
    end

    return tbl
end

function SimpleUI:_wrapRemoteCall(remote, ...)
    if not remote then
        return
    end

    local args = {...}

    if newcclosure then
        local wrapped = newcclosure(function()
            return remote:FireServer(unpack(args))
        end)
        return wrapped()
    else
        return remote:FireServer(unpack(args))
    end
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

function SimpleUI:initializeThemeRegistry(window)
    window._themeRegistry = {
        elements = {},
        currentTheme = window.Theme or self.Themes.Obsidian
    }
end

function SimpleUI:getCurrentTheme(window)
    if window and window._themeRegistry then
        return window._themeRegistry.currentTheme
    end
    return self.Themes.Obsidian
end

function SimpleUI:registerThemeElement(window, element, bindings)
    if not window or not window._themeRegistry then
        return
    end

    if not element or not bindings then
        return
    end

    for property, themeKey in pairs(bindings) do
        table.insert(window._themeRegistry.elements, {
            element = element,
            property = property,
            themeKey = themeKey
        })
    end
end

function SimpleUI:registerMultipleThemeElements(window, elements)
    if not window then
        return
    end
    for element, bindings in pairs(elements) do
        self:registerThemeElement(window, element, bindings)
    end
end

function SimpleUI:applyThemeToElement(element, property, themeKey, theme, animate)
    if not element or not element.Parent then
        return
    end

    if type(themeKey) == "function" then
        return
    end

    local value = theme[themeKey]
    if value == nil then
        return
    end

    if animate and (property:find("Color") or property:find("Transparency")) then
        local tweenService = self:getService("TweenService")
        tweenService:Create(element, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            [property] = value
        }):Play()
    else
        element[property] = value
    end
end

function SimpleUI:setWindowTheme(window, themeName, animate)
    if not window or not window._themeRegistry then
        return
    end

    local newTheme = self.Themes[themeName]
    if not newTheme then
        return
    end

    window._themeRegistry.currentTheme = newTheme
    window.Theme = newTheme

    local seen = {}
    local validElements = {}

    for _, entry in ipairs(window._themeRegistry.elements) do
        local el = entry.element
        local prop = entry.property

        if el and el.Parent then
            seen[el] = seen[el] or {}

            if not seen[el][prop] then
                seen[el][prop] = true

                if type(entry.themeKey) == "function" then
                    entry.themeKey(el, newTheme)
                else
                    self:applyThemeToElement(el, prop, entry.themeKey, newTheme, animate)
                end

                table.insert(validElements, entry)
            end
        end
    end

    window._themeRegistry.elements = validElements
end

function SimpleUI:getWindowTheme(window)
    if not window or not window._themeRegistry then
        return "Secondary"
    end

    for name, theme in pairs(self.Themes) do
        if theme == window._themeRegistry.currentTheme then
            return name
        end
    end

    return "Secondary"
end

function SimpleUI:getWindowFromElement(element)
    local current = element
    while current do
        if current:IsA("ScreenGui") then
            return self.Windows and self.Windows[current]
        end
        current = current.Parent
    end
    return nil
end

function SimpleUI:applyTheme(properties, themeMap, theme)
    local result = {}
    local bindings = {}

    for k, v in pairs(properties) do
        result[k] = v
    end

    if themeMap then
        for propName, themeKey in pairs(themeMap) do
            if theme[themeKey] then
                result[propName] = theme[themeKey]
                bindings[propName] = themeKey
            end
        end
    end

    return result, bindings
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

    local totalHeight = layout.AbsoluteContentSize.Y
    local availableHeight = container.AbsoluteSize.Y
    local needsScrolling = totalHeight > availableHeight
    local isScrollFrame = container:IsA("ScrollingFrame")

    if needsScrolling and not isScrollFrame then
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
            ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200),
            ScrollBarImageTransparency = 1,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(0, 0, 0, 0),
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

    elseif not needsScrolling and isScrollFrame then
        container.ScrollBarThickness = 0
    elseif needsScrolling and isScrollFrame then
        container.ScrollBarImageTransparency = 1
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
            local TweenService = self:getService("TweenService")
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
            local TweenService = self:getService("TweenService")
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
    local theme = options.Theme or self.Themes.Obsidian

    local gui = self:createElement("ScreenGui", {
        Name = options.Name or self:_generateIdentifier(),
        ResetOnSpawn = false,
        DisplayOrder = 1
    }, self:_getSafeContainer())

    local frameData = self:merge(self.DefaultElements.MainFrame, options.MainFrame)
    local frame = self:createElement(frameData.Class, frameData.Properties, gui)
    frame.ClipsDescendants = false

    local uiScale = Instance.new("UIScale")
    uiScale.Name = "WindowScale"
    uiScale.Scale = math.clamp(options.defaultScale or 1, 0.5, 2)
    uiScale.Parent = frame

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

    local titleProps, titleBindings = self:applyTheme(titleLabelData.Properties, titleLabelData.Theme, theme)
    local titleLabel = self:createElement(titleLabelData.Class, titleProps, titleContainer)

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
        _uiScale = uiScale,
        getScale = function()
            return uiScale.Scale
        end,
        setScale = function(value, tween)
            value = math.clamp(tonumber(value) or 1, 0.100, 3)

            if tween then
                local ts = self:getService("TweenService")
                local info = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                ts:Create(uiScale, info, {
                    Scale = value
                }):Play()
            else
                uiScale.Scale = value
            end
        end,
        setTheme = function(self, themeName, animate)
            SimpleUI:setWindowTheme(self, themeName, animate ~= false)
        end,
        getTheme = function(self)
            return SimpleUI:getWindowTheme(self)
        end,
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

    SimpleUI:initializeThemeRegistry(windowInstance)

    if titleBindings then
        self:registerThemeElement(windowInstance, titleLabel, titleBindings)
    end

    local topBarProps, topBarBindings = self:applyTheme(topBarData.Properties, topBarData.Theme, theme)
    if topBarBindings then
        self:registerThemeElement(windowInstance, topBar, topBarBindings)
    end

    local mainContainerProps, mainContainerBindings = self:applyTheme(mainContainerData.Properties,
        mainContainerData.Theme, theme)
    if mainContainerBindings then
        self:registerThemeElement(windowInstance, mainContainer, mainContainerBindings)
    end

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
    local tabProps, tabBindings = self:applyTheme(tabData.Properties, tabData.Theme, theme)
    local tab = self:createElement(tabData.Class, tabProps, window.Elements.TabsContainer)

    if tabBindings then
        self:registerThemeElement(window, tab, tabBindings)
    end
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
        local currentTheme = SimpleUI:getCurrentTheme(window)
        if isActive then
            tab.BackgroundColor3 = currentTheme.SecondaryColorActive
            tab.TextColor3 = currentTheme.TextActive
        elseif isPressed then
            tab.BackgroundColor3 = currentTheme.SecondaryColorMouse1Down
            tab.TextColor3 = currentTheme.TextInactive
        elseif isHovering then
            tab.BackgroundColor3 = currentTheme.SecondaryColorHover
            tab.TextColor3 = currentTheme.TextInactive
        else
            tab.BackgroundColor3 = currentTheme.SecondaryColor
            tab.TextColor3 = currentTheme.TextInactive
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

function SimpleUI:createComponentContainer(config, theme)
    local container = self:createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = theme[config.colorTier or "SecondaryColor"],
        BackgroundTransparency = theme.SecondaryTransparency,
        BorderSizePixel = 0,
        ZIndex = 4
    }, config.parent)

    if config.minHeight then
        local constraint = Instance.new("UISizeConstraint")
        constraint.MinSize = Vector2.new(0, config.minHeight)
        constraint.Parent = container
    end

    if config.corner then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, config.corner)
        corner.Parent = container
    end

    local padding = config.padding or {}
    if type(padding) == "number" then
        padding = {
            top = padding,
            bottom = padding,
            left = padding,
            right = padding
        }
    end

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingTop = UDim.new(0, padding.top or 8)
    uiPadding.PaddingBottom = UDim.new(0, padding.bottom or 8)
    uiPadding.PaddingLeft = UDim.new(0, padding.left or 10)
    uiPadding.PaddingRight = UDim.new(0, padding.right or 0)
    uiPadding.Parent = container

    local textZone, interactiveZone, layout

    if config.layout == "textLeft" then
        textZone = self:createElement("Frame", {
            Size = UDim2.new(config.textWidth or 0.65, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            ZIndex = 5
        }, container)

        layout = Instance.new("UIListLayout")
        layout.FillDirection = Enum.FillDirection.Vertical
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        layout.VerticalAlignment = config.hasDescription and Enum.VerticalAlignment.Top or Enum.VerticalAlignment.Center
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 5)
        layout.Parent = textZone

        interactiveZone = container

    elseif config.layout == "stacked" then
        local contentFrame = self:createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            ZIndex = 5
        }, container)

        layout = Instance.new("UIListLayout")
        layout.FillDirection = Enum.FillDirection.Vertical
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        layout.VerticalAlignment = Enum.VerticalAlignment.Top
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, config.spacing or 4)
        layout.Parent = contentFrame

        if not config.hasDescription then
            contentFrame.Position = UDim2.new(0, 0, 0.5, 0)
            contentFrame.AnchorPoint = Vector2.new(0, 0.5)
        end

        textZone = contentFrame
        interactiveZone = contentFrame

    else
        textZone = container
        interactiveZone = container
    end

    return {
        container = container,
        textZone = textZone,
        interactiveZone = interactiveZone,
        layout = layout
    }
end

function SimpleUI:createLabel(parent, text, theme, config)
    config = config or {}
    return self:createElement("TextLabel", {
        Size = UDim2.new(1, config.widthOffset or 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text or "",
        TextColor3 = theme[config.colorTier or "TextPrimary"],
        TextSize = config.size or 14,
        Font = theme[config.font or "SecondaryFont"],
        TextXAlignment = config.align or Enum.TextXAlignment.Left,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = config.order or 1,
        ZIndex = 5
    }, parent)
end

function SimpleUI:createDescription(parent, text, theme, order)
    if not text or text == "" then
        return nil
    end
    return self:createLabel(parent, text, theme, {
        colorTier = "TextSecondary",
        size = 14,
        order = order or 2
    })
end

function SimpleUI:createSection(page, text, options)
    if not page then
        return
    end
    options = options or {}
    local theme = self:getTheme(page)
    local window = self:getWindowFromElement(page)
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

    local themeRegistry = {
        [label] = {
            TextColor3 = "TextActive",
            Font = "PrimaryFont"
        },
        [underline] = {
            BackgroundColor3 = "AccentColor"
        }
    }

    self:registerMultipleThemeElements(window, themeRegistry)

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
    local mobile = self:isMobile()
    local window = self:getWindowFromElement(page)

    local hasDescription = options.Description and options.Description ~= ""

    local zones = self:createComponentContainer({
        parent = page,
        layout = "stacked",
        minHeight = 35,
        padding = hasDescription and {
            top = 10,
            bottom = 10,
            left = 10,
            right = 0
        } or {
            top = 0,
            bottom = 0,
            left = 10,
            right = 0
        },
        spacing = hasDescription and 2 or 0,
        hasDescription = hasDescription,
        corner = 4,
        colorTier = "SecondaryColor"
    }, theme)

    local title = self:createLabel(zones.textZone, text, theme, {
        colorTier = "TextPrimary",
        size = 15,
        order = 1,
        widthOffset = -30
    })

    local description = hasDescription and self:createDescription(zones.textZone, options.Description, theme, 2) or nil

    local arrow = self:createElement("ImageLabel", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://113826256227095",
        ImageRectOffset = Vector2.new(448, 192),
        ImageRectSize = Vector2.new(64, 64),
        ImageColor3 = theme.TextPrimary,
        ZIndex = 5
    }, zones.container)

    local themeRegistry = {
        [zones.container] = {
            BackgroundColor3 = "SecondaryColor",
            BackgroundTransparency = "SecondaryTransparency"
        },
        [title] = {
            TextColor3 = "TextPrimary",
            Font = "SecondaryFont"
        },
        [arrow] = {
            ImageColor3 = "TextPrimary"
        }
    }

    if description then
        themeRegistry[description] = {
            TextColor3 = "TextSecondary",
            Font = "SecondaryFont"
        }
    end

    self:registerMultipleThemeElements(window, themeRegistry)

    local state, held = "Base", false

    local function setColor(s)
        local currentTheme = window and self:getCurrentTheme(window) or theme
        if s == "Base" then
            zones.container.BackgroundColor3 = currentTheme.SecondaryColor
        elseif s == "Hover" then
            zones.container.BackgroundColor3 = currentTheme.SecondaryColorHover
        elseif s == "Button1Down" then
            zones.container.BackgroundColor3 = currentTheme.SecondaryColorMouse1Down
        end
    end

    local button = self:createElement("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 6
    }, zones.container)

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
        local hadDescription = description ~= nil and description.Visible
        local hasDescription = t and t ~= ""

        if description and t then
            description.Text = t
            description.Visible = true
        elseif description and not t then
            description.Visible = false
        elseif not description and t then
            description = self:createDescription(zones.textZone, t, theme, 2)
            if window then
                self:registerThemeElement(window, description, {
                    TextColor3 = "TextSecondary",
                    Font = "SecondaryFont"
                })
            end
        end

        if hadDescription ~= hasDescription then
            local padding = zones.container:FindFirstChildOfClass("UIPadding")
            if padding then
                if hasDescription then
                    padding.PaddingTop = UDim.new(0, 10)
                    padding.PaddingBottom = UDim.new(0, 10)
                    zones.layout.Padding = UDim.new(0, 2)
                    zones.textZone.Position = UDim2.new(0, 0, 0, 0)
                    zones.textZone.AnchorPoint = Vector2.new(0, 0)
                else
                    padding.PaddingTop = UDim.new(0, 0)
                    padding.PaddingBottom = UDim.new(0, 0)
                    zones.layout.Padding = UDim.new(0, 0)
                    zones.textZone.Position = UDim2.new(0, 0, 0.5, 0)
                    zones.textZone.AnchorPoint = Vector2.new(0, 0.5)
                end
            end
        end
    end

    function api:setCallback(cb)
        callback = cb
    end

    function api:setVisible(v)
        zones.container.Visible = v
    end

    function api:getElements()
        return {
            Container = zones.container,
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
    local window = self:getWindowFromElement(page)
    local hasDescription = options.Description and options.Description ~= ""

    local zones = self:createComponentContainer({
        parent = page,
        layout = "textLeft",
        textWidth = 0.7,
        minHeight = 35,
        padding = hasDescription and {
            top = 10,
            bottom = 10,
            left = 10,
            right = 0
        } or {
            top = 0,
            bottom = 0,
            left = 10,
            right = 0
        },
        spacing = hasDescription and 2 or 0,
        hasDescription = hasDescription,
        corner = 4,
        colorTier = "SecondaryColor"
    }, theme)

    local label = self:createLabel(zones.textZone, text, theme, {
        colorTier = "TextPrimary",
        size = 14,
        order = 1
    })

    local description = hasDescription and self:createDescription(zones.textZone, options.Description, theme, 2) or nil

    local switch = self:createElement("TextButton", {
        Size = UDim2.new(0, 40, 0, 20),
        Position = UDim2.new(1, -50, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = theme.SecondaryColorMouse1Down,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 5
    }, zones.container)

    self:createElement("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, switch)

    local indicator = self:createElement("Frame", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 2, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = theme.TextInactive,
        BorderSizePixel = 0,
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
        local currentTheme = window and self:getCurrentTheme(window) or theme
        local posGoal = state and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
        local colorGoal = state and currentTheme.AccentColor or currentTheme.SecondaryColorMouse1Down
        local indicatorColorGoal = state and currentTheme.TextActive or currentTheme.TextInactive

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

    local themeRegistry = {
        [zones.container] = {
            BackgroundColor3 = "SecondaryColor",
            BackgroundTransparency = "SecondaryTransparency"
        },
        [label] = {
            TextColor3 = "TextPrimary",
            Font = "SecondaryFont"
        },
        [switch] = {
            BackgroundColor3 = function()
                updateToggle(false)
            end
        },
        [indicator] = {
            BackgroundColor3 = function()
                updateToggle(false)
            end
        }
    }

    if description then
        themeRegistry[description] = {
            TextColor3 = "TextSecondary",
            Font = "SecondaryFont"
        }
    end

    self:registerMultipleThemeElements(window, themeRegistry)

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
        container = zones.container,
        getState = function()
            return state
        end,
        setState = function(val)
            state = val
            updateToggle(true)
        end,
        setDescription = function(t)
            local hadDescription = description ~= nil and description.Visible
            local hasDescription = t and t ~= ""

            if description and t then
                description.Text = t
                description.Visible = true
            elseif description and not t then
                description.Visible = false
            elseif not description and t then
                description = SimpleUI:createDescription(zones.textZone, t, theme, 2)
                if window then
                    SimpleUI:registerThemeElement(window, description, {
                        TextColor3 = "TextSecondary",
                        Font = "SecondaryFont"
                    })
                end
            end

            if hadDescription ~= hasDescription then
                local padding = zones.container:FindFirstChildOfClass("UIPadding")
                if padding then
                    if hasDescription then
                        padding.PaddingTop = UDim.new(0, 10)
                        padding.PaddingBottom = UDim.new(0, 10)
                        zones.layout.Padding = UDim.new(0, 2)
                        zones.textZone.Position = UDim2.new(0, 0, 0, 0)
                        zones.textZone.AnchorPoint = Vector2.new(0, 0)
                    else
                        padding.PaddingTop = UDim.new(0, 0)
                        padding.PaddingBottom = UDim.new(0, 0)
                        zones.layout.Padding = UDim.new(0, 0)
                        zones.textZone.Position = UDim2.new(0, 0, 0.5, 0)
                        zones.textZone.AnchorPoint = Vector2.new(0, 0.5)
                    end
                end
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
    local mobile = self:isMobile()
    local window = self:getWindowFromElement(page)
    local multiSelect = dropdownOptions.MultiSelect or false
    local changedEvent = Instance.new("BindableEvent")
    local hasDescription = dropdownOptions.Description and dropdownOptions.Description ~= ""

    local zones = self:createComponentContainer({
        parent = page,
        layout = "textLeft",
        textWidth = 0.5,
        minHeight = 35,
        padding = hasDescription and {
            top = 10,
            bottom = 10,
            left = 10,
            right = 0
        } or {
            top = 0,
            bottom = 0,
            left = 10,
            right = 0
        },
        spacing = hasDescription and 2 or 0,
        hasDescription = hasDescription,
        corner = 4,
        colorTier = "SecondaryColor"
    }, theme)

    local label = self:createLabel(zones.textZone, text, theme, {
        colorTier = "TextPrimary",
        size = 14,
        order = 1
    })

    local description =
        hasDescription and self:createDescription(zones.textZone, dropdownOptions.Description, theme, 2) or nil

    local display = self:createElement("TextButton", {
        Size = UDim2.new(0, 160, 0, 30),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = theme.TertiaryColor,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 5
    }, zones.container)

    self:createElement("UICorner", {
        CornerRadius = UDim.new(0, 4)
    }, display)

    local displayLabel = self:createElement("TextLabel", {
        Size = UDim2.new(1, -28, 1, 0),
        Position = UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = theme.TextPrimary,
        TextSize = 13,
        Font = theme.SecondaryFont,
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

    local themeRegistry = {
        [zones.container] = {
            BackgroundColor3 = "SecondaryColor",
            BackgroundTransparency = "SecondaryTransparency"
        },
        [label] = {
            TextColor3 = "TextPrimary",
            Font = "SecondaryFont"
        },
        [display] = {
            BackgroundColor3 = "TertiaryColor"
        },

        [displayLabel] = {
            TextColor3 = "TextPrimary",
            Font = "SecondaryFont"
        },
        [arrow] = {
            ImageColor3 = "TextPrimary"
        }
    }

    if description then
        themeRegistry[description] = {
            TextColor3 = "TextSecondary",
            Font = "SecondaryFont"
        }
    end

    self:registerMultipleThemeElements(window, themeRegistry)

    local displayState = "Base"
    local isOpen = false

    local function updateDisplayColor()
        local currentTheme = window and self:getCurrentTheme(window) or theme
        if displayState == "Base" then
            display.BackgroundColor3 = currentTheme.TertiaryColor
        elseif displayState == "Hover" then
            display.BackgroundColor3 = currentTheme.TertiaryColorHover
        elseif displayState == "Active" then
            display.BackgroundColor3 = currentTheme.TertiaryColorActive
        elseif displayState == "Mouse1Down" then
            display.BackgroundColor3 = currentTheme.TertiaryColorMouse1Down
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

    local listContainer = self:createElement("Frame", {
        Size = UDim2.new(0, 160, 0, 0),
        BackgroundColor3 = theme.TertiaryColor,
        BackgroundTransparency = theme.PrimaryTransparency,
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

    if window then
        self:registerMultipleThemeElements(window, {
            [listContainer] = {
                BackgroundColor3 = "TertiaryColor",
                BackgroundTransparency = "PrimaryTransparency"
            },

            [searchBox] = {
                BackgroundColor3 = "TertiaryColor",
                TextColor3 = "TextPrimary",
                PlaceholderColor3 = "TextSecondary",
                Font = "SecondaryFont"
            }
        })
    end

    local scrollList = self:createElement("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -36),
        Position = UDim2.new(0, 0, 0, 36),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
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
            Size = UDim2.new(0, 160, 0, 0)
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
        local currentTheme = window and self:getCurrentTheme(window) or theme

        local optionContainer = self:createElement("Frame", {
            Size = UDim2.new(1, -8, 0, 28),
            BackgroundTransparency = 1,
            ZIndex = 252,
            LayoutOrder = index
        }, scrollList)

        local option = self:createElement("TextButton", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundColor3 = currentTheme.TertiaryColor,
            BorderSizePixel = 0,
            Text = optionText,
            TextColor3 = currentTheme.TextPrimary,
            TextSize = 13,
            Font = currentTheme.SecondaryFont,
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
            BackgroundColor3 = currentTheme.AccentColor,
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = 254
        }, optionContainer)

        self:createElement("UICorner", {
            CornerRadius = UDim.new(1, 0)
        }, indicator)

        if window then
            self:registerThemeElement(window, option, {
                BackgroundColor3 = "TertiaryColor",
                TextColor3 = "TextPrimary",
                Font = "SecondaryFont"
            })
            self:registerThemeElement(window, indicator, {
                BackgroundColor3 = "AccentColor"
            })
        end

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
                end
                changedEvent:Fire(optionDataMap[optionText])
            end)
        end

        if not mobile then
            option.MouseEnter:Connect(function()
                local currentTheme = window and self:getCurrentTheme(window) or theme
                option.BackgroundColor3 = currentTheme.TertiaryColorHover
            end)
            option.MouseLeave:Connect(function()
                local currentTheme = window and self:getCurrentTheme(window) or theme
                option.BackgroundColor3 = currentTheme.TertiaryColor
            end)
            option.MouseButton1Down:Connect(function()
                local currentTheme = window and self:getCurrentTheme(window) or theme
                option.BackgroundColor3 = currentTheme.TertiaryColorMouse1Down
            end)
            option.MouseButton1Up:Connect(function()
                local currentTheme = window and self:getCurrentTheme(window) or theme
                option.BackgroundColor3 = currentTheme.TertiaryColorHover
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
            listContainer.Size = UDim2.new(0, 160, 0, 0)
            listContainer.Visible = true
            tweenService:Create(listContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 160, 0, targetHeight)
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
        container = zones.container,
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
            local hadDescription = description ~= nil and description.Visible
            local hasDescription = t and t ~= ""

            if description and t then
                description.Text = t
                description.Visible = true
            elseif description and not t then
                description.Visible = false
            elseif not description and t then
                description = SimpleUI:createDescription(zones.textZone, t, theme, 2)
                if window then
                    SimpleUI:registerThemeElement(window, description, {
                        TextColor3 = "TextSecondary",
                        Font = "SecondaryFont"
                    })
                end
            end

            if hadDescription ~= hasDescription then
                local padding = zones.container:FindFirstChildOfClass("UIPadding")
                if padding then
                    if hasDescription then
                        padding.PaddingTop = UDim.new(0, 10)
                        padding.PaddingBottom = UDim.new(0, 10)
                        zones.layout.Padding = UDim.new(0, 2)
                        zones.textZone.Position = UDim2.new(0, 0, 0, 0)
                        zones.textZone.AnchorPoint = Vector2.new(0, 0)
                    else
                        padding.PaddingTop = UDim.new(0, 0)
                        padding.PaddingBottom = UDim.new(0, 0)
                        zones.layout.Padding = UDim.new(0, 0)
                        zones.textZone.Position = UDim2.new(0, 0, 0.5, 0)
                        zones.textZone.AnchorPoint = Vector2.new(0, 0.5)
                    end
                end
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
    local window = self:getWindowFromElement(page)
    local increment = options.Increment or 1
    local hasDescription = options.Description and options.Description ~= ""

    local zones = self:createComponentContainer({
        parent = page,
        layout = "stacked",
        minHeight = 50,
        padding = hasDescription and {
            top = 10,
            bottom = 10,
            left = 10,
            right = 10
        } or {
            top = 8,
            bottom = 8,
            left = 10,
            right = 10
        },
        spacing = hasDescription and 4 or 2,
        hasDescription = hasDescription,
        corner = 4,
        colorTier = "SecondaryColor"
    }, theme)

    local labelContainer = self:createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        ZIndex = 5
    }, zones.textZone)

    local label = self:createLabel(labelContainer, text, theme, {
        colorTier = "TextPrimary",
        size = 14,
        widthOffset = -60
    })

    local valueLabel = self:createElement("TextLabel", {
        Size = UDim2.new(0, 50, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Text = tostring(defaultValue or min),
        TextColor3 = theme.TextSecondary,
        TextSize = 13,
        Font = theme.SecondaryFont,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 5
    }, labelContainer)

    local description = hasDescription and self:createDescription(zones.textZone, options.Description, theme, 2) or nil

    local trackContainer = self:createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 24),
        BackgroundTransparency = 1,
        LayoutOrder = 3,
        ZIndex = 5
    }, zones.textZone)

    local track = self:createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 4),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = theme.TertiaryColorMouse1Down,
        BorderSizePixel = 0,
        ZIndex = 5
    }, trackContainer)

    self:createElement("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, track)

    local fill = self:createElement("Frame", {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = theme.AccentColor,
        BorderSizePixel = 0,
        ZIndex = 6
    }, track)

    self:createElement("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, fill)

    local thumb = self:createElement("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = theme.TextActive,
        BorderSizePixel = 0,
        ZIndex = 7
    }, track)

    self:createElement("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, thumb)

    local themeRegistry = {
        [zones.container] = {
            BackgroundColor3 = "SecondaryColor",
            BackgroundTransparency = "SecondaryTransparency"
        },
        [label] = {
            TextColor3 = "TextPrimary",
            Font = "SecondaryFont"
        },
        [valueLabel] = {
            TextColor3 = "TextSecondary",
            Font = "SecondaryFont"
        },
        [track] = {
            BackgroundColor3 = "TertiaryColorMouse1Down"
        },
        [fill] = {
            BackgroundColor3 = "AccentColor"
        },
        [thumb] = {
            BackgroundColor3 = "TextActive"
        }
    }

    if description then
        themeRegistry[description] = {
            TextColor3 = "TextSecondary",
            Font = "SecondaryFont"
        }
    end

    self:registerMultipleThemeElements(window, themeRegistry)

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
        container = zones.container,
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
            local hadDescription = description ~= nil and description.Visible
            local hasDescription = t and t ~= ""

            if description and t then
                description.Text = t
                description.Visible = true
            elseif description and not t then
                description.Visible = false
            elseif not description and t then
                description = SimpleUI:createDescription(zones.textZone, t, theme, 2)
                if window then
                    SimpleUI:registerThemeElement(window, description, {
                        TextColor3 = "TextSecondary",
                        Font = "SecondaryFont"
                    })
                end
            end

            if hadDescription ~= hasDescription then
                local padding = zones.container:FindFirstChildOfClass("UIPadding")
                if padding then
                    if hasDescription then
                        padding.PaddingTop = UDim.new(0, 10)
                        padding.PaddingBottom = UDim.new(0, 10)
                        zones.layout.Padding = UDim.new(0, 4)
                    else
                        padding.PaddingTop = UDim.new(0, 8)
                        padding.PaddingBottom = UDim.new(0, 8)
                        zones.layout.Padding = UDim.new(0, 2)
                    end
                end
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
    local mobile = self:isMobile()
    local window = self:getWindowFromElement(page)
    local hasDescription = options.Description and options.Description ~= ""

    local zones = self:createComponentContainer({
        parent = page,
        layout = "textLeft",
        textWidth = 0.6,
        minHeight = 35,
        padding = hasDescription and {
            top = 10,
            bottom = 10,
            left = 10,
            right = 0
        } or {
            top = 0,
            bottom = 0,
            left = 10,
            right = 0
        },
        spacing = hasDescription and 2 or 0,
        hasDescription = hasDescription,
        corner = 4,
        colorTier = "SecondaryColor"
    }, theme)

    local label = self:createLabel(zones.textZone, text, theme, {
        colorTier = "TextPrimary",
        size = 14,
        order = 1
    })

    local description = hasDescription and self:createDescription(zones.textZone, options.Description, theme, 2) or nil

    local inputBox = self:createElement("TextBox", {
        Size = UDim2.new(0.35, 0, 0, 30),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = theme.TertiaryColor,
        BorderSizePixel = 0,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Text = defaultValue or "",
        PlaceholderText = "Enter text...",
        TextColor3 = theme.TextPrimary,
        PlaceholderColor3 = theme.TextSecondary,
        TextSize = 13,
        Font = theme.SecondaryFont,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        ZIndex = 5
    }, zones.container)

    self:createElement("UICorner", {
        CornerRadius = UDim.new(0, 4)
    }, inputBox)

    self:createElement("UIPadding", {
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8)
    }, inputBox)

    local underline = self:createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = theme.TertiaryColor,
        BorderSizePixel = 0,
        ZIndex = 6
    }, inputBox)

    self:createElement("UICorner", {
        CornerRadius = UDim.new(1, 0)
    }, underline)

    local themeRegistry = {
        [zones.container] = {
            BackgroundColor3 = "SecondaryColor",
            BackgroundTransparency = "SecondaryTransparency"
        },
        [label] = {
            TextColor3 = "TextPrimary",
            Font = "SecondaryFont"
        },
        [inputBox] = {
            TextColor3 = "TextPrimary",
            PlaceholderColor3 = "TextSecondary",
            BackgroundColor3 = "TertiaryColor",
            Font = "SecondaryFont"
        },
        [underline] = {
            BackgroundColor3 = "TertiaryColor"
        }
    }

    if description then
        themeRegistry[description] = {
            TextColor3 = "TextSecondary",
            Font = "SecondaryFont"
        }
    end

    self:registerMultipleThemeElements(window, themeRegistry)

    local isFocused = false
    local tween = self:getService("TweenService")

    inputBox.Focused:Connect(function()
        isFocused = true
        local currentTheme = window and self:getCurrentTheme(window) or theme
        tween:Create(underline, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = currentTheme.AccentColor
        }):Play()
    end)

    inputBox.FocusLost:Connect(function()
        isFocused = false
        local currentTheme = window and self:getCurrentTheme(window) or theme
        tween:Create(underline, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = currentTheme.TertiaryColorMouse1Down
        }):Play()
        if callback then
            callback(inputBox.Text)
        end
    end)

    if not mobile then
        inputBox.MouseEnter:Connect(function()
            if not isFocused then
                local currentTheme = window and self:getCurrentTheme(window) or theme
                inputBox.BackgroundColor3 = currentTheme.TertiaryColorHover
            end
        end)
        inputBox.MouseLeave:Connect(function()
            if not isFocused then
                local currentTheme = window and self:getCurrentTheme(window) or theme
                inputBox.BackgroundColor3 = currentTheme.TertiaryColor
            end
        end)
    end

    return {
        container = zones.container,
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
            local hadDescription = description ~= nil and description.Visible
            local hasDescription = t and t ~= ""

            if description and t then
                description.Text = t
                description.Visible = true
            elseif description and not t then
                description.Visible = false
            elseif not description and t then
                description = SimpleUI:createDescription(zones.textZone, t, theme, 2)
                if window then
                    SimpleUI:registerThemeElement(window, description, {
                        TextColor3 = "TextSecondary",
                        Font = "SecondaryFont"
                    })
                end
            end

            if hadDescription ~= hasDescription then
                local padding = zones.container:FindFirstChildOfClass("UIPadding")
                if padding then
                    if hasDescription then
                        padding.PaddingTop = UDim.new(0, 10)
                        padding.PaddingBottom = UDim.new(0, 10)
                        zones.layout.Padding = UDim.new(0, 2)
                        zones.textZone.Position = UDim2.new(0, 0, 0, 0)
                        zones.textZone.AnchorPoint = Vector2.new(0, 0)
                    else
                        padding.PaddingTop = UDim.new(0, 0)
                        padding.PaddingBottom = UDim.new(0, 0)
                        zones.layout.Padding = UDim.new(0, 0)
                        zones.textZone.Position = UDim2.new(0, 0, 0.5, 0)
                        zones.textZone.AnchorPoint = Vector2.new(0, 0.5)
                    end
                end
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
    local mobile = self:isMobile()
    local window = self:getWindowFromElement(page)
    local hasDescription = options.Description and options.Description ~= ""

    local zones = self:createComponentContainer({
        parent = page,
        layout = "textLeft",
        textWidth = 0.65,
        minHeight = 35,
        padding = hasDescription and {
            top = 10,
            bottom = 10,
            left = 10,
            right = 0
        } or {
            top = 0,
            bottom = 0,
            left = 10,
            right = 0
        },
        spacing = hasDescription and 2 or 0,
        hasDescription = hasDescription,
        corner = 4,
        colorTier = "SecondaryColor"
    }, theme)

    local label = self:createLabel(zones.textZone, text, theme, {
        colorTier = "TextPrimary",
        size = 14,
        order = 1
    })

    local description = hasDescription and self:createDescription(zones.textZone, options.Description, theme, 2) or nil

    local display = self:createElement("TextButton", {
        Size = UDim2.new(0.3, 0, 0, 30),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = theme.TertiaryColor,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 5
    }, zones.container)

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
        TextColor3 = theme.TextPrimary,
        TextSize = 13,
        Font = theme.SecondaryFont,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 6
    }, display)

    local themeRegistry = {
        [zones.container] = {
            BackgroundColor3 = "SecondaryColor",
            BackgroundTransparency = "SecondaryTransparency"
        },
        [label] = {
            TextColor3 = "TextPrimary",
            Font = "SecondaryFont"
        },
        [displayLabel] = {
            TextColor3 = "TextPrimary",
            Font = "SecondaryFont"
        }
    }

    if description then
        themeRegistry[description] = {
            TextColor3 = "TextSecondary",
            Font = "SecondaryFont"
        }
    end

    self:registerMultipleThemeElements(window, themeRegistry)

    local currentKey = defaultKey
    local listening = false
    local uis = self:getService("UserInputService")
    local bindConnection
    local inputConnection

    local function updateDisplay()
        local currentTheme = window and self:getCurrentTheme(window) or theme
        if listening then
            displayLabel.Text = "Press a key.."
            display.BackgroundColor3 = currentTheme.AccentColor
        else
            displayLabel.Text = "Key: " .. (currentKey and currentKey.Name or "Select Keybind...")
            display.BackgroundColor3 = currentTheme.TertiaryColor
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
                local currentTheme = window and self:getCurrentTheme(window) or theme
                display.BackgroundColor3 = currentTheme.TertiaryColorHover
            end
        end)
        display.MouseLeave:Connect(function()
            if not listening then
                local currentTheme = window and self:getCurrentTheme(window) or theme
                display.BackgroundColor3 = currentTheme.TertiaryColor
            end
        end)
    end

    updateDisplay()
    setupBind()

    self:registerThemeElement(window, display, {
        BackgroundColor3 = function(el, theme)
            el.BackgroundColor3 = listening and theme.AccentColor or theme.TertiaryColor
        end
    })

    return {
        container = zones.container,
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
            local hadDescription = description ~= nil and description.Visible
            local hasDescription = t and t ~= ""

            if description and t then
                description.Text = t
                description.Visible = true
            elseif description and not t then
                description.Visible = false
            elseif not description and t then
                description = SimpleUI:createDescription(zones.textZone, t, theme, 2)
                if window then
                    SimpleUI:registerThemeElement(window, description, {
                        TextColor3 = "TextSecondary",
                        Font = "SecondaryFont"
                    })
                end
            end

            if hadDescription ~= hasDescription then
                local padding = zones.container:FindFirstChildOfClass("UIPadding")
                if padding then
                    if hasDescription then
                        padding.PaddingTop = UDim.new(0, 10)
                        padding.PaddingBottom = UDim.new(0, 10)
                        zones.layout.Padding = UDim.new(0, 2)
                        zones.textZone.Position = UDim2.new(0, 0, 0, 0)
                        zones.textZone.AnchorPoint = Vector2.new(0, 0)
                    else
                        padding.PaddingTop = UDim.new(0, 0)
                        padding.PaddingBottom = UDim.new(0, 0)
                        zones.layout.Padding = UDim.new(0, 0)
                        zones.textZone.Position = UDim2.new(0, 0, 0.5, 0)
                        zones.textZone.AnchorPoint = Vector2.new(0, 0.5)
                    end
                end
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
    local window = self:getWindowFromElement(page)

    local container = self:createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = theme.SecondaryColor,
        BackgroundTransparency = theme.SecondaryTransparency,
        BorderSizePixel = 0,
        ZIndex = 4
    }, page)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = container

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingBottom = UDim.new(0, 10)
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = container

    local contentFrame = self:createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        ZIndex = 5
    }, container)

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    layout.VerticalAlignment = Enum.VerticalAlignment.Top
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 4)
    layout.Parent = contentFrame

    local titleLabel = self:createElement("TextLabel", {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = title or "Paragraph",
        TextSize = 16,
        TextColor3 = theme.TextActive,
        Font = theme.PrimaryFont,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutomaticSize = Enum.AutomaticSize.Y,
        TextWrapped = true,
        LayoutOrder = 0,
        ZIndex = 5
    }, contentFrame)

    local themeRegistry = {
        [container] = {
            BackgroundColor3 = "SecondaryColor",
            BackgroundTransparency = "SecondaryTransparency"
        },
        [titleLabel] = {
            TextColor3 = "TextActive",
            Font = "PrimaryFont"
        }
    }

    self:registerMultipleThemeElements(window, themeRegistry)

    local fieldElements = {}
    local fieldCounter = 0

    local function createField(fieldData, layoutOrder)
        fieldCounter = fieldCounter + 1
        local fieldId = "field_" .. fieldCounter
        local isSubField = fieldData.isSubField or false

        local field = self:createElement("TextLabel", {
            Size = UDim2.new(1, isSubField and -20 or 0, 0, 0),
            Position = isSubField and UDim2.new(0, 20, 0, 0) or UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = fieldData.text or "",
            TextSize = isSubField and 13 or 14,
            TextColor3 = isSubField and theme.TextSecondary or theme.TextPrimary,
            Font = theme.SecondaryFont,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextWrapped = true,
            LayoutOrder = layoutOrder or (fieldCounter + 1),
            ZIndex = 5
        }, contentFrame)

        if window then
            SimpleUI:registerThemeElement(window, field, {
                TextColor3 = isSubField and "TextSecondary" or "TextPrimary",
                Font = "SecondaryFont"
            })
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
    local containerName = "SimpleUI_NotificationContainer"
    local isMobile = self:isMobile()
    local parent = self._getSafeContainer()

    local container = parent:FindFirstChild(containerName)
    if not container then
        container = self:createElement("ScreenGui", {
            Name = containerName,
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 999
        }, parent)

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
    screenGui.Parent = self:_getSafeContainer()
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
    blurEffect.Parent = self:getService("Lighting")
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

return SimpleUI
