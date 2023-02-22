local status, mason = pcall(require, "mason")
if not status then
	vim.notify("没有找到 mason.nvim")
	return
end
mason.setup({
	ui = {
		border = "rounded",
	},
	install_root_dir = require("commConf").sharePath .. "/abc/mason",
})

local mason_lspconfig
status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
	vim.notify("没有找到 mason-lspconfig")
	return
end

-- see https://github.com/folke/neodev.nvim
-- settings for neovim dev environment
local neodev
status, neodev = pcall(require, "neodev")
if not status then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("没有找到 neodev", "error")
	return
end
neodev.setup({
	library = {
		enable = true,
		plugins = { "nvim-dap-ui" },
		types = true,
	},
})

mason_lspconfig.setup({
	ensure_installed = {
		"lua_ls",
		"bashls",
		"pyright",
		"tsserver",
		"gopls",
		"clangd",
		"vimls",
	},
	automatic_installation = true,
})

local lspconfig
status, lspconfig = pcall(require, "lspconfig")
if not status then
	vim.notify("没有找到 lspconfig")
	return
end

-- 使用neovim原生lspconfig进行language server配置
local servers = {
	lua_ls = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
	bashls = require("lsp.config.bash"),
	pyright = require("lsp.config.pyright"),
	tsserver = require("lsp.config.tsserver"),
	gopls = require("lsp.config.gopls"),
	clangd = require("lsp.config.clangd"),
	-- quick_lint_js = require("lsp.config.quick-lint-js"),
	sqls = require("lsp.config.sqls"),
	-- css html
	emmet_ls = require("lsp.config.emmet-ls"),
	html = require("lsp.config.html"),
	cssls = require("lsp.config.css"),
	-- json
	jsonls = require("lsp.config.json"),
	-- vim
	vimls = require("lsp.config.vimls"),
}
for name, config in pairs(servers) do
	if config ~= nil and type(config) == "table" then
		-- 自定义初始化配置文件必须实现on_setup 方法
		config.on_setup(lspconfig[name])
	else
		-- 使用默认参数
		lspconfig[name].setup({})
	end
end
