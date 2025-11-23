---@type vim.lsp.Config
return {
    cmd = { "astro-ls", "--stdio" },
    root_markers = {
        "package.json",
        "tsconfig.json",
        "jsconfig.json",
        "astro.config.mjs",
        ".git",
    },
    filetypes = {
        "astro",
    },

    init_options = {
        typescript = {
            tsdk = "node_modules/typescript/lib/",
        },
    },
}
