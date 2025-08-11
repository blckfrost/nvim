return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufRead" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        {
            "nvim-treesitter/nvim-treesitter-context",
            opts = {
                min_window_height = 20,
                max_lines = 3,
            },
            keys = {
                {
                    "[c",
                    function()
                        if vim.wo.diff then
                            return "[c"
                        else
                            vim.schedule(function()
                                require("treesitter-context").go_to_context()
                            end)
                            return "<Ignore>"
                        end
                    end,
                    desc = "Jump to upper context",
                    expr = true,
                },
            },
        },
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
