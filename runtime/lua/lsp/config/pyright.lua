-- filter diagnostic message https://github.dev/askfiy/nvim/blob/master/lua/config/lsp/server_configurations/pyright.lua
-- https://github.com/neovim/nvim-lspconfig/issues/726
-- rootDir patter https://github.com/neovim/nvim-lspconfig/blob/master/doc/lspconfig.txt  #root_patter
local root_files = {
	"project.md",
}
local util = require("lspconfig.util")
local opts = {
	capabilities = require("lsp.common-config").capabilities,
	on_attach = function(client, bufnr)
		local lspComm = require("lsp.common-config")
		lspComm.keyAttach(bufnr)
		-- lspComm.shwLinDiaAtom(bufnr)
		-- lspComm.disableFormat(client)
		lspComm.navic.attach(client, bufnr)
		vim.opt_local.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
		-- lspComm.hlSymUdrCursor(client, bufnr)
	end,
	handlers = require("lsp.common-config").handlers,
	root_dir = function(fname)
		return util.root_pattern(unpack(root_files))(fname)
	end,
}
return {
	on_setup = function(server)
		server.setup(opts)
	end,
}
