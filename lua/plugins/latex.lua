-- return {
--     "lervag/vimtex",
--     enabled = true,
--     config = function()
--         vim.cmd([[
--         filetype plugin indent on
--         syntax enable
--
--         let g:vimtex_view_method = 'zathura'
--         let g:vimtex_view_general_viewer = 'zathura'
--         let g:vimtex_view_general_options = '--unique file:@pdf\src:@line@tex'
--
--         let g:vimtex_compiler_method = 'latexmk'
--
--         let g:vimtex_compiler_latexmk
--         ]])
--     end,
-- }

return {
    "lervag/vimtex",
    lazy = false,
    enabled = false,
    ft = { "tex", "plaintex", "bib" },
    config = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_compiler_latexmk = {
            build_dir = "build",
            -- options = {
            --     "-pdf",
            --     "-verbose",
            --     "-file-line-error",
            --     "-synctex=1",
            --     "-interaction=nonstopmode",
            -- },
        }
        vim.g.vimtex_quickfix_ignore_filters = {
            "Overfull \\hbox",
            "Underfull \\hbox",
            "LaTeX Warning: .\\+ float specifier change to",
            "LaTeX hooks Warning",
            "Package siunitx Warning: Detected the 'physics' package:",
            "Package hyperref Warning: Token not allowed in a PDF string",
        }
        vim.g.vimtex_quickfix_open_on_warning = 0
    end,
}
