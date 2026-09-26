ESX = Framework.Libs()

local cfg = Config.Pointer

function startPointing()
    local ped = PlayerPedId()
    ESX.Streaming.RequestAnimDict('anim@mp_point')
    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
    SetPedConfigFlag(ped, 36, 1)
    TaskMoveNetworkByName(ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
end

function stopPointing()
    local ped = PlayerPedId()
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
    RemoveAnimDict("anim@mp_point")
end

if Commands.pointer.enabled then
    RegisterKeyMapping('pointer', 'Pointer', 'keyboard', 'B')

    RegisterCommand('pointer', function()
        if IsPedInAnyVehicle(PlayerPedId(), true) or IsEntityDead(PlayerPedId()) then return end

        if not keyPressed then
            keyPressed = true
            if not mp_pointing then
                mp_pointing = true
                startPointing()
            end
            CreateThread(function()
                while mp_pointing do
                    Wait(0)
                    if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
                        local ped       = PlayerPedId()
                        local camPitch  = GetGameplayCamRelativePitch()

                        DisablePlayerFiring(PlayerPedId(), false)

                        if camPitch < cfg.camPitchMin then camPitch = cfg.camPitchMin end
                        if camPitch > cfg.camPitchMax then camPitch = cfg.camPitchMax end
                        camPitch = (camPitch - cfg.camPitchMin) / (cfg.camPitchMax - cfg.camPitchMin)

                        local camHeading    = GetGameplayCamRelativeHeading()
                        local cosCamHeading = Cos(camHeading)
                        local sinCamHeading = Sin(camHeading)
                        if camHeading < -180.0 then camHeading = -180.0
                        elseif camHeading > 180.0 then camHeading = 180.0 end
                        camHeading = (camHeading + 180.0) / 360.0

                        local blocked = 0
                        local nn      = 0
                        local coords  = GetOffsetFromEntityInWorldCoords(ped,
                            (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)),
                            (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                        local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2,
                            coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7)
                        nn, blocked, coords, coords = GetRaycastResult(ray)

                        Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                        Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                        Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                        Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson",
                            Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
                    end
                end
            end)
        else
            keyPressed = false
            if mp_pointing then
                mp_pointing = false
                stopPointing()
                DisablePlayerFiring(PlayerPedId(), true)
            end
        end
    end)
end
