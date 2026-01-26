return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context"
    },
    config = function()
        local ts = require("nvim-treesitter")

        ts.install({
            "vim",
            "vimdoc",
            "javascript",
            "typescript",
            "html",
            "css",
            "markdown",
            "bash",
            "go",
            "gomod",
            "astro",
            "make",
            "regex",
            "less",
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
            "make",
            "markdown_inline",
            "python",
            "query",
            "toml",
            "tsx",
            "typst",
            "yaml",
        })
    end,

}
