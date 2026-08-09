vim.diagnostic.config({
    update_in_insert = false,
    virtual_lines = { current_line = true },
    underline = true,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'if_many',
    },
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        ---@param lhs string
        ---@param rhs string|function
        ---@param mode? string|string[]
        local function keymap(lhs, rhs, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- DIAGNOSTICS
        keymap('<leader>D', '<cmd>Pick diagnostic bufnr=0<CR>', 'Show buffer dianostics')

        keymap(']d', function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, 'Go to next dianostic')

        keymap('[d', function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, 'Go to prev dianostic')

        keymap('<leader>ld', vim.diagnostic.open_float, 'Show line dianostics')

        keymap(']e', function()
            vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
        end, 'Go to next ERROR')

        keymap('[e', function()
            vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
        end, 'Go to prev ERROR')

        -- REFERNCES
        keymap('grr', '<cmd>Telescope lsp_references<CR>', '[L]SP [R]eferences')

        -- CODE ACTIONS
        keymap('gra', vim.lsp.buf.code_action, '[L]SP Code [A]ction')

        -- DEFINITIONS
        keymap('gd', '<cmd>Telescope lsp_definitions<CR>', '[L]SP [D]efinition')

        -- RENAME
        keymap('grn', vim.lsp.buf.rename, '[R]ename')

        keymap('K', function()
            vim.lsp.buf.hover({ border = 'single' })
        end, 'Show Documentation for symbol under cursor')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })

            keymap('<leader>ih', function()
                vim.lsp.inlay_hint.enable(
                    not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
                    { bufnr = event.buf }
                )
            end, '[I]nlay [H]int')
        end

        if client and client:supports_method('textDocument/signatureHelp') then
            keymap('<C-k>', function()
                if require('blink.cmp.completion.windows.menu').win:is_open() then
                    require('blink.cmp').hide()
                end

                vim.lsp.buf.signature_help()
            end, 'Signature help', 'i')
        end
    end,
})

-- Set up LSP servers.
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    once = true,
    callback = function()
        -- Extend neovim's client capabilities with the completion ones.
        vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(nil, true) })

        local servers = vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
            :map(function(file)
                return vim.fn.fnamemodify(file, ':t:r')
            end)
            :totable()
        vim.lsp.enable(servers)
    end,
})
