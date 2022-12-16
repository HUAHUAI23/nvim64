local status, whichkey = pcall(require, "which-key")
if not status then
	vim.notify("没有找到 which-key")
	return
end
-- disable some operators
local presets = require("which-key.plugins.presets")
presets.operators["v"] = nil

whichkey.setup({
	window = {
		border = "rounded", -- none, single, double, shadow
	},
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		["<space>"] = "SPC",
		["<cr>"] = "RET",
		["<tab>"] = "TAB",
	},
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		-- i = { "j", "k", "<space>", "<leader>" },
		i = { "j", "k", "<leader>", "<space>" },
		v = { "j", "k" },
	},
	disable = {
		buftypes = {},
		filetypes = { "TelescopePrompt" },
	},
})
