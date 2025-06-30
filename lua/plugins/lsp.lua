return {

    { "b0o/schemastore.nvim" }, -- For JSON schemas

    {
        "mason-org/mason.nvim",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
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
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "tailwindcss",
                    "gopls",
                    "bashls",
                },
            })
        end,
    },
}
