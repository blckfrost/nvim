return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    cmd = "Telescope",
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Show old files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
        { "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Show buffers" },
        { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fzf Current Buffer" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
        { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Show builtin man-pages" },
        { "<leader>fco", "<cmd>Telescope commands<cr>", desc = "Show vim builtin commands" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Show Keymaps" },
        { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Show git files" },
        { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Show git status" },
        { "<leader>fcs", "<cmd>Telescope colorscheme<cr>", desc = "Show available colorschemes" },
        { "<leader>fs", "<cmd>Telescope spell_suggest<cr>", desc = "Show Spelling Suggestion" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },

    config = function()
        local actions = require("telescope.actions")
        local action_layout = require("telescope.actions.layout")
        require("telescope").setup({
            defaults = {
                color_devicons = true,
                prompt_prefix = "   ",
                selection_caret = " ",
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
                help_tags = {
                    theme = "ivy",
                    previewer = false,
                },
                live_grep = {
                    theme = "ivy",
                },
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
    end,
}
