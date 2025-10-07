return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        vim.cmd(":hi statusline guibg=NONE")
        local colors = {
            bg = "NONE",
            fg = "#DCD7BA",
        }

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand("%:p:h")
                local gitdir = vim.fn.finddir(".git", filepath .. ";")
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }

        local function show_macro_recording()
            local recording_register = vim.fn.reg_recording()
            if recording_register == "" then
                return ""
            else
                return "󰑋 @ " .. recording_register
            end
        end

        local function virtual_env()
            if vim.bo.filetype ~= "python" then
                return ""
            end

            local venv_path = os.getenv("VIRTUAL_ENV")
            if venv_path then
                local venv_name = vim.fn.fnamemodify(venv_path, ":t")
                return string.format(" %s", venv_name)
            else
                return "[no-venv]"
            end
        end

        local config = {
            options = {
                component_separators = "",
                section_separators = "",

                theme = {
                    normal = { c = { fg = colors.fg, bg = colors.bg } },
                    inactive = { c = { fg = colors.fg, bg = colors.bg } },
                },
                disabled_filetypes = {
                    statusline = { "NvimTree", "alpha", "dashboard", "Outline" }, -- disable lualine for nvim-tree buffer
                    winbar = { "NvimTree" },
                },
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        }
        local mode_map = {
            ["NORMAL"] = "N",
            ["O-PENDING"] = "N?",
            ["INSERT"] = "I",
            ["VISUAL"] = "V",
            ["V-BLOCK"] = "VB",
            ["V-LINE"] = "VL",
            ["V-REPLACE"] = "VR",
            ["REPLACE"] = "R",
            ["COMMAND"] = "!",
            ["SHELL"] = "SH",
            ["TERMINAL"] = "T",
            ["EX"] = "X",
            ["S-BLOCK"] = "SB",
            ["S-LINE"] = "SL",
            ["SELECT"] = "S",
            ["CONFIRM"] = "Y?",
            ["MORE"] = "M",
        }
        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end

        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end

        ins_left({
            function()
                return "▊"
            end,
            color = { fg = "#000000" },
            padding = { left = 0, right = 1 },
        })

        ins_left({
            "mode",
            fmt = function(s)
                return mode_map[s]
            end,
            color = { gui = "bold" },
        })

        ins_left({
            "branch",
            cond = conditions.check_git_workspace,
            icon = { "", color = { fg = "#ff0000", gui = "bold" } },
        })

        ins_left({
            "filename",
            cond = conditions.buffer_not_empty,
            file_status = true,
            newfile_status = true,
        })

        ins_left({ "progress" })
        ins_left({ "location" })

        ins_left({
            "diagnostics",
            update_in_insert = true,
            symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
            },
        })

        ins_right({
            virtual_env,
            color = { fg = "#a6e3a1" },
            padding = { left = 0, right = 1 },
        })

        ins_right({
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
        })

        ins_right({
            show_macro_recording,
            color = { fg = "#f38ba8", gui = "bold" },
        })

        ins_right({
            "lsp_status",
            -- icon = " LSP:",
        })

        ins_right({ "filetype" })

        ins_right({
            function()
                return "▊"
            end,
            color = { fg = "#000000" },
            padding = { left = 1 },
        })

        require("lualine").setup(config)
    end,
}
