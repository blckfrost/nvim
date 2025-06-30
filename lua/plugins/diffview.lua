return {
    "sindrets/diffview.nvim",
    opts = {
        default = {
            disable_diagnostics = false,
        },
        view = {
            merge_tool = {
                disable_diagnostics = false,
                winbar_info = true,
            },
        },
        enhanced_diff_hl = true,
        hooks = {
            diff_buf_win_enter = function()
                vim.opt_local.foldenable = false
            end,
        },
    },
    config = function()
        local keymap = vim.keymap
        keymap.set("n", "<leader>gdo", "<cmd>DiffviewOpen<CR>", { desc = "Open diffview" })
        keymap.set("n", "<leader>gdx", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" })
        keymap.set("n", "<leader>gdm", "<cmd>DiffviewOpen<CR>", { desc = "Solve merge conflicts" })
        keymap.set("n", "<leader>gdh", "<cmd>DiffviewFileHistory %<CR>", { desc = "File History" })
    end,
}
