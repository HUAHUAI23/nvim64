local status, lualine = pcall(require, "lualine")
if not status then
	vim.notify("没有找到 lualine")
	return
end
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
	check_py_venv = function()
		if vim.env.VIRTUAL_ENV_PROMPT then
			return true
		else
			return false
		end
	end,
}
-- 为特定文件类型的buffer设置 特定的状态栏
local my_extension = { sections = { lualine_a = { "mode" } }, filetypes = { "undotree", "lspsagaoutline", "diff" } }
local config = {
	options = {
		-- 指定皮肤
		-- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
		-- theme = "gruvbox-material",
		theme = "auto",
		-- 分割线
		component_separators = {
			left = "|",
			right = "|",
		},
		-- https://github.com/ryanoasis/powerline-extra-symbols
		section_separators = {
			left = " ",
			right = "",
		},
		globalstatus = true,
	},
	extensions = {
		"nvim-tree",
		"toggleterm",
		"quickfix",
		"nvim-dap-ui",
		"man",
		my_extension,
	},
	sections = {
		lualine_b = { "branch", "diff" },
		lualine_c = {},
		lualine_x = {
			{ "filesize", icon = "📃", color = { gui = "bold" } },
			{
				"fileformat",
				-- symbols = {
				--   unix = '', -- e712
				--   dos = '', -- e70f
				--   mac = '', -- e711
				-- },
				symbols = {
					unix = "LF",
					dos = "CRLF",
					mac = "CR",
				},
				color = { gui = "bold" },
				-- on_click = function() vim.api.nvim_command('set number') end,
			},
			{ "encoding", color = { gui = "bold" } },
			{ "filetype", color = { gui = "bold" } },
		},
	},
}
-- Inserts a component in lualine_c
local function ins_leftc(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x
local function ins_leftx(component)
	table.insert(config.sections.lualine_x, component)
end

ins_leftc({
	-- Lsp server name .
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		-- make LSP first
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				if client.name ~= "null-ls" then
					return client.name
				end
			end
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	-- icon = " LSP:",
	icon = "🏗︎ LSP:",
	-- icon = "👻 LSP:",
	color = { --[[ fg = "#ffffff", ]]
		gui = "bold",
	},
})

ins_leftx({
	function()
		return "🫙 " .. string.match(vim.env.VIRTUAL_ENV_PROMPT, "%w+")
	end,
	cond = conditions.check_py_venv,
	color = { gui = "bold" },
})

lualine.setup(config)
