return {
    {
        "lewis6991/gitsigns.nvim",
        cond = function()
            local gitdir = vim.fn.finddir(".git", ".;")
            return gitdir ~= ""
        end,
        config = function()
            require("gitsigns").setup({
                signs = {

                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                },
            })
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
            { "<leader>gdo", "<cmd>DiffviewOpen<CR>", { desc = "[D]iff [O]pen" } },
            { "<leader>gdc", "<cmd>DiffviewClose<CR>", { desc = "[D]iff [C]lose" } },
            { "<leader>gdh", "<cmd>DiffviewFileHistory<CR>", { desc = "[D]iff [H]istory" } },
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
