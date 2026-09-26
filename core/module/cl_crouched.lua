ESX = Framework.Libs()

local isLoadAnimDict = false
local isCrouched = false

Citizen.CreateThread(function()
    Citizen.Wait(100)

    RequestAnimSet(Config.Crouched.animSet)
    while not HasAnimSetLoaded(Config.Crouched.animSet) do
        Citizen.Wait(100)
    end
    ResetPedMovementClipset(PlayerPedId(), 1.0)
    isLoadAnimDict = true
end)

local stopCrouched = function()

end

local exec_ccOptimizedPush = function()
    if not isLoadAnimDict then return end
    if isCrouched then return end
    isCrouched = true
    while DoesEntityExist(PlayerPedId()) and isCrouched do
        DisableControlAction(0, 36)
        Wait(0)
        SetPedMovementClipset(PlayerPedId(), Config.Crouched.animSet, Config.Crouched.blendInSpeed)
    end
end

local exec_ccOptimizedUnPush = function()
    if not isCrouched then return end
    isCrouched = false
    Wait(50)
    ResetPedMovementClipset(PlayerPedId(), 1.0)
end

local toggleEngine = function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
        SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
    end
end


RegisterCommand('+exec_ccOptimized', exec_ccOptimizedPush)
RegisterCommand('-exec_ccOptimized', exec_ccOptimizedUnPush)
RegisterKeyMapping('+exec_ccOptimized', 'CrouchFinal', 'keyboard', 'lcontrol')




local crouched = false
local startaim = false
local loadanimation = false

Citizen.CreateThread(function()
	RequestAnimSet( Config.Crouched.animSet )
	while ( not HasAnimSetLoaded( Config.Crouched.animSet ) ) do
		Citizen.Wait( 0 )
	end
end)

RegisterKeyMapping('crouchedfix', 'crouched', 'keyboard', 'LCONTROL')

RegisterCommand('crouchedfix', function()
	if not IsPedInAnyVehicle(PlayerPedId(), false) then
		local coords = GetEntityCoords(PlayerPedId())
		if GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey('WEAPON_UNARMED') then
			Reset()
			return
		end
		for _, zone in ipairs(Config.Crouched.restrictedZones) do
			if GetDistanceBetweenCoords(coords, zone.coords.x, zone.coords.y, zone.coords.z, true) <= zone.radius then
				Reset()
				return
			end
		end


		if ( DoesEntityExist( PlayerPedId() ) and not IsEntityDead( PlayerPedId() ) ) then
			SetPedUsingActionMode(PlayerPedId(), false , -1, 'DEFAULT_ACTION')
			if ( not IsPauseMenuActive() ) then

					if ( crouched == true ) then

						-- ยกเลืก
						ResetPedMovementClipset( PlayerPedId(), 0 )
						Citizen.CreateThread(function()
							while crouched do
								DisableControlAction(0, 36)
								Wait(1)
							end
						end)
						Wait(500)
						SetPedUsingActionMode(PlayerPedId(), false , -1, 'DEFAULT_ACTION')
						crouched = false
						startaim = false
					elseif ( crouched == false ) then
						crouched = true
						-- นั่ง
						while crouched do
							DisableControlAction(0, 36)
							Wait(1)
							if crouched then
								if not startaim then
									startaim = true
									SetPedMovementClipset( PlayerPedId(), Config.Crouched.animSet, Config.Crouched.blendInSpeed )
								end
							end
						end
					end
			end
		end
	end
end)

function Reset()
	local crouched2 = true

	ResetPedMovementClipset( PlayerPedId(), 0 )
	Citizen.CreateThread(function()
		while crouched2 do
			DisableControlAction(0, 36)
			Wait(1)
		end
	end)
	Wait(500)
	SetPedUsingActionMode(PlayerPedId(), false , -1, 'DEFAULT_ACTION')
	crouched = false
	crouched2 = false
	startaim = false
end
