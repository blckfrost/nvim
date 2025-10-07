return {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    config = function()
        vim.keymap.set("n", "<leader>pp", function()
            require("dropbar.api").pick(vim.v.count ~= 0 and vim.v.count or nil)
        end, { desc = "Toggle dropbar menu" })
    end,
}
