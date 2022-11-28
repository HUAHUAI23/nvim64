local M = {}

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#borders
-- LSP settings (for overriding per client)  set border of lsp.hover and signature_help
-- 修改gh(lsp.hover) 窗口UI的border
M.handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- Show line diagnostics automatically in hover window
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
M.shwLinDiaAtom = function(bufnr)
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				-- prefix = "🔮 ",
				prefix = "🔔 ",
				scope = "cursor",
			}
			vim.diagnostic.open_float(nil, opts)
		end,
	})
end

-- Highlight symbol under cursor
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-symbol-under-cursor
M.hlSymUdrCursor = function(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd([[
      hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    ]])
		vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = false,
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = "lsp_document_highlight",
		})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

--  plugin cmp need this
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- lsp keybinding
M.keyAttach = function(bufnr)
	-- 绑定快捷键
	require("keybindings").pluginKeys.mapLSP(bufnr)
end

-- 禁用lsp格式化功能，交给专门插件处理
M.disableFormat = function(client)
	if vim.fn.has("nvim-0.8") == 1 then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	else
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
end

M.navic = require("nvim-navic")
--
-----winbar And navic
--
-- local ignore_filetype = {
-- 	"",
-- 	"dap-repl",
-- 	"markdown",
-- }
M.navic.setup({
	-- icons = {
	-- 	File = " ",
	-- 	Module = " ",
	-- 	Namespace = " ",
	-- 	Package = " ",
	-- 	Class = " ",
	-- 	Method = " ",
	-- 	Property = " ",
	-- 	Field = " ",
	-- 	Constructor = " ",
	-- 	Enum = "練",
	-- 	Interface = "練",
	-- 	Function = " ",
	-- 	Variable = " ",
	-- 	Constant = " ",
	-- 	String = " ",
	-- 	Number = " ",
	-- 	Boolean = "◩ ",
	-- 	Array = " ",
	-- 	Object = " ",
	-- 	Key = " ",
	-- 	Null = "ﳠ ",
	-- 	EnumMember = " ",
	-- 	Struct = " ",
	-- 	Event = " ",
	-- 	Operator = " ",
	-- 	TypeParameter = " ",
	-- },
	highlight = true,
})

-- local function load_navic()
-- 	vim.api.nvim_create_autocmd(
-- 		{ "DirChanged", "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufNewFile" },
-- 		{
-- 			callback = function()
-- 				if not vim.bo.buflisted or vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
-- 					vim.opt_local.winbar = ""
-- 					return
-- 				end
-- 				vim.opt_local.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
-- 			end,
-- 		}
-- 	)
-- end
-- load_navic()

M.winbarrs = "%{%v:lua.require('nvim-navic').get_location()%}"

return M
