-- return {
--     "NvChad/nvim-colorizer.lua",
--     event = "BufReadPost",
--     config = function()
--         require("colorizer").setup({
--             user_default_options = {
--                 RGB = true,
--                 RRGGBB = true,
--                 names = true,
--                 RRGGBBAA = true,
--                 AARRGGBB = true,
--                 rgb_fn = true,
--                 hsl_fn = true,
--                 css = true,
--                 css_fn = true,
--                 -- modes: foreground, background, virtualtext
--                 mode = "virtualtext",
--                 tailwind = false,
--                 -- virtualtext = "■",
--                 always_update = true,
--                 virtualtext_inline = "before",
--             },
--
--             filetypes = {
--                 css = { mode = "background" },
--                 html = { mode = "background" },
--                 lua = { mode = "background" },
--
--                 javascript = { tailwind = true, mode = "virtualtext" },
--                 typescript = { tailwind = true, mode = "virtualtext" },
--                 javascriptreact = { tailwind = true, mode = "virtualtext" },
--                 typescriptreact = { tailwind = true, mode = "virtualtext", virtualtext = "■" },
--                 svelte = { tailwind = true, mode = "virtualtext" },
--                 vue = { tailwind = true, mode = "virtualtext" },
--                 astro = { tailwind = true, mode = "virtualtext" },
--                 ["*"] = { mode = "background" },
--             },
--         })
--     end,
-- }
return {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
        require("colorizer").setup({
            user_default_options = {
                RGB = true,
                RRGGBB = true,
                names = true,
                RRGGBBAA = true,
                AARRGGBB = true,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
                -- modes: foreground, background, virtualtext
                mode = "virtualtext",
                tailwind = true,
                virtualtext = "■",
                always_update = true,
                virtualtext_inline = "before",
            },

            filetypes = {
                css = {
                    RGB = true, -- #RGB hex codes
                    RRGGBB = true, -- #RRGGBB hex codes
                    names = true, -- "Name" codes like Blue
                    RRGGBBAA = true, -- #RRGGBBAA hex codes
                    rgb_fn = true, -- CSS rgb() and rgba() functions
                    hsl_fn = true, -- CSS hsl() and hsla() functions
                    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                },
                html = { mode = "background" },
                -- markdown = { names = false },
                "*",
                -- "!javascript",
                -- "!javascriptreact",
                -- "!typescript",
                -- "!typescriptreact",
            },
        })
    end,
}
