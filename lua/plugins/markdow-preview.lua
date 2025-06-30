return {
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = function()
            require("lazy").load({ plugins = { "markdown-preview.nvim" } })
            vim.fn["mkdp#util#install"]()
        end,
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        keys = {
            {
                "<leader>map",
                ft = "markdown",
                "<cmd>MarkdownPreviewToggle<CR>",
                desc = "[M][a]rkdown [P]review",
            },
        },
    },
}
