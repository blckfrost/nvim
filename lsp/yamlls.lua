return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
    settings = {
        yaml = {
            schemas = require("schemastore").yaml.schemas(),
            validate = true,
            hover = true,
        },
    },
}
