fx_version 'cerulean'
game 'gta5'

name        't.ponsumri'
author      'https://github.com/taropongsumri'
version     '1.0.0'
description 'Default Resource'

dependencies {
    'ox_lib',
    'es_extended',
    'esx_notify',
}

shared_scripts {
    'shared/default.config.lua',
    'shared/car.config.lua',
    'shared/handsup.config.lua',
    'core/framework.lua',
}

server_scripts {
    '@ox_lib/init.lua',
    'core/sv_helpers.lua',
}

client_scripts {
    'core/module/cl_default.lua',
    'core/module/cl_blips.lua',
    'core/module/cl_car.lua',
    'core/module/cl_crouched.lua',
    'core/module/cl_handsup.lua',
    'core/module/cl_hurt.lua',
    'core/module/cl_slide.lua',
    'core/module/cl_pointer.lua',
    'core/module/cl_shifte.lua',
}
