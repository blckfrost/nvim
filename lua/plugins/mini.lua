return {
    {
        "nvim-mini/mini.pick",
        config = function()
            require("mini.pick").setup({})
            vim.keymap.set("n", "<leader>fp", "<cmd>Pick files<CR>")
        end,
    },
    {
        "nvim-mini/mini.surround",
        opts = {
            mappings = {
                add = "ys",
            },
        },
    },
    -- {
    --     "nvim-mini/mini.comment",
    --     dependencies = {
    --         "JoosepAlviste/nvim-ts-context-commentstring",
    --     },
    --     opts = {
    --         mappings = {
    --             comment = "gb",
    --             comment_visual = "gb",
    --             textobject = "gb",
    --         },
    --         options = {
    --             -- 👇 This is the important part
    --             custom_commentstring = function()
    --                 local ok, internal = pcall(require, "ts_context_commentstring.internal")
    --                 if ok then
    --                     return internal.calculate_commentstring() or vim.bo.commentstring
    --                 end
    --                 return vim.bo.commentstring
    --             end,
    --         },
    --     },
    -- },
}
