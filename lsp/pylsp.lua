---@type vim.lsp.Config
return {
	cmd = { "pylsp" },
	filetypes = { "python" },
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = { "W301" },
					maxLineLength = 100,
				},
			},
		},
	},
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
}
