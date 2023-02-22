local status, notify = pcall(require, "notify")
if not status then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("没有找到 nvim-notify 插件", "error")
	return
end
-- NOTE: anther configuration in lua/plugin-config/telescope.lua
-- https://github.com/rcarriga/nvim-notify/blob/master/doc/nvim-notify.txt
notify.setup({
	timeout = 3000,
})
vim.notify = notify
-- TODO: filter some notify message
