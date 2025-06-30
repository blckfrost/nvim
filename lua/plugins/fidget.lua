return {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
        progress = {
            suppress_on_insert = true,
            ignore_done_already = false,
            ignore_empty_message = false,
            display = {
                progress_icon = { pattern = "moon" },
            },
        },
        notification = {
            window = {
                relative = "editor", -- where to anchor, either "win" or "editor"
                winblend = 0, -- &winblend for the window
                border = "none", -- style of border for the fidget window
            },
        },
    },
}
