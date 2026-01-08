return {
    "nvim-mini/mini.nvim",
    config = function()
        require("mini.surround").setup({
            mappings = {
                add = "ys",
            },
        })

        require("mini.pick").setup({})
        vim.keymap.set("n", "<leader>fp", "<cmd>Pick files<CR>")
    end,
}
