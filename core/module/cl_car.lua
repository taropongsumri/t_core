ESX = Framework.Libs()

local cfg = Config.Car

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()

        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if cfg.disableVehicleRewards then
                DisablePlayerVehicleRewards(PlayerId())
            end

            for i = 1, #cfg.disabledControls do
                DisableControlAction(1, cfg.disabledControls[i], true)
            end

            if cfg.stripHelmet then
                SetPedHelmet(playerPed, false)
            end

            if cfg.disableBikeMeleeAttack and IsPedOnAnyBike(playerPed) then
                DisableControlAction(1, 346, true) -- INPUT_VEH_MELEE_ATTACK
                DisableControlAction(1, 347, true) -- INPUT_VEH_MELEE_ATTACK_2
            end

            if cfg.disableRadio then
                SetUserRadioControlEnabled(false)
                if GetPlayerRadioStationName() ~= nil then
                    SetVehRadioStation(vehicle, "OFF")
                end
            end

            Citizen.Wait(cfg.inVehicleTickRate)
        else
            Citizen.Wait(cfg.onFootTickRate)
        end
    end
end)
