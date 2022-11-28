local status, comment = pcall(require, "Comment")
if not status then
	vim.notify("没有找到 Comment")
	return
end

local keybindings = require("keybindings").pluginKeys
local commConf = require("commConf")

comment.setup({
	toggler = keybindings.comment.toggler,
	opleader = keybindings.comment.opleader,
	mappings = {
		basic = true,
		extra = false,
		extended = false,
	},
	-- ignore = "^$", -- or function see https://github.com/numToStr/Comment.nvim#-ignoring-lines
	-- fix large file issues see https://github.com/numToStr/Comment.nvim/discussions/272
	pre_hook = function(ctx)
		local max_filesize = commConf.largefileEdge -- 100 KB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
		if ok and stats and stats.size > max_filesize then
			return require("Comment.ft").get(vim.bo.filetype, ctx.ctype) or vim.bo.commentstring
		end
	end,
})
