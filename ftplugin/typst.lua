local function pdf_path()
	return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":r") .. ".pdf"
end

-- compile with error reporting
local function compile()
	vim.cmd.update()
	local src = vim.api.nvim_buf_get_name(0)
	local res = vim.system({ "typst", "compile", src, pdf_path() }, { text = true }):wait()
	if res.code ~= 0 then
		vim.notify(res.stderr, vim.log.levels.ERROR)
		return false
	end
	vim.notify("Compiled " .. vim.fn.fnamemodify(pdf_path(), ":t"))
	return true
end

-- compile once, then open in zathura
local function open()
	if compile() then
		vim.fn.jobstart({ "zathura", pdf_path() }, { detach = true })
	end
end

-- watch mode: recompiles on every change
local watch_job
local function watch()
	if watch_job then
		vim.fn.jobstop(watch_job)
		watch_job = nil
		vim.notify("Typst watch stopped")
		return
	end

	local src = vim.api.nvim_buf_get_name(0)
	watch_job = vim.fn.jobstart({ "typst", "watch", src, pdf_path() }, {
		on_stderr = function(_, data)
			-- shows errors on compile
			local msg = table.concat(data or {}, "\n")
			if msg:match("error") then
				vim.notify(msg, vim.log.levels.ERROR)
			end
		end,
	})
	vim.fn.jobstart({ "zathura", pdf_path() }, { detach = true })
	vim.notify("Typst watch started")
end

local map = function(lhs, fn, desc)
	vim.keymap.set("n", lhs, fn, { buffer = true, desc = desc })
end

vim.api.nvim_buf_create_user_command(0, "TypstCompile", compile, {})
vim.api.nvim_buf_create_user_command(0, "TypstOpen", open, {})
vim.api.nvim_buf_create_user_command(0, "TypstWatch", watch, {})

map("<leader>tc", compile, "Typst compile")
map("<leader>to", open, "Typst compile + open in pdf viewer")
map("<leader>tw", watch, "Typst watch")

vim.opt_local.spell = true
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
