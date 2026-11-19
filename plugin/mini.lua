local add = require("vim-pack").add

-- Autoclosing braces.
add({
	{
		src = "nvim-mini/mini.nvim",
		setup = false,
		on_setup = function()
			require("mini.surround").setup({
				mappings = {
					add = "ys",
					delete = "ds",
					replace = "cs",
				},
			})

			local ai = require("mini.ai")
			ai.setup({
				n_lines = 500,
				custom_textobjects = {
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
					a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
					l = ai.gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
					i = ai.gen_spec.treesitter({
						a = "@conditional.outer",
						i = "@conditional.inner",
					}),
				},
			})
		end,
	},
})
