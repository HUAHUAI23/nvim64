local status, null_ls = pcall(require, "null-ls")
if not status then
	vim.notify("没有找到 null-ls")
	return
end
-- builtin sources
-- code action sources
local code_actions = null_ls.builtins.code_actions
-- diagnostic sources
local diagnostics = null_ls.builtins.diagnostics
-- formatting sources
local formatting = null_ls.builtins.formatting
-- hover sources
local hover = null_ls.builtins.hover

local sources = {
	-- formatting  autopep8  djlint  sql_formatter  stylua  shfmt
	-- fixjson  eslint_d  black  clang_format  prettier markdownlint
	formatting.eslint_d,
	formatting.shfmt,
	formatting.black.with({ extra_args = { "--fast" } }),
	formatting.clang_format,
	formatting.fixjson,
	formatting.prettier.with({
		disabled_filetypes = { "markdown" },
	}),
	formatting.sql_formatter,
	formatting.stylua,
	formatting.markdownlint.with({
		prefer_local = "node_modules/.bin",
	}),
	-- Code action  eslint_d  shellcheck
	code_actions.shellcheck,
	code_actions.eslint_d,
	code_actions.gitsigns,
	-- Ddiagnostics   checkmake{make}  eslint_d  pylint  shellcheck
	-- TODO: luacheck checkmake{make}
	-- diagnostics.checkmake,
	diagnostics.eslint_d.with({
		prefer_local = "node_modules/.bin",
	}),
	diagnostics.pylint,
	diagnostics.shellcheck,
	diagnostics.markdownlint,
	--Hover
	hover.printenv,
	hover.dictionary,
}
null_ls.setup({
	debug = false,
	-- diagnostics_format = "[#{c}] #{m} (#{s})",
	diagnostics_format = "[#{s}] #{m}",
	sources = sources,
	on_attach = function(_)
		vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()']])
		-- if client.resolved_capabilities.document_formatting then
		--   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		-- end
		local opts = { buffer = vim.api.nvim_get_current_buf() }
		vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)
	end,
})
