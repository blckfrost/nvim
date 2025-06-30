return {
    "onsails/lspkind-nvim", -- vscode like pictograms
    event = "InsertEnter",
    config = function()
        local lspkind = require("lspkind")

        lspkind.init({
            -- enables text annotations
            --
            -- default: true
            mode = "symbol_text",

            -- default symbol map
            -- can be either 'default' (requires nerd-fonts font) or
            -- 'codicons' for codicon preset (requires vscode-codicons font)
            --
            -- default: 'default'
            preset = "codicons",

            -- override preset symbols
            --
            -- default: {}
            symbol_map = {
                Array = " ",
                Boolean = "󰨙 ",
                Class = " ",
                Codeium = "󰘦 ",
                Color = " ",
                Control = " ",
                Collapsed = " ",
                Constant = "󰏿 ",
                Constructor = " ",
                Copilot = " ",
                Enum = " ",
                EnumMember = " ",
                Event = " ",
                Field = " ",
                File = " ",
                Folder = " ",
                Function = "󰊕 ",
                Interface = " ",
                Key = " ",
                Keyword = " ",
                Method = "󰊕 ",
                Module = " ",
                Namespace = "󰦮 ",
                Null = " ",
                Number = "󰎠 ",
                Object = " ",
                Operator = " ",
                Package = " ",
                Property = " ",
                Reference = " ",
                Snippet = "󱄽 ",
                String = " ",
                Struct = "󰆼 ",
                Supermaven = " ",
                TabNine = "󰏚 ",
                Text = " ",
                TypeParameter = " ",
                Unit = " ",
                Value = " ",
                Variable = "󰀫 ",
            },
        })
    end,
}
