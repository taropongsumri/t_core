Framework = {}

---@return table ESX shared object
function Framework.Libs()
    -- ESX Legacy (modern export-based)
    if GetResourceState('es_extended') == 'started' then
        return exports['es_extended']:getSharedObject()
    end

    -- Older ESX (event-based fallback)
    local ESX
    TriggerEvent('esx:getSharedObject', function(obj)
        ESX = obj
    end)

    if ESX then return ESX end

    error('[xo_default] ESX not found. Ensure es_extended is started before this resource.')
end
