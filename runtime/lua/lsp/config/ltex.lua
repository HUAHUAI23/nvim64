local root_files = {
	"project.md",
}
local util = require("lspconfig.util")
local opts = {
	capabilities = require("lsp.common-config").capabilities,
	---@diagnostic disable-next-line: unused-local
	on_attach = function(client, bufnr)
		-- local lspComm = require("lsp.common-config")
		-- lspComm.keyAttach(bufnr)
		-- lspComm.navic.attach(client, bufnr)
		vim.opt_local.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
		-- lspComm.shwLinDiaAtom(bufnr)
		-- lspComm.hlSymUdrCursor(client, bufnr)  -- vim-illuminate plugin do this
		-- lspComm.disableFormat(client)
	end,
	handlers = require("lsp.common-config").handlers,
	root_dir = function(fname)
		return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
	end,
}
return {
	on_setup = function(server)
		server.setup(opts)
	end,
}
