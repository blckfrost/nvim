return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local whichkey = require("which-key")
        whichkey.setup({
            win = {
                border = "single",
                no_overlap = false,
                title_pos = "center",
            },
        })
        whichkey.add({
            {
                mode = { "n", "v" },
                { "<leader>g", group = "[G]it" },
                { "<leader>t", group = "[T]oggle" },
                { "<leader>l", group = "[L]SP" },
                { "<leader>f", group = "file/find" },
                { "<leader>R", group = "+Rest" },
            },
        })
    end,
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
