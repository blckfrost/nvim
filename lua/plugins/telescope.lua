return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },

    config = function()
        local keymap = vim.keymap
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")
        local action_layout = require("telescope.actions.layout")
        require("telescope").setup({
            defaults = {
                layout_strategy = "vertical",
                color_devicons = true,
                file_ignore_patterns = {
                    "%git/",
                    "node_modules",
                },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<M-p>"] = action_layout.toggle_preview, -- toggle preview
                    },
                },
            },
            pickers = {
                buffers = {
                    sort_lastused = true,
                    previewer = false,
                    theme = "dropdown",
                    mappings = {
                        i = {
                            ["<c-d>"] = "delete_buffer",
                        },
                    },
                },
                help_tags = {
                    theme = "ivy",
                    previewer = false,
                },
                live_grep = {
                    theme = "ivy",
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        require("telescope").load_extension("fzf")
        require("telescope").load_extension("ui-select")

        keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" }) --find files
        keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Show old files" }) --olf files
        keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
        keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Show buffers" })
        keymap.set(
            "n",
            "<leader>/",
            builtin.current_buffer_fuzzy_find,
            { desc = "Fzf Current Buffer" }
        )

        keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
        keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Show builtin man-pages" })
        keymap.set("n", "<leader>fco", builtin.commands, { desc = "Show vim builtin commands" })
        keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Show Keymaps" })

        keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Show git files" })
        keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Show git status" })

        keymap.set(
            "n",
            "<leader>fcs",
            builtin.colorscheme,
            { desc = "Show available colorschemes" }
        )

        keymap.set("n", "<leader>fs", builtin.spell_suggest, { desc = "Show Spelling Suggestion" })
    end,
}
