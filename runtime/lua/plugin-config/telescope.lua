local status, telescope = pcall(require, "telescope")
if not status then
	vim.notify("没有找到 telescope")
	return
end

local commConf = require("commConf")
local previewers = require("telescope.previewers")
local putils = require("telescope.previewers.utils")
local pfiletype = require("plenary.filetype")
local new_maker = function(filepath, bufnr, opts)
	opts = opts or {}
	if opts.use_ft_detect == nil then
		opts.use_ft_detect = true
	end

	filepath = vim.fn.expand(filepath)
	local ft = pfiletype.detect(filepath, {})
	local ok, stats = pcall(vim.loop.fs_stat, filepath)
	if ok and stats and stats.size > commConf.largefileEdge then
		opts.use_ft_detect = false
		putils.regex_highlighter(bufnr, ft)
	end
	previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

telescope.setup({
	defaults = {
		prompt_prefix = "🔍 ",
		-- 打开弹窗后进入的初始模式，默认为 normal，也可以是 insert
		initial_mode = "normal",
		-- default mappings see https://github.com/nvim-telescope/telescope.nvim
		mappings = {
			n = {
				["q"] = "close",
			},
		},
		buffer_previewer_maker = new_maker,
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		xray23 = {
			-- location to store session files, default is vim.fn.stdpath("data") .. "/vimSession"
			sessionDir = commConf.sharePath .. "/othersss/vimSession",
		},
	},
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
pcall(telescope.load_extension, "fzf")
-- extension telescope-env.nvim
pcall(telescope.load_extension, "env")
-- extension telescope-http.nvim
pcall(telescope.load_extension, "http")
-- extension telescope-project
pcall(telescope.load_extension, "projects")
-- extension telescope-ui-select
pcall(telescope.load_extension, "ui-select")
-- extension telescope-dap
pcall(telescope.load_extension, "dap")
-- extension telescope-dapzzzz
pcall(telescope.load_extension, "i23")
-- extension telescope-session
pcall(telescope.load_extension, "xray23")
-- extension telescope-color
pcall(telescope.load_extension, "i42")
-- extension telescope-notify
pcall(telescope.load_extension, "notify")

vim.api.nvim_create_user_command("SessionSv", function()
	vim.api.nvim_cmd(vim.api.nvim_parse_cmd("Telescope xray23 save", {}), {})
end, { desc = "load user session,like workspace" })
