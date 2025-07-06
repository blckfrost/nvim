-- To show Macro recording message in Lualine
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

local function show_fileformat()
    if vim.o.fileformat == "" then
        return ""
    else
        return vim.bo.fileformat:upper()
    end
end

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status")
        lualine.setup({
            options = {
                icons_enabled = true,
                globalstatus = vim.o.laststatus == 2,
                theme = "auto",
                component_separators = "",
                section_separators = "",
                always_divide_middle = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = function(res)
                            local replace = {
                                COMMAND = "C",
                                NORMAL = "N",
                                INSERT = "I",
                                VISUAL = "V",
                                ["V-BLOCK"] = "VB",
                                ["V-LINE"] = "VL",
                                TERMINAL = "T",
                                REPLACE = "R",
                            }
                            return replace[res] or res
                        end,
                        padding = 1,
                    },
                },
                lualine_b = {
                    {
                        "branch",
                        icon = { "", color = { fg = "#ff0000" } },
                        color = { fg = "#cba6f7" },
                        padding = 1,
                    },
                    {
                        virtual_env,
                        color = { fg = "#a6e3a1" },
                        padding = { left = 0, right = 1 },
                    },
                },
                lualine_c = {
                    {
                        "diagnostics",
                        padding = 1,
                        update_in_insert = true,
                        symbols = {
                            error = " ",
                            warn = " ",
                            info = " ",
                            hint = " ",
                        },
                    },
                    "%=",
                    {

                        "filename",
                        file_status = true,
                        newfile_status = true,
                        path = 1,
                        padding = 1,
                        color = { fg = "#cdd6f4" },
                    },

                    "searchcount",
                },
                lualine_x = {
                    {
                        show_macro_recording,
                        color = { fg = "#f38ba8", gui = "bold" },
                    },
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        padding = 1,
                    },
                    {
                        "diff",
                        symbols = { added = " ", modified = " ", removed = " " },
                        padding = 1,
                    },
                    -- {
                    --     "lsp_status",
                    -- },
                },
                lualine_y = {
                    {
                        "filetype",
                        icon_only = false,
                        fmt = string.upper,
                        separator = "::",
                        colored = false,
                    },
                    {
                        show_fileformat,
                    },
                    { "progress", padding = 1 },
                },
                lualine_z = {
                    -- { "location", padding = 1 },
                    {
                        function()
                            local bufnr = vim.api.nvim_get_current_buf()
                            local clients = vim.lsp.get_clients({ bufnr = bufnr })
                            if next(clients) == nil then
                                return ""
                            end
                            local client_names = {}
                            for _, client in pairs(clients) do
                                table.insert(client_names, client.name)
                            end
                            return table.concat(client_names, ", ")
                        end,
                        icon = " LSP:",
                    },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { "filename", file_status = true, path = 1 } },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            disabled_filetypes = { statuline = { "alpha", "NvimTree", "dashboard", "Outline" } },
            extensions = { "fugitive", "nvim-tree", "lazy", "fzf", "quickfix" },
        })
    end,
}
