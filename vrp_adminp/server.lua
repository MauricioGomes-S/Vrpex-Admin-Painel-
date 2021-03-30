local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local pontostaff = "https://discord.com/api/webhooks/823894815498305561/6R1KdQVyn10EZCzK2qt_F2Ly8b2ILjF48V1GkG82--Uquv14RUnmNG_E1B_Wxl6-_6sz"
local logpaineladmin = "https://discord.com/api/webhooks/823894815498305561/6R1KdQVyn10EZCzK2qt_F2Ly8b2ILjF48V1GkG82--Uquv14RUnmNG_E1B_Wxl6-_6sz"
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
--------------------------------------------------------- Entrar em Serviço Staff -------------------------------------------------------------------------		

RegisterCommand('staff',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"staff.permissao") then
		vRP.addUserGroup(user_id,"Off-staff")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		PerformHttpRequest(pontostaff, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 
					title = "REGISTRO STAFF: SAIU DE SERVIÇO",
					thumbnail = {
						url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
					}, 
					fields = {
						{ 
							name = "**ID:**", 
							value = "` "..user_id.." ` "
						},
						{ 
							name = "**IP:**", 
							value = "` "..GetPlayerEndpoint(source).." ` "
						},
						{
							name = "**NOME**",
							value = "` "..identity.name.." "..identity.firstname.. " ` "
						},
					}, 
					footer = { 
						text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
						icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
					},
					color = 16725812 
				}
			}
		}), { ['Content-Type'] = 'application/json' })

	elseif vRP.hasPermission(user_id,"off-staff.permissao") then
		vRP.addUserGroup(user_id,"Staff")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		print("entrando")
		PerformHttpRequest(pontostaff, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 
					title = "REGISTRO STAFF: ENTROU EM SERVIÇO",
					thumbnail = {
						url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
					}, 
					fields = {
						{ 
							name = "**ID:**", 
							value = "` "..user_id.." ` "
						},
						{ 
							name = "**IP:**", 
							value = "` "..GetPlayerEndpoint(source).." ` "
						},
						{
							name = "**NOME**",
							value = "` "..identity.name.." "..identity.firstname.. " ` "
						},
					}, 
					footer = { 
						text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
						icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
					},
					color = 3512319
				}
			}
		}), { ['Content-Type'] = 'application/json' })

	end
end)

src = {}
Tunnel.bindInterface("vrp_adminp",src)
vCLIENT = Tunnel.getInterface("vrp_adminp")

function src.dados()
    local users = vRP.getUsers()
    local usuarios = {}
    for k,v in pairs(users) do
        local id = vRP.getUserSource(parseInt(k))
        local user_id =  vRP.getUserId(id)
        local identity = vRP.getUserIdentity(user_id)
        local nome = identity.name

        usuarios[k] = {nome, user_id}
    end 
	return usuarios
end


function src.CheckPerm()
	print("This Script Has Been Producted BY Tio Mitsu<3 Discord:MITSU#3867")
    local source = source
    local user_id = vRP.getUserId(source)
        if  vRP.hasPermission(user_id,"staff.permissao") then 
            return true
        end
        return false
end
RegisterNetEvent("pgod")
AddEventHandler("pgod",function(args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nsource = vRP.getUserSource(parseInt(args))
	local user_id2 = vRP.getUserId(nsource)
	local identity2 = vRP.getUserIdentity(user_id2)

        if args then
            local nplayer = vRP.getUserSource(parseInt(args))
            if nplayer then
                vRPclient.killGod(nplayer)
				vRPclient.setHealth(nplayer,400)
				
                TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)

				vRP.varyThirst(nplayer,-15)
				vRP.varyHunger(nplayer,-15)


				PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 
							title = "LOG ADMIN PAINEL : GOD",
							thumbnail = {
								url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
							}, 
							fields = {
								{ 
									name = "**ID:**", 
									value = "` "..user_id.." ` "
								},
								{ 
									name = "**IP:**", 
									value = "` "..GetPlayerEndpoint(source).." ` "
								},
								{
									name = "**NOME**",
									value = "` "..identity.name.." "..identity.firstname.. " ` "
								},
								{ 
									name = "**USOU COMANDO GOD EM :**",
									value = "`ID: "..user_id2.." ` "
								},
								{
									name = "**NOME**",
									value = "` "..identity2.name.." "..identity2.firstname.. " ` "
								},
							}, 
							footer = { 
								text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
								icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
							},
							color = 9886173 
						}
					}
				}), { ['Content-Type'] = 'application/json' })
            end
        end
