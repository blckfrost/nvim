return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    enabled = false,
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-emoji",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "Jezda1337/nvim-html-css",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
        { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local cmp_tailwind = require("tailwindcss-colorizer-cmp")

        cmp_tailwind.setup({
            color_square_width = 2,
        })

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            mapping = cmp.mapping.preset.insert({
                -- Scroll up and down the completion docs window
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),

                -- to trigger completion menu
                ["<C-Space>"] = cmp.mapping.complete(),

                -- to close completion menu
                ["<C-e>"] = cmp.mapping.close(),

                -- Select next/prev item on the list
                ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.ConfirmBehavior.Insert }),
                ["<S-Tab>"] = cmp.mapping.select_prev_item({
                    behavior = cmp.ConfirmBehavior.Insert,
                }),

                -- 'Enter' key to confirm completion
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),

                ["<C-g>"] = function()
                    if cmp.visible_docs() then
                        cmp.close_docs()
                    else
                        cmp.open_docs()
                    end
                end,
            }),

            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "nvim_lsp_signature_help" },
                { name = "nvim_lua" },
            }, {
                { name = "buffer" },
                { name = "path" },
                { name = "html-css" },
                { name = "emoji" },
            }),

            experimental = {
                native_menu = false,
                ghost_text = true,
            },

            formatting = {
                expandable_indicator = true,
                fields = { "abbr", "kind", "menu" },
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "...",
                    with_text = true,
                    before = function(entry, vim_item)
                        cmp_tailwind.formatter(entry, vim_item)
                        return vim_item
                    end,
                    -- before = require("tailwind-tools.cmp").lspkind_format,
                    --
                    -- menu = {
                    --     buffer = "[Buffer]",
                    --     nvim_lsp = "[LSP]",
                    --     luasnip = "[LuaSnip]",
                    --     nvim_lua = "[Lua]",
                    --     path = "[Path]",
                    --     latex_symbols = "[Latex]",
                    --     copilot = "[Copilot]",
                    -- },
                }),
            },
        })
    end,
}
