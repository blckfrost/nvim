local add_on_event = require("vim-pack").add_on_event

add_on_event({ "BufReadPre", "BufNewFile" }, {
	{
		src = "lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			update_debounce = 1000,
		},
	},
})