end)

RegisterNetEvent("caros")
AddEventHandler("caros",function(args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
		local user_id = vRP.getUserId(source)
		if user_id then
			local identity = vRP.getUserIdentity(user_id)
			if vRP.hasPermission(user_id,"mindmaster.permissao") then
				if args then
					TriggerClientEvent('spawncaradmp',source,args)
					TriggerEvent("setPlateEveryone",identity.registration)
					PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{ 
								title = "LOG ADMIN PAINEL : PUXOU UM VEICULO",
								thumbnail = {
									url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
								}, 
								fields = {
									{ 
										name = "**ID:**", 
										value = "` "..user_id.." ` "
									},
									{ 
										name = "**IP:**", 
										value = "` "..GetPlayerEndpoint(source).." ` "
									},
									{
										name = "**NOME**",
										value = "` "..identity.name.." "..identity.firstname.. " ` "
									},
									{
										name = "**Veiculo**",
										value = "`"..args.. " ` "
									},

								}, 
								footer = { 
									text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
									icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
								},
								color = 9886173 
							}
						}
					}), { ['Content-Type'] = 'application/json' })
				end
			end
		end
end)
RegisterNetEvent("debugvida")
AddEventHandler('debugvida',function(args)
		local source = source
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local nsource = vRP.getUserSource(parseInt(args))
		local user_id2 = vRP.getUserId(nsource)
		local identity2 = vRP.getUserIdentity(user_id2)
		local sorce = vRP.getUserSource(args)
		vRPclient._setCustomization(sorce,vRPclient.getCustomization(sorce))
		vRP.removeCloak(sorce)
		PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 
					title = "LOG ADMIN PAINEL : GOD",
					thumbnail = {
						url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
					}, 
					fields = {
						{ 
							name = "**ID:**", 
							value = "` "..user_id.." ` "
						},
						{ 
							name = "**IP:**", 
							value = "` "..GetPlayerEndpoint(source).." ` "
						},
						{
							name = "**NOME**",
							value = "` "..identity.name.." "..identity.firstname.. " ` "
						},
						{ 
							name = "**USOU COMANDO BVIDA EM :**",
							value = "`ID: "..user_id2.." ` "
						},
						{
							name = "**NOME**",
							value = "` "..identity2.name.." "..identity2.firstname.. " ` "
						},
					}, 
					footer = { 
						text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
						icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
					},
					color = 9886173 
				}
			}
		}), { ['Content-Type'] = 'application/json' })
end)

RegisterNetEvent("repecar")
AddEventHandler("repecar",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local user_id = vRP.getUserId(source)
	local user_id = vRP.getUserId(source)
	local vehicle = vRPclient.getNearestVehicle(source,11)
	if vehicle then
		if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
			TriggerClientEvent('reparar',source)
			PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "LOG ADMIN PAINEL : REPAROU UM VEICULO",
						thumbnail = {
							url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
						}, 
						fields = {
							{ 
								name = "**ID:**", 
								value = "` "..user_id.." ` "
							},
							{ 
								name = "**IP:**", 
								value = "` "..GetPlayerEndpoint(source).." ` "
							},
							{
								name = "**NOME**",
								value = "` "..identity.name.." "..identity.firstname.. " ` "
							},
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
						},
						color = 9886173 
					}
				}
			}), { ['Content-Type'] = 'application/json' })
		end
	end
end)

RegisterCommand('carcolor',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mindmaster.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source,7)
        if vehicle then
            local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
            rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
            local r,g,b = table.unpack(splitString(rgb," "))
            TriggerClientEvent('vcolorv',source,vehicle,tonumber(r),tonumber(g),tonumber(b))
            TriggerClientEvent('Notify',source,"sucesso","Cor Alterada")
        end
    end
