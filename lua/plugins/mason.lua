return {

    { "b0o/schemastore.nvim" }, -- For JSON schemas

    {
        "mason-org/mason.nvim",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            local mason_tool_installer = require("mason-tool-installer")
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
            mason_lspconfig.setup({
                automatic_enable = true,
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "tailwindcss",
                    "gopls",
                    "bashls",
                    "dockerls",
                    "jsonls",
                    "yamlls",
                    "html",
                },
            })
            mason_tool_installer.setup({
                ensure_installed = {
                    "prettier", -- prettier formatter
                    "stylua", -- lua formatter
                    "goimports",
                },
            })
        end,
    },
}
