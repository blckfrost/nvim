return {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "less", "scss", "sass" },
    settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
    },
}
