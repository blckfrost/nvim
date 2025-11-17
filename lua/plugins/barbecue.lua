return {
    "utilyre/barbecue.nvim",
    dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
    config = function()
        require("barbecue").setup({
            theme = "tokyodark",
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "barbecue.config",
            callback = function()
                vim.api.nvim_set_hl(0, "BarbecueNormal", {
                    bg = "NONE",
                })
                vim.api.nvim_set_hl(0, "BarbecueNormalNC", {
                    bg = "NONE",
                })
            end,
        })
    end,
}
