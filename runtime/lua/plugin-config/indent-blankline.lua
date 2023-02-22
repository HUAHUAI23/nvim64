local status, indent_blankline = pcall(require, "indent_blankline")
if not status then
	vim.notify("没有找到 indent_blankline")
	return
end
-- NOTE: anther configuration in lua/autocmd.lua
indent_blankline.setup({
	-- show_trailing_blankline_indent = true,
	-- show_end_of_line = true,
	-- 空行占位
	space_char_blankline = " ",
	-- 用 treesitter 判断上下文
	show_current_context = true,
	show_current_context_start = true,
	-- echo &filetype
	filetype_exclude = {
		"null-ls-info",
		"dashboard",
		"packer",
		"terminal",
		"help",
		"log",
		"markdown",
		"TelescopePrompt",
		"lspinfo",
		"mason.nvim",
		"toggleterm",
		"lspsagaoutline",
		"text",
	},
	-- -- 竖线样式
	char = "▏",
	-- char = "╬",
	-- char = "¦",
})
