fx_version "cerulean"
game "gta5"
lua54 "yes"

name "Gun Rack"
author "gigo"
version "1.0.0"
description "Gun rack for genesis"

shared_scripts {
    "config.lua",
    "@ox_lib/init.lua",
}

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    "client/*.lua",
}

server_scripts {
    "server/*.lua",
}