end)

RegisterNetEvent("kill")
AddEventHandler("kill",function( args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nsource = vRP.getUserSource(parseInt(args))
	local user_id2 = vRP.getUserId(nsource)
	local identity2 = vRP.getUserIdentity(user_id2)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao")  then
		if args then
			local nplayer = vRP.getUserSource(parseInt(args))
			if nplayer then
				vRPclient.setHealth(nplayer,0)
				PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 
							title = "LOG ADMIN PAINEL : KILL",
							thumbnail = {
								url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
							}, 
							fields = {
								{ 
									name = "**ID:**", 
									value = "` "..user_id.." ` "
								},
								{ 
									name = "**IP:**", 
									value = "` "..GetPlayerEndpoint(source).." ` "
								},
								{
									name = "**NOME**",
									value = "` "..identity.name.." "..identity.firstname.. " ` "
								},
								{ 
									name = "**MATOU:**",
									value = "`ID: "..user_id2.." ` "
								},
								{
									name = "**NOME**",
									value = "` "..identity2.name.." "..identity2.firstname.. " ` "
								},
							}, 
							footer = { 
								text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
								icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
							},
							color = 9886173 
						}
					}
				}), { ['Content-Type'] = 'application/json' })


			end
		end
	end
end)

RegisterNetEvent("grupoadd")
AddEventHandler("grupoadd",function(args,param)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args))
	local user_id2 = vRP.getUserId(nplayer)
	local identity2 = vRP.getUserIdentity(user_id2)

	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
		if args and param then
			if vRP.hasPermission(user_id,"administrador.permissao") and param == "mindmaster" then 
				TriggerClientEvent("Notify",source,"Negado","Você Não Pode Dar este grupo.")
			else 	
				vRP.addUserGroup(parseInt(args),param)
				TriggerClientEvent("Notify",source,"sucesso","Voce setou o passaporte <b>"..parseInt(args).."</b> no grupo <b>"..param.."</b>.")
				PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 
							title = "LOG ADMIN PAINEL : GROUP",
							thumbnail = {
								url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
							}, 
							fields = {
								{ 
									name = "**ID:**", 
									value = "` "..user_id.." ` "
								},
								{ 
									name = "**IP:**", 
									value = "` "..GetPlayerEndpoint(source).." ` "
								},
								{
									name = "**NOME**",
									value = "` "..identity.name.." "..identity.firstname.. " ` "
								},
								{ 
									name = "**SETOU NO GRUPO : "..param.."**",
									value = "`ID: "..user_id2.." ` "
								},
								{
									name = "**NOME**",
									value = "` "..identity2.name.." "..identity2.firstname.. " ` "
								},
							}, 
							footer = { 
								text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
								icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
							},
							color = 9886173 
						}
					}
				}), { ['Content-Type'] = 'application/json' })
			end
		end
	end
