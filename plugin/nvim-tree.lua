local add = require("vim-pack").add

add({
	{
		src = "nvim-tree/nvim-tree.lua",
		module_name = "nvim-tree",
		opts = {
			view = { width = 30 },
		},
	},
})
vim.keymap.set("n", "<c-n>", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree", silent = true })
