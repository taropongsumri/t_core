*A small all-in-one core for ESX servers, made by ponsumri*

# What is this
Most servers install ten tiny scripts just for hands up, crouch, pointing, and so on.
This puts all of them into one resource, so you only need one `ensure`.

# Features
- Player
    - Hands up : Raise your hands, can't shoot while hands are up
    - Crouch : Crouch walk
    - Pointing : Point your finger where the camera looks
    - Slide : Run and slide on the ground (10s cooldown)
    - Hurt walk : Walk injured when your health is low
    - Push car : Push a broken car by hand
- Vehicle
    - No helmet when riding a bike
    - No melee attack on bikes
    - Radio off
    - No weapon rewards from cars
- World
    - Custom pause menu title
    - Custom minimap colour
    - Custom map blips
    - Mute annoying sounds (police scanner, wanted music, strip club, ...)
    - No AFK idle camera
    - Players on foot and cars don't bump each other

# Keybinds
| Key | Action |
|---|---|
| X | Hands up |
| Left Ctrl | Crouch |
| B | Point |
| H | Slide |
| Shift + E | Push car (stand near the car) |

Players can change any of these in
`Settings > Key Bindings > FiveM`

# Requirements
- [es_extended](https://github.com/esx-framework/esx_core)
- [ox_lib](https://github.com/overextended/ox_lib)

# Installation
1. Download and put the folder in your `resources`
2. Add this to your `server.cfg` **after** ESX and ox_lib
```cfg
ensure ox_lib
ensure es_extended
ensure t_core
```
3. Restart your server, done

# Config
Everything is in the `shared/` folder.

- `default.config.lua`
    - PauseMenuTitle : The text on top of the pause menu
    - MinimapTheme : Minimap colour (r, g, b, a)
    - Audio : Turn each sound on / off
    - Blips : Add your own blips to the map
    - Crouched : Zones where players can't crouch
    - Hurt : How low health must be to walk hurt
    - Commands : Turn hands up / pointing on / off
- `car.config.lua`
    - Turn helmet, radio, bike melee on / off
- `handsup.config.lua`
    - Change the hands up animation

## Change the server name
```lua
Config.PauseMenuTitle = "~b~T"
```
`~b~` is the colour. Try `~r~` red, `~g~` green, `~y~` yellow, `~w~` white.

## Change the minimap colour
```lua
Config.MinimapTheme = {
    enabled = true,
    color   = { r = 70, g = 180, b = 220, a = 200 },
}
```
Pick any colour on [Google Color Picker](https://www.google.com/search?q=color+picker) and copy the RGB.

## Add a blip
```lua
{
    label      = "Hospital",
    coords     = vector3(295.9, -1447.9, 29.9),
    sprite     = 61,
    color      = 1,
    scale      = 0.8,
    display    = 4,
    shortRange = true,
},
```
- [Blip icons](https://docs.fivem.net/docs/game-references/blips/#blips)
- [Blip colours](https://docs.fivem.net/docs/game-references/blips/#blip-colors)

# Good to know
- The minimap hides when you are on foot, and shows again in a car.
- The slide shows its "ready" message using `esx_notify`.

# Found a bug ?
Open an issue on GitHub, tell me what happened and how to make it happen again.
I'll try to fix it as soon as I can :)