end)
RegisterNetEvent("gruporemove")
AddEventHandler("gruporemove",function(args,param)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args))
	local user_id2 = vRP.getUserId(nplayer)
	local identity2 = vRP.getUserIdentity(user_id2)

	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
		if args and param then
			
			if vRP.hasPermission(user_id,"administrador.permissao") and param == "mindmaster" then 
				TriggerClientEvent("Notify",source,"Negado","Você Não Pode Retirar este grupo.")
				
			elseif nplayer then
				print(args,param)
					vRP.removeUserGroup(parseInt(args),param)
					TriggerClientEvent("Notify",source,"sucesso","Voce removeu o passaporte <b>"..parseInt(args).."</b> do grupo <b>"..param.."</b>.")
						PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{ 
									title = "LOG ADMIN PAINEL : UNGROUP",
									thumbnail = {
										url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
									}, 
									fields = {
										{ 
											name = "**ID:**", 
											value = "` "..user_id.." ` "
										},
										{ 
											name = "**IP:**", 
											value = "` "..GetPlayerEndpoint(source).." ` "
										},
										{
											name = "**NOME**",
											value = "` "..identity.name.." "..identity.firstname.. " ` "
										},
										{ 
											name = "**RETIROU DO GRUPO : "..param.."**",
											value = "`ID: "..user_id2.." ` "
										},
										{
											name = "**NOME**",
											value = "` "..identity2.name.." "..identity2.firstname.. " ` "
										},
									}, 
									footer = { 
										text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
										icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
									},
									color = 9886173 
								}
							}
							}), { ['Content-Type'] = 'application/json' })
			else
				local data = vRP.getUserDataTable(parseInt(args))
				if data.groups then
					data.groups[param] = nil
				end
				vRP.setUData(parseInt(args),"vRP:datatable",json.encode(data)).
				TriggerClientEvent("Notify",source,"sucesso","Voce removeu o passaporte <b>"..parseInt(args).."</b> do grupo <b>"..param.."</b>.")
				PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "LOG ADMIN PAINEL : UNGROUP",
						thumbnail = {
							url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
						}, 
						fields = {
							{ 
								name = "**ID:**", 
								value = "` "..user_id.." ` "
							},
							{ 
								name = "**IP:**", 
								value = "` "..GetPlayerEndpoint(source).." ` "
							},
							{
								name = "**NOME**",
								value = "` "..identity.name.." "..identity.firstname.. " ` "
							},
							{ 
								name = "**RETIROU DO GRUPO : "..param.."**",
								value = "`ID: "..user_id2.." ` "
							},
							{
								name = "**NOME**",
								value = "` "..identity2.name.." "..identity2.firstname.. " ` "
							},
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
						},
						color = 9886173 
					}
				}
				}), { ['Content-Type'] = 'application/json' })
			end
		end
	end
end)




RegisterNetEvent("add:carro:garagem")
AddEventHandler("add:carro:garagem",function(args,param)

end)


RegisterNetEvent("placamudar")
AddEventHandler("placamudar",function(args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"mindmaster.permissao") then
	
        if user_id then
            if args then
                TriggerClientEvent("setPlateText",source,args)
				PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 
							title = "LOG ADMIN PAINEL : MUDOU A PLACA DE UM VEICULO",
							thumbnail = {
								url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
							}, 
							fields = {
								{ 
									name = "**ID:**", 
									value = "` "..user_id.." ` "
								},
								{ 
									name = "**IP:**", 
									value = "` "..GetPlayerEndpoint(source).." ` "
								},
								{
									name = "**NOME**",
									value = "` "..identity.name.." "..identity.firstname.. " ` "
								},
								{
									name = "**MUDOU A PLACA PARA**",
									value = "`"..args.. " ` "
								},

							}, 
							footer = { 
								text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
								icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
							},
							color = 9886173 
						}
					}
				}), { ['Content-Type'] = 'application/json' })
				
            end
        end
    end
end)


RegisterNetEvent("apagar")
AddEventHandler("apagar",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			vCLIENT.deleteVehicle(source,vehicle)
			PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "LOG ADMIN PAINEL : DV ",
						thumbnail = {
							url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
						}, 
						fields = {
							{ 
								name = "**ID:**", 
								value = "` "..user_id.." ` "
							},
							{ 
								name = "**IP:**", 
								value = "` "..GetPlayerEndpoint(source).." ` "
							},
							{
								name = "**NOME**",
								value = "` "..identity.name.." "..identity.firstname.. " ` "
							},
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
						},
						color = 9886173 
					}
				}
			}), { ['Content-Type'] = 'application/json' })
		end
	end
end)
-----
local froze = false 

