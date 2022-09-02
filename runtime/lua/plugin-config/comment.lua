local status, comment = pcall(require, "Comment")
if not status then
	vim.notify("没有找到 Comment")
	return
end

local keybindings = require("keybindings")

comment.setup({
	toggler = keybindings.comment.toggler,
	opleader = keybindings.comment.opleader,
	mappings = {
		basic = true,
		extra = false,
		extended = false,
	},
})
