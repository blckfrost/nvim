return {
    {
        "zbirenbaum/copilot-cmp",
        event = "Insertenter",
        enabled = false,
        config = function()
            require("copilot_cmp").setup()
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "Insertenter",
        enabled = false,
        config = function()
            require("copilot").setup({
                panel = { enabled = false },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = true,
                    keymap = {
                        accept = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
                filetypes = {
                    ["*"] = true,
                    markdown = true,
                    help = true,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                },
            })
        end,
    },
}
