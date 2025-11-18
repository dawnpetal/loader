# SimpleScripts
A simple script hub for Roblox with a built-in loader to access scripts quickly.

---

## Supported Games

| Game Name | Place ID | Link | Description |
|-----------|----------|------|-------------|
| Prospecting | 129827112113663 | [Play Prospecting](https://www.roblox.com/games/129827112113663) | Auto Farm & A LOT more |
| Dig to Earth's Core | 81440632616906 | [Play Dig to Earth's Core](https://www.roblox.com/games/81440632616906) | Auto Farm, Auto Treasure etc |
| Plants vs Brainrots | 127742093697776 | [Play Plants vs Brainrots](https://www.roblox.com/games/127742093697776) | In-game support available |

---

## Supported Game Info
Check the individual files for each game script for detailed information about features, changelogs, and development roadmaps.

---

## Installation

**Loader URL:**
```
https://raw.githubusercontent.com/dawnpetal/loader/main/src/loader.lua
```

**Full Code:**
```lua
local success, err = pcall(function()
    local url = "https://raw.githubusercontent.com/dawnpetal/loader/main/src/loader.lua"
    local loaderCode = game:HttpGet(url)
    assert(loaderCode and #loaderCode > 0, "Loader code is empty")
    local loaderFunc, loadErr = loadstring(loaderCode)
    assert(loaderFunc, "Failed to compile loader: " .. tostring(loadErr))
    loaderFunc()
end)

if not success then
    warn("Loader failed to execute: " .. tostring(err))
end
```

**Short Code:**
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/dawnpetal/loader/main/src/loader.lua"))()
```

---

## Usage
Copy the code into your executor and run it.

---

## Supported Executors

### Windows
| Executor | Status |
|----------|--------|
| Zenith | 🟢 Good |
| Wave | 🟢 Good |
| Velocity | 🟡 Decent |
| Volcano | 🟡 Decent |
| Xeno | 🔴 Not Supported |
| Solara | 🔴 Not Supported |

### macOS
| Executor | Status |
|----------|--------|
| Hydrogen | 🟢 Works |
| Ronix | 🟢 Works |

### iOS/Android
| Executor | Status |
|----------|--------|
| Delta | 🟢 Good |
| KRNL | 🔴 Not Supported |

---