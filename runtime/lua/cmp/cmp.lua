local status, cmp = pcall(require, "cmp")
if not status then
	vim.notify("没有找到 cmp")
	return
end
local luasnip
status, luasnip = pcall(require, "luasnip")
if not status then
	vim.notify("没有找到 luasnip")
	return
end

local mapping = require("keybindings").cmp(luasnip, cmp)

-- UI
local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

--cmp config
-- https://github.com/hrsh7th/nvim-cmp
cmp.setup({
	-- UI
	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			-- Source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				dap = "[DAP]",
			})[entry.source.name]
			return vim_item
		end,
	},
	-- do not enable auto-completion in comments
	enabled = function()
		-- disable completion in comments
		local context = require("cmp.config.context")
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
			-- return not context.in_syntax_group("Comment")
		end
	end,
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	-- keybindings
	mapping = mapping,
	-- sources
	sources = cmp.config.sources({
		{ name = "nvim_lsp", group_index = 1 },
		{ name = "luasnip", group_index = 1 }, -- For luasnip users.
		{ name = "nvim_lsp_signature_help", group_index = 1 },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					local buf = vim.api.nvim_get_current_buf()
					local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
					if byte_size > 1024 * 1024 then -- 1 Megabyte max
						return {}
					end
					return { buf }
				end,
			},
			group_index = 2,
		},
		{ name = "path", group_index = 2 },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					local buf = vim.api.nvim_get_current_buf()
					local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
					if byte_size > 1024 * 1024 then -- 1 Megabyte max
						return {}
					end
					return { buf }
				end,
			},
		},
	},
})
--[[
{
    { name = 'path' }
}, {
    { name = 'cmdline' } 和group_index意思相同，上面的优先级越高，即path的优先级高于
}                         cmdline，path源ok的话将优先匹配path
--]]

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		-- https://github.com/hrsh7th/cmp-cmdline/issues/24
		-- https://github.com/hrsh7th/nvim-cmp/issues/821
		-- Solve the problem that typing :! in command mode takes too long time for wait  ENV:WSL2
		-- { name = 'cmdline', keyword_pattern = [[\!\@<!\w*]] }
		{ name = "cmdline" },
	}),
})

cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
	sources = {
		{ name = "dap" },
	},
})

-- disable cmp for specify filetype
cmp.setup.filetype({ "TelescopePrompt", "text", "" }, {
	enabled = false,
})

-- ---LuaSnip configuration--------
-- ·与代码snippet有关
-- custom snippets
-- https://github.com/rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()
local config_path = vim.env.VIM

-- load snippets from path/of/your/nvim/config/my-cool-snippets
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { config_path .. "/abc/cmp/snippets/vscode" } })
require("luasnip.loaders.from_lua").load({ paths = { config_path .. "/abc/cmp/snippets/lua" } })

-- For changing choices in choiceNodes (not strictly necessary for a basic setup).
-- { "i", "s" } Indicates insertion mode and selection mode, respectively
vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end)

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(-1)
	end
end)
