-- TODO: use loop to disable bulks of plugins
-- disable some builtin plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 基础配置
require("basic")

-- 定义颜色主题
-- require("colorscheme")

-- Packer插件管理
require("plugins")

-- 通过vim.cmd加载一些 vimscript commands
vim.cmd("source" .. vim.env.VIM .. "/extVIM.vim")

-- 快捷键映射
local keybind = require("keybindings")
keybind.unsetKey(keybind.unsetmap)
keybind.editorKeyRegister(keybind.keymap_set)

-- 自动命令
require("autocmd")

-- 用户自建立命令
require("usercmd")

-- TODO: switch plugin's status, on or off
--- 插件配置
-- lualine
-- require("plugin-config.lualine")

-- bufferline
-- require("plugin-config.bufferline")

-- nvim-treesitter
-- require("plugin-config.nvim-treesitter")

-- nvim-tree
-- require("plugin-config.nvim-tree")

-- telescope.nvim
-- require("plugin-config.telescope")

-- toggleterm.nvim
-- require("plugin-config.toggleterm")

-- Comment.nvim
-- require("plugin-config.comment")

-- autopairs
-- require("plugin-config.nvim-autopairs")

-- indentline
-- require("plugin-config.indent-blankline")

-- project
-- require("plugin-config.project")

-- todotree
-- require("plugin-config.todo-comments")

-- trouble
-- require("plugin-config.trouble")

-- dashboard
-- require("plugin-config.dashboard")

-- neoscroll
-- require("plugin-config.neoscrolL")

--- cmp
require("cmp.cmp")

--- LSP
require("lsp.setup")
require("lsp.ui")
require("plugin-config.fidget")
require("lsp.null-ls")

-- DAP
require("dap.nvim-dap.setup")
