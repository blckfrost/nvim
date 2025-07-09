return {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "LspAttach",
    config = function()
        require("lspsaga").setup({
            lightbulb = {
                enable = true,
                sign = true,
                virtual_text = true,
            },

            ui = {
                theme = "round",
                border = "rounded",
                winblend = 0,
                expand = "",
                collaspe = "",
                preview = " ",
                code_action = "󱧣 ",
                diagnostic = " ",
                hover = " ",
            },
        })
    end,
}
