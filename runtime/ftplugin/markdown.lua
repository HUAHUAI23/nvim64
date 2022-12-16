vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
-- wo window local
-- bo buffer local
-- see more: https://github.com/glepnir/nvim-lua-guide-zh
vim.wo.wrap = true
vim.cmd("setlocal spell spelllang=en_us") -- switch spell check on
-- 超过80字符自动添加换行符
-- TODO: 如何实现超过80个字符后，先添加两个空格然后添加换行符
-- vim.bo.textwidth = 80
