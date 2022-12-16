lua << EOF
-- add runtimpath
-- see :h 'runtimepath'
-- vim.cmd([[set runtimepath=$VIMRUNTIME,$VIM/xray23]])
vim.cmd([[set runtimepath=$VIMRUNTIME]])
vim.opt.runtimepath:append(vim.env.VIM .. "/xray23")
require("start42")
EOF
