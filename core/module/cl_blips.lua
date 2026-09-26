Citizen.CreateThread(function()
    for _, data in ipairs(Config.Blips) do
        local blip = AddBlipForCoord(data.coords.x, data.coords.y, data.coords.z)

        SetBlipSprite(blip, data.sprite)
        SetBlipColour(blip, data.color)
        SetBlipScale(blip, data.scale)
        SetBlipDisplay(blip, data.display)
        SetBlipAsShortRange(blip, data.shortRange)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(data.label)
        EndTextCommandSetBlipName(blip)
    end
end)
