client_script '@X.Brain/Shared/xGuardPlayer.lua'
server_script '@X.Brain/Shared/xGuardServer.lua'


fx_version 'adamant'

game 'gta5'

ui_page "html/ui.html"

files {
    'html/ui.html',
    'html/ui.css',
    'html/ui.js'
}

client_scripts { 
	"client/main.lua",
	"config.lua" 
} 
 
server_scripts { 
	"server/server.lua",
	"config.lua" 
} 
