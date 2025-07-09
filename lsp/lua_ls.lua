return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            hint = {
                enable = true,
                setType = true,
                paramType = true,
                paramName = "All", -- All | Literal | Disable
            },
            completion = {
                callSnippet = "Replace",
            },
        },
    },
}
