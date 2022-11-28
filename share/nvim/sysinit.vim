lua << EOF
-- add runtimpath
-- see :h 'runtimepath'
-- local luaPath = require("commConf").runtimePath .. "/xray23"
-- vim.cmd([[set runtimepath=$VIMRUNTIME,$VIM/xray23]])
vim.cmd([[set runtimepath=$VIMRUNTIME]])
vim.opt.runtimepath:append(vim.env.VIM .. "/xray23")
require("init")
EOF
