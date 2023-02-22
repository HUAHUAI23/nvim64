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
			-- see https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips#use-json-schemas-from-schemastore
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
}
return {
	on_setup = function(server)
		server.setup(opts)
	end,
}
