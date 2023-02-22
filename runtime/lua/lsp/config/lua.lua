-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
-- local runtime_path = vim.split(package.path, ";")
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")
local util = require("lspconfig.util")
local lspComm = require("lsp.common-config")
local root_files = {
	"project.md",
}
local opts = {
	--  see more: https://github.com/neovim/nvim-lspconfig/blob/master/doc/lspconfig.txt  #root_patter
	root_dir = function(fname)
		return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
	end,
	-- settings = {
	--     Lua = {
	--         runtime = {
	--             -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
	--             version = "LuaJIT",
	--             -- Setup your lua path
	--             path = runtime_path,
	--         },
	--         diagnostics = {
	--             Get the language server to recognize the `vim` global
	--             globals = { "vim" },
	--         },
	--         workspace = {
	--             -- Make the server aware of Neovim runtime files
	--             library = vim.api.nvim_get_runtime_file("", true),
	--         },
	--         Do not send telemetry data containing a randomized but unique identifier
	--         telemetry = {
	--             enable = false,
	--         },
	--     },
	-- },
	capabilities = require("lsp.common-config").capabilities,
	on_attach = function(client, bufnr)
		-- lspComm.keyAttach(bufnr)
		-- lspComm.disableFormat(client)
		-- lspComm.shwLinDiaAtom(bufnr)
		lspComm.navic.attach(client, bufnr)
		vim.opt_local.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
		-- lspComm.hlSymUdrCursor(client, bufnr)
	end,
	handlers = require("lsp.common-config").handlers,
}

return {
	on_setup = function(server)
		server.setup(opts)
	end,
}
