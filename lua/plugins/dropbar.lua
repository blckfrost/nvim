return {
    "Bekaboo/dropbar.nvim",
    event = "BufReadPre",
    dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
}
