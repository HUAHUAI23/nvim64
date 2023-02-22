local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
	vim.notify("没有找到 nvim-autopairs")
	return
end
autopairs.setup({
	disable_filetype = { "TelescopePrompt", "vim" },
	-- Don't add pairs if it already has a close pair in the same line
	enable_check_bracket_line = false,
	-- Don't add pairs if the next char is in pattern "%w%%%'%[%"%."
	ignored_next_char = [=[[%w%%%'%[%"%.]]=],
	-- use treesitter to check for a pair
	-- NOTE: in large file, the autopair will not be enable   lua/autocmd.lua
	check_ts = true,
	ts_config = {
		-- 在lua字符串中将不会启用autopair
		lua = { "string" }, -- it will not add a pair on that treesitter node (treesitter语法节点 字符串)
		javascript = { "template_string" },
		java = false, -- don't check treesitter on java
	},
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local handlers = require("nvim-autopairs.completion.handlers")
local cmp = require("cmp")
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
cmp.event:on(
	"confirm_done",
	cmp_autopairs.on_confirm_done({
		filetypes = {
			-- "*" is a alias to all filetypes
			["*"] = {
				["("] = {
					kind = {
						cmp.lsp.CompletionItemKind.Function,
						cmp.lsp.CompletionItemKind.Method,
					},
					handler = handlers["*"],
				},
			},
			-- Disable for tex
			tex = false,
		},
	})
)
