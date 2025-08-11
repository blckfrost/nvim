return {
    "rcarriga/nvim-notify",
    event = {"BufReadPost"},
    config = function()
        require("notify").setup({
            render = "wrapped-compact",
            background_colour = "#000000",
            fps = 30,
            timeout = 200,
        })
        vim.notify = require("notify")
    end,
}
