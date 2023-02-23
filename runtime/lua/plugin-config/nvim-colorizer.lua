local status, colorizer = pcall(require, "colorizer")
if not status then
	vim.notify("没有找到 colorizer")
	return
end
colorizer.setup({
	"css",
	"javascript",
	-- lua = {
	-- 	mode = "foreground",
	-- },
	html = {
		mode = "foreground",
	},
})
