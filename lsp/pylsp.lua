---@type vim.lsp.Config
return {
    cmd = { "pylsp" },
    filetypes = { "python" },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { "W301" },
                    maxLineLength = 100,
                },
            },
        },
    },
}
