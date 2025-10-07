return {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
        {
            "<leader>Rs",
            function()
                require("kulala").run()
            end,
            desc = "Send request",
            ft = "http",
        },
        {
            "<leader>Ra",
            function()
                require("kulala").run_all()
            end,
            desc = "Send all requests",
            ft = "http",
        },
        {
            "<leader>Rb",
            function()
                require("kulala").scratchpad()
            end,
            desc = "Open scratchpad",
            ft = "http",
        },
        {
            "<leader>Rt",
            function()
                require("kulala").toggle_view()
            end,
            desc = "Toggle headers/body",
            ft = "http",
        },
        {
            "<leader>Rq",
            function()
                require("kulala").close()
            end,
            desc = "Close window",
            ft = "http",
        },
        {
            "<leader>RS",
            function()
                require("kulala").show_stats()
            end,
            desc = "Show stas",
            ft = "http",
        },
    },
    opts = {
        formatters = {
            json = { "jq", "." },
        },
    },
}
