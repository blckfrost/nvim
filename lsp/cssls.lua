---@type vim.lsp.Config
return {
	cmd = { "vscode-css-language-server", "--studio" },
	filetypes = { "css", "less", "scss", "sass" },
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
}
