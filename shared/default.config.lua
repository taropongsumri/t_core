Config = {}

-- Title shown at the top of the pause menu (~b~ = blue, ~r~ = red, ~w~ = white ...)
Config.PauseMenuTitle       = "~b~T"

-- Minimap colour (default: light ocean blue)
Config.MinimapTheme = {
    enabled = true,
    color   = { r = 70, g = 180, b = 220, a = 200 },
}

Config.Audio = {
    PoliceScannerDisabled            = true,
    DisableFlightMusic               = true,
    DisableFrontendSting             = true,
    DisableShallowWaterSurfaceChecks = true,
    WantedMusicDisabled              = true,
    MissionEndMusicDisabled          = true,
    StopAudioScenes                  = true,
    DisableStaticEmitters            = true,
    DisableAmbientZones              = true,
}

-- Prevent vehicles from physically colliding with on-foot players (and vice versa)
Config.VehicleAttacks       = true

-- Suppress AFK idle camera takeover
Config.DisableIdleCam       = true

Config.Crouched = {
    animSet       = "move_ped_crouched",
    blendInSpeed  = 0.25,
    restrictedZones = {
        -- { coords = vector3(0.0, 0.0, 0.0), radius = 100.0 },
    },
}

Config.Hurt = {
    animSet               = "move_m@injured",
    healthThresholdHurt   = 120,   -- health <= this triggers hurt walk
    healthThresholdRecover = 160,  -- health > this clears hurt walk
    checkInterval         = 500,   -- ms between health checks
}

Config.Pointer = {
    camPitchMin = -70.0,
    camPitchMax =  42.0,
}

-- Blips
-- sprite  : https://docs.fivem.net/docs/game-references/blips/#blips
-- color   : https://docs.fivem.net/docs/game-references/blips/#blip-colors
-- display : 2 = minimap only | 4 = minimap + full map
Config.Blips = {
    {
        label      = "Police Station",
        coords     = vector3(441.3, -982.0, 30.7),
        sprite     = 60,
        color      = 29,
        scale      = 0.8,
        display    = 4,
        shortRange = true,
    },
    -- {
    --     label      = "Hospital",
    --     coords     = vector3(295.9, -1447.9, 29.9),
    --     sprite     = 61,
    --     color      = 1,
    --     scale      = 0.8,
    --     display    = 4,
    --     shortRange = true,
    -- },
    -- {
    --     label      = "Mechanic",
    --     coords     = vector3(-348.0, -133.2, 39.0),
    --     sprite     = 446,
    --     color      = 5,
    --     scale      = 0.8,
    --     display    = 4,
    --     shortRange = true,
    -- },
}

Commands = {
    toggleCrouch     = { enabled = true},
    put_your_handsup = { enabled = true},
    pointer          = { enabled = true},
}
