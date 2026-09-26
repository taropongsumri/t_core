ESX = Framework.Libs()

local cfg     = Config.HandsUp
local handsUp = false

Citizen.CreateThread(function()
    while not ESX do Wait(0) end
    ESX.Streaming.RequestAnimDict(cfg.animDict)
end)

if Commands.put_your_handsup.enabled then
    RegisterKeyMapping('put_your_handsup', 'Hands Up', 'keyboard', 'X')

    RegisterCommand('put_your_handsup', function()
        if not IsPedOnFoot(PlayerPedId()) or IsEntityDead(PlayerPedId()) then return end

        if not handsUp then
            handsUp = true
            Citizen.CreateThread(function()
                ESX.Streaming.RequestAnimDict(cfg.animDict)
                while true do
                    Wait(0)
                    if handsUp then
                        DisablePlayerFiring(PlayerPedId(), false)
                        if not IsEntityPlayingAnim(PlayerPedId(), cfg.animDict, cfg.animName, 49) then
                            TaskPlayAnim(PlayerPedId(), cfg.animDict, cfg.animName,
                                cfg.blendInSpeed, cfg.blendOutSpeed, cfg.duration, cfg.flag, 0, 0, 0, 0)
                        end
                    else
                        break
                    end
                end
            end)
        else
            handsUp = false
            RemoveAnimSet(cfg.animDict)
            ClearPedTasks(PlayerPedId())
            DisablePlayerFiring(PlayerPedId(), true)
        end
    end)
end
