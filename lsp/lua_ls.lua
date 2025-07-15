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
                setType = false,
                paramType = true,
                paramName = "Disable", -- All | Literal | Disable
                semicolon = "Disable",
                arrayIndex = "Disable",
            },
            completion = {
                callSnippet = "Replace",
            },
            codeLens = {
                enable = true,
            },
        },
    },
}
