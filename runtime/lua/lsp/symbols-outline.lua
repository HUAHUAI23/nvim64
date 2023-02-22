local status, symbolsOutline = pcall(require, "symbols-outline")
if not status then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("没有找到 symbols-outline 插件", "error")
	return
end
symbolsOutline.setup({
	auto_close = true,
	highlight_hovered_item = false,
	show_symbol_details = false,
	position = "right",
	autofold_depth = nil,
	-- wrap = true,
	-- preview_bg_highlight = { bg = "#1d1536" },
	keymaps = { -- These keymaps can be a string or a table for multiple keys
		close = { "<Esc>", "q" },
		goto_location = "<Cr>",
		focus_location = "o",
		toggle_preview = "p",
		fold = "f",
		unfold = "u",
		fold_all = "w",
		unfold_all = "W",
		fold_reset = "r",
		rename_symbol = "R",
		hover_symbol = "i",
	},
})
