---@diagnostic disable: undefined-global
ESX = exports['es_extended']:getSharedObject()

function NotifySV(player, notifType, duration, title, description)
    TriggerClientEvent('ox_lib:notify', player.source, {
        type        = notifType,
        duration    = duration,
        title       = title ~= '' and title or nil,
        description = description,
    })
end