return {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "moyiz/blink-emoji.nvim",
        "L3MON4D3/LuaSnip",
    },
    event = { "InsertEnter", "LspAttach" },

    opts = {
        keymap = {
            preset = "default",
            ["<CR>"] = { "accept", "fallback" },
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
        },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "normal",
        },

        completion = {
            accept = {
                auto_brackets = { enabled = true },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
                window = {
                    border = "single",
                    min_width = 20,
                    max_width = 75,
                    max_height = 15,
                },
            },
            menu = {
                draw = {
                    treesitter = { "lsp" },
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", "kind" },
                        -- { "source_name" },
                    },
                },
                border = "single",
            },
            ghost_text = { enabled = true },
        },

        signature = {
            enabled = true,
            window = { border = "single" },
        },

        snippets = {
            preset = "luasnip",
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer", "emoji" },
            providers = {
                emoji = {
                    module = "blink-emoji",
                    name = "Emoji",
                    opts = {
                        insert = true,
                        trigger = function()
                            return { ":" }
                        end,
                    },
                    should_show_items = function()
                        return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
                    end,
                },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
