local add_on_event = require("vim-pack").add_on_event

add_on_event("UIEnter", {
	{
		src = "nvim-lualine/lualine.nvim",
		on_setup = function()
			local c = require("themes.frost").colors
			vim.cmd(":hi statusline guibg=NONE")

			local colors = {
				bg = "NONE",
				fg = c.fg,
			}

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			-- local function show_macro_recording()
			--     local recording_register = vim.fn.reg_recording()
			--     if recording_register == "" then
			--         return ""
			--     else
			--         return "󰑋 @ " .. recording_register
			--     end
			-- end

			local function virtual_env()
				if vim.bo.filetype ~= "python" then
					return ""
				end

				local venv_path = os.getenv("VIRTUAL_ENV")
				if venv_path then
					local venv_name = vim.fn.fnamemodify(venv_path, ":t")
					return string.format(" %s", venv_name)
				else
					return "[no-venv]"
				end
			end

			local function set_diff_highlights()
				vim.api.nvim_set_hl(0, "LualineDiffBracket", { fg = c.fg })
				vim.api.nvim_set_hl(0, "LualineDiffAdd", { fg = c.green })
				vim.api.nvim_set_hl(0, "LualineDiffChange", { fg = c.warning })
				vim.api.nvim_set_hl(0, "LualineDiffDelete", { fg = c.error })
			end

			set_diff_highlights()
			local function diff_source()
				local d = vim.b.gitsigns_status_dict
				local added, changed, removed = 0, 0, 0
				if d then
					added, changed, removed = d.added or 0, d.changed or 0, d.removed or 0
				end
				return string.format(
					"%%#LualineDiffBracket#[%%#LualineDiffAdd# %d %%#LualineDiffChange# %d %%#LualineDiffDelete# %d%%#LualineDiffBracket#]%%*",
					added,
					changed,
					removed
				)
			end

			local config = {
				options = {
					component_separators = "",
					section_separators = "",

					theme = {
						normal = { c = { fg = colors.fg, bg = colors.bg } },
						inactive = { c = { fg = colors.fg, bg = colors.bg } },
					},
					disabled_filetypes = {
						statusline = { "NvimTree", "alpha", "dashboard", "Outline" }, -- disable lualine for nvim-tree buffer
						winbar = { "NvimTree" },
					},
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}
			local mode_map = {
				["NORMAL"] = "NOR",
				["O-PENDING"] = "N?",
				["INSERT"] = "INS",
				["VISUAL"] = "V",
				["V-BLOCK"] = "VB",
				["V-LINE"] = "VL",
				["V-REPLACE"] = "VR",
				["REPLACE"] = "R",
				["COMMAND"] = "!",
				["SHELL"] = "SH",
				["TERMINAL"] = "T",
				["EX"] = "X",
				["S-BLOCK"] = "SB",
				["S-LINE"] = "SL",
				["SELECT"] = "S",
				["CONFIRM"] = "Y?",
				["MORE"] = "M",
			}
			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end

			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			ins_left({
				function()
					return "▊"
				end,
				color = { fg = c.green },
				padding = { left = 0, right = 1 },
			})

			ins_left({
				"mode",
				fmt = function(s)
					return mode_map[s]
				end,
				color = { gui = "bold" },
			})

			ins_left({
				"filetype",
				icon_only = true,
				padding = { left = 1, right = 0 },
			})

			ins_left({
				"filename",
				cond = conditions.buffer_not_empty,
				file_status = true,
				newfile_status = true,
				padding = { left = 0, right = 1 },
			})

			ins_left({ "progress" })
			ins_left({ "location" })

			ins_left({
				"diagnostics",
				update_in_insert = true,
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
			})

			ins_right({
				virtual_env,
				color = { fg = "#a6e3a1" },
				padding = { left = 0, right = 1 },
			})

			ins_right({
				diff_source,
			})

			-- ins_right({
			--     show_macro_recording,
			--     color = { fg = "#f38ba8", gui = "bold" },
			-- })

			ins_right({
				-- "lsp_status",
				-- -- icon = " LSP:",
				function()
					local bufnr = vim.api.nvim_get_current_buf()
					local clients = vim.lsp.get_clients({ bufnr = bufnr })

					if next(clients) == nil then
						return ""
					end

					local excluded_clients = {
						["copilot"] = true,
						-- ["null-ls"] = true,
					}

					local client_names = {}
					for _, client in pairs(clients) do
						if not excluded_clients[client.name] then
							table.insert(client_names, client.name)
						end
					end
					return table.concat(client_names, ", ")
				end,
			})

			ins_right({
				"branch",
				cond = conditions.check_git_workspace,
				icon = { "", color = { fg = "#ff0000", gui = "bold" } },
			})

			ins_right({
				function()
					return "▊"
				end,
				color = { fg = c.green },
				padding = { left = 1 },
			})

			require("lualine").setup(config)
		end,
	},
})
