local status, zen = pcall(require, "zen-mode")
if not status then
	vim.notify("没有找到 zen-mode")
	return
end
zen.setup({
	window = {
		-- backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
		-- width = 0.8, -- width of the Zen window
		-- height = 1, -- height of the Zen window
		backdrop = 1,
		width = 0.8, -- 1 100%
		height = 1, -- height of the Zen window
		options = {
			signcolumn = "no", -- disable signcolumn
			number = false, -- disable number column
			relativenumber = false, -- disable relative numbers
			cursorline = false, -- disable cursorline
			cursorcolumn = false, -- disable cursor column
			foldcolumn = "0", -- disable fold column
			list = false, -- disable whitespace characters
		},
	},
	plugins = {
		twilight = { enabled = true },
	},
})
