local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Events

RegisterServerEvent("decrypto:server:removeitem")
AddEventHandler("decrypto:server:removeitem", function(data)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local item = data
	xPlayer.removeInventoryItem(item, 1)
	xPlayer.triggerEvent('esx_status:add','stress',( Config.AddStress * 1000))
	xPlayer.showNotification("You are feeling more stressed!")
end)

RegisterNetEvent('decrypto:server:givecash')
AddEventHandler('decrypto:server:givecash', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    local randomMoney = math.random(Config.MinWithdrawl ,Config.MaxWithdrawal)
	xPlayer.showNotification("ATM cash received: $" .. randomMoney)
	xPlayer.addAccountMoney(Config.Account, randomMoney)
end)

ESX.RegisterServerCallback('decrypto:server:hasitem', function(source, cb, item1, item2)
    local xPlayer = ESX.GetPlayerFromId(source)
    local hasItems = false
    local hasItem1 = false
    local hasItem2 = false
    if xPlayer.getInventoryItem(item1).count > 0 then
        hasItem1 = true
    end
    if xPlayer.getInventoryItem(item2).count > 0 then
        hasItem2 = true
    end
    if hasItem1 and hasItem2 then
        hasItems = true
    end
    cb(hasItems)
end)
