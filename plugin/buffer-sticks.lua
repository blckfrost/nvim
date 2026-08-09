local add_on_event = require('vim-pack').add_on_event

add_on_event('BufReadPre', {
    {
        src = 'ahkohd/buffer-sticks.nvim',
        config = function()
            local sticks = require('buffer-sticks')

            sticks.setup({
                highlights = {
                    active = { link = 'Statement' },
                    inactive = { link = 'Whitespace' },
                    active_modified = { link = 'Constant' },
                    alternate_modified = { link = 'Constant' },
                    inactive_modified = { link = 'Constant' },
                    label = { link = 'Comment' },
                },
            })
            sticks.show()
        end,
    },
})
