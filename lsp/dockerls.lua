return {
    cmd = { "docker-langserver", "--stdio" },
    filetypes = { "dockerfile" },
    settings = {
        docker = {
            languageserver = {
                formatter = {
                    ignoreMultilineInstructions = true,
                },
            },
        },
    },
}
