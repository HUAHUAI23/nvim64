local status, ne = pcall(require, "neoscroll")
if not status then
	vim.notify("没有找到 neoscroll")
	return
end
ne.setup({
	easing_function = "circular",
	-- All these keys will be mapped to their corresponding default scrolling animation
	mappings = {
		"<C-u>",
		"<C-d>",
		"<C-b>",
		--[["<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" ]]
	},
	hide_cursor = true, -- Hide cursor while scrolling
	stop_eof = true, -- Stop at <EOF> when scrolling downwards
	respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	pre_hook = nil, -- Function to run before the scrolling animation starts
	post_hook = nil, -- Function to run after the scrolling animation ends
	performance_mode = false, -- Disable "Performance Mode" on all buffers.
})
local t = {}
t["<C-k>"] = { "scroll", { "-0.10", "false", "100", nil } }
t["<C-j>"] = { "scroll", { "0.10", "false", "100", nil } }
require("neoscroll.config").set_mappings(t)

-- fix j and k in normal mode
vim.keymap.set({ "n", "x" }, "j", function()
	return vim.v.count > 0 and "j" or "gj"
end, { noremap = true, silent = true, expr = true, desc = "enhanced j" })

vim.keymap.set({ "n", "x" }, "k", function()
	return vim.v.count > 0 and "k" or "gk"
end, { noremap = true, silent = true, expr = true, desc = "enhanced k" })
