return {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
    root_markers = { "go.mod", "go.work", ".git" },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = false,
            semanticTokens = true,
            staticcheck = true,
            analyses = {
                unusedparams = true,
                useany = true,
                nilness = true,
                unusedwrite = true,
                simplifyrange = true,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },

            codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
        },
    },
}
