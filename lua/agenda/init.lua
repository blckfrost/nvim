local M = {}
local api, fn = vim.api, vim.fn
local ns = api.nvim_create_namespace("agenda")

M.config = {
	dir = "~/garden/tasks", -- folder containing the weekly files
	glob = "*.md", -- which files in that folder to scan
	overdue_limit = 10, -- max lines in the "Overdue" section
	open_cmd = "botright split", -- how the agenda window is opened
	highlights = {}, -- overrides, e.g. { AgendaToday = { bg = "#334455", bold = true } }
}

-- Default highlight groups. Override via setup{highlights=...} or by
-- defining the group yourself (e.g. in your colorscheme) before setup().
local DEFAULT_HL = {
	AgendaTitle = { link = "Title" },
	AgendaHint = { link = "Comment" },
	AgendaSection = { link = "Type" }, -- "Overdue" / "Goals"
	AgendaDay = { link = "Function" }, -- normal day header
	AgendaToday = { link = "Visual" }, -- today's header (whole line)
	AgendaDone = { link = "Comment" }, -- dimmed done task
	AgendaDoneStrike = { strikethrough = true }, -- layered over AgendaDone, text only
	AgendaOverdue = { link = "WarningMsg" }, -- unfinished + past date
}

local function apply_highlights()
	for name, def in pairs(DEFAULT_HL) do
		api.nvim_set_hl(0, name, vim.tbl_extend("force", def, { default = true }))
	end
	for name, def in pairs(M.config.highlights) do
		api.nvim_set_hl(0, name, def)
	end
end

---------------------------------------------------------------------------
-- Parsing
---------------------------------------------------------------------------

