local commConf = require("commConf")
local api = vim.api
local loop = vim.loop
local status, null_ls = pcall(require, "null-ls")
if not status then
	vim.notify("没有找到 null-ls")
	return
end
-- builtin sources
-- code action sources
---@diagnostic disable-next-line: unused-local
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
	formatting.shfmt,
	formatting.black.with({ extra_args = { "--fast" }, timeout = 20000 }),
	formatting.clang_format,
	formatting.fixjson,
	formatting.prettier.with({
		disabled_filetypes = { "markdown", "javascript", "typescript" },
		prefer_local = "node_modules/.bin",
		-- milliseconds
		-- NOTE: The maximum processing time of prettier,
		-- if file size is very large,the maximum processing time should be more longer
		timeout = 20000,
	}),
	formatting.deno_fmt.with({
		filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
		timeout = 20000,
	}),
	formatting.sql_formatter,
	formatting.stylua,
	formatting.markdownlint,

	-- Code action  eslint_d  shellcheck gitsigns(need https://github.com/lewis6991/gitsigns.nvim)
	-- code_actions.shellcheck,
	-- code_actions.eslint.with({
	-- 	prefer_local = "node_modules/.bin",
	-- }),
	-- code_actions.gitsigns,

	-- Ddiagnostics   checkmake{make}  eslint_d  pylint  shellcheck
	-- TODO: luacheck checkmake{make}
	-- diagnostics.checkmake, markdownlint
	diagnostics.eslint.with({
		prefer_local = "node_modules/.bin",
		method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
		condition = function()
			if api.nvim_buf_line_count(0) < commConf.lintLargefileEdge then
				return true
			else
				return false
			end
		end,
	}),
	-- diagnostics.pylint,  -- lsp_server pyright
	diagnostics.shellcheck,
	diagnostics.markdownlint.with({
		method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
	}),

	--Hover
	hover.printenv,
	hover.dictionary,
}

local augroup = api.nvim_create_augroup("LspFormatting", { clear = false })
local function lsp_formatting(bufnr)
	local max_filesize = commConf.autoformatEdge -- 100 KB
	local ok, stats = pcall(loop.fs_stat, api.nvim_buf_get_name(bufnr))
	if ok and stats and stats.size < max_filesize then
		vim.lsp.buf.format({
			filter = function(client)
				-- apply whatever logic you want (in this example, we'll only use null-ls)
				return client.name == "null-ls"
			end,
			bufnr = bufnr or vim.api.nvim_get_current_buf(),
			-- timeout_ms = 20000,
			async = true,
		})
	end
end

null_ls.setup({
	debug = false,
	-- debounce = 250,
	-- default_timeout = 5000,
	-- NOTE: The null-ls's maximum waiting time,if the source processing time exceed this time,the source result will be discarded
	-- null-ls will wait for results from the source util the maximum waiting time of null-ls,
	-- if this time be exceeded and the source does not return a result,null-ls will return the default value
	-- The null-ls's maximum waiting time should be greater than or equal to the maximum processing time of sources
	default_timeout = 20000, -- 20 seconds
	-- #{m}: message  #{s}: source name (defaults to null-ls if not specified)  #{c}: code (if available)
	-- diagnostics_format = "[#{c}] #{m} (#{s})",
	diagnostics_format = "[#{s}] #{m}",
	-- diagnostics_format = "#{m}",
	sources = sources,
	root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git", "project.md"),
	on_attach = function(client, bufnr)
		-- format document before save
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end

		local lspKey = require("keybindingAlias").lsp

		-- TODO: fix markdown file
		-- there are some lsp keymap the markdown file don't need

		vim.keymap.set("n", lspKey.definition, function()
			require("telescope.builtin").lsp_definitions(
				require("telescope.themes").get_cursor({ initial_mode = "normal" })
			)
		end, { noremap = true, silent = true, desc = "goto lsp definition", buffer = bufnr })
		vim.keymap.set("n", lspKey.references, function()
			require("telescope.builtin").lsp_references(
				require("telescope.themes").get_cursor({ initial_mode = "normal" })
			)
		end, { noremap = true, silent = true, desc = "goto lsp references", buffer = bufnr })
		vim.keymap.set(
			"n",
			lspKey.hover,
			"<cmd>lua vim.lsp.buf.hover()<CR>",
			{ noremap = true, silent = true, desc = "open lsp hover", buffer = bufnr }
		)
		vim.keymap.set(
			"n",
			lspKey.open_flow,
			"<cmd>lua vim.diagnostic.open_float()<CR>",
			{ noremap = true, silent = true, desc = "open lsp diagnostic", buffer = bufnr }
		)
		vim.keymap.set(
			"n",
			lspKey.goto_next,
			"<cmd>lua vim.diagnostic.goto_next()<CR>",
			{ noremap = true, silent = true, desc = "goto next diagnostic", buffer = bufnr }
		)
		vim.keymap.set(
			"n",
			lspKey.goto_prev,
			"<cmd>lua vim.diagnostic.goto_prev()<CR>",
			{ noremap = true, silent = true, desc = "goto prev diagnostic", buffer = bufnr }
		)
		vim.keymap.set(
			"n",
			lspKey.rename,
			"<cmd>lua vim.lsp.buf.rename()<CR>",
			{ noremap = true, silent = true, desc = "variable lsp rename", buffer = bufnr }
		)
		vim.keymap.set(
			"n",
			lspKey.code_action,
			"<cmd>lua vim.lsp.buf.code_action()<CR>",
			{ noremap = true, silent = true, desc = "lsp code action", buffer = bufnr }
		)
		vim.keymap.set("n", lspKey.format, function()
			vim.lsp.buf.format({
				filter = function()
					-- apply whatever logic you want (in this example, we'll only use null-ls)
					-- NOTE: the client.name is the name of the client attached to this buffer
					return client.name == "null-ls"
				end,
				bufnr = bufnr or vim.api.nvim_get_current_buf(),
				-- NOTE: the maximum time that vim.lsp.buf.format will wait for
				-- timeout_ms = 20000
				async = true,
			})
		end, { noremap = true, silent = true, desc = "lsp code format", buffer = bufnr })
		vim.keymap.set(
			"n",
			lspKey.signature_help,
			"<cmd>lua vim.lsp.buf.signature_help()<CR>",
			{ noremap = true, silent = true, desc = "open function signature help", buffer = bufnr }
		)
		vim.keymap.set("n", lspKey.implementations, function()
			require("telescope.builtin").lsp_implementations(
				require("telescope.themes").get_cursor({ initial_mode = "normal" })
			)
		end, { noremap = true, silent = true, desc = "goto interface implementation", buffer = bufnr })
		vim.keymap.set("n", lspKey.type_definitions, function()
			require("telescope.builtin").lsp_type_definitions(
				require("telescope.themes").get_cursor({ initial_mode = "normal" })
			)
		end, { noremap = true, silent = true, desc = "goto type definition", buffer = bufnr })
	end,
})
