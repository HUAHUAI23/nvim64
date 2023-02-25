vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

-- more info: https://neovim.io/doc/user/options.html#'spelloptions'
-- 拼写检查 识别驼峰命名法
vim.opt_local.spelloptions = "camel"
vim.cmd("setlocal spell spelllang=en_us,cjk") -- switch spell check on

-- fold method use treesitter
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldlevel = 99
