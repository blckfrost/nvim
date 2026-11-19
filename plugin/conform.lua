local add_on_event = require("vim-pack").add_on_event

local prettier = { "prettier", timeout_ms = 500, lsp_format = "fallback" }

add_on_event({ "BufReadPre", "BufNewFile" }, {
	{
		src = "stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				c = { name = "clangd", timeout_ms = 500 },
				go = { name = "gopls", timeout_ms = 500 },
				rust = { name = "rust_analyzer", timeout_ms = 500 },
				java = { "palantir-java-format" },
				javascript = prettier,
				typescript = prettier,
				javascriptreact = prettier,
				typescriptreact = prettier,
				json = prettier,
				jsonc = prettier,
				less = { "prettier" },
				lua = { "stylua" },
				markdown = prettier,
				python = { "ruff_format" },
				scss = { "prettier" },
				sh = { "shfmt" },
				svelte = { "prettier" },
				yaml = { "yamlfmt" },
				typst = { "typstyle" },
				["_"] = { "trim_whitespace", "trim_newlines" },
			},
			format_on_save = {
				lsp_format = "fallback",
				async = false,
				timeout_ms = 2500,
			},
			formatters = {
				prettier = { require_cwd = true },
			},
		},
	},
})

vim.g.autoformat = true
