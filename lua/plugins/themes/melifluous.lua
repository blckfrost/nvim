return {
    "ramojus/mellifluous.nvim",
    config = function()
        require("mellifluous").setup({
            mellifluous = {
                neutral = true,
            },
            colorset = "mountain",
        })
        -- vim.cmd.colorscheme("mellifluous")
    end,
}
