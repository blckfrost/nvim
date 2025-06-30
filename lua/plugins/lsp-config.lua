return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "b0o/schemastore.nvim", lazy = true },
    },

    config = function()
        local nvim_lsp = require("lspconfig")

        local keymap = vim.keymap

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local opts = { noremap = true, silent = true }

        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            opts.desc = "Restart Lsp"
            keymap.set("n", "<leader>ls", ":LspRestart<CR>", opts)

            opts.desc = "Lsp Info"
            keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts)

            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

            opts.desc = "Show LSP references"
            keymap.set("n", "<leader>lR", "<cmd>Telescope lsp_references<CR>", opts)

            opts.desc = "Show available code actions"
            keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

            opts.desc = "Show lsp definitions"
            keymap.set("n", "<leader>lD", "<cmd>Lspsaga goto_definition <cr>", opts)

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

            opts.desc = "Go to previous diagnostic"
            keymap.set("n", "[d", function()
                vim.diagnostic.jump({ count = -1, float = true })
            end, opts)

            opts.desc = "Go to next diagnostic"
            keymap.set("n", "]d", function()
                vim.diagnostic.jump({ count = 1, float = true })
            end, opts)

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", function()
                vim.lsp.buf.hover({ border = "single" })
            end, opts)

            opts.desc = "Rename all ref of symbol under cursor"
            keymap.set("n", "<leader>lrn", vim.lsp.buf.rename, opts)

            opts.desc = "Sig help"
            keymap.set("n", "<C-s>", function()
                vim.lsp.buf.signature_help({ border = "single" })
            end, opts)

            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true)
            end
        end

        --  default server configurations
        local servers = {
            "lua_ls",
            "marksman",
            "pyright",
            "texlab",
            "jsonls",
            "sqlls",
            "postgres_lsp",
            "prismals",
            "dockerls",
        }

        for _, lsp in ipairs(servers) do
            nvim_lsp[lsp].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end

        -- [BASH]
        nvim_lsp.bashls.setup({
            capabilities = capabilities,
            filetypes = { "bash", "sh" },
        })

        -- [C/C++]
        nvim_lsp.clangd.setup({
            capabilities = vim.tbl_deep_extend(
                "force",
                capabilities,
                { offsetEncoding = { "utf-16" } }
            ),
            on_attach = on_attach,
            cmd = { "clangd", "-j=4", "--inlay-hints" },
        })

        -- [CSS]
        nvim_lsp.cssls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "css", "less", "scss", "sass" },
        })

        -- [GO]
        nvim_lsp.gopls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "gopls" },
            root_dir = nvim_lsp.util.root_pattern("go.work", "go.mod", ".git"),
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            settings = {
                gopls = {
                    completeUnimported = true,
                    usePlaceholders = false,
                    semanticTokens = true,
                    staticcheck = true,
                    analyses = {
                        unusedparams = true,
                        useany = true,
                        nilness = true,
                        unusedwrite = true,
                    },
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },

                    codelenses = {
                        gc_details = false,
                        generate = true,
                        regenerate_cgo = true,
                        run_govulncheck = true,
                        test = true,
                        tidy = true,
                        upgrade_dependency = true,
                        vendor = true,
                    },
                },
            },
        })

        -- [Tailwind]
        nvim_lsp.tailwindcss.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = {
                "html",
                "css",
                "scss",
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
                "svelte",
            },
        })

        -- [HTML]
        nvim_lsp.html.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "html", "javascriptreact", "typescriptreact" },
        })

        -- [TS]
        nvim_lsp.ts_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
            },
            settings = {
                typescript = {
                    updateImportsOnFileMove = { enabled = "always" },
                    inlayHints = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayParameterNameHints = "literals",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayVariableTypeHints = true,
                    },
                    suggest = { suggestFunctionCalls = true },
                },
                javascript = {
                    updateImportsOnFileMove = { enabled = "always" },
                    inlayHints = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayVariableTypeHints = true,
                    },
                },
            },
        })

        -- [YAML]
        local schemas = require("schemastore").yaml.schemas()
        nvim_lsp.yamlls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "yaml" },
            format = {
                enable = true,
            },
            settings = {
                yaml = {
                    schemas = schemas,
                    validate = true,
                    hover = true,
                },
            },
        })

        vim.diagnostic.config({
            virtual_text = { spacing = 1, prefix = "󰊠 " },
            update_in_insert = false,
            severity_sort = true,
            underline = true,
            float = {
                focusable = true,
                spacing = 2,
                style = "minimal",
                border = "rounded",
                source = "if_many",
                header = { "  Diagnostics", "String" },
                suffix = "",
                prefix = function(_, _, _)
                    return "  ", "String"
                end,
            },

            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.INFO] = "󰋼 ",
                    [vim.diagnostic.severity.HINT] = " ",
                    hint = " ",
                },
                texthl = {
                    [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                    [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                    [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                    [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                },
            },
        })

        -- INLAY HINTS
        if vim.lsp.inlay_hint then
            vim.keymap.set("n", "<Space>ih", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, { desc = "Toggle Inlay Hints" })
        end
    end,
}
