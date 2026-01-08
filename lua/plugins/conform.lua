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
            },

            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 2500,
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
        --  special config for prettier
        require("conform.formatters.prettier").args = function(self, ctx)
            local args = { "--stdin-filepath", "$FILENAME" }
            local localPrettierConfig = vim.fs.find(".prettierrc.json", {
                upward = true,
                path = ctx.dirname,
                type = "file",
            })[1]
            local globalPrettierConfig = vim.fs.find(".prettierrc.json", {
                path = vim.fn.expand("~/.config/nvim"),
                type = "file",
            })[1]

            -- Project config takes precedence over global config
            if localPrettierConfig then
                vim.list_extend(args, { "--config", localPrettierConfig })
            elseif globalPrettierConfig then
                vim.list_extend(args, { "--config", globalPrettierConfig })
            end
            return args
        end
    end,
}
