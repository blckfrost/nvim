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
    opts = {
        win = {
            no_overlap = false,
            title_pos = "center",
        },
    },
    config = function()
        require("which-key").add({
            {
                mode = { "n", "v" },
                { "<leader>g", group = "Git" },
            },
        })
    end,
}
