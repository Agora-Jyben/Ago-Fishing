fx_version 'adamant'

game 'gta5'


shared_scripts {
    "config.lua"
}

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    '@es_extended/locale.lua',
    'client/*.lua'
}

server_scripts {
    '@es_extended/locale.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/*.lua'
}

client_scripts {
    'aProgressBar/config.lua',
    'aProgressBar/utils.lua',
    'aProgressBar/client.lua',
}

ui_page 'aProgressBar/ui/ui.html'

files {
    'aProgressBar/ui/ui.html',
    'aProgressBar/ui/fonts/*.ttf',
    'aProgressBar/ui/css/*.css',
    'aProgressBar/ui/js/*.js',
}

exports {
    "Start",
    "Custom",
    "Stop",
    "Static",
    "Linear",
    "MiniGame"
}
