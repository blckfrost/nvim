return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = true,
            },
        })

        vim.keymap.set("n", "Mm", function()
            harpoon:list():add()

            local file = vim.api.nvim_buf_get_name(0)
            vim.notify("Harpoon: ::" .. file .. ":: added", vim.log.levels.INFO, {})
        end)

        vim.keymap.set("n", "<leader>mm", function()
            harpoon.ui:toggle_quick_menu(harpoon:list(), { title_pos = "center" })
        end)

        vim.keymap.set("n", "<leader>mh", function()
            require("telescope").extensions.harpoon.marks()
        end)

        vim.keymap.set("n", "M1", function()
            harpoon:list():select(1)
        end)

        vim.keymap.set("n", "M2", function()
            harpoon:list():select(2)
        end)
        vim.keymap.set("n", "M3", function()
            harpoon:list():select(3)
        end)
        vim.keymap.set("n", "M4", function()
            harpoon:list():select(4)
        end)
        vim.keymap.set("n", "M5", function()
            harpoon:list():select(5)
        end)
    end,
}
