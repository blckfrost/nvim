local add = require("vim-pack").add

add({
	{
		src = "ibhagwan/fzf-lua",
		opts = {
			winopts = {
				height = 0.5,
				width = 0.5,
				row = 0.98,
				col = 0,
				preview = { hidden = true },
			},
		},
	},
})

local function fzf(name, ...)
	local args = { ... }
	return function()
		require("fzf-lua")[name](unpack(args))
	end
end

vim.keymap.set("n", "<leader>fp", fzf("files"), { desc = "Browse files" })
vim.keymap.set("n", "<leader>fg", fzf("live_grep"), { desc = "Grep" })
vim.keymap.set("n", "<leader>fb", fzf("buffers"), { desc = "Buffers" })
vim.keymap.set("n", "<leader>fcs", fzf("colorschemes"), { desc = "Browse colorschemes" })
