-- 当plugins.lua文件发生变化时 会自动执行:PackerCompile
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

local sharePath = require("commConf").sharePath
local packer_dir = sharePath .. "/abc/packeeeee"
vim.cmd("set packpath=" .. join_paths(packer_dir, "nvim", "site"))
local package_root = join_paths(packer_dir, "nvim", "site", "pack")
local install_path = join_paths(package_root, "packer", "start", "packer.nvim")
local compile_path = join_paths(install_path, "plugin", "packer_compiled.lua")

-- 当在新环境没有packer.nvim时 会自动下载安装packer.nvim
local ensure_packer = function()
	local fn = vim.fn
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup({
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		-- UI
		-- ---------------------------------------------------------
		-- icon,使neovim支持展示更多的icon
		use({ "kyazdani42/nvim-web-devicons" })

		-- 主题
		use({
			"ajmwagar/vim-deus",
			config = function()
				require("colorscheme")
			end,
		})

		use({ "sam4llis/nvim-tundra" })

		use({ "sainnhe/everforest" })

		-- use({ "Avimitin/neovim-deus" })

		-- 底部状态栏 statusline
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			event = "BufEnter",
			config = function()
				require("plugin-config.lualine")
			end,
			after = "nvim-web-devicons",
		})

		-- 顶部状态栏 bufferline
		use({
			"akinsho/bufferline.nvim",
			tag = "v2.*",
			requires = "kyazdani42/nvim-web-devicons",
			event = "BufEnter",
			config = function()
				require("plugin-config.bufferline")
			end,
			after = "nvim-web-devicons",
		})

		-- sytax highlight
		-- ---------------------------------------------------------
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
			config = function()
				require("plugin-config.nvim-treesitter")
			end,
		})

		-- Editor
		-- ---------------------------------------------------------
		-- 文件浏览器
		use({
			"nvim-tree/nvim-tree.lua",
			requires = {
				"nvim-tree/nvim-web-devicons", -- optional, for file icons
			},
			tag = "nightly", -- optional, updated every week. (see issue #1193)
			cmd = "NvimTreeToggle",
			config = function()
				require("plugin-config.nvim-tree")
			end,
			after = "nvim-web-devicons",
		})
		-- 禅意模式
		use({
			"folke/zen-mode.nvim",
			cmd = "ZenMode",
			config = function()
				require("plugin-config.zen-mode")
			end,
		})
		use({
			"folke/twilight.nvim",
			config = function()
				require("plugin-config.twilight")
			end,
			-- first load zen-mode then load twilight
			after = "zen-mode.nvim",
		})

		-- 更好看的命令终端
		use({
			"akinsho/toggleterm.nvim",
			tag = "*",
			config = function()
				require("plugin-config.toggleterm")
			end,
		})

		-- 注释插件
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("plugin-config.comment")
			end,
		})

		-- 括号自动补全插件
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("plugin-config.nvim-autopairs")
			end,
		})

		-- 对齐线插件
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("plugin-config.indent-blankline")
			end,
		})

		-- Project
		use({
			"ahmedkhalf/project.nvim",
			config = function()
				require("plugin-config.project")
			end,
		})

		--  dashboard-nvim
		use({
			"glepnir/dashboard-nvim",
			config = function()
				require("plugin-config.dashboard")
			end,
		})
		-- neocroll.nvim
		use({
			"karb94/neoscroll.nvim",
			config = function()
				require("plugin-config.neoscrolL")
			end,
		})
		-- yank
		use({
			"gbprod/yanky.nvim",
			config = function()
				require("plugin-config.yanky")
			end,
		})
		-- undo tree
		-- use({ "dinhhuy258/vim-local-history" })
		use({ "mbbill/undotree" })

		-- easy motion hop
		use({
			"phaazon/hop.nvim",
			branch = "v2", -- optional but strongly recommended
			config = function()
				require("plugin-config.hop")
			end,
			cmd = { "HopWord", "HopPattern", "HopLine" },
		})

		-- which key
		use({
			"folke/which-key.nvim",
			config = function()
				require("plugin-config.whichkey")
			end,
		})

		-- something toolkit
		-- ---------------------------------------------------------
		use({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("plugin-config.nvim-colorizer")
			end,
			cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer" },
		})

		-- the more powerful %
		-- matchup
		use({
			"andymass/vim-matchup",
			setup = function()
				-- may set any options here
				vim.g.matchup_matchparen_offscreen = { method = "popup" }
			end,
		})

		-- vim.notify
		use({
			"rcarriga/nvim-notify",
			config = function()
				require("plugin-config.nvim-notify")
			end,
		})

		-- something like lsp
		-- ---------------------------------------------------------
		-- TODO Comments
		use({
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("plugin-config.todo-comments")
			end,
		})
		-- Trouble
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			cmd = { "Trouble", "TroubleToggle", "Trouble loclist" },
			config = function()
				require("plugin-config.trouble")
			end,
			after = "nvim-web-devicons",
		})

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
			ft = "markdown",
			cmd = "MarkdownPreview",
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
			ft = "markdown",
			-- 通过lua包管理器下载一些lua依赖包
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
			config = function()
				require("plugin-config.telescope")
			end,
		})
		-- improve telescope performance
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		-- look environment variables with telescope
		use({ "LinArcX/telescope-env.nvim" })
		-- Project need
		use({ "nvim-telescope/telescope-project.nvim" })
		-- telesocpe-dap
		use("nvim-telescope/telescope-dap.nvim")
		-- telesope http
		use({ "barrett-ruth/telescope-http.nvim" })
		-- telesocpe-dapzzzz
		use("HUAHUAI23/telescope-dapzzzz")
		-- telescope-session
		use("HUAHUAI23/telescope-session.nvim")
		-- telescope-color
		use({ "HUAHUAI23/telescope-color.nvim" })

		-- --------LSP-------------------
		-- https://github.com/neovim/nvim-lspconfig
		use("neovim/nvim-lspconfig")
		use({ "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" })
		-- json LSP need
		use("b0o/schemastore.nvim")
		-- display lsp progress
		use("j-hui/fidget.nvim")
		-- null-ls
		use({
			"jose-elias-alvarez/null-ls.nvim",
			requires = { "nvim-lua/plenary.nvim" },
		})
		-- ui-lsp_signature
		-- use({
		-- 	"ray-x/lsp_signature.nvim",
		-- 	config = function()
		-- 		require("lsp.lsp-signature")
		-- 	end,
		-- })
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
		-- Highlight symbol under cursor
		use({
			"RRethy/vim-illuminate",
			config = function()
				require("lsp.vim-illuminate")
			end,
		})

		-- -------DAP--------------------
		-- DAP client
		use("mfussenegger/nvim-dap")
		-- something useful that improve UI
		use("theHamsta/nvim-dap-virtual-text")
		use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
		---specific configuration
		-- python
		use("mfussenegger/nvim-dap-python")
		-- js
		use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
		-- js DAP debugger
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
		use({ "L3MON4D3/LuaSnip" })
		-- sources
		use("saadparwaiz1/cmp_luasnip")
		-- code snippets
		use("rafamadriz/friendly-snippets")
		-- UI
		use("onsails/lspkind.nvim")
		-- AI assistant
		-- tabnine
		use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })
		--  GitHub Copilot
		-- use({ "github/copilot.vim" })

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
			prompt_border = "rounded", -- Border style of prompt popups.
		},
		-- -- 自定义源
		-- git = {
		-- 	default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
		-- },
		-- luarocks = {
		-- 	python_cmd = "python3", -- Set the python command to use for running hererocks
		-- },
	},
})
