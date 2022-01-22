fx_version 'cerulean'
game 'gta5'

description 'QB-Weed'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/main.lua', 
    'client/drying.lua', 
    'client/processing.lua', 
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/processing.lua',
    'server/drying.lua',
}

lua54 'yes'