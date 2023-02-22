local status, lsp_signature = pcall(require, "lsp_signature")
if not status then
	vim.notify("没有找到 lsp_signature")
	return
end
local cfg = {
	handler_opts = {
		border = "rounded",
	},
	-- floating_window_off_x = 1, -- adjust float windows x position.
	-- floating_window_off_y = -5, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
	toggle_key = "<M-x>",
	select_signature_key = "<M-n>",
}
lsp_signature.setup(cfg)
