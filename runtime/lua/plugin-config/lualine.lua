local status, lualine = pcall(require, "lualine")
if not status then
	vim.notify("没有找到 lualine")
	return
end

lualine.setup({
	options = {
		-- 指定皮肤
		-- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
		-- theme = "gruvbox-material",
		-- theme = "auto",
		theme = "everforest",
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
	extensions = { "nvim-tree", "toggleterm", "quickfix", "nvim-dap-ui", "man" },
	sections = {
		-- lualine_c = {
		--   "filename",
		--   {
		-----  arkav/lualine-lsp-progress
		--     "lsp_progress",
		--     spinner_symbols = { " ", " ", " ", " ", " ", " " },
		--   },
		-- },
		lualine_x = {
			"filesize",
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
				-- on_click = function() vim.api.nvim_command('set number') end,
			},
			"encoding",
			"filetype",
		},
	},
})
