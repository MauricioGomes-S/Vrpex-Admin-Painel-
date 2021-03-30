resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Mitsui é brasbo'


client_scripts {
	'@vrp/lib/utils.lua',
	'client.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua'
}
ui_page {'ui/index.html'
}

files {
	'ui/index.html',
	'ui/style.css'
}

--dependency 'essentialmode'