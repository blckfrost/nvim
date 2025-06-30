return {
    "mason-org/mason.nvim",
    event = "VeryLazy",
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "whoIsSethDaniel/mason-tool-installer.nvim",
    },

    config = function()
        local mason = require("mason")
        local mason_tool = require("mason-tool-installer")
        local mason_lspconfig = require("mason-lspconfig")

        mason.setup({
            ui = {
                icons = {
                    package_pending = "󰁇 ",
                    package_installed = " ",
                    package_uninstalled = " ",
                },
                border = "rounded",
            },
            log_level = vim.log.levels.INFO,
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",
                "pyright",
                "marksman",
                "ts_ls",
                "html",
                "bashls",
                "cssls",
                "clangd",
                "tailwindcss",
                "gopls",
            },
            automatic_installation = true,
        })
        mason_tool.setup({
            run_on_start = true,
            ensure_installed = {
                "stylua",
                "isort",
                "black",
                "prettier",
                "flake8",
                "beautysh",
                "goimports",
                "gofumpt",
                "eslint_d",
                "yamlfmt",
            },
        })
    end,
}
