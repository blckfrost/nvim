return {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },

    settings = {
        typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayParameterNameHints = "literals", -- literals | none | all
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayVariableTypeHints = false,
            },
            suggest = { suggestFunctionCalls = true },
        },
        javascript = {
            updateImportsOnFileMove = { enabled = "always" },
            inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayParameterNameHints = "literals",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayVariableTypeHints = false,
            },
        },
    },
}