RegisterNetEvent("congelar")
AddEventHandler("congelar",function( args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nsource = vRP.getUserSource(parseInt(args))
	local user_id2 = vRP.getUserId(nsource)
	local identity2 = vRP.getUserIdentity(user_id2)
	local src2 = vRP.getUserSource(args)

		if args then
			if not froze then 

				play = FreezeEntityPosition(src2, true)
				froze = true
			else 

				play = FreezeEntityPosition(src2, false)
				froze = false

			end
			
			PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "LOG ADMIN PAINEL : CONGELAR",
						thumbnail = {
							url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
						}, 
						fields = {
							{ 
								name = "**ID:**", 
								value = "` "..user_id.." ` "
							},
							{ 
								name = "**IP:**", 
								value = "` "..GetPlayerEndpoint(source).." ` "
							},
							{
								name = "**NOME**",
								value = "` "..identity.name.." "..identity.firstname.. " ` "
							},
							{ 
								name = "**USOU COMANDO CONGELAR :cold_face: EM :**",
								value = "`ID: "..user_id2.." ` "
							},
							{
								name = "**NOME**",
								value = "` "..identity2.name.." "..identity2.firstname.. " ` "
							},
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
						},
						color = 9886173 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

		end
end)    


RegisterNetEvent("noclip")
AddEventHandler("noclip",function( args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nsource = vRP.getUserSource(parseInt(args))
	local user_id2 = vRP.getUserId(nsource)
	local identity2 = vRP.getUserIdentity(user_id2)
	local src2 = vRP.getUserSource(args)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
			vRPclient.toggleNoclip(src2)
			PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 
					title = "LOG ADMIN PAINEL : NOCLIP",
					thumbnail = {
						url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
					}, 
					fields = {
						{ 
							name = "**ID:**", 
							value = "` "..user_id.." ` "
						},
						{ 
							name = "**IP:**", 
							value = "` "..GetPlayerEndpoint(source).." ` "
						},
						{
							name = "**NOME**",
							value = "` "..identity.name.." "..identity.firstname.. " ` "
						},
						{ 
							name = "**USOU COMANDO NOCLIP EM :**",
							value = "`ID: "..user_id2.." ` "
						},
						{
							name = "**NOME**",
							value = "` "..identity2.name.." "..identity2.firstname.. " ` "
						},
					}, 
					footer = { 
						text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
						icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
					},
					color = 9886173 
				}
			}
		}), { ['Content-Type'] = 'application/json' })
	end
end)

RegisterNetEvent("tptome")
AddEventHandler("tptome",function( args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nsource = vRP.getUserSource(parseInt(args))
	local user_id2 = vRP.getUserId(nsource)
	local identity2 = vRP.getUserIdentity(user_id2)

	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
		if args then
			local tplayer = vRP.getUserSource(parseInt(args))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then
				vRPclient.teleport(tplayer,x,y,z)
				PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 
							title = "LOG ADMIN PAINEL : TPTOME",
							thumbnail = {
								url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
							}, 
							fields = {
								{ 
									name = "**ID:**", 
									value = "` "..user_id.." ` "
								},
								{ 
									name = "**IP:**", 
									value = "` "..GetPlayerEndpoint(source).." ` "
								},
								{
									name = "**NOME**",
									value = "` "..identity.name.." "..identity.firstname.. " ` "
								},
								{ 
									name = "**USOU COMANDO TPTOME EM :**",
									value = "`ID: "..user_id2.." ` "
								},
								{
									name = "**NOME**",
									value = "` "..identity2.name.." "..identity2.firstname.. " ` "
								},
							}, 
							footer = { 
								text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
								icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
							},
							color = 9886173 
						}
					}
				}), { ['Content-Type'] = 'application/json' })
			end
		end
	end
end)

RegisterNetEvent("tpto")
AddEventHandler("tpto",function( args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nsource = vRP.getUserSource(parseInt(args))
	local user_id2 = vRP.getUserId(nsource)
	local identity2 = vRP.getUserIdentity(user_id2)

	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
		if args then
			local tplayer = vRP.getUserSource(parseInt(args))
			if tplayer then

				vRPclient.teleport(source,vRPclient.getPosition(tplayer))
				PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 
							title = "LOG ADMIN PAINEL : TPTO",
							thumbnail = {
								url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
							}, 
							fields = {
								{ 
									name = "**ID:**", 
									value = "` "..user_id.." ` "
								},
								{ 
									name = "**IP:**", 
									value = "` "..GetPlayerEndpoint(source).." ` "
								},
								{
									name = "**NOME**",
									value = "` "..identity.name.." "..identity.firstname.. " ` "
								},
								{ 
									name = "**USOU COMANDO TPTO EM :**",
									value = "`ID: "..user_id2.." ` "
								},
								{
									name = "**NOME**",
									value = "` "..identity2.name.." "..identity2.firstname.. " ` "
								},
							}, 
							footer = { 
								text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
								icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
							},
							color = 9886173 
						}
					}
				}), { ['Content-Type'] = 'application/json' })
			end
		end
	end
