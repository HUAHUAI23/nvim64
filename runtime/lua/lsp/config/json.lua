local opts = {
	capabilities = require("lsp.common-config").capabilities,
	on_attach = function(client, bufnr)
		local lspComm = require("lsp.common-config")
		lspComm.keyAttach(bufnr)
		lspComm.navic.attach(client, bufnr)
		vim.opt_local.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
		-- lspComm.shwLinDiaAtom(bufnr)
		-- lspComm.hlSymUdrCursor(client, bufnr)  -- vim-illuminate plugin do this
		-- lspComm.disableFormat(client)
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