-- Parse one file's lines into `tops` (top-level tasks) and `all` (every task).
local function parse_lines(path, lines, tops, all)
	local year, wk_month, wk_key -- from "# Week of YYYY-MM-DD"
	local date, in_goals, stack = nil, false, {}
	for lnum, line in ipairs(lines) do
		local y, m, d = line:match("^#%s+Week of (%d+)-(%d+)-(%d+)")
		if y then
			year, wk_month, wk_key = tonumber(y), tonumber(m), ("%s-%s-%s"):format(y, m, d)
			date, in_goals, stack = nil, false, {}
		elseif line:match("^##%s") then
			-- Any "## ..." heading starts a new context and resets nesting.
			date, in_goals, stack = nil, false, {}
			if line:match("^##%s+Goals%s*$") then
				in_goals = true
			else
				local mm, dd = line:match("^##%s+%a+%s+(%d+)-(%d+)")
				if mm and year then
					-- A week spanning New Year (week of 12-28 has a "01-02" day) rolls the year.
					local yy = year + ((tonumber(mm) < wk_month - 6) and 1 or 0)
					date = ("%04d-%02d-%02d"):format(yy, tonumber(mm), tonumber(dd))
				end
			end
		else
			local ind, mark, text = line:match("^([ \t]*)[-*+]%s+%[(.)%]%s*(.*)$")
			if ind and (date or in_goals) then
				local width = #(ind:gsub("\t", "    "))
				local task = {
					file = path,
					lnum = lnum,
					date = date,
					goal = in_goals,
					week = wk_key,
					done = mark:lower() == "x" or text:find("~~.+~~") ~= nil,
					text = text:gsub("~~", ""),
					width = width,
					children = {},
				}
				-- Pop until the top of the stack is shallower: that is our parent.
				while #stack > 0 and stack[#stack].width >= width do
					table.remove(stack)
				end
				local parent = stack[#stack]
				table.insert(parent and parent.children or tops, task)
				table.insert(all, task)
				table.insert(stack, task)
			end
		end
	end
end

-- Scan every weekly file. Loaded buffers win over disk so unsaved edits show.
local function parse_all()
	local dir = fn.fnamemodify(fn.expand(M.config.dir), ":p:h")
	local loaded = {}
	for _, b in ipairs(api.nvim_list_bufs()) do
		if api.nvim_buf_is_loaded(b) then
			loaded[api.nvim_buf_get_name(b)] = b
		end
	end
	local tops, all = {}, {}
	for _, f in ipairs(fn.glob(dir .. "/" .. M.config.glob, false, true)) do
		local path = fn.fnamemodify(f, ":p")
		local lines = loaded[path] and api.nvim_buf_get_lines(loaded[path], 0, -1, false) or fn.readfile(path)
		parse_lines(path, lines, tops, all)
	end
	return tops, all
end

---------------------------------------------------------------------------
-- Rendering
---------------------------------------------------------------------------

local function monday_of(t) -- noon of the Monday of t's week
	local offset = (tonumber(os.date("%w", t)) + 6) % 7
	return t - offset * 86400
end

local function render()
	local tops, all = parse_all()
	local lines, marks, map = {}, {}, {}
	local today = os.date("%Y-%m-%d")

	-- Append a line; `group` highlights the text, `line_group` the whole row.
	local function put(text, group, line_group)
		lines[#lines + 1] = text
		local row = #lines - 1
		if group then
			marks[#marks + 1] = { row, 0, { end_col = #text, hl_group = group } }
		end
		if line_group then
			marks[#marks + 1] = { row, 0, { line_hl_group = line_group } }
		end
	end

	-- Append a task (and, unless `flat`, its subtasks indented below it).
	local function put_task(t, depth, suffix, flat)
		local prefix = ("  "):rep(depth + 1) .. (t.done and "[x] " or "[ ] ")
		local text = prefix .. t.text .. (suffix or "")
		put(text)
		local row = #lines - 1
		map[#lines] = t
		if t.done then
			marks[#marks + 1] = { row, 0, { end_col = #text, hl_group = "AgendaDone" } }
			marks[#marks + 1] = { row, #prefix, { end_col = #prefix + #t.text, hl_group = "AgendaDoneStrike" } }
		elseif t.date and t.date < today then
			marks[#marks + 1] = { row, 0, { end_col = #text, hl_group = "AgendaOverdue" } }
		end
		if not flat then
			for _, c in ipairs(t.children) do
				put_task(c, depth + 1)
			end
		end
	end

	local ws = M.week_start
	local first = os.date("%Y-%m-%d", ws)
	local last = os.date("%Y-%m-%d", ws + 6 * 86400)
	put(("Agenda: Week %s | week of %s to %s"):format(os.date("%V", ws), first, last), "AgendaTitle")
	put("<CR> jump  x toggle  r refresh  f/b week  . today  q close", "AgendaHint")
	put("")

	-- Overdue: unfinished tasks dated before today, from ANY week, oldest first.
	local overdue = {}
	for _, t in ipairs(all) do
		if not t.done and t.date and t.date < today then
			overdue[#overdue + 1] = t
		end
	end
	table.sort(overdue, function(a, b)
		return ("%s|%s|%06d"):format(a.date, a.file, a.lnum) < ("%s|%s|%06d"):format(b.date, b.file, b.lnum)
	end)
	if #overdue > 0 then
		put("Overdue", "AgendaSection")
		for i = 1, math.min(#overdue, M.config.overdue_limit) do
			put_task(overdue[i], 0, "  (" .. overdue[i].date .. ")", true)
		end
		if #overdue > M.config.overdue_limit then
			put(("  ... and %d more"):format(#overdue - M.config.overdue_limit), "AgendaHint")
		end
		put("")
	end

	-- Goals belonging to the displayed week (undated, so their own section).
	local goals = vim.tbl_filter(function(t)
		return t.goal and t.week and t.week >= first and t.week <= last
	end, tops)
	if #goals > 0 then
		put("Goals", "AgendaSection")
		for _, t in ipairs(goals) do
			put_task(t, 0)
		end
		put("")
	end

	-- One header per day, then that day's top-level tasks (subtasks nest).
	local by_date = {}
	for _, t in ipairs(tops) do
		if t.date then
			by_date[t.date] = by_date[t.date] or {}
			table.insert(by_date[t.date], t)
		end
	end
	local w = os.date("*t", ws)
	for i = 0, 6 do
		local t = os.time({ year = w.year, month = w.month, day = w.day + i, hour = 12 })
		local key = os.date("%Y-%m-%d", t)
		local is_today = key == today
		put(os.date("%A %d %B %Y", t), (not is_today) and "AgendaDay" or nil, is_today and "AgendaToday" or nil)
		for _, task in ipairs(by_date[key] or {}) do
			put_task(task, 0)
		end
		put("")
	end
	return lines, marks, map
end

function M.refresh()
	local buf = M.buf
	if not (buf and api.nvim_buf_is_valid(buf)) then
		return
	end
	local lines, marks, map = render()
	local win = fn.bufwinid(buf)
	local cur = win ~= -1 and api.nvim_win_get_cursor(win)[1] or 1
	vim.bo[buf].modifiable = true
	api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false
	api.nvim_buf_clear_namespace(buf, ns, 0, -1)
	for _, m in ipairs(marks) do
		m[3].strict = false
		api.nvim_buf_set_extmark(buf, ns, m[1], m[2], m[3])
	end
	M.map = map
	if win ~= -1 then
		api.nvim_win_set_cursor(win, { math.min(cur, #lines), 0 })
	end
end

---------------------------------------------------------------------------
-- Actions
---------------------------------------------------------------------------

local function task_at_cursor()
	return (M.map or {})[api.nvim_win_get_cursor(0)[1]]
end

local function jump()
	local t = task_at_cursor()
	if not t then
		return
	end
	if M.origin_win and api.nvim_win_is_valid(M.origin_win) then
		api.nvim_set_current_win(M.origin_win)
	end
	vim.cmd("edit " .. fn.fnameescape(t.file))
	api.nvim_win_set_cursor(0, { t.lnum, 0 })
	vim.cmd("normal! zz")
end

-- Toggle done on the source line: [ ] <-> [x] and add/remove ~~ ~~ around the text.
local function toggle()
	local t = task_at_cursor()
	if not t then
		return
	end
	local sbuf = fn.bufadd(t.file)
	fn.bufload(sbuf)
	local was_modified = vim.bo[sbuf].modified
	local line = api.nvim_buf_get_lines(sbuf, t.lnum - 1, t.lnum, false)[1] or ""
	local pre, mark, gap, text = line:match("^([ \t]*[-*+]%s+%[)(.)(%]%s*)(.*)$")
	if not pre then
		return vim.notify("agenda: source line changed, press r to refresh", vim.log.levels.WARN)
	end
	text = vim.trim(text)
	if mark:lower() == "x" or text:find("~~.+~~") then
		mark, text = " ", text:gsub("~~", "") -- done -> not done
	else
		mark = "x" -- not done -> done
		if text ~= "" then
			text = "~~" .. text .. "~~"
		end
	end
	api.nvim_buf_set_lines(sbuf, t.lnum - 1, t.lnum, false, { pre .. mark .. gap .. text })
	if was_modified then
		vim.notify(
			"agenda: " .. fn.fnamemodify(t.file, ":t") .. " has unsaved changes; not written",
			vim.log.levels.WARN
		)
	else
		api.nvim_buf_call(sbuf, function()
			vim.cmd("silent write")
		end)
	end
	M.refresh()
end

local function shift_week(days)
	M.week_start = days and (M.week_start + days * 86400) or monday_of(os.time())
	M.refresh()
end

---------------------------------------------------------------------------
-- Window / setup
---------------------------------------------------------------------------

function M.open()
	M.week_start = M.week_start or monday_of(os.time())
	if M.buf and api.nvim_buf_is_valid(M.buf) then
		local win = fn.bufwinid(M.buf)
		if win ~= -1 then
			api.nvim_set_current_win(win)
			return M.refresh()
		end
		api.nvim_buf_delete(M.buf, { force = true })
	end
	M.origin_win = api.nvim_get_current_win()
	vim.cmd(M.config.open_cmd)
	local buf = api.nvim_create_buf(false, true)
	api.nvim_win_set_buf(0, buf)
	M.buf = buf
	for opt, val in pairs({ buftype = "nofile", bufhidden = "wipe", swapfile = false, filetype = "agenda" }) do
		vim.bo[buf][opt] = val
	end
	vim.wo.wrap, vim.wo.cursorline, vim.wo.number, vim.wo.relativenumber = false, true, false, false

	local function map(key, f)
		vim.keymap.set("n", key, f, { buffer = buf, nowait = true, silent = true })
	end
	map("<CR>", jump)
	map("x", toggle)
	map("r", M.refresh)
	map("f", function()
		shift_week(7)
	end)
	map("b", function()
		shift_week(-7)
	end)
	map(".", function()
		shift_week(nil)
	end)
	map("q", function()
		api.nvim_buf_delete(buf, { force = true })
	end)
	M.refresh()
end

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
	apply_highlights()
	api.nvim_create_autocmd(
		"ColorScheme",
		{ group = api.nvim_create_augroup("AgendaHL", { clear = true }), callback = apply_highlights }
	)
	api.nvim_create_user_command("Agenda", M.open, { desc = "Open the weekly markdown agenda" })
end

return M
