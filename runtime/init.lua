vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local on_windows = vim.loop.os_uname().version:match("Windows")

local function join_paths(...)
	local path_sep = on_windows and "\\" or "/"
	local result = table.concat({ ... }, path_sep)
	return result
end

-- see :h 'runtimepath'
vim.cmd([[set runtimepath=$VIMRUNTIME,$VIM/xray23]])
local packer_dir = vim.env.VIM .. "/abc"
vim.cmd("set packpath=" .. join_paths(packer_dir, "nvim", "site"))
local package_root = join_paths(packer_dir, "nvim", "site", "pack")
local install_path = join_paths(package_root, "packer", "start", "packer.nvim")
local compile_path = join_paths(install_path, "plugin", "packer_compiled.lua")
local function load_plugins()
	require("packer").startup({
		function(use)
			-- Packer can manage itself
			use("wbthomason/packer.nvim")

			-- 主题
			use("ajmwagar/vim-deus")

			-- icon,使neovim支持展示更多的icon
			use({ "kyazdani42/nvim-web-devicons" })

			-- 底部状态栏 statusline
			use({
				"nvim-lualine/lualine.nvim",
				requires = { "kyazdani42/nvim-web-devicons", opt = true },
			})

			-- nvim-treesitter,基于语法语义生成代码高亮
			use({
				"nvim-treesitter/nvim-treesitter",
				run = function()
					require("nvim-treesitter.install").update({ with_sync = true })
				end,
				requires = {
					{ "p00f/nvim-ts-rainbow" },
					{ "windwp/nvim-ts-autotag" },
					{ "nvim-treesitter/nvim-treesitter-refactor" },
				},
			})

			-- 文件浏览器
			use({
				"kyazdani42/nvim-tree.lua",
				requires = {
					"kyazdani42/nvim-web-devicons", -- optional, for file icons
				},
				tag = "nightly", -- optional, updated every week. (see issue #1193)
			})
			-- 禅意模式
			use({
				"folke/zen-mode.nvim",
				config = function()
					require("plugin-config.zen-mode")
				end,
			})

			-- 顶部状态栏 bufferline
			use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })

			-- 更好看的命令终端
			use({ "akinsho/toggleterm.nvim", tag = "v2.*" })

			-- 注释插件
			use({ "numToStr/Comment.nvim" })

			-- 括号自动补全插件
			use({ "windwp/nvim-autopairs" })

			-- 对齐线插件
			use("lukas-reineke/indent-blankline.nvim")

			-- Project
			use({ "ahmedkhalf/project.nvim" })

			--  dashboard-nvim
			use("glepnir/dashboard-nvim")

			-- TODO Comments
			use({
				"folke/todo-comments.nvim",
				requires = "nvim-lua/plenary.nvim",
			})
			-- Trouble
			use({
				"folke/trouble.nvim",
				requires = "kyazdani42/nvim-web-devicons",
			})
			-- neocroll.nvim
			use("karb94/neoscroll.nvim")
			-- yank
			use({
				"gbprod/yanky.nvim",
				config = function()
					require("plugin-config.yanky")
				end,
			})
			-- undo tree
			use({ "mbbill/undotree" })

			-- --------git-------------------
			use({
				"lewis6991/gitsigns.nvim",
				-- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
				config = function()
					require("plugin-config.gitsigns")
				end,
			})
			-- --------markdown--------------
			-- install without yarn or npm
			-- markdown preview
			use({
				"iamcco/markdown-preview.nvim",
				run = function()
					vim.fn["mkdp#util#install"]()
				end,
				config = function()
					require("plugin-config.markdown-preview")
				end,
			})
			-- markdown work flow
			use({
				"jakewvincent/mkdnflow.nvim",
				rocks = "luautf8",
				config = function()
					require("plugin-config.mkdnflow")
				end,
			})
			-- --------telescope-------------
			use({
				"nvim-telescope/telescope.nvim",
				-- tag = "0.1.0",
				branch = "0.1.x",
				requires = { { "nvim-lua/plenary.nvim" } },
			})
			-- improve telescope performance
			use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
			-- look environment variables with telescope
			use({ "LinArcX/telescope-env.nvim" })
			-- Project need
			use({ "nvim-telescope/telescope-project.nvim" })
			-- telesocpe-dap
			use("nvim-telescope/telescope-dap.nvim")

			-- --------LSP-------------------
			-- https://github.com/neovim/nvim-lspconfig
			use({ "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" })
			use("neovim/nvim-lspconfig")
			-- json LSP need
			use("b0o/schemastore.nvim")
			-- display lsp progress
			use("j-hui/fidget.nvim")
			-- null-ls
			use({
				"jose-elias-alvarez/null-ls.nvim",
				requires = { "nvim-lua/plenary.nvim" },
			})
			-- ui-lspsaga
			use({
				"glepnir/lspsaga.nvim",
				branch = "main",
			})
			-- ui-breadcrumb
			use({
				"SmiteshP/nvim-navic",
				requires = "neovim/nvim-lspconfig",
			})
			-- -------DAP--------------------
			use("mfussenegger/nvim-dap")
			use("theHamsta/nvim-dap-virtual-text")
			use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
			---specific configuration
			-- python
			use("mfussenegger/nvim-dap-python")
			-- js
			use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
			use({
				"microsoft/vscode-js-debug",
				opt = true,
				run = "npm install --legacy-peer-deps && npm run compile",
			})
			-- -------nvim-cmp---------------
			-- nvim-cmp
			use("hrsh7th/nvim-cmp")
			-- sources
			use("rcarriga/cmp-dap")
			use("hrsh7th/cmp-nvim-lsp")
			use("hrsh7th/cmp-buffer")
			use("hrsh7th/cmp-path")
			use("hrsh7th/cmp-cmdline")
			use("hrsh7th/cmp-nvim-lsp-signature-help")
			-- snippet engine
			use("L3MON4D3/LuaSnip")
			-- sources
			use("saadparwaiz1/cmp_luasnip")
			-- code snippets
			use("rafamadriz/friendly-snippets")

			-- Automatically set up your configuration after cloning packer.nvim
			-- Put this at the end after all plugins
			if packer_bootstrap then
				require("packer").sync()
			end
		end,
		config = {
			package_root = package_root,
			compile_path = compile_path,
			display = {
				open_fn = function()
					return require("packer.util").float({ border = "rounded" })
				end,
			},
		},
	})
