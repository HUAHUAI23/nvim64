local status, gitsigns = pcall(require, "gitsigns")
if not status then
	vim.notify("没有找到 gitsigns")
	return
end
gitsigns.setup({
	-- signs = {
	-- 	add = { hl = "GitSignsAdd", text = "A│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
	-- 	change = { hl = "GitSignsChange", text = "C│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	-- 	delete = { hl = "GitSignsDelete", text = "D_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
	-- 	topdelete = { hl = "GitSignsDelete", text = "D‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
	-- 	changedelete = { hl = "GitSignsChange", text = "D~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	-- },
	preview_config = {
		-- Options passed to nvim_open_win
		border = "rounded",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	on_attach = require("keybindings").gitsigns_on_attach,
})
