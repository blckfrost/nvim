local M = {}

M.colors = {
    white = '#d9d0c1',
    grey_light = '#8a7a68',
    grey_mid = '#786a5a',
    grey_dark = '#5c5045',
    grey_darker = '#4a4038',

    bg = '#101010',
    bg_alt = '#201d1a',
    bg_highlight = '#2a2621',
    bg_subtle = '#302b26',

    fg = '#d6cdc0',
    fg_alt = '#8f8272',
    fg_subtle = '#6e6357',
    fg_dim = '#8f8272',

    error = '#c17a5e',
    warning = '#c4a25e',
    info = '#8a9c8e',
    success = '#8ca873',
    hint = '#9b968b',

    border = '#3a352f',
    selection = '#40382f',
    cursor_line = '#221f1b',
    line_nr = '#5c5245',
    line_nr_active = '#a89a86',

    line = '#2e2a25',
    black = '#101010',
    blue = '#9aa88c',
    yellow = '#d9b97c',
    sun = '#e8d9a8',
    purple = '#a48f7a',
    dark_purple = '#7d6a5b',
    teal = '#8f9a7a',
    cyan = '#a8ab8a',
    green = '#8a9e6e',
    green_light = '#7d9161', -- e8755
    lavendar = '#9b8a72',
    violet = '#b09468',
    violet_light = '#d4bd93',
    violet_subtle = '#a08a6d',
}

