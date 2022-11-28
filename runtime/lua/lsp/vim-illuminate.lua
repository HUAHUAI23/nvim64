local status, illuminate = pcall(require, "illuminate")
local commConf = require("commConf")
if not status then
	vim.notify("没有找到 illuminate")
	return
end
illuminate.configure({
	-- providers: provider used to get references in the buffer, ordered by priority
	providers = {
		-- "lsp",
		"treesitter",
		"regex",
	},
	-- delay: delay in milliseconds
	delay = 100,
	-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
	filetypes_denylist = {
		"NvimTree",
		"undotree",
		"dbui",
		"toggleterm",
		"notify",
		"packer",
		"lsp-installer",
		"help",
		"terminal",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"dashboard",
		"",
	},
	-- modes_denylist: modes to not illuminate, this overrides modes_allowlist
	-- See `:help mode()` for possible values
	modes_denylist = { "i" },
	-- under_cursor: whether or not to illuminate under the cursor
	under_cursor = true,
	-- large_file_cutoff: number of lines at which to use large_file_config
	-- The `under_cursor` option is disabled when this cutoff is hit
	large_file_cutoff = commConf.illuminateLargefileEdge,
	-- large_file_config: config to use for large files (based on large_file_cutoff).
	-- Supports the same keys passed to .configure
	-- If nil, vim-illuminate will be disabled for large files.
	-- large_file_overrides = nil,
	large_file_overrides = {
		providers = {
			"lsp",
			-- "treesitter",
			-- "regex",
		},
		-- under_cursor = true,
		delay = 100,
	},
	-- min_count_to_highlight: minimum number of matches required to perform highlighting
	min_count_to_highlight = 1,
})
