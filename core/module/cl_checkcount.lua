-- In nc_inventory (client.lua)

local inventoryCache = {}

AddEventHandler('esx:playerLoaded', function(xPlayer)
    inventoryCache = xPlayer.inventory or {}
end)

AddEventHandler('esx:setObject', function(key, value)
    if key == 'inventory' then
        inventoryCache = value
    end
end)

-- In xo_default (client.lua)
exports('checkcount', function(itemName)
    local inventory = ESX.GetPlayerData().inventory
    if inventory == nil then return 0 end
    for _, item in ipairs(inventory) do
        if item.name == itemName then
            return item.count or 0
        end
    end
    return 0
end)