local add = require('vim-pack').add

-- Auto completion and snippets
add({
    { src = 'saghen/blink.lib', setup = false },
    {
        src = 'saghen/blink.cmp',
        opts = {
            keymap = {
                ['<CR>'] = { 'accept', 'fallback' },

                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<S-Tab>'] = { 'select_prev' },

                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

                ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },

                ['<C-f>'] = { 'snippet_forward', 'fallback' },
                ['<C-b>'] = { 'snippet_backward', 'fallback' },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'normal',
                kind_icons = require('icons').lspkind,
            },
            completion = {
                list = {
                    -- Insert items while navigating the completion list.
                    selection = { preselect = true, auto_insert = true },
                    max_items = 10,
                },

                documentation = {
                    auto_show = true,
                    window = {
                        border = 'single',
                        min_width = 20,
                        max_width = 60,
                        max_height = 12,
                    },
                },
                menu = {
                    draw = {
                        treesitter = { 'lsp' },
                        columns = {
                            { 'kind_icon' },
                            { 'label', 'label_description', gap = 1 },
                            { 'kind' },
                            { 'source_name' },
                        },
                    },
                    border = 'single',
                },
                ghost_text = { enabled = true },
            },

            signature = {
                enabled = true,
                window = { border = 'single' },
            },

            -- snippets = {
            --     preset = 'luasnip',
            -- },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
        on_setup = function()
            require('blink.cmp').build():pwait()
        end,
    },
})
