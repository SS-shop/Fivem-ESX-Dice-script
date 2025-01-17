local isRolling = false
local resultText = nil
local resultPed = nil

local function playDiceAnimation()
    local ped = PlayerPedId()
    RequestAnimDict("anim@mp_player_intcelebrationmale@wank")
    while not HasAnimDictLoaded("anim@mp_player_intcelebrationmale@wank") do
        Wait(0)
    end

    TaskPlayAnim(ped, "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, -8.0, 3000, 49, 0, false, false, false)
    RemoveAnimDict("anim@mp_player_intcelebrationmale@wank")
end

local function draw3DText(coords, text)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local scale = 0.35

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x, y)

        local factor = string.len(text) / 370
        DrawRect(x, y + 0.015, 0.015 + factor, 0.03, 0, 0, 0, 150)
    end
end


Citizen.CreateThread(function()
    while true do
        if isRolling and resultText and resultPed then
            local pedCoords = GetEntityCoords(resultPed)
            draw3DText(pedCoords + vector3(0.0, 0.0, 1.0), resultText)
        end
        Wait(0) 
    end
end)

RegisterNetEvent('esx_dice:roll')
AddEventHandler('esx_dice:roll', function(playerId, result)
    local ped = GetPlayerPed(GetPlayerFromServerId(playerId))

    
    resultText = "🎲 " .. result
    resultPed = ped
    isRolling = true

    
    Citizen.SetTimeout(3000, function()
        isRolling = false
        resultText = nil
        resultPed = nil
    end)
end)

RegisterCommand('dice', function()
    playDiceAnimation()
    TriggerServerEvent('esx_dice:rollDice')
end)
