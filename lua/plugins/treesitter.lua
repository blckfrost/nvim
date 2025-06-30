return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },

    config = function()
        require("nvim-treesitter.configs").setup({
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            auto_install = true,
            indent = { enable = true },
            ensure_installed = {
                "c",
                "cpp",
                "markdown",
                "python",
                "markdown_inline",
                "html",
                "vim",
                "vimdoc",
                "javascript",
                "typescript",
                "yaml",
                "lua",
                "css",
                "scss",
                "bash",
                "json",
                "jsonc",
                "tsx",
                "regex",
                "gitignore",
                "dart",
                "go",
                "sql",
                "gomod",
                "gosum",
                "gowork",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end,
}
