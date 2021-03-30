local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

------conexao 
src = {}
Tunnel.bindInterface("vrp_adminp",src)
vSERVER = Tunnel.getInterface("vrp_adminp")

-------------



Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)		
		if IsControlJustPressed(0,167) then
			if vSERVER.CheckPerm() then
				SetNuiFocus(true, true)
				SendNUIMessage({type = 'open', players = getPlayers()})
			end
		end
	end
end) 


RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false)
end)

RegisterNUICallback('set', function(data, cb)
	TriggerServerEvent('es_admin:set', data.type, data.user, data.param)
	print(data.type, data.user, data.param)

	---tudo começa a partir do data.type  pu seja usar o data.type == "comando ex "ban" then  Setagem--" 
end)
 
RegisterNUICallback('carro', function(data, cb)
	TriggerServerEvent('http://vrp_adminp/carro', data.type, data.param)
	print(data.type , data.param)
	
	if data.type == "car" then 
		TriggerServerEvent("caros",data.param)
		
	elseif data.type == "carplaca" then 
		TriggerServerEvent("placamudar",data.param)
	elseif data.type == "carcor" then 
		TriggerEvent('cordocarro',data.param)
	end

	
end)
RegisterNUICallback('set', function(data)

	if data.type == "group" then 
		print(data.param,data.user,"certo")
		TriggerServerEvent("grupoadd",data.user,data.param)
	elseif data.type == "ungroup" then 
		TriggerServerEvent("gruporemove",data.user,data.param)

	elseif data.type == "carrog" then 
		TriggerServerEvent("add:carro:garagem",data.user,data.param)
	elseif data.type == "advertencia" then 
		
		TriggerServerEvent("",data.user,data.param)
	elseif data.type == "bank" then 

		TriggerServerEvent("",data.user,data.param)

	end


end)

RegisterNUICallback('quick', function(data, cb)
	print(data.type , data.id) 
	if data.type == "god" then 
		TriggerServerEvent("pgod",data.id)
	elseif data.type == "kill" then 
		TriggerServerEvent("kill",data.id)
	elseif data.type == "kick" then 
		TriggerServerEvent("kick",data.id)
	elseif data.type == "ban" then 
		TriggerServerEvent("ban",data.id)
	elseif data.type == "congelar" then 
		TriggerServerEvent("congelar",data.id)
	elseif data.type == "tpto" then 
		TriggerServerEvent("tpto",data.id)
	elseif data.type == "tptome" then 
		TriggerServerEvent("tptome",data.id)
	elseif data.type == "noclip" then 
		TriggerServerEvent("noclip",data.id)
	elseif data.type == "crash" then
		TriggerServerEvent("debugvida",data.id) 
	elseif data.type == "tunar" then 
		TriggerEvent("vehtuningadminp")
	elseif data.type == "fix" then 
		TriggerServerEvent("repecar")
	elseif data.type == "deletar" then
		TriggerServerEvent("apagar")

	elseif data.type == "god_all" then
		TriggerServerEvent("")
	elseif data.type == "bring_all" then
		TriggerServerEvent("")
	elseif data.type == "slay_all" then
		TriggerServerEvent("")
	end 
end)


function getPlayers()
    local players = {}
	local usuarios = {}
	TriggerServerEvent("dados",usuarios)
		usuarios = vSERVER.dados()
    for k, v in pairs(usuarios) do
        print(v[1],v[2])
		nome = v[1]
		user_id = v[2]
       table.insert(players, {id = user_id, name = nome })
    end
	return players
end



