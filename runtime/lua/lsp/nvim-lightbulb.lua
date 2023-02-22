local status, lightbulb = pcall(require, "nvim-lightbulb")

if not status then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("没有找到 nvim-lightbulb 插件", "error")
	return
end
lightbulb.setup({
	ignore = { "null-ls" },
})

local llightbulbAu = vim.api.nvim_create_augroup("myAutoGroup", {
	clear = true,
})

vim.api.nvim_create_autocmd({
	"CursorHold",
	"CursorHoldI",
	-- "CursorMoved",
}, {
	group = llightbulbAu,
	pattern = { "*" },
	callback = function()
		lightbulb.update_lightbulb()
	end,
})
