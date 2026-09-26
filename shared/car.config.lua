Config.Car = {
    inVehicleTickRate     = 7,      -- ms per tick while player is inside a vehicle
    onFootTickRate        = 500,    -- ms per tick while player is on foot

    disableVehicleRewards = true,   -- suppress vehicle reward spawns each frame
    stripHelmet           = true,   -- remove helmet while in any vehicle
    disableBikeMeleeAttack = true,  -- block melee attack inputs on motorcycles/bicycles
    disableRadio          = true,   -- force radio off and lock station to "OFF"

    -- INPUT_VEH_RADIO_WHEEL = 85 | INPUT_VEH_MULTIPLAYER_INFO = 199
    disabledControls = { 85, 199 },
}
