local status, yanky = pcall(require, "yanky")
if not status then
	vim.notify("没有找到 yanky.nvim")
	return
end
yanky.setup({
	ring = {
		history_length = 50,
	},
	system_clipboard = {
		sync_with_ring = false,
	},
})
require("telescope").load_extension("yank_history")
