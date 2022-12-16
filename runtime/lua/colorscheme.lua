local api = vim.api
vim.o.t_Co = 256
-- vim.o.termguicolors = true
vim.opt.termguicolors = true
vim.o.t_ut = ""
vim.o.t_ul = ""

vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"

-- 已经定义在basic.lua文件中
-- vim.opt.list = false
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

vim.o.background = "dark"
local colorscheme = "deus"
-- vim.g.deus_background = "hard"
vim.g.deus_termcolors = 256
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
	return
end

-- https://zhuanlan.zhihu.com/p/20718108
-- hi 样式名称 guifg=Gvim字体颜色 guibg=Gvim背景颜色 ctermfg=终端Vim字体颜色 ctermbg=终端Vim背景颜色 gui=Gvim字体样式 cterm=终端Vim字体样式
-- hi 的意思是 highlight，也就是它的缩写。 Normal 代表初始化时候的样式，
-- 常规样式， guifg 意思是，在 GVim 中（带有图形界面的Vim） ，字体的颜色是#990808 ，
-- 而 guibg 意思就是 背景色是black黑色，
-- ctermfg 代表了 vim 在 Linux 下的 terminal 终端里的字体配色，
-- terminal 只有 256色， 所以具体， 你需要查询 256 色值表，每个数字具体代表了什么颜色，
-- 而最后的 gui cterm 则是代表了字体的样式，你可以设置为bold(粗体) , 也可以设置为none(常规)

-- 在使用完colorscheme后再使用，若在之前使用，则会被colorscheme覆盖
-- 定义一些高亮组的颜色 see :h highlight
-- vim.cmd([[
--     highlight NonText ctermfg=gray guifg=grey50
--     hi SignColumn ctermbg=None guibg=None
--     hi VertSplit ctermfg=None ctermbg=None cterm=None guibg=None guifg=None
--     ]])

-- editor
api.nvim_set_hl(0, "NonText", { ctermfg = 142, fg = "grey50", bold = true })

api.nvim_set_hl(0, "SignColumn", { ctermbg = "none", bg = "none" })
api.nvim_set_hl(0, "VertSplit", { bg = "#2C323B", ctermbg = "none", ctermfg = 246, fg = "#ebdbb2" })
-- api.nvim_set_hl(0, "VertSplit", { bg = "none", ctermbg = "none", ctermfg = 246, fg = "#a89984" })
api.nvim_set_hl(0, "CursorLineNr", { ctermfg = 208, ctermbg = 239, bg = "#242a32", fg = "#fe8019", bold = true })

-- gitsigns
api.nvim_set_hl(0, "GitSignsAdd", { ctermfg = 142, ctermbg = 239, bg = "none", fg = "#98c379" })
api.nvim_set_hl(0, "GitSignsChange", { ctermfg = 108, ctermbg = 239, bg = "none", fg = "#8ec07c" })
api.nvim_set_hl(0, "GitSignsDelete", { ctermfg = 167, ctermbg = 239, bg = "none", fg = "#fb4934" })

-- treesitter
-- self,this ...
api.nvim_set_hl(0, "@variable.builtin", { ctermfg = 203, fg = "#ff4090" })
-- self.xxx
api.nvim_set_hl(0, "@parameter", { ctermfg = 223, fg = "#c678dd" })
api.nvim_set_hl(0, "@field", { ctermfg = 223, fg = "#c678dd" })
-- api.nvim_set_hl(0, "@boolean", { ctermfg = 175, fg = "#c678dd", bold = true, italic = true })
api.nvim_set_hl(0, "@boolean", { ctermfg = 214, fg = "#fabd2f", bold = true, italic = true })
api.nvim_set_hl(0, "@operator", { ctermfg = 203, fg = "#ff4090" })
api.nvim_set_hl(0, "@keyword.operator", { ctermfg = 203, fg = "#ff4090" }) -- and, or, not
api.nvim_set_hl(0, "@type", { ctermfg = 214, fg = "#fabd2f", bold = true, italic = true }) -- class
-- api.nvim_set_hl(0, "@variable", { ctermfg = 223, fg = "#ebdbb2" })
api.nvim_set_hl(0, "@string", { ctermfg = 142, fg = "#98c379", italic = true })
api.nvim_set_hl(0, "@keyword", { ctermfg = 203, fg = "#ff4090" })
api.nvim_set_hl(0, "@keyword.function", { ctermfg = 167, fg = "#fb4934" })
api.nvim_set_hl(0, "@keyword.return", { ctermfg = 167, fg = "#fb4934" })

-- navic
vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, fg = "#FBC19D", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, fg = "#FECDD3", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, fg = "#A5B4FC", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, fg = "#BF7471", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, fg = "#DDD6FE", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, fg = "#BF7471", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, fg = "#ebdbb2", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, fg = "#D1D5DB", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, fg = "#B5E8B0", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, fg = "#fe8019", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, fg = "#fe8019", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, fg = "#DDD6FE", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, fg = "#E8D4B0", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, fg = "#99BBBD", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, fg = "#BAE6FD", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, fg = "#D1D5DB", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, fg = "#9CA3AF", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, fg = "#fdb095", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, fg = "#FFFFFF", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, fg = "#E5E7EB", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, fg = "#DDD6FE", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, fg = "#BF7471", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, fg = "#FCA5A5", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, fg = "#FECDD3", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, fg = "#FBC19D", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, fg = "#ffa6ff", bold = true })
vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = "#ff4090", bold = true })
vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, fg = "#f5b3b3", bold = true })

-- sytax hightlight
-- local style = {
-- 	Comment = { italic = false, bold = false },
-- 	Function = { italic = false, bold = true },
-- 	Keyword = { italic = true, bold = true },
-- 	String = { italic = false, bold = true },
-- 	Identifier = { italic = false, bold = false },
-- }
-- for key, value in pairs(style) do
-- 	api.nvim_set_hl(0, key, value)
