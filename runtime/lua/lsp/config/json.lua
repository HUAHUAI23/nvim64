local opts = {
	capabilities = require("lsp.common-config").capabilities,
	on_attach = function(client, bufnr)
		local lspComm = require("lsp.common-config")
		lspComm.keyAttach(bufnr)
		lspComm.disableFormat(client)
		lspComm.shwLinDiaAtom(bufnr)
		lspComm.navic.attach(client, bufnr)
		-- lspComm.hlSymUdrCursor(client, bufnr)
	end,
	handlers = require("lsp.common-config").handlers,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
		},
	},
}
return {
	on_setup = function(server)
		server.setup(opts)
	end,
}
