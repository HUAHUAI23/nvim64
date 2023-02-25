vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

vim.opt_local.list = true

-- wo window local options
-- bo buffer local options
-- see more: https://github.com/glepnir/nvim-lua-guide-zh

vim.wo.wrap = true -- auto wrap line

-- vim.wo.conceallevel = 2

-- more info :h awa
-- This will ensure that changes to buffers are saved when you navigate away from that buffer
-- e.g. by following a link to another file
vim.opt_local.autowriteall = true
vim.api.nvim_create_autocmd("BufLeave", { pattern = "*.md", command = "silent! wall" })

-- more info about cjk : https://neovim.io/doc/user/spell.html
vim.cmd("setlocal spell spelllang=en_us,cjk") -- switch spell check on
-- off
-- setlocal nospell

-- 超过80字符自动添加换行符
-- TODO: 如何实现超过80个字符后，先添加两个空格然后添加换行符
-- vim.bo.textwidth = 80
