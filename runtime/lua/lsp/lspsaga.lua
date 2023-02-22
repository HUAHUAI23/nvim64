-- lspsage offers some interesting stuff eg: outline floatterm
-- TODO:设置saga的高亮组
local status, lspsaga = pcall(require, "lspsaga")

if not status then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("没有找到 lspsaga 插件", "error")
	return
end
lspsaga.setup({
	-- request_timeout = 2000,
	lightbulb = {
		enable = false,
		sign = true,
		virtual_text = false,
	},
	symbol_in_winbar = {
		enable = false,
	},
	-- #1d1536
	ui = {
		border = "rounded",
		code_action = "💡",
	},
})
-- test packer lazy load for lspsaga, lazy cmd
-- vim.g.testtt = 1
