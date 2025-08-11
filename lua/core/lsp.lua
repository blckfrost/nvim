vim.lsp.enable({ "lua_ls", "gopls", "ts_ls", "prismals", "tailwindcss" })

vim.diagnostic.config({
    update_in_insert = fasle,
    virtual_lines = { current_line = true },
    underline = true,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = "󰋼 ",
            [vim.diagnostic.severity.HINT] = " ",
        },
    },
})

vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("silent checkhealth vim.lsp")
end, { desc = "Get all information about attached LSP" })

vim.api.nvim_create_user_command("LspLogs", function()
    vim.cmd.vsplit(vim.lsp.log.get_filename())
end, { desc = "Get all the LSP Logs" })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local keymap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- DIAGNOSTICS
        keymap("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer dianostics")

        keymap("]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, "Go to next dianostic")

        keymap("[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, "Go to prev dianostic")

        keymap("<leader>ld", vim.diagnostic.open_float, "Show line dianostics")

        keymap("]e", function()
            vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
        end, "Go to next ERROR")

        keymap("[e", function()
            vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
        end, "Go to prev ERROR")

        -- REFERNCES
        keymap("grr", "<cmd>Telescope lsp_references<CR>", "[L]SP [R]eferences")

        -- CODE ACTIONS
        keymap("gra", vim.lsp.buf.code_action, "[L]SP Code [A]ction")

        -- DEFINITIONS
        keymap("gd", "<cmd>Telescope lsp_definitions<CR>", "[L]SP [D]efinition")

        -- RENAME
        keymap("grn", vim.lsp.buf.rename, "[R]e[n]ame")

        keymap("K", function()
            vim.lsp.buf.hover({ border = "single" })
        end, "Show Documentation for symbol under cursor")

        keymap("<C-s>", vim.lsp.buf.signature_help, "[L]SP Signature Help")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local methods = vim.lsp.protocol.Methods
        if client:supports_method(methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })

            keymap("<leader>ih", function()
                vim.lsp.inlay_hint.enable(
                    not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
                    { bufnr = event.buf }
                )
            end, "[I]nlay [H]int")
        end
    end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
    contextSupport = true,
    snippetSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
    labelDetailsSupport = true,
    documentationFormat = { "markdown", "plaintext" },
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

vim.lsp.config("*", {
    capabilities = capabilities,
})
