local keymap = vim.keymap
local opts = { silent = true }

-- Disable the arrow keys
-- keymap.set("n", "<Left>", ":echo 'use h'<CR>")
-- keymap.set("n", "<Right>", ":echo 'use l'<CR>")
-- keymap.set("n", "<Up>", ":echo 'use k'<CR>")
-- keymap.set("n", "<Down>", ":echo 'use j'<CR>")

-- Exit and quit
keymap.set("n", "<leader>ws", "<cmd>w<CR>", { desc = "Save current File" })
keymap.set("n", "<C-q>", "<cmd>q<CR>", { desc = "[Q]uit" })

-- Split window
keymap.set("n", "se", "<C-w>=", { desc = "[S]plit [E]qual" })
keymap.set("n", "sv", ":vsplit<Return><C-w>w", { desc = "[S]plit [V]ertical" }, opts)
keymap.set("n", "sh", ":split<Return>", { desc = "[S]plit [H]orizontal" }, opts)

-- Move to window
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move window left" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move window up" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move window down" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move window right" })

--  Resizing windows
keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Reset highlights
keymap.set("n", "<Esc>", "<cmd>noh<CR>")

--  Lazy UI and Mason UI
keymap.set("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Open Lazy UI" })
keymap.set("n", "<leader>M", "<cmd>Mason<CR>", { desc = "Open Mason UI" })

-- Toggle relative number
keymap.set("n", "<leader>rn", function()
    vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle Relative number" })

-- Run current line as shell command
keymap.set("n", "Q", "!!zsh<CR>")

-- Move lines up and down
keymap.set("n", "<A-j>", ":move .+1<CR>==")
keymap.set("n", "<A-k>", ":move .-2<CR>==")
keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv")
keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv")

-- some line movement
keymap.set("n", "H", "^")
keymap.set("n", "L", "$")
