return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    enabled = true,
    main = "ibl",
    config = function()
        require("ibl").setup({
            indent = {
                -- char = "|",
                char = "▏",
                -- char = "┊",
                repeat_linebreak = true,
                -- tab_char = ">",
            },
            scope = {
                enabled = true,
                show_start = true,
                show_end = true,
                injected_languages = true,
                char = "▏",
                priority = 500,
            },
            whitespace = { remove_blankline_trail = false },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-treee",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                },
                buftypes = { "terminal" },
            },
        })
    end,
}
