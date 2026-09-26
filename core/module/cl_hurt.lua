ESX = Framework.Libs()

local cfg  = Config.Hurt
local hurt = false

Citizen.CreateThread(function()
    while true do
        Wait(cfg.checkInterval)
        local health = GetEntityHealth(GetPlayerPed(-1))
        if health <= cfg.healthThresholdHurt then
            setHurt()
        elseif hurt and health > cfg.healthThresholdRecover then
            setNotHurt()
        end
    end
end)

function setHurt()
    hurt = true
    RequestAnimSet(cfg.animSet)
    SetPedMovementClipset(GetPlayerPed(-1), cfg.animSet, true)
end

function setNotHurt()
    hurt = false
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end
