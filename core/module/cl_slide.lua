local OnSlide = false
RegisterCommand("t:Slide", function()
	if OnSlide then return end

    local playerPed = PlayerPedId()

    if IsPedOnFoot(playerPed) and not IsEntityInWater(playerPed) then
        if not IsPedRagdoll(playerPed) then
            if IsControlPressed(0, 155) then
                -- if IsControlPressed(0, 304) then
                    if not OnSlide then
                        OnSlide = true
						while (not HasAnimDictLoaded("missheistfbi3b_ig6_v2")) do RequestAnimDict("missheistfbi3b_ig6_v2") Wait(5) end
                        SetPedMoveRateOverride(playerPed, 1.25)
                        ClearPedSecondaryTask(playerPed)
                        TaskPlayAnim(playerPed, "missheistfbi3b_ig6_v2", "rubble_slide_gunman", 3.0, 1.0, -1, 1, 0, 0, 0, 0)
                        ApplyForceToEntityCenterOfMass(playerPed, 1, 0, 12.8, 0.8, true, true, true, true)
                        Wait(250)
                        TaskPlayAnim(playerPed, "missheistfbi3b_ig6_v2", "exit", 3.0, 1.0, -1, 1, 0, 0, 0, 0)
                        ClearPedSecondaryTask(playerPed)
                        Wait(10000)					-- COOLDOWN
                        OnSlide = false
                        exports["esx_notify"]:Notify("success", 3000, "Slide Ready")    
                    end
                -- end
            end
        end
    end
end)
RegisterKeyMapping("t:Slide", "Start Action Slide", 'keyboard', "H")