-- disable some builtin plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- matchup need this, can make a very slight start-up time improvement
vim.g.loaded_matchit = 1

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

--- cmp
require("cmp.cmp")

--- LSP
require("lsp.setup")
require("lsp.ui")

-- DAP
require("dap.nvim-dap.setup")
