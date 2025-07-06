return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    enabled = false,
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
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
    },
}
