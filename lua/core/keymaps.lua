local keymap = vim.keymap.set
local opts = { silent = true }

-- Disable the arrow keys
-- keymap.set("n", "<Left>", ":echo 'use h'<CR>")
-- keymap.set("n", "<Right>", ":echo 'use l'<CR>")
-- keymap.set("n", "<Up>", ":echo 'use k'<CR>")
-- keymap.set("n", "<Down>", ":echo 'use j'<CR>")

-- Exit and quit
keymap("n", "<leader>ws", "<cmd>w<CR>", { desc = "Save current File" })
keymap("n", "<C-q>", "<cmd>q<CR>", { desc = "[Q]uit" })

-- Split window
keymap("n", "se", "<C-w>=", { desc = "[S]plit [E]qual" })
keymap("n", "sv", ":vsplit<Return><C-w>w", { desc = "[S]plit [V]ertical", silent = true })
keymap("n", "sh", ":split<Return>", { desc = "[S]plit [H]orizontal", silent = true })

-- Move to window
keymap("n", "<C-h>", "<C-w>h", { desc = "Move window left" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move window up" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move window down" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move window right" })

--  Resizing windows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Reset highlights
keymap("n", "<Esc>", "<cmd>noh<CR>")

--  Lazy UI and Mason UI
keymap("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Open Lazy UI" })
keymap("n", "<leader>M", "<cmd>Mason<CR>", { desc = "Open Mason UI" })

-- Toggle relative number
keymap("n", "<leader>rn", function()
    vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle Relative number" })

-- Run current line as shell command
keymap("n", "Q", "!!zsh<CR>")

-- Move lines up and down
keymap("n", "<A-j>", ":move .+1<CR>==")
keymap("n", "<A-k>", ":move .-2<CR>==")
keymap("v", "<A-k>", ":move '<-2<CR>gv=gv")
keymap("v", "<A-j>", ":move '>+1<CR>gv=gv")

-- some line movement
keymap("n", "H", "^")
keymap("n", "L", "$")