end)


RegisterNetEvent("kick")
AddEventHandler("kick",function( args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nsource = vRP.getUserSource(parseInt(args))
	local user_id2 = vRP.getUserId(nsource)
	local identity2 = vRP.getUserIdentity(user_id2)

if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
	if args then
		local id = vRP.getUserSource(parseInt(args))
		if id then
			vRP.kick(id,"Você foi expulso da cidade.")
			TriggerClientEvent("Notify",source,"sucesso","Voce kickou o passaporte <b>"..args.."</b> da cidade.")
			
			PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "LOG ADMIN PAINEL : KICK",
						thumbnail = {
							url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
						}, 
						fields = {
							{ 
								name = "**ID:**", 
								value = "` "..user_id.." ` "
							},
							{
								name = "**NOME**",
								value = "` "..identity.name.." "..identity.firstname.. " ` "
							},
							{ 
								name = "**USOU COMANDO KICK EM :**",
								value = "`ID: "..user_id2.." ` "
							},
							{
								name = "**NOME**",
								value = "` "..identity2.name.." "..identity2.firstname.. " ` "
							},
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
						},
						color = 9886173 
					}
				}
			}), { ['Content-Type'] = 'application/json' })
		end
	end
end
end)

RegisterNetEvent("ban")
AddEventHandler("ban",function( args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nsource = vRP.getUserSource(parseInt(args))
	local user_id2 = vRP.getUserId(nsource)
	local identity2 = vRP.getUserIdentity(user_id2)


if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
	if args then

		local t_user_id = vRP.getUserSource(parseInt(args))

		vRP.setBanned(parseInt(args),true)
		vRP.kick(t_user_id,"Você foi banido! [ Suas Ações Não Estão De Acordo Com Nossas Regras ]")
		TriggerClientEvent("Notify",source,"sucesso","Voce baniu o passaporte <b>"..args.."</b> da cidade.")

		PerformHttpRequest(logpaineladmin, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 
					title = "LOG ADMIN PAINEL : BANIU",
					thumbnail = {
						url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473"
					}, 
					fields = {
						{ 
							name = "**ID:**", 
							value = "` "..user_id.." ` "
						},
						{ 
							name = "**IP:**", 
							value = "` "..GetPlayerEndpoint(source).." ` "
						},
						{
							name = "**NOME**",
							value = "` "..identity.name.." "..identity.firstname.. " ` "
						},
						{ 
							name = "**USOU COMANDO BANIR EM :**",
							value = "`ID: "..user_id2.." ` "
						},
						{
							name = "**NOME**",
							value = "` "..identity2.name.." "..identity2.firstname.. " ` "
						},
					}, 
					footer = { 
						text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
						icon_url = "https://media.discordapp.net/attachments/782516329705111553/820789482890330112/03.png?width=686&height=473" 
					},
					color = 9886173 
				}
			}
		}), { ['Content-Type'] = 'application/json' })
	end
end
end)

local vehlist = {}

function src.tryDelete(vehid,vehengine,vehbody,vehfuel)
	if vehlist[vehid] and vehid ~= 0 then
		local user_id = vehlist[vehid][1]
		local vehname = vehlist[vehid][2]
		local player = vRP.getUserSource(user_id)
		if player then
			vCLIENT.syncNameDelete(player,vehname)
		end

		if vehengine <= 100 then
			vehengine = 100
		end

		if vehbody <= 100 then
			vehbody = 100
		end

		if vehfuel >= 100 then
			vehfuel = 100
		end

		local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = vehname })
		if vehicle[1] ~= nil then
			vRP.execute("creative/set_update_vehicles",{ user_id = parseInt(user_id), vehicle = vehname, engine = parseInt(vehengine), body = parseInt(vehbody), fuel = parseInt(vehfuel) })
		end
	end
	vCLIENT.syncVehicle(-1,vehid)
end