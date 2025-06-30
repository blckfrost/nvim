return {
    cmd = { "vscode-json-language-server", "--studio" },
    filetypes = { "json", "jsonc" },
    settings = {
        json = {
            validate = { enable = true },
            schemas = require("schemastore").json.schemas(),
        },
    },
}
