return {
    { "b0o/schemastore.nvim" },
    {
        "mason-org/mason.nvim",
        cmd = "Mason",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "↻",
                        package_uninstalled = "✗",
                    },
                },
            })
            local mason_lspconfig = require("mason-lspconfig")
            local mason_tool_installer = require("mason-tool-installer")
            mason_lspconfig.setup({
                automatic_enable = true,
                ensure_installed = {
                    "lua_ls",
                    "vtsls",
                    "html",
                    "tailwindcss",
                    "jsonls",
                    "gopls",
                    "taplo",
                    "copilot",
                },
            })
            mason_tool_installer.setup({
                ensure_installed = {
                    "prettier",
                    "stylua",
                    "goimports",
                    "yamlfmt",
                    "shfmt",
                },
            })
        end,
    },
}