-------Alguns Request -----
RegisterNetEvent("vehtuningadminp")
AddEventHandler("vehtuningadminp",function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if IsEntityAVehicle(vehicle) then
		SetVehicleModKit(vehicle,0)
		SetVehicleWheelType(vehicle,7)
		SetVehicleMod(vehicle,0,GetNumVehicleMods(vehicle,0)-1,false)
		SetVehicleMod(vehicle,1,GetNumVehicleMods(vehicle,1)-1,false)
		SetVehicleMod(vehicle,2,GetNumVehicleMods(vehicle,2)-1,false)
		SetVehicleMod(vehicle,3,GetNumVehicleMods(vehicle,3)-1,false)
		SetVehicleMod(vehicle,4,GetNumVehicleMods(vehicle,4)-1,false)
		SetVehicleMod(vehicle,5,GetNumVehicleMods(vehicle,5)-1,false)
		SetVehicleMod(vehicle,6,GetNumVehicleMods(vehicle,6)-1,false)
		SetVehicleMod(vehicle,7,GetNumVehicleMods(vehicle,7)-1,false)
		SetVehicleMod(vehicle,8,GetNumVehicleMods(vehicle,8)-1,false)
		SetVehicleMod(vehicle,9,GetNumVehicleMods(vehicle,9)-1,false)
		SetVehicleMod(vehicle,10,GetNumVehicleMods(vehicle,10)-1,false)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,14,16,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-2,false)
		SetVehicleMod(vehicle,16,GetNumVehicleMods(vehicle,16)-1,false)
		ToggleVehicleMod(vehicle,17,true)
		ToggleVehicleMod(vehicle,18,true)
		ToggleVehicleMod(vehicle,19,true)
		ToggleVehicleMod(vehicle,20,true)
		ToggleVehicleMod(vehicle,21,true)
		ToggleVehicleMod(vehicle,22,true)
		SetVehicleMod(vehicle,23,1,false)
		SetVehicleMod(vehicle,24,1,false)
		SetVehicleMod(vehicle,25,GetNumVehicleMods(vehicle,25)-1,false)
		SetVehicleMod(vehicle,27,GetNumVehicleMods(vehicle,27)-1,false)
		SetVehicleMod(vehicle,28,GetNumVehicleMods(vehicle,28)-1,false)
		SetVehicleMod(vehicle,30,GetNumVehicleMods(vehicle,30)-1,false)
		SetVehicleMod(vehicle,33,GetNumVehicleMods(vehicle,33)-1,false)
		SetVehicleMod(vehicle,34,GetNumVehicleMods(vehicle,34)-1,false)
		SetVehicleMod(vehicle,35,GetNumVehicleMods(vehicle,35)-1,false)
		SetVehicleMod(vehicle,38,GetNumVehicleMods(vehicle,38)-1,true)
		SetVehicleTyreSmokeColor(vehicle,0,0,0)
        SetVehicleWindowTint(vehicle,1)
        SetVehicleTyresCanBurst(vehicle,false)
        SetVehicleNumberPlateText(vehicle,"PREFEITO")
        SetVehicleNumberPlateTextIndex(vehicle,5)
        SetVehicleModColor_1(vehicle,0,0,0)
        SetVehicleModColor_2(vehicle,0,0)
        SetVehicleColours(vehicle,0,0)
        SetVehicleExtraColours(vehicle,0,0)
        SetVehicleNeonLightEnabled(vehicle,0,true)
        SetVehicleNeonLightEnabled(vehicle,1,true)
        SetVehicleNeonLightEnabled(vehicle,2,true)
        SetVehicleNeonLightEnabled(vehicle,3,true)
        SetVehicleNeonLightsColour(vehicle,0,0,0)
	end
end)

--------------------------------------
RegisterNetEvent('setPlateText')
AddEventHandler('setPlateText',function(plateText)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    if vehicle then
        SetVehicleNumberPlateText(vehicle,plateText)
    end
end)

function src.deleteVehicle(vehicle)
	if IsEntityAVehicle(vehicle) then
		vSERVER.tryDelete(VehToNet(vehicle),GetVehicleEngineHealth(vehicle),GetVehicleBodyHealth(vehicle),GetVehicleFuelLevel(vehicle))
	end
end
function src.syncVehicle(vehicle)
	if NetworkDoesNetworkIdExist(vehicle) then
		local v = NetToVeh(vehicle)
		if DoesEntityExist(v) and IsEntityAVehicle(v) then
			Citizen.InvokeNative(0xAD738C3085FE7E11,v,true,true)
			SetEntityAsMissionEntity(v,true,true)
			SetVehicleHasBeenOwnedByPlayer(v,true)
			NetworkRequestControlOfEntity(v)
			Citizen.InvokeNative(0xEA386986E786A54F,Citizen.PointerValueIntInitialized(v))
			DeleteEntity(v)
			DeleteVehicle(v)
			SetEntityAsNoLongerNeeded(v)
		end
	end
end

function src.syncNameDelete(vehname)
	if vehicle[vehname] then
		vehicle[vehname] = nil
		if DoesBlipExist(vehblips[vehname]) then
			RemoveBlip(vehblips[vehname])
			vehblips[vehname] = nil
		end
	end
end


RegisterNetEvent('spawncaradmp')
AddEventHandler('spawncaradmp',function(name)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		local ped = PlayerPedId()
		local nveh = CreateVehicle(mhash,GetEntityCoords(ped),GetEntityHeading(ped),true,false)

		NetworkRegisterEntityAsNetworked(nveh)
		while not NetworkGetEntityIsNetworked(nveh) do
			NetworkRegisterEntityAsNetworked(nveh)
			Citizen.Wait(1)
		end

		SetVehicleOnGroundProperly(nveh)
		SetVehicleAsNoLongerNeeded(nveh)
		SetVehicleIsStolen(nveh,false)
		SetPedIntoVehicle(ped,nveh,-1)
		SetVehicleNeedsToBeHotwired(nveh,false)
		SetEntityInvincible(nveh,false)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
		SetVehicleHasBeenOwnedByPlayer(nveh,true)
		SetVehRadioStation(nveh,"OFF")

		SetModelAsNoLongerNeeded(mhash)
	end
end)



RegisterNetEvent("adv")
AddEventHandler("adv",function(css,mensagem)
	SendNUIMessage({ css = css, mensagem = mensagem })
end)

