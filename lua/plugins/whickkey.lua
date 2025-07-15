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
                { "<leader>g", group = "git" },
                { "<leader>gd", group = "diffview" },
                { "<leader>t", group = "toggle" },
                { "<leader>c", group = "code" },
                { "<leader>f", group = "file/find" },
                { "<leader>l", group = "LSP", icon = "" },
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
