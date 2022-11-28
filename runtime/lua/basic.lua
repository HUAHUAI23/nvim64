-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"

-- jkhl 移动时光标周围保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- 使用相对行号
vim.wo.number = true
vim.wo.relativenumber = false
-- 高亮所在行
vim.wo.cursorline = true
-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"
-- vim.wo.signcolumn = "yes:1"
-- 右侧参考线，超过表示代码太长了，考虑换行
-- vim.wo.colorcolumn = "80"
vim.o.colorcolumn = "80"

-- TODO: sessionoptions
-- -- indent
-- -- 缩进2个空格等于一个Tab
-- vim.o.tabstop = 2
-- vim.bo.tabstop = 2
-- vim.o.softtabstop = 2
-- vim.o.shiftround = true
-- -- >> << 时移动长度
-- vim.o.shiftwidth = 2
-- vim.bo.shiftwidth = 2
-- expandtab Tab键会被替换为空格（例如一个tab键被替换成四个空格）
-- noexpandtab Tab键不会被替换成空格
-- vim.o.expandtab = true
-- vim.bo.expandtab = true

-- 新行对齐当前行
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true

-- 搜索不要高亮
vim.o.hlsearch = false
-- 边输入边搜索
vim.o.incsearch = true

-- 命令行高为1，提供足够的显示空间
vim.o.cmdheight = 1
-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true

-- 禁止折行
vim.wo.wrap = false
-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.o.whichwrap = "<,>,[,]"
-- 允许隐藏被修改过的buffer
vim.o.hidden = true

-- 禁止创建备份文件
-- don't create backup file (swap file)
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- default 4000 -- if no type in 1000ms, then write the swap file to disk
-- also a wait time for the CursorHold event
-- vim.o.updatetime = 1000 --1000
-- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒，可根据需要设置,例如快捷键shift+q
-- map映射的组合键，输入一个键 最长等待时间500秒 等待下一个键输入
-- 遇到问题详见：https://github.com/nshen/learn-neovim-lua/issues/1
vim.o.timeoutlen = 500 --500

-- split window 从下边和右边出现
vim.o.splitbelow = true
vim.o.splitright = true

-- 自动补全不自动选中
vim.g.completeopt = "menu,menuone,noselect,noinsert"

-- 样式 使neovim支持 termguicolors
-- 已经定义在colorscheme 文件中
-- vim.o.termguicolors = true
-- vim.opt.termguicolors = true
-- https://stackoverflow.com/questions/15375992/vim-difference-between-t-co-256-and-term-xterm-256color-in-conjunction-with-tmu
-- vim.o.t_Co = 256

-- 不可见字符的显示，这里只把空格显示为一个点
vim.opt.list = true
vim.o.listchars = "tab:··,trail:▫"
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
-- vim.o.list = false
-- vim.o.listchars = "space:·,tab:··"
-- vim.o.listchars = "tab:··,trail:▫"

-- 补全增强
vim.o.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. "c"
-- 补全最多显示10行
vim.o.pumheight = 10

-- 永远显示 tabline
-- tabline winbar statusbar
vim.o.showtabline = 2

-- 使用增强状态栏插件后不再需要 vim 的模式提示
vim.o.showmode = false

-- 配置剪切板
-- vim.opt.clipboard = "unnamedplus"

-- 鼠标移动事件支持
-- vim.o.mousemoveevent = true
-- 鼠标支持
vim.o.mouse = "a"

-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldlevel = 99

-- 启用vim自带的插件检测文件类型
vim.opt.filetype = "plugin"
