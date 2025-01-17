ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx_dice:rollDice')
AddEventHandler('esx_dice:rollDice', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local diceResult = math.random(1, 6)
        TriggerClientEvent('esx_dice:roll', -1, source, diceResult)
    end
end)
