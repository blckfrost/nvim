vim.cmd.colorscheme("frost")

require("options")
require("keymaps")
require("autocmds")
require("lsp")

vim.cmd.packadd("nvim.undotree")

require("vim._core.ui2").enable({})
