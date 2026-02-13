return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                typescript = { "prettier" },
                markdown = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                json = { "prettier" },
                jsonc = { "prettier" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                c = { "clang-format" },
                go = { "goimports", "gofmt" },
                yaml = { "yamlfmt" },
                astro = { "prettier" },
                rust = { "rustfmt" },
                python = { "black", "isort" },
            },

            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 2500,
            },

            formatters = {
                prettier = { require_cwd = true },
            },

            notify_on_error = false,
        })

        vim.keymap.set({ "n", "v" }, "<leader>lf", function()
            require("conform").format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range(in visual mode)" })
    end,
}
