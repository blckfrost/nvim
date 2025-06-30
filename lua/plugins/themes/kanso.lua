return {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,

    config = function()
        require("kanso").setup({
            undercurl = true, -- enable undercurls
            commentStyle = { italic = true },
            keywordStyle = { bold = true },
            functionStyle = { italic = true },
            disableItalics = false,
            transparent = false, -- do not set background color
            dimInactive = false, -- dim inactive window `:h hl-NormalNC`
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
            -- theme = "zen", -- Load zen | ink | pearl
        })
        -- vim.cmd("colorscheme kanso-zen")
    end,
}
