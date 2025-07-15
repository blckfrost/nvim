local M = {}
local methods = vim.lsp.protocol.Methods

--- LSP attach setup
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true, buffer = bufnr }

    opts.desc = "Lsp Install"
    keymap.set("n", "<leader>li", "<cmd>LspInstall<cr>", opts)

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

    opts.desc = "Show LSP references"
    keymap.set("n", "<leader>lR", "<cmd>Telescope lsp_references<CR>", opts)

    opts.desc = "Show available code actions"
    keymap.set({ "n", "v" }, "gra", function()
        vim.lsp.buf.code_action()
    end, opts)

    opts.desc = "Show lsp definitions"
    keymap.set("n", "grd", vim.lsp.buf.definition, opts)

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

    opts.desc = "Next Error"
    keymap.set("n", "]e", function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
    end, opts)

    opts.desc = "Previous Error"
    keymap.set("n", "[e", function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
    end, opts)

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", function()
        vim.lsp.buf.hover({ border = "single" })
    end, opts)

    opts.desc = "Rename all ref of symbol under cursor"
    keymap.set("n", "grn", vim.lsp.buf.rename, opts)

    opts.desc = "Sig help"
    keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, opts)

    -- Enable inlay hints if supported
    if client:supports_method(methods.textDocument_inlayHint) then
        -- Enable inlay hints by default
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

        -- Add toggle keymap
        opts.desc = "Toggle Inlay Hints"
        keymap.set("n", "<leader>ih", function()
            vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                { bufnr = bufnr }
            )
        end, opts)
    end

    -- Duplicates
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    for _, c in pairs(clients) do
        if c.name == client.name and c.id ~= client.id then
            c:stop()
            return
        end
    end

    -- Highlight symbol under cursor
    if client:supports_method(methods.textDocument_documentHighlight) then
        local highlight_group =
            vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = highlight_group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
            group = highlight_group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

vim.diagnostic.config({
    -- virtual_text = { spacing = 1, prefix = "󰊠 ", current_line = true },
    update_in_insert = false,
    virtual_lines = { current_line = true },
    underline = true,
    severity_sort = true,
    header = { "  Diagnostics" },
    float = {
        source = "if_many",
        style = "minimal",
        border = "rounded",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = "󰋼 ",
            [vim.diagnostic.severity.HINT] = " ",
        },

        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Configure LSP Keymaps",
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then
            return
        end

        on_attach(client, args.buf)
    end,
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    once = true,
    callback = function()
        local server_configs = vim.iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
            :map(function(file)
                return vim.fn.fnamemodify(file, ":t:r")
            end)
            :totable()
        vim.lsp.enable(server_configs)
    end,
})

vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
})

return M
