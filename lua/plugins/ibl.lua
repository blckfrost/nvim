return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
        indent = {
            char = "▏",
            repeat_linebreak = true,
            -- tab_char = ">",
        },
        scope = {
            enabled = true,
            show_start = true,
            show_end = true,
            char = "▏",
            priority = 500,
            injected_languages = true,
        },
        exclude = {
            filetypes = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
            buftypes = { "terminal", "nofile" },
        },
    },
}
