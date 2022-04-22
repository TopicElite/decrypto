local ESX = nil
local playerPed, playerCoords, Tablet
local PlayerJob = {}
local MiniGame ={}
local HackStatus = false
local NotifyMessage = ''
local NotifyType = 'primay'
local Hacked = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- bt-target Exports

exports['bt-target']:AddTargetModel(Config.ATMModels, {
	options = {
		{
			event = "decrypto:client:starthack",
			icon = "fa-solid fa-mobile-screen-button",
			label = 'Hack ATM',
		}
	},
	job = {"all"},
	distance = 1.5
})
--[[
exports['bt-target']:AddTargetModel(Config.ATMModels[2], {
	options = {
		{
			event = "decrypto:client:starthack",
			icon = "fa-solid fa-mobile-screen-button",
			label = 'Hack ATM',
		},
	},
	job = {"all"},
	distance = 1.5
})

exports['bt-target']:AddTargetModel(Config.ATMModels[3], {
	options = {
		{
			event = "decrypto:client:starthack",
			icon = "fa-solid fa-mobile-screen-button",
			label = 'Hack ATM',
		},
	},
	job = {"all"},
	distance = 1.5
})

exports['bt-target']:AddTargetModel(Config.ATMModels[4], {
	options = {
		{
			event = "decrypto:client:starthack",
			icon = "fa-solid fa-mobile-screen-button",
			label = 'Hack ATM',
		},
	},
	job = {"all"},
	distance = 1.5
})
]]--


-- NUI

MiniGame.Open = function()
	SendNUIMessage({
		action = "open",
		base = Config.MingameBase, 
		timeLimit = Config.MinigameTimeLimit,
		attemptLimit = Config.MingameAttemptLimit 
	})
	SetNuiFocus(true, true)
end

RegisterNUICallback('close', function(data, cb)
	cb('ok')
	HackStatus = data
	Citizen.Wait(500)
	ClearPedTasks(PlayerPedId())
	Citizen.Wait(500)
	DeleteObject(Tablet)
	if HackStatus then
		NotifyMessage = 'Hack Successful!'
		NotifyType = 'success'
		TriggerServerEvent("decrypto:server:givecash")
		local chance = math.random()
		if chance < Config.Chance then
			TriggerServerEvent('police:server:policeAlert', "ATM Suspicious Activity")
		end
	else
		NotifyMessage = 'Hack Failed!'
		NotifyType = 'error'
		TriggerServerEvent('police:server:policeAlert', "ATM Suspicious Activity")
	end
	ESX.ShowNotification(NotifyMessage)
	SetNuiFocus(false, false)
	ClearPedTasks(PlayerPedId())
	DeleteObject(tablet)
	TriggerServerEvent("decrypto:server:removeitem", "hackcard")
end)


-- Events

RegisterNetEvent('decrypto:client:starthack')
AddEventHandler('decrypto:client:starthack', function()
	ATMHack()
end)


-- Functions

function ATMHack()
	playerPed = PlayerPedId()
	playerCoords = GetEntityCoords(playerPed, true)
	local nearATM = false
	local hackStarted = false
	local beenHacked = false
	ESX.TriggerServerCallback("decrypto:server:hasitem", function(hasItem)
		if(hasItem) then
			for k, v in pairs(Config.ATMModelsString) do
				print(v)
				local hash = GetHashKey(v)
				print(hash)
				Citizen.Wait(50)
				nearATM = IsObjectNearPoint(hash, playerCoords.x, playerCoords.y, playerCoords.z, 1.5)
				print(nearATM)
				Citizen.Wait(50)
				if nearATM then
					hackStarted = true
					local ATM = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 1.5, hash, false, false, false)
					for i = 1, #Hacked do
						if Hacked[i] == ATM then
							beenHacked = true
						end
					end
					if not beenHacked then
						RequestAnimDict('amb@prop_human_atm@male@enter')
						while not HasAnimDictLoaded('amb@prop_human_atm@male@enter') do
							Citizen.Wait(5)
						end
						if HasAnimDictLoaded('amb@prop_human_atm@male@enter') then
							TaskPlayAnim(playerPed, 'amb@prop_human_atm@male@enter', "enter", 1.0,-1.0, 3000, 1, 1, true, true, true)
							Citizen.Wait(1000)
							Tablet = CreateObject(GetHashKey("hei_prop_dlc_tablet"), 0, 0, 0, true, true, true)
							AttachEntityToEntity(Tablet, playerPed, GetPedBoneIndex(GetPlayerPed(-1), 18905), 0.20, 0.12, 0.05, 58.0, 122.0, 180.0, true, true, false, true, 1, true)
							RequestAnimDict('missfam4')
							while not HasAnimDictLoaded('missfam4') do
								Citizen.Wait(5)
							end
							if HasAnimDictLoaded('missfam4') then
								TaskPlayAnim(playerPed, "missfam4", "base", 1.0, 4.0, -1, 33, 0.0, false, false, false)
								Citizen.Wait(2000)
							end
						end
						table.insert(Hacked, ATM)
						MiniGame.Open()
					else
						ESX.ShowNotification('Already hacked!')
					end
				else
					if not hackStarted and k == #Config.ATMModelsString then
						ESX.ShowNotification('You cannot do that here.')
					end
				end
			end
		else
			ESX.ShowNotification('You are missing something!')
		end
	end, 'decryptor', 'hackcard')
end
