-- 自定义图标
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#customizing-how-diagnostics-are-displayed
-- see ：h diagnostic.txt     398gg
vim.diagnostic.config({
	-- 🔬 🔮
	virtual_text = { source = "always", prefix = "🔬" },
	signs = true,
	update_in_insert = false,
	float = {
		border = "rounded",
		source = "always", -- show diagnostices sources
	},
})
-- Change diagnostic symbols in the sign column (gutter)
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
-- local signs = { Error = "🙀", Warn = "😿", Info = "😾", Hint = "😺" }
local signs = { Error = "🤕", Warn = "😦", Info = "🤔", Hint = "😐" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- 修改lspconfig.ui.windows.default_opts函数的返回值,(opts.border="rounded"), 其中border为控制lsp ui的边框 例如 :LspInfo窗口的边框
-- local win = require("lspconfig.ui.windows")
-- local org_default_opts = win.default_opts
-- win.default_opts = function(options)
-- 	local opts = org_default_opts(options)
-- 	opts.border = "rounded"
-- 	return opts
-- end
-- if neovim version >= 8.0,the above configuration	will not work
-- and you can use following configuration
-- see more https://github.com/neovim/nvim-lspconfig/blob/master/doc/lspconfig.txt
require("lspconfig.ui.windows").default_options.border = "rounded"

