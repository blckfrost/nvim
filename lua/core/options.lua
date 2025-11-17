-- set leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- performance optimizations
vim.opt.updatetime = 300
vim.opt.timeout = true
vim.opt.timeoutlen = 500

-- Line numbers (relative)
vim.opt.number = true
vim.opt.relativenumber = true

-- Disable mouse
vim.o.mouse = ""

-- Clipboard
vim.o.clipboard = "unnamedplus"

-- Tab widths, indents and spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Don't line wrap
vim.opt.wrap = false

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight search matches
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Better colors
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Allow hidden unsaved buffers
vim.opt.hidden = true

-- Attempts to keep cursor in center of screen
vim.opt.scrolloff = 10

-- Keep a left hand column for error icons etc.
vim.opt.signcolumn = "yes"

-- Give more space for displaying messages
vim.opt.cmdheight = 1

-- Persistent undo
vim.o.undofile = true

-- Improve sidescroll
vim.opt.sidescroll = 1

-- Cursor line
vim.opt.cursorline = true

-- Split windows
vim.opt.splitright = true -- splits vertical window to the right
vim.opt.splitbelow = true -- splits horizontal window to the bottom
vim.opt.splitkeep = "cursor"

-- Disable error bells
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Whitespace chars
vim.opt.listchars = {
    tab = "→ ",
    eol = "↵",
    nbsp = "␣",
    trail = "⋅",
    extends = "⟩",
    precedes = "⟨",
    space = "·",
}

vim.opt.fillchars = {
    eob = " ",
    fold = " ",
    foldclose = "",
    foldopen = "",
    foldsep = " ",
    msgsep = "─",
    diff = "╱",
}

-- encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- turn of swapfile
vim.opt.swapfile = false

-- complete the longest common match, tab the results to fully complete them
vim.opt.wildmode = "longest:full,full"
vim.opt.wildmenu = true

-- vim.g.python3_host_prog = "/usr/bin/python"

-- Disable health checks for these providers.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.opt.spelllang = { "en" }
