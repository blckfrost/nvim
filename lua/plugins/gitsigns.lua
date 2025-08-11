return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre" },
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup({
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },

            signcolumn = true,
            numhl = false,
            linehl = false,
            word_diff = false,

            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },

            auto_attach = true,
            attach_to_untracked = true,

            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pox = "eol",
                delay = 1000,
                ignore_whitespace = true,
            },

            preview_config = {
                border = "single",
                style = "minima",
                relative = "cursor",
                row = 0,
                col = 1,
            },
        })
        local opts = { noremap = true, silent = true }

        opts.desc = "Next Hunk"
        vim.keymap.set("n", "<leader>]h", gitsigns.next_hunk, opts)

        opts.desc = "Prev Hunk"
        vim.keymap.set("n", "<leader>[h", gitsigns.prev_hunk, opts)

        opts.desc = "Preview Hunk"
        vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, opts)

        opts.desc = "Reset Hunk"
        vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, opts)

        opts.desc = "Diff this"
        vim.keymap.set("n", "<leader>gx", gitsigns.diffthis, opts)

        opts.desc = "Stage Hunk"
        vim.keymap.set("n", "<leader>gS", gitsigns.stage_hunk, opts)

        opts.desc = "Blame Line"
        vim.keymap.set("n", "<leader>gb", gitsigns.blame_line, opts)
    end,
}
