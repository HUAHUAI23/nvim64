local status, toggleterm = pcall(require, "toggleterm")
if not status then
	vim.notify("没有找到 toggleterm")
	return
end

toggleterm.setup({
	size = function(term)
		if term.direction == "horizontal" then
			return vim.o.lines * 0.35
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.3
		end
	end,
	start_in_insert = true,
	highlights = {
		FloatBorder = {
			link = "FloatBorder",
		},
	},
})
local keybind = require("keybindings")
local keybindingAlias = require("keybindingAlias")
local unsetMap = { t = { keybindingAlias.term.horizontal_split, keybindingAlias.term.vertical_split } }
local setMap = {
	{
		mode = "t",
		lhs = keybindingAlias.term.horizontal_split,
		rhs = [[:sp | terminal<CR>]],
		opts = { silent = false },
		description = "open terminal horizontal split",
	},
	{
		mode = "t",
		lhs = keybindingAlias.term.vertical_split,
		rhs = [[:vsp | terminal<CR>]],
		opts = { silent = false },
		description = "open terminal vertical split",
	},
}
local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	-- hidden = true,
	float_opts = {
		border = "rounded",
		width = math.floor(vim.o.columns * 0.9),
		height = math.floor(vim.o.lines * 0.9),
	},
	-- function to run on opening the terminal
	---@diagnostic disable-next-line: unused-local
	on_open = function(term)
		vim.cmd("startinsert!")
		--q | <leader>tg 关闭terminal
		-- vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		-- vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<leader>tg", "<cmd>close<CR>", { noremap = true, silent = true })

		-- ESC 键取消，留给lazygit
		-- https://neovim.io/doc/user/builtin.html   #mapcheck
		if vim.fn.mapcheck("<Esc>", "t") ~= "" then
			vim.api.nvim_del_keymap("t", "<Esc>")
		end

		for k, v in pairs(unsetMap) do
			if type(v) == "string" then
				if vim.fn.mapcheck(v, k) ~= "" then
					vim.api.nvim_del_keymap(k, v)
				end
			else
				for _, vv in ipairs(v) do
					if vim.fn.mapcheck(vv, k) ~= "" then
						vim.api.nvim_del_keymap(k, vv)
					end
				end
			end
		end
	end,
	-- function to run on closing the terminal
	---@diagnostic disable-next-line: unused-local
	on_close = function(term)
		-- 添加回来, 前面取消了<Esc>的映射
		vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {
			noremap = true,
			silent = true,
		})
		keybind.bulk_register_keymaps(setMap)
	end,
})

local ta = Terminal:new({
	direction = "float",
	float_opts = {
		border = "rounded",
	},
	close_on_exit = true,
	-- function to run on opening the terminal
	---@diagnostic disable-next-line: unused-local
	on_open = function(term)
		vim.cmd("startinsert!")
		-- ESC 键取消，留给terminal
		if vim.fn.mapcheck("<Esc>", "t") ~= "" then
			vim.api.nvim_del_keymap("t", "<Esc>")
		end
		for k, v in pairs(unsetMap) do
			if type(v) == "string" then
				if vim.fn.mapcheck(v, k) ~= "" then
					vim.api.nvim_del_keymap(k, v)
				end
			else
				for _, vv in ipairs(v) do
					if vim.fn.mapcheck(vv, k) ~= "" then
						vim.api.nvim_del_keymap(k, vv)
					end
				end
			end
		end
	end,
	-- function to run on closing the terminal
	---@diagnostic disable-next-line: unused-local
	on_close = function(term)
		-- 添加回来, 前面取消了<Esc>的映射
		vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {
			noremap = true,
			silent = true,
		})
		keybind.bulk_register_keymaps(setMap)
	end,
})

local tb = Terminal:new({
	direction = "vertical",
	close_on_exit = true,
	-- function to run on opening the terminal
	---@diagnostic disable-next-line: unused-local
	on_open = function(term)
		vim.cmd("startinsert!")
		-- ESC 键取消，留给terminal
		if vim.fn.mapcheck("<Esc>", "t") ~= "" then
			vim.api.nvim_del_keymap("t", "<Esc>")
		end
	end,
	-- function to run on closing the terminal
	---@diagnostic disable-next-line: unused-local
	on_close = function(term)
		-- 添加回来, 前面取消了<Esc>的映射
		vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {
			noremap = true,
			silent = true,
		})
	end,
})

local tc = Terminal:new({
	direction = "horizontal",
	close_on_exit = true,
	-- function to run on opening the terminal
	---@diagnostic disable-next-line: unused-local
	on_open = function(term)
		vim.cmd("startinsert!")
		-- ESC 键取消，留给terminal
		if vim.fn.mapcheck("<Esc>", "t") ~= "" then
			vim.api.nvim_del_keymap("t", "<Esc>")
		end
	end,
	-- function to run on closing the terminal
	---@diagnostic disable-next-line: unused-local
	on_close = function(term)
		-- 添加回来, 前面取消了<Esc>的映射
		vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {
			noremap = true,
			silent = true,
		})
	end,
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

require("keybindings").pluginKeys.mapToggleTerm(M)
