return {
    cmd = { "yaml-language-server", "--studio" },
    filetypes = { "yaml" },
    settings = {
        yaml = {
            schemas = require("schemastore").yaml.schemas(),
            validate = true,
            hover = true,
        },
    },
}
