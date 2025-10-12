return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
        suggestion = {
            enabled = not vim.g.ai_cmp,
            auto_trigger = true,
            hide_during_completion = vim.g.ai_cmp,
            keymap = {
                accept = "<C-y>",
                accept_word = "<M-w>",
                accept_line = "<M-l>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-/>",
            },
        },
        panel = { enabled = false },
        filetypes = {
            markdown = true,
            help = true,
            yaml = true,
        },
    },
}
