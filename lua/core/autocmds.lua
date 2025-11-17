-- HIGHLIGHT YANKED TEXT
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({
            higroup = "Search",
            timeout = 500,
        })
    end,
})

-- QUIT SOME WINDOWS WITH Q
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "help", "qf", "checkhealth", "man", "query", "notify", "git" },
    callback = function()
        vim.keymap.set("n", "q", "<cmd>bd<cr>", { silent = true, buffer = true })
    end,
})

-- OPEN HELP IN A NEW TAB
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    command = ":wincmd T",
})

-- VIM VISUAL MULTI (inlay hints)
local visual_multi_group = vim.api.nvim_create_augroup("VisualMulti", { clear = true })
vim.api.nvim_create_autocmd("User", {
    pattern = "visual_multi_start",
    callback = function()
        vim.cmd("NoiceDisable")
        vim.lsp.inlay_hint.enable(false)
    end,
    group = visual_multi_group,
})
vim.api.nvim_create_autocmd("User", {
    pattern = "visual_multi_exit",
    callback = function()
        vim.cmd("NoiceEnable")
        vim.lsp.inlay_hint.enable(true)
    end,
    group = visual_multi_group,
})

-- spell checking for some filetypes
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    desc = "Enable spellcheck",
    pattern = { "*.txt", "*.md", "*.tex", "*.typ" },
    callback = function()
        vim.opt.spell = true
        vim.opt.spelllang = "en"
    end,
})
