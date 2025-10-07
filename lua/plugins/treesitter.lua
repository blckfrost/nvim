return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            opts = {
                enabled = true,
                enable_autocmd = false,
            },
        },
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            sync_install = false,
            auto_install = true,
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "javascript",
                "typescript",
                "html",
                "css",
                "json",
                "markdown",
                "bash",
                "go",
                "gomod",
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = { query = "@function.outer", desc = "around a function" },
                        ["if"] = { query = "@function.inner", desc = "inside a function" },
                        ["ac"] = { query = "@class.outer", desc = "around a class" },
                        ["ic"] = { query = "@class.inner", desc = "inside a class" },
                        ["al"] = { query = "@loop.outer", desc = "around a loop" },
                        ["il"] = { query = "@loop.inner", desc = "inside a loop" },
                        ["aa"] = { query = "@parameter.outer", desc = "around a parameter" },
                        ["ia"] = { query = "@parameter.inner", desc = "inside a parameter" },
                        ["a="] = { query = "@assignment.outer", desc = "around an assignment" },
                        ["i="] = { query = "@assignment.inner", desc = "inside an assignment" },
                        ["l="] = { query = "@assignment.outer", desc = "lhs of assignment" },
                        ["r="] = { query = "@assignment.rhs", desc = "rhs of assignment" },
                        ["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
                        ["ii"] = { query = "@conditional.inner", desc = "inside an if statement" },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = { query = "@parameter.inner", desc = "Swap next parameter" },
                    },
                    swap_previous = {
                        ["<leader>A"] = {
                            query = "@parameter.inner",
                            desc = "Swap previous parameter",
                        },
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = { query = "@function.outer", desc = "Next function start" },
                        ["]c"] = { query = "@class.outer", desc = "Next class start" },
                        ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
                    },
                    goto_previous_start = {
                        ["[f"] = { query = "@function.outer", desc = "Previous function start" },
                        ["[c"] = { query = "@class.outer", desc = "Previous class start" },
                        ["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
                    },
                },
            },
        })
    end,
}