end
-- 第一次运行会通过git 下载packer插件管理器，同时sync同步一下
if vim.fn.isdirectory(install_path) == 0 then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	load_plugins()
	require("packer").sync()
else
	load_plugins()
end

-- 加载配色
require("colorscheme")

local config_path_root = vim.env.VIM
-- 通过vim.cmd加载一些 vimscript commands
vim.cmd("source" .. config_path_root .. "/extVIM.vim")

-- 基础配置
require("basic")

-- 快捷键映射
require("keybindings")

-- 自动命令
require("autocmd")

-- 用户自建立命令
require("usercmd")

-- 插件配置
--
-- lualine
require("plugin-config.lualine")

-- bufferline
require("plugin-config.bufferline")

-- nvim-treesitter
require("plugin-config.nvim-treesitter")

-- nvim-tree
require("plugin-config.nvim-tree")

-- telescope.nvim
require("plugin-config.telescope")

-- toggleterm.nvim
require("plugin-config.toggleterm")

-- Comment.nvim
require("plugin-config.comment")

-- autopairs
require("plugin-config.nvim-autopairs")

-- indentline
require("plugin-config.indent-blankline")

-- project
require("plugin-config.project")

-- todotree
require("plugin-config.todo-comments")

-- trouble
require("plugin-config.trouble")

-- dashboard
require("plugin-config.dashboard")

-- neoscroll
require("plugin-config.neoscrolL")

---自动补全
--
--- cmp
require("cmp.cmp")

---语言服务
--
--- LSP
require("lsp.setup")
require("lsp.ui")
require("plugin-config.fidget")
require("lsp.null-ls")

---代码调试器
--
-- DAP
require("dap.nvim-dap.setup")
