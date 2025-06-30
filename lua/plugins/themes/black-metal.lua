return {
    "metalelf0/black-metal-theme-neovim",
    lazy = false,
    priorit = 1000,
    config = function()
        require("black-metal").setup({
            -- Can be one of: bathory | burzum | dark-funeral | darkthrone |
            -- emperor | gorgoroth | immortal | impaled-nazarene | khold |
            -- marduk | mayhem | nile | taake | thyrfing | venom | windir
            theme = "bathory",
            code_stye = {
                comments = "italic",
                conditionals = "italic",
                functions = "italic",
                keywords = "bold",
                headings = "bold",
                strings = "italic",
            },
        })
        -- require("black-metal").load()
    end,
}
