local add_on_event = require('vim-pack').add_on_event

add_on_event('LspAttach', {
    {
        src = 'j-hui/fidget.nvim',
        opts = {
            progress = {
                suppress_on_insert = true,
                ignore_done_already = false,
                ignore_empty_message = false,
                display = {
                    progress_icon = {
                        pattern = {
                            '⠋',
                            '⠙',
                            '⠹',
                            '⠸',
                            '⠼',
                            '⠴',
                            '⠦',
                            '⠧',
                            '⠇',
                            '⠏',
                        },
                    },
                },
            },

            notification = {
                override_vim_notify = true,
                window = {
                    relative = 'editor', -- where to anchor, either "win" or "editor"
                    winblend = 0, -- winblend for the window
                    border = 'none',
                },
            },
        },
    },
})
