local root_files = {
	"project.md",
}
local util = require("lspconfig.util")
return {
	on_setup = function(server)
		server.setup({
			capabilities = require("lsp.common-config").capabilities,
			on_attach = function(client, bufnr)
				local lspComm = require("lsp.common-config")
				lspComm.keyAttach(bufnr)
				lspComm.shwLinDiaAtom(bufnr)
				lspComm.navic.attach(client, bufnr)
				-- lspComm.hlSymUdrCursor(client, bufnr)
			end,
			handlers = require("lsp.common-config").handlers,
			root_dir = function(fname)
				return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
			end,
		})
	end,
}
