local status, mason = pcall(require, "mason")
if not status then
	vim.notify("没有找到 mason.nvim")
	return
end
mason.setup({
	ui = {
		border = "rounded",
	},
	install_root_dir = vim.env.VIM .. "/abc/mason",
})

local mason_lspconfig
status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
	vim.notify("没有找到 mason-lspconfig")
	return
end

mason_lspconfig.setup({
	ensure_installed = {
		"bash-language-server",
		-- "shfmt",
		"shellcheck",
		-- "luacheck",
		"stylua",
		"lua-language-server",
		"black",
		"pyright",
		"pylint",
		"debugpy",
		"clang-format",
		"clangd",
		"cpptools",
		"eslint-lsp",
		"eslint_d",
		"node-debug2-adapter",
		"typescript-language-server",
		"quick-lint-js",
		"prettier",
		"sqls",
		"sql-formatter",
		"json-lsp",
		"html-lsp",
		"fixjson",
		"emmet-ls",
		"css-lsp",
		"markdownlint",
		"gopls",
	},
	automatic_installation = true,
})

local lspconfig
status, lspconfig = pcall(require, "lspconfig")
if not status then
	vim.notify("没有找到 lspconfig")
	return
end

-- local srvPairs = {
-- 	lua = "sumneko_lua",
-- 	luaConf = "lsp.config.lua",
-- 	bash = "bashls",
-- 	bashConf = "lsp.config.bash",
-- 	python = "pyright",
-- 	pythonConf = "lsp.config.pyright",
-- }

-- mason_lspconfig.setup_handlers({
-- 	-- The first entry (without a key) will be the default handler
-- 	-- and will be called for each installed server that doesn't have
-- 	-- a dedicated handler.
-- 	function(server_name) -- default handler (optional)
-- 		lspconfig[server_name].setup({})
-- 	end,
-- 	[srvPairs["lua"]] = function()
-- 		local status, config = pcall(require, srvPairs["luaConf"])
-- 		if status and type(config) == "table" then
-- 			-- 自定义初置文件必须实现on_setup 方法
-- 			config.on_setup(lspconfig[srvPairs["lua"]])
-- 		else
-- 			-- 使用默认参数
-- 			lspconfig[srvPairs["lua"]].setup({})
-- 		end
-- 	end,
-- 	[srvPairs["bash"]] = function()
-- 		local status, config = pcall(require, srvPairs["bashConf"])
-- 		if status and type(config) == "table" then
-- 			-- 自定义初置文件必须实现on_setup 方法
-- 			config.on_setup(lspconfig[srvPairs["bash"]])
-- 		else
-- 			-- 使用默认参数
-- 			lspconfig[srvPairs["bash"]].setup({})
-- 		end
-- 	end,
-- 	[srvPairs["python"]] = function()
-- 		local status, config = pcall(require, srvPairs["pythonConf"])
-- 		if status and type(config) == "table" then
-- 			-- 自定义初置文件必须实现on_setup 方法
-- 			config.on_setup(lspconfig[srvPairs["python"]])
-- 		else
-- 			-- 使用默认参数
-- 			lspconfig[srvPairs["python"]].setup({})
-- 		end
-- 	end,
-- })

-- 使用neovim原生lspconfig进行language server配置
local servers = {
	sumneko_lua = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
	bashls = require("lsp.config.bash"),
	pyright = require("lsp.config.pyright"),
	-- eslint = require("lsp.config.eslint"),
	tsserver = require("lsp.config.tsserver"),
	sqls = require("lsp.config.sqls"),
	emmet_ls = require("lsp.config.emmet-ls"),
	jsonls = require("lsp.config.json"),
	html = require("lsp.config.html"),
	cssls = require("lsp.config.css"),
	clangd = require("lsp.config.clangd"),
	-- quick_lint_js = require("lsp.config.quick-lint-js"),
	gopls = require("lsp.config.gopls"),
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
