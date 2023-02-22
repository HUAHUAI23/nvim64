-- filter diagnostic message https://github.dev/askfiy/nvim/blob/master/lua/config/lsp/server_configurations/pyright.lua
-- https://github.com/neovim/nvim-lspconfig/issues/726
-- rootDir patter https://github.com/neovim/nvim-lspconfig/blob/master/doc/lspconfig.txt  #root_patter
local root_files = {
	"project.md",
}
local lspComm = require("lsp.common-config")
-- local commConf = require("commConf")
local util = require("lspconfig.util")
local opts = {
	capabilities = lspComm.capabilities,
	on_attach = function(client, bufnr)
		-- lspComm.keyAttach(bufnr)
		-- lspComm.shwLinDiaAtom(bufnr)
		-- lspComm.disableFormat(client)
		lspComm.navic.attach(client, bufnr)
		vim.opt_local.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
		-- lspComm.hlSymUdrCursor(client, bufnr)
		-- large file hundler
		-- local max_filesize = commConf.largefileEdge -- 100 KB
		-- local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
		-- if ok and stats and stats.size < max_filesize then
		-- 	vim.api.nvim_cmd(vim.api.nvim_parse_cmd("LspStop", {}), {})
		-- end
	end,
	handlers = require("lsp.common-config").handlers,
	root_dir = function(fname)
		return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
	end,
	-- on_new_config = function(new_config, new_root_dir)
	-- 	new_config.autostart = false
	-- 	-- vim.pretty_print(new_config)
	-- end,
}

return {
	on_setup = function(server)
		server.setup(opts)
	end,
}
