local M = {}

M.colors = {
    white = "#d8dee9",
    grey_light = "#677777",
    grey_mid = "#606060",
    grey_dark = "#4c4c4c",
    grey_darker = "#424242",

    bg = "#101010",
    bg_alt = "#202020",
    bg_highlight = "#2a2a2a",
    bg_subtle = "#303030",

    fg = "#d9d9d9",
    fg_alt = "#808080",
    fg_subtle = "#666666",
    fg_dim = "#808080",

    error = "#b87a7a",
    warning = "#b8a87a",
    info = "#8a8a8a",
    success = "#7ab87a",

    border = "#353535",
    selection = "#404040",
    cursor_line = "#252525",
    line_nr = "#585858",
    line_nr_active = "#a0a0a0",

    line = "#2e2e2e",
    black = "#101010",
    blue = "#8abae1",
    yellow = "#ffe6b5",
    sun = "#eff6ab",
    purple = "#e1bee9",
    dark_purple = "#db9fe9",
    teal = "#6484a4",
    cyan = "#9aafe6",
    green = "#7ab27a",
}

function M.setup()
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end

    vim.o.background = "dark"
    vim.g.colors_name = "frost"

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
        Boolean = { fg = c.grey_light },
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

        Statement = { fg = c.grey_light, bold = true },
        Conditional = { fg = c.grey_light, bold = true },
        Repeat = { fg = c.grey_light, bold = true },
        Label = { fg = c.grey_light },
        Operator = { fg = c.fg_dim },
        Keyword = { fg = c.grey_light, bold = true },
        Exception = { fg = c.grey_light, bold = true },

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
        TelescopeSelectionCaret = { fg = c.grey_light },
        TelescopeNormal = { fg = c.fg, bg = c.bg },
        TelescopeBorder = { fg = c.border, bg = c.bg },
        TelescopePromptBorder = { fg = c.border, bg = c.bg },
        TelescopeResultsBorder = { fg = c.border, bg = c.bg },
        TelescopeMultiSelection = { fg = c.grey_dark },
        TelescopePreviewBorder = { fg = c.border, bg = c.bg },
        TelescopePromptTitle = { fg = c.fg, bold = true },
        TelescopeResultsTitle = { fg = c.fg, bold = true },
        TelescopePreviewTitle = { fg = c.fg, bold = true },

        -- Cmp
        CmpItemAbbr = { fg = c.fg },
        CmpItemAbbrMatch = { fg = c.grey_light, bold = true },
        CmpItemKind = { fg = c.purple },
        CmpItemMenu = { fg = c.fg_dim },
        CmpItemAbbrDeprecated = { fg = c.fg_dim, strikethrough = true },
        CmpItemAbbrMatchFuzzy = { fg = c.grey_light, bold = true },

        -- Blink Cmp
        BlinkCmpMenu = { fg = c.fg, bg = c.bg_alt },
        BlinkCmpMenuBorder = { fg = c.border, bg = c.bg_alt },
        BlinkCmpLabel = { fg = c.fg },
        BlinkCmpKind = { fg = c.purple },
        BlinkCmpMenuSelection = { fg = c.bg, bg = c.grey_light },
        BlinkCmpLabelDeprecated = { fg = c.fg_dim, strikethrough = true },
        BlinkCmpLabelMatch = { fg = c.grey_light, bold = true },
        BlinkCmpSource = { fg = c.fg_dim },
        BlinkCmpGhostText = { fg = c.fg_subtle, italic = true },

        -- Diagnostic highlights
        DiagnosticError = { fg = c.error },
        DiagnosticWarn = { fg = c.warning },
        DiagnosticInfo = { fg = c.info },
        DiagnosticHint = { fg = c.grey_mid },

        -- Diagnostic underlines
        DiagnosticUnderlineError = { undercurl = true, sp = c.error },
        DiagnosticUnderlineWarn = { undercurl = true, sp = c.warning },
        DiagnosticUnderlineInfo = { undercurl = true, sp = c.info },
        DiagnosticUnderlineHint = { undercurl = true, sp = c.grey_mid },

        -- Treesitter
        ["@variable"] = { fg = c.fg },
        ["@variable.builtin"] = { fg = c.grey_light },

        ["@constant"] = { fg = c.grey_dark },
        ["@constant.builtin"] = { fg = c.grey_dark },

        ["@module"] = { fg = c.grey_dark },

        ["@string"] = { fg = c.green },
        ["@string.regex"] = { fg = c.blue },
        ["@string.escape"] = { fg = c.fg_alt },
        ["@string.special"] = { fg = c.fg_alt },

        ["@boolean"] = { fg = c.fg_alt },
        ["@number"] = { fg = c.fg_alt },
        ["@float"] = { fg = c.fg_alt },

        ["@function"] = { fg = c.grey_light, bold = true },
        ["@function.builtin"] = { fg = c.grey_light, bold = true },
        ["@function.macro"] = { fg = c.grey_light },
        ["@method"] = { fg = c.dark_purple, bold = true },
        ["@method.call"] = { fg = c.dark_purple },
        ["@constructor"] = { fg = c.fg_alt },
        ["@parameter"] = { fg = c.fg },

        ["@comment"] = { fg = c.fg_subtle, italic = true },
        ["@comment.documentation"] = { fg = c.fg_subtle, italic = true },

        ["@type"] = { fg = c.blue },
        ["@type.builtin"] = { fg = c.blue },
        ["@type.definition"] = { fg = c.blue },
        ["@type.qualifier"] = { fg = c.grey_light },

        ["@attribute"] = { fg = c.teal },
        ["@field"] = { fg = c.teal },

        ["@text.strong"] = { bold = true },
        ["@text.emphasis"] = { italic = true },
        ["@text.underline"] = { underline = true },
        ["@text.strike"] = { strikethrough = true },
        ["@text.quote"] = { fg = c.grey_mid, italic = true },
        ["@text.title"] = { fg = c.fg, bold = true },
        ["@text.literal"] = { fg = c.green },
        ["@text.uri"] = { fg = c.cyan, underline = true },
        ["@text.math"] = { fg = c.fg_alt },

        ["@tag"] = { fg = c.purple },
        ["@tag.attribute"] = { fg = c.teal },
        ["@tag.delimiter"] = { fg = c.grey_light },

        ["@namespace"] = { fg = c.fg },
        ["@symbol"] = { fg = c.fg },

        ["@punctuation.delimiter"] = { fg = c.fg_dim },
        ["@punctuation.bracket"] = { fg = c.fg_dim },

        -- LSP highlights
        LspReferenceText = { bg = c.bg_highlight },
        LspReferenceRead = { bg = c.bg_highlight },
        LspReferenceWrite = { bg = c.bg_highlight },

        -- Which-key
        WhichKey = { fg = c.grey_light },
        WhichKeyGroup = { fg = c.grey_mid, bold = true },
        WhichKeyDesc = { fg = c.fg_dim },
        WhichKeySeparator = { fg = c.fg_subtle },
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
