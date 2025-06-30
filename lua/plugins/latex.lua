return {
    "lervag/vimtex",
    lazy = false,
    ft = { "tex", "plaintex", "bib" },
    config = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_quickfix_mode = 0
        vim.cmd([[
        filetype plugin indent on
        ]])
    end,
}
