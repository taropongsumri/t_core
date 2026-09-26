ESX = Framework.Libs()

-- Minimap theme
Citizen.CreateThread(function()
    AddTextEntry('FE_THDR_GTAO', Config.PauseMenuTitle)

    local theme = Config.MinimapTheme
    if theme.enabled then
        local c = theme.color
        Citizen.InvokeNative(0xF314CF4F0211894E, 116, c.r, c.g, c.b, c.a)
        Citizen.InvokeNative(0xF314CF4F0211894E, 143, c.r, c.g, c.b, c.a)
    end
end)

-- Audio Settings
Citizen.CreateThread(function()
    local audio = Config.Audio

    if audio.PoliceScannerDisabled            then SetAudioFlag("PoliceScannerDisabled", true) end
    if audio.DisableFlightMusic               then SetAudioFlag("DisableFlightMusic", true) end
    if audio.DisableFrontendSting             then SetAudioFlag("DisableFrontendSting", true) end
    if audio.DisableShallowWaterSurfaceChecks then SetAudioFlag("DisableShallowWaterSurfaceChecks", true) end
    if audio.WantedMusicDisabled              then SetAudioFlag("WantedMusicDisabled", true) end
    if audio.MissionEndMusicDisabled          then SetAudioFlag("MissionEndMusicDisabled", true) end

    if audio.StopAudioScenes then
        StopAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
        StopAudioScene("FBI_HEIST_H5_MUTE_AMBIENCE_SCENE")
    end

    if audio.DisableStaticEmitters then
        SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_01_STAGE", false)
        SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM", false)
        SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM", false)
    end

    if audio.DisableAmbientZones then
        SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones", false, true)
    end
end)

-- Vehicle Attacks Collision Management
if Config.VehicleAttacks then
    VehicleCollisionTracker = {}
    PlayerCollisionTracker  = {}
    local playerPed         = GetPlayerPed(-1)

    function ResetVehicleCollisions()
        for _, vehicle in pairs(ESX.Game.GetVehicles()) do
            local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
            if VehicleCollisionTracker[plate] then
                SetEntityNoCollisionEntity(playerPed, vehicle, true)
                VehicleCollisionTracker[plate] = nil
            end
        end
    end

    function ResetPlayerCollisions()
        for _, playerId in pairs(GetActivePlayers()) do
            local serverId = GetPlayerServerId(playerId)
            if serverId and PlayerCollisionTracker[serverId] then
                SetEntityNoCollisionEntity(playerPed, GetPlayerPed(playerId), true)
                PlayerCollisionTracker[serverId] = nil
            end
        end
    end

    function ManageCollisions()
        while true do
            Wait(500)
            playerPed = GetPlayerPed(-1)

            if IsPedOnFoot(playerPed) then
                -- ##
                DisplayRadar(false)
                -- ##
                SetRagdollBlockingFlags(playerPed, 2)
                for _, vehicle in pairs(ESX.Game.GetVehicles()) do
                    if GetVehicleClass(vehicle) ~= 14 then
                        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
                        if GetPedInVehicleSeat(vehicle, -1) ~= 0 then
                            if not VehicleCollisionTracker[plate] then
                                SetEntityNoCollisionEntity(playerPed, vehicle, false)
                                VehicleCollisionTracker[plate] = true
                            end
                        elseif VehicleCollisionTracker[plate] then
                            SetEntityNoCollisionEntity(playerPed, vehicle, true)
                            VehicleCollisionTracker[plate] = nil
                        end
                    end
                end
            else
                ResetVehicleCollisions()
            end

            if IsPedInAnyVehicle(playerPed, true) then
                for _, playerId in pairs(GetActivePlayers()) do
                    local ped      = GetPlayerPed(playerId)
                    local serverId = GetPlayerServerId(playerId)
                    if IsPedOnFoot(ped) then
                        if not PlayerCollisionTracker[serverId] then
                            SetEntityNoCollisionEntity(playerPed, ped, false)
                            PlayerCollisionTracker[serverId] = true
                        end
                    elseif PlayerCollisionTracker[serverId] then
                        SetEntityNoCollisionEntity(playerPed, ped, true)
                        PlayerCollisionTracker[serverId] = nil
                    end
                end
            else
                ResetPlayerCollisions()
            end
        end
    end

    CreateThread(ManageCollisions)
end

-- AFK / Idle Camera
if Config.DisableIdleCam then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(25000)
            InvalidateIdleCam()
            InvalidateVehicleIdleCam()
        end
    end)
end
