require("agenda").setup({
	dir = "~/garden/tasks/",
})

vim.keymap.set("n", "<leader>oa", "<cmd>Agenda<CR>", { desc = "Open [A]genda" })
