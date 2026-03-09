return {
    "nvim-mini/mini.nvim",
    config = function()
        require("mini.surround").setup({
            mappings = {
                add = "ys",
                delete = "ds",
            },
        })

        require("mini.pick").setup({})

        local ai = require("mini.ai")

        ai.setup({
            n_lines = 500,
            custom_textobjects = {
                f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
                a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
                l = ai.gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
                i = ai.gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
            },
        })
        vim.keymap.set("n", "<leader>fp", "<cmd>Pick files<CR>", { desc = "Browse files" })

        require("mini.extra").setup()
        vim.keymap.set(
            "n",
            "<leader>fcs",
            "<cmd>Pick colorschemes<CR>",
            { desc = "Browse colorschemes" }
        )
    end,
}
