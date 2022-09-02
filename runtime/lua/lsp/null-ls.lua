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

local sources = {
	-- formatting  autopep8  djlint  sql_formatter  stylua  shfmt
	-- fixjson  eslint_d  black  clang_format  prettier
	formatting.eslint_d,
	formatting.shfmt,
	formatting.black.with({ extra_args = { "--fast" } }),
	formatting.clang_format,
	formatting.fixjson,
	formatting.prettier,
	formatting.sql_formatter,
	formatting.stylua,
	-- Code action  eslint_d  shellcheck
	code_actions.shellcheck,
	code_actions.eslint_d,
	-- Ddiagnostics   checkmake{make}  eslint_d  pylint  shellcheck
	-- TODO: luacheck checkmake{make}
	-- diagnostics.checkmake,
	diagnostics.eslint_d,
	diagnostics.pylint,
	diagnostics.shellcheck,
}
null_ls.setup({
	debug = false,
	-- diagnostics_format = "[#{c}] #{m} (#{s})",
	diagnostics_format = "[#{s}] #{m}",
	sources = sources,
})
