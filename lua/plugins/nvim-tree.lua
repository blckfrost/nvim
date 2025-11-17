return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "NvimTreeToggle" },
    keys = {
        { "<c-n>", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree", silent = true },
    },
    config = function()
        require("nvim-tree").setup()
    end,
}
