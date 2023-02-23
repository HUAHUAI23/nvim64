local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	vim.notify("没有找到 nvim-treesitter")
	return
end

local commConf = require("commConf")
local lsp = require("keybindingAlias").lsp
---@diagnostic disable-next-line: unused-local
local filesize_hundle = function(lang, buf)
	local max_filesize = commConf.largefileEdge -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	if ok and stats and stats.size > max_filesize then
		return true
	end
end

treesitter.setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"html",
		"css",
		"vim",
		"lua",
		"javascript",
		"python",
		"json",
		"bash",
		"markdown",
		"markdown_inline",
		"go",
	},
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	-- 启用代码高亮模块
	highlight = {
		enable = true,
		disable = filesize_hundle,
		additional_vim_regex_highlighting = false,
		-- list of language that will be disabled
		-- disable = { "c", "rust" },
	},
	-- 启用增量选择模块
	incremental_selection = {
		enable = false,
		disable = filesize_hundle,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<BS>",
			scope_incremental = "<TAB>",
		},
	},
	-- 启用代码缩进模块 (=)
	indent = {
		enable = true,
		disable = filesize_hundle,
	},
	-- https://github.com/nvim-treesitter/nvim-treesitter-refactor
	refactor = {
		-- the illuminate plugin is better than this
		highlight_definitions = {
			enable = false,
			disable = filesize_hundle,
			-- Set to false if you have an `updatetime` of ~100.
			clear_on_cursor_move = true,
		},
		highlight_current_scope = {
			enable = false,
			disable = filesize_hundle,
		},
		smart_rename = {
			enable = true,
			disable = filesize_hundle,
			keymaps = {
				smart_rename = lsp.tsRename,
			},
		},
	},
	-- more powerful %
	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
		-- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
		disable = filesize_hundle,
		-- [options]
	},
	-- https://github.com/windwp/nvim-ts-autotag
	-- 方便前端语言标签的自动闭合
	autotag = {
		enable = true,
		disable = filesize_hundle,
	},
	-- https://github.com/p00f/nvim-ts-rainbow
	rainbow = {
		enable = true,
		-- disable = filesize_hundle,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		disable = filesize_hundle,
		-- some compreesed file is very large,but only one line
		max_file_lines = commConf.rainbowLargefileEdge, -- Do not enable for files with more than n lines, int
		colors = {
			"#95ca60",
			"#ee6985",
			"#D6A760",
			"#7794f4",
			"#b38bf5",
			"#7cc7fe",
		}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})

-- use tressitter to fold code
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
