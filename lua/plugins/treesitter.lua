return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-context",
            opts = {
                max_lines = 3,
                multiline_threshold = 1,
                min_window_height = 20,
            },
        },
    },

    config = function()
        local ts = require("nvim-treesitter")
        local parsers = {
            "vim",
            "vimdoc",
            "javascript",
            "typescript",
            "html",
            "css",
            "markdown",
            "markdown_inline",
            "bash",
            "go",
            "gomod",
            "astro",
            "make",
            "regex",
            "xml",
            "diff",
            "editorconfig",
            "fish",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "hcl",
            "jsdoc",
            "json",
            "lua",
            "python",
            "query",
            "toml",
            "tsx",
            "typst",
            "yaml",
            "c",
            "cpp",
            "hyprlang",
            "java",
            "rasi",
            "svelte",
        }
        ts.install(parsers)

        ts.setup({
            highlight = { enable = true },

            indent = {
                enable = true,
                -- Treesitter unindents Yaml lists for some reason.
                disable = { "yaml" },
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<cr>",
                    node_incremental = "<cr>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = ts.get_installed(),
            callback = function()
                vim.treesitter.start()
            end,
        })
        vim.filetype.add({ extension = { mdx = "markdown.mdx" } })
        vim.treesitter.language.register("markdown", "markdown.mdx")
    end,
}