function M.setup()
    vim.cmd('hi clear')
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end

    vim.o.background = 'dark'
    vim.g.colors_name = 'frost'

    local c = M.colors

    local highlights = {
        -- Editor highlights
        Normal = { fg = c.fg, bg = c.bg },
        NormalFloat = { fg = c.fg, bg = c.bg_alt },
        FloatBorder = { fg = c.grey_mid },
        FloatTitle = { fg = c.white, bg = c.grey_dark },

        -- Visual selection
        Visual = { bg = c.bg_alt },
        VisualNOS = { bg = c.bg_alt },

        -- Search
        Search = { fg = c.bg, bg = c.grey_light },
        IncSearch = { fg = c.bg, bg = c.fg },

        -- Syntax highlighting
        Comment = { fg = c.fg_subtle },
        Constant = { fg = c.grey_mid },
        String = { fg = c.green },
        Character = { fg = c.grey_mid },
        Number = { fg = c.grey_mid },
        Boolean = { fg = c.lavendar },
        Float = { fg = c.grey_mid },

        Identifier = { fg = c.fg },
        Function = { fg = c.grey_light, bold = true },

        -- Window Buffer
        ColorColumn = { bg = c.bg_alt },
        Cursor = { fg = c.black, bg = c.white },
        CursorLine = { bg = c.cursor_line },
        CursorLineNr = { fg = c.line_nr_active, bold = true },
        LineNr = { fg = c.line_nr },
        SignColumn = { fg = c.line_nr, bg = c.bg },

        Statement = { fg = c.grey_light },
        Conditional = { fg = c.grey_light },
        Repeat = { fg = c.grey_light },
        Label = { fg = c.grey_light },
        Operator = { fg = c.fg_dim },
        Keyword = { fg = c.grey_light },
        Exception = { fg = c.grey_light },

        -- StatusLine
        StatusLine = { fg = c.fg, bg = c.bg_subtle },
        StatusLineNC = { fg = c.fg_dim, bg = c.bg_alt },

        -- Indent lines
        IndentBlanklineChar = { fg = c.line },
        IndentBlanklineContextChar = { fg = c.grey_dark },
        IndentBlanklineSpaceChar = { fg = c.line },
        IndentBlanklineContextStart = { sp = c.grey_light, underline = true },

        -- Telescope
        TelescopeSelection = { fg = c.fg, bg = c.bg_highlight },
        TelescopeSelectionCaret = { fg = c.violet },
        TelescopeNormal = { fg = c.fg, bg = c.bg },
        TelescopeBorder = { fg = c.violet_subtle, bg = c.bg },
        TelescopePromptBorder = { fg = c.violet_subtle, bg = c.bg },
        TelescopeResultsBorder = { fg = c.violet_subtle, bg = c.bg },
        TelescopeMultiSelection = { fg = c.grey_dark },
        TelescopePreviewBorder = { fg = c.violet_subtle, bg = c.bg },
        TelescopePromptTitle = { fg = c.violet_light },
        TelescopeResultsTitle = { fg = c.violet_light },
        TelescopePreviewTitle = { fg = c.violet_light },

        -- Cmp
        CmpItemAbbr = { fg = c.fg },
        CmpItemAbbrMatch = { fg = c.violet, bold = true },
        CmpItemKind = { fg = c.violet_light },
        CmpItemMenu = { fg = c.fg_dim },
        CmpItemAbbrDeprecated = { fg = c.fg_dim, strikethrough = true },
        CmpItemAbbrMatchFuzzy = { fg = c.violet, bold = true },

        -- Blink Cmp
        BlinkCmpMenu = { fg = c.fg, bg = c.bg_alt },
        BlinkCmpMenuBorder = { fg = c.violet_subtle, bg = c.bg_alt },
        BlinkCmpLabel = { fg = c.fg },
        BlinkCmpKind = { fg = c.violet_light },
        BlinkCmpMenuSelection = { fg = c.bg, bg = c.violet },
        BlinkCmpLabelDeprecated = { fg = c.fg_dim, strikethrough = true },
        BlinkCmpLabelMatch = { fg = c.violet, bold = true },
        BlinkCmpSource = { fg = c.fg_dim },
        BlinkCmpGhostText = { fg = c.fg_subtle, italic = true },

        -- Diagnostic highlights
        DiagnosticError = { fg = c.error },
        DiagnosticWarn = { fg = c.warning },
        DiagnosticInfo = { fg = c.info },
        DiagnosticHint = { fg = c.hint },

        -- Diagnostic underlines
        DiagnosticUnderlineError = { undercurl = true, sp = c.error },
        DiagnosticUnderlineWarn = { undercurl = true, sp = c.warning },
        DiagnosticUnderlineInfo = { undercurl = true, sp = c.info },
        DiagnosticUnderlineHint = { undercurl = true, sp = c.hint },

        -- Treesitter
        ['@variable'] = { fg = c.fg },
        ['@variable.builtin'] = { fg = c.grey_light },

        ['@constant'] = { fg = c.grey_dark },
        ['@constant.builtin'] = { fg = c.grey_dark },

        ['@module'] = { fg = c.grey_light },

        ['@string'] = { fg = c.green },
        ['@string.regex'] = { fg = c.cyan },
        ['@string.escape'] = { fg = c.cyan },
        ['@string.special'] = { fg = c.cyan },

        ['@boolean'] = { fg = c.lavendar, italic = true },
        ['@number'] = { fg = c.fg_alt },
        ['@float'] = { fg = c.fg_alt },

        ['@function'] = { fg = c.violet, bold = false },
        ['@function.builtin'] = { fg = c.grey_light, bold = false },
        ['@function.macro'] = { fg = c.violet_subtle },
        ['@method'] = { fg = c.violet_subtle, bold = false },
        ['@method.call'] = { fg = c.violet_subtle },
        ['@constructor'] = { fg = c.fg_alt },
        ['@parameter'] = { fg = c.fg },

        ['@comment'] = { fg = c.fg_subtle, italic = true },
        ['@comment.documentation'] = { fg = c.fg_subtle, italic = true },

        ['@type'] = { fg = c.blue },
        ['@type.builtin'] = { fg = c.blue },
        ['@type.definition'] = { fg = c.blue },
        ['@type.qualifier'] = { fg = c.grey_light },

        ['@attribute'] = { fg = c.teal },
        ['@field'] = { fg = c.teal },

        ['@text.strong'] = { bold = true },
        ['@text.emphasis'] = { italic = true },
        ['@text.underline'] = { underline = true },
        ['@text.strike'] = { strikethrough = true },
        ['@text.quote'] = { fg = c.grey_mid, italic = true },
        ['@text.title'] = { fg = c.fg, bold = true },
        ['@text.literal'] = { fg = c.green },
        ['@text.uri'] = { fg = c.cyan, underline = true },
        ['@text.math'] = { fg = c.fg_alt },

        ['@tag'] = { fg = c.violet },
        ['@tag.attribute'] = { fg = c.violet_light },
        ['@tag.delimiter'] = { fg = c.violet_subtle },

        ['@namespace'] = { fg = c.fg },
        ['@symbol'] = { fg = c.fg },

        ['@punctuation.delimiter'] = { fg = c.fg_dim },
        ['@punctuation.bracket'] = { fg = c.fg_dim },

        -- LSP highlights
        LspReferenceText = { bg = c.bg_highlight },
        LspReferenceRead = { bg = c.bg_highlight },
        LspReferenceWrite = { bg = c.bg_highlight },

        -- Which-key
        WhichKey = { fg = c.violet },
        WhichKeyGroup = { fg = c.violet_light, bold = true },
        WhichKeyDesc = { fg = c.fg_dim },
        WhichKeySeparator = { fg = c.violet_subtle },
        WhichKeyFloat = { bg = c.bg_alt },

        -- Winbar
        WinBar = { fg = c.fg_subtle, bg = c.bg },

        -- NvimTree
        NvimTreeNormal = { fg = c.fg, bg = c.bg },
        NvimTreeWinSeparator = { fg = c.bg_alt },
        NvimTreeGitNew = { fg = c.green },
        NvimTreeGitDeleted = { fg = c.error },

        -- Git signs
        GitSignsAdd = { fg = c.green },
        GitSignsChange = { fg = c.warning },
        GitSignsDelete = { fg = c.error },

        -- Diff
        DiffAdd = { fg = c.green },
        DiffChange = { fg = c.warning },
        DiffDelete = { fg = c.error },
        DiffText = { fg = c.blue, bold = true },

        -- Error and warning
        Error = { fg = c.error },
        ErrorMsg = { fg = c.error },
        WarningMsg = { fg = c.warning },
    }

    for group, settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

return M
