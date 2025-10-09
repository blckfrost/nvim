return {
    {
        "lewis6991/gitsigns.nvim",
        cond = function()
            local gitdir = vim.fn.finddir(".git", ".;")
            return gitdir ~= ""
        end,
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        opts = {
            view = {
                merge_tool = {
                    disable_diagnostics = true,
                    layout = "diff4_mixed",
                    winbar_info = true,
                },
            },
            enhanced_diff_hl = true,
        },
        keys = {
            { "<leader>gdo", "<cmd>DiffviewOpen<CR>", { desc = "[G]it [D]iff [O]pen" } },
            { "<leader>gdc", "<cmd>DiffviewClose<CR>", { desc = "[G]it [D]iff [C]lose" } },
            { "<leader>gdh", "<cmd>DiffviewFileHistory<CR>", { desc = "[G]it [D]iff [H]istory" } },
        },
    },
    {

        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
    },
}
