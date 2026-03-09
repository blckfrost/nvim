return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
    config = function()
        local wkey = require("which-key")
        wkey.add({
            {
                mode = { "n", "v" },
                { "<leader>g", group = "Git" },
            },
        })
        wkey.setup({
            layout = {
                width = { min = 20, max = 50 },
                spacing = 3,
            },
            win = {
                no_overlap = false,
                title = true,
                title_pos = "center",
                row = math.huge,
                col = -1,
                border = "rounded",
                width = 60,
                height = { min = 10, max = 20 },
                padding = { 1, 2 },
            },
        })
    end,
}
