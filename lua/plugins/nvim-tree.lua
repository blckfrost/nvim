return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local nvimtree = require("nvim-tree")
        nvimtree.setup({
            auto_reload_on_write = true,
            sort_by = "name",
            hijack_cursor = true,
            disable_netrw = true,
            hijack_netrw = true,
            live_filter = {
                always_show_folders = false,
            },
            actions = {
                use_system_clipboard = true,
                open_file = { quit_on_open = false },
            },
            update_focused_file = {
                enable = true,
            },
            modified = {
                enable = true,
                show_on_dirs = false,
                show_on_open_dirs = false,
            },
            view = {
                -- adaptive_size = true,
                relativenumber = false,
                -- side = "right",
                width = 35,
                preserve_window_proportions = true,
                signcolumn = "yes",
            },
            filters = {
                enable = true,
                git_ignored = false,
                dotfiles = false,
                git_clean = false,
                no_buffer = false,
                no_bookmark = false,
                custom = {},
                exclude = {},
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                icons = {
                    error = " ",
                    warning = " ",
                    info = " ",
                    hint = " ",
                },
            },
            renderer = {
                root_folder_label = false,
                highlight_git = true,
                indent_markers = {
                    enable = true,
                },
                icons = {
                    modified_placement = "after",
                    webdev_colors = true,
                    padding = " ",
                    show = {
                        git = true,
                        folder = true,
                        file = true,
                        folder_arrow = true,
                        bookmarks = true,
                        diagnostics = true,
                        modified = true,
                    },
                    glyphs = {
                        -- default = " ",
                        default = "",
                        symlink = "",
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                            empty = "󱞞",
                            empty_open = "󱞞",
                            symlink = "",
                            symlink_open = "",
                        },
                        git = {
                            -- unstaged = "✗",
                            unstaged = "!",
                            staged = "✓",
                            -- unmerged = "",
                            unmerged = " ",
                            renamed = "󰕛 ",
                            untracked = "★",
                            deleted = "",
                            -- deleted = "󰧧",
                            -- ignored = "",
                            ignored = "",
                            -- conflict = "",
                        },
                    },
                },
            },
        })
        vim.keymap.set("n", "<c-n>", ":NvimTreeToggle<CR>", { silent = true })
    end,
}
