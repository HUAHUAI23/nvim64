local status, toggleterm = pcall(require, "toggleterm")
if not status then
	vim.notify("没有找到 toggleterm")
	return
end

toggleterm.setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 10
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.3
		end
	end,
	start_in_insert = true,
})

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "rounded",
		width = vim.o.columns * 0.8,
		height = vim.o.lines * 0.8,
	},
	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		--q | <leader>tg 关闭terminal
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		-- vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<leader>tg", "<cmd>close<CR>", { noremap = true, silent = true })
		-- ESC 键取消，留给lazygit
		if vim.fn.mapcheck("<Esc>", "t") ~= "" then
			vim.api.nvim_del_keymap("t", "<Esc>")
		end
	end,
	-- function to run on closing the terminal
	on_close = function(term)
		-- 添加回来, 前面取消了<Esc>的映射
		vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {
			noremap = true,
			silent = true,
		})
	end,
})

local ta = Terminal:new({
	direction = "float",
	float_opts = {
		border = "rounded",
	},
	close_on_exit = true,
})

local tb = Terminal:new({
	direction = "vertical",
	close_on_exit = true,
})

local tc = Terminal:new({
	direction = "horizontal",
	close_on_exit = true,
})

local M = {}

M.toggleA = function(cmd)
	if ta:is_open() then
		ta:close()
		return
	end
	tb:close()
	tc:close()
	lazygit:close()
	ta:open()
	if cmd ~= nil then
		ta:send(cmd)
	end
end

M.toggleB = function()
	if tb:is_open() then
		tb:close()
		return
	end
	ta:close()
	tc:close()
	lazygit:close()
	tb:open()
end

M.toggleC = function()
	if tc:is_open() then
		tc:close()
		return
	end
	ta:close()
	tb:close()
	lazygit:close()
	tc:open()
end

M.toggleG = function()
	if lazygit:is_open() then
		lazygit:close()
		return
	end
	ta:close()
	tb:close()
	tc:close()
	lazygit:open()
end

require("keybindings").mapToggleTerm(M)
