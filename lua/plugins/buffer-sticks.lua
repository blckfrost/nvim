return {
    "ahkohd/buffer-sticks.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>j",
            function()
                BufferSticks.jump()
            end,
            desc = "Buffer jump mode",
        },
        {
            "<leader>J",
            function()
                BufferSticks.toggle()
            end,
            desc = "Toggle buffer-sticks",
        },
    },
    config = function()
        local sticks = require("buffer-sticks")
        sticks.setup({
            highlights = {
                active = { link = "Statement" },
                inactive = { link = "Whitespace" },
                active_modified = { link = "Constant" },
                alternate_modified = { link = "Constant" },
                inactive_modified = { link = "Constant" },
                label = { link = "Comment" },
            },
        })
        sticks.show()
    end,
}
