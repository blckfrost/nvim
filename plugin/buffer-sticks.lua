local add_on_event = require("vim-pack").add_on_event

add_on_event("BufReadPre", {
	{
		src = "ahkohd/buffer-sticks.nvim",
		on_setup = function()
			local sticks = require("buffer-sticks")
			sticks.setup({
				highlights = {
					active = { link = "Statement" },
					inactive = { link = "Whitespace" },
					active_modified = { link = "Constant" },
					alternate_modified = { link = "Constant" },
					inactive_modified = { link = "Constant" },
					label = { link = "Comment" },
				},
			})
			sticks.show()
		end,
	},
})

vim.keymap.set({ "n", "v" }, "<leader>jj", function()
	require("buffer-sticks").jump()
end, { desc = "Jump to buffer" })
vim.keymap.set({ "n", "v" }, "<leader>jq", function()
	require("buffer-sticks").close()
end, { desc = "Close buffer" })
