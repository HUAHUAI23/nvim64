local status, lsp_signature = pcall(require, "lsp_signature")
if not status then
	vim.notify("没有找到 lsp_signature")
	return
end
local cfg = {
	handler_opts = {
		border = "rounded",
	},
	toggle_key = "<M-x>",
	select_signature_key = "<M-n>",
}
lsp_signature.setup(cfg)
