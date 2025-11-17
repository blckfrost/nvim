---@type vim.lsp.Config
return {
    cmd = { "templ", "lsp" },
    filetypes = { "templ", "tmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
}
