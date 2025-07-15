return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    enabled = true,
    config = function()
        require("notify").setup({
            background_colour = "NormalFloat",
            fps = 30,
        })
    end,
    -- config = function()
    --     local notify = require("notify")
    --     notify.setup({
    --         background_colour = "#000000",
    --         fps = 30,
    --         icons = {
    --             DEBUG = "",
    --             ERROR = "",
    --             INFO = "",
    --             TRACE = "✎",
    --             WARN = "",
    --         },
    --         timeout = 200,
    --         stages = "fade_in_slide_out",
    --     })
    --     vim.notify = notify
    -- end,
}
