local add_on_event = require('vim-pack').add_on_event

add_on_event('UIEnter', {
    {
        src = 'lukas-reineke/indent-blankline.nvim',
        module_name = 'ibl',
        opts = {
            indent = {
                char = '⋅',
                repeat_linebreak = true,
            },

            scope = {
                enabled = false,
                show_start = true,
                show_end = true,
                char = '▏',
                priority = 500,
                injected_languages = true,
            },
        },
    },
})
