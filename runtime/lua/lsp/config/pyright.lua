-- local nvim_lsp = require 'nvim_lsp'
local opts = {
	capabilities = require("lsp.common-config").capabilities,
	on_attach = function(client, bufnr)
		local lspComm = require("lsp.common-config")
		lspComm.keyAttach(bufnr)
		lspComm.shwLinDiaAtom(bufnr)
		-- lspComm.hlSymUdrCursor(client, bufnr)
	end,
	handlers = require("lsp.common-config").handlers,
	-- root_dir = nvim_lsp.util.root_pattern("project.md")
	-- root_dir = util.root_pattern("project.md"),
	-- root_dir = nvim_lsp.util.root_pattern("project.md"),
}
return {
	on_setup = function(server)
		server.setup(opts)
	end,
}
