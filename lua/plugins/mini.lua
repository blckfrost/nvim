return {
    {
        "nvim-mini/mini.pick",
        config = function()
            require("mini.pick").setup({})
            vim.keymap.set("n", "<leader>fp", "<cmd>Pick files<CR>")
        end,
    },
    {
        "nvim-mini/mini.surround",
        opts = {
            mappings = {
                add = "ys",
            },
        },
    },
}
