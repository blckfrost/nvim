local add_on_event = require("vim-pack").add_on_event

add_on_event("InsertEnter", {
	{
		src = "stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				c = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
				go = { name = "gopls", timeout_ms = 500, lsp_format = "prefer" },
				java = { "palantir-java-format" },
				javascript = {
					"prettier",
					name = "dprint",
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				javascriptreact = {
					"prettier",
					name = "dprint",
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				json = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				jsonc = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				less = { "prettier" },
				lua = { "stylua" },
				markdown = {
					"prettier",
					name = "dprint",
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				python = { "ruff_format" },
				scss = { "prettier" },
				sh = { "shfmt" },
				typescript = {
					"prettier",
					name = "dprint",
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				typescriptreact = {
					"prettier",
					name = "dprint",
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				svelte = { "prettier" },
				yaml = { "yamlfmt" },
				rust = { name = "rust_analyzer", timeout_ms = 500, lsp_format = "prefer" },
				["_"] = { "trim_whitespace", "trim_newlines" },
			},
			format_on_save = {
				lsp_fallback = true,
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
