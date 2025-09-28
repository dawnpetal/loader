# Some Script Hub (i don't have a name for it, yet)

A simple script hub for Roblox with a built-in loader to access scripts quickly.

---

## Supported Games

The hub currently supports the following Roblox games:

| Game Name   | Place ID           | Link                                                                 | Description                     |
|------------|------------------|----------------------------------------------------------------------|---------------------------------|
| Prospecting | 129827112113663  | [Play Prospecting](https://www.roblox.com/games/129827112113663/Prospecting) | Auto Farm & Auto Sell script |

---

## Supported Game Info

For detailed information about each supported game, including features, changelogs, and development roadmaps, check the individual files for each game script.


---

## Installation

loader URL:
https://raw.githubusercontent.com/dawnpetal/loader/main/src/loader.lua

Code:
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
    warn("loader failed to execute: " .. tostring(err))
end
```

or 

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/dawnpetal/loader/main/src/loader.lua"))()
```

# Usage

Slap the code into your executor and just run it

---

# Supported Executors

| Executor   | Platform       | Status                        |
|------------|----------------|-------------------------------|
| Xeno  | Windows        | 🟡 Not sure, should work though                 |
| Krnl       | Android        | 🔴 Doesn't Work (they have shitty decompiler)                    |
| Delta   | Android            | 🟢 Working                    |
| Hydrogen   | Mac            | 🟢 Working                    |


---