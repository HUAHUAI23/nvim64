local root_files = {
	"project.md",
}
local util = require("lspconfig.util")
local opts = {
	capabilities = require("lsp.common-config").capabilities,
	on_attach = function(client, bufnr)
		local lspComm = require("lsp.common-config")
		lspComm.keyAttach(bufnr)
		lspComm.navic.attach(client, bufnr)
		-- lspComm.shwLinDiaAtom(bufnr)
		-- lspComm.disableFormat(client)
		-- lspComm.hlSymUdrCursor(client, bufnr)
		vim.opt_local.winbar = lspComm.winbarrs
	end,
	single_file_support = true,
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
