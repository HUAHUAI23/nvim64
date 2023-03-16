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

-- normal #2C323B, nc and float #242a32 -- editor background
-- #1e2329 darker background eg: toggerterm vertical and horizontal, bufferline fill bg
-- #1d1536 darker background
-- #000000 statusline fill bg
-- error Red #b30909 #FF0000 #a80000
-- Error          xxx cterm=bold,reverse ctermfg=167 ctermbg=235 gui=bold,reverse guifg=#fb4934 guibg=bg -- #2C323B ##242a32
-- other colors
-- #FF0000 #fb4934 #B5E8B0 #ebdbb2 #fe8019 #a89984 #b8bb26 #d3869b
-- #8ec07c #98c379 #990808 #990606 #B30909 #fabd2f #aaaaaa #ffa6ff
-- #83a598 #90b5a7 #c678dd #928374 #fff073 "LightGrey" #959595 #ededed #4493c8
-- #bb0099 #00d0c0 #50de60 #FFFFFF #808080 "LightBlue" #665c54 #8094b4
-- #a80000 #f3a0a0 #bdae93 #ea589d #ff4090
-- syntax clear   syntax reset
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
---@diagnostic disable-next-line: param-type-mismatch
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！", "error")
	return
end
vim.g.deus_termcolors = 256

-- default mode
local mode = "you"
-- local mode = "camellia"

local function set_editor_hl()
	-- editor
	-- Normal         xxx ctermfg=223 ctermbg=235 guifg=#ebdbb2 guibg=#2c323b
	-- NormalFloat    xxx ctermfg=223 ctermbg=239 guifg=#ebdbb2 guibg=#242a32
	-- Visual         xxx cterm=reverse ctermbg=241 gui=reverse guibg=#665c54

	-- vim.api.nvim_set_hl(0, "NormalFloat", { ctermfg = 223, ctermbg = 239, fg = "#ebdbb2", bg = "#242a32", bold = true })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { ctermfg = 223, ctermbg = 239, fg = "#ebdbb2", bg = "#242a32" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { ctermfg = 223, ctermbg = 235, fg = "#ebdbb2", bg = "#2c323b", bold = true })
	vim.api.nvim_set_hl(0, "NormalFloat", { ctermfg = 223, ctermbg = 235, fg = "#ebdbb2", bg = "#2c323b" })

	vim.api.nvim_set_hl(0, "NonText", { ctermfg = 142, fg = "grey50", bold = true })
	vim.api.nvim_set_hl(0, "Cursor", { bold = true })
	-- nvim gutter, sign 列 number 列 fold（折叠标记） bookmark 列
	vim.api.nvim_set_hl(0, "SignColumn", { ctermbg = "none", bg = "none" })

	vim.api.nvim_set_hl(0, "VertSplit", { ctermfg = 245, fg = "#928374", bold = true })
	-- vim.api.nvim_set_hl(0, "VertSplit", { bg = "#2C323B", ctermbg = "none", ctermfg = 246, fg = "#ebdbb2" })
	-- api.nvim_set_hl(0, "VertSplit", { bg = "none", ctermbg = "none", ctermfg = 246, fg = "#a89984" })

	vim.api.nvim_set_hl(0, "Directory", { ctermfg = 142, fg = "#98c379", bold = true })
	vim.api.nvim_set_hl(0, "MoreMsg", { ctermfg = 214, fg = "#fabd2f", bold = true })
	vim.api.nvim_set_hl(0, "Question", { ctermfg = 208, fg = "#fe8019", bold = true })
	vim.api.nvim_set_hl(0, "MatchParen", { ctermbg = 241, bg = "#665c54", bold = true })
	-- MsgArea

	-- statusline
	vim.api.nvim_set_hl(0, "StatusLine", { fg = "#98c379", bg = "#242a32", bold = true })

	-- cursor number highlight
	vim.api.nvim_set_hl(
		0,
		"CursorLineNr",
		{ ctermfg = 208, ctermbg = 239, bg = "#242a32", fg = "#fe8019", bold = true }
	)

	vim.api.nvim_set_hl(0, "SpecialKey", { ctermfg = 208, fg = "#fe8019", bold = true })
	-- vim.api.nvim_set_hl(0, "SpecialKey", { fg = "#B5E8B0", bold = true })

	-- Search impact yank highlight
	-- vim.api.nvim_set_hl(0, "Search", { ctermbg = 214, ctermfg = 235, bg = "#fe8019", fg = "White", bold = true })
	-- vim.api.nvim_set_hl(0, "Search", { ctermbg = 214, ctermfg = 235, bg = "#B5E8B0", fg = "#808080", bold = true })
	-- vim.api.nvim_set_hl(0, "Search", { ctermbg = 214, ctermfg = 235, bg = "#B5E8B0", fg = "#665c54", bold = true })
	vim.api.nvim_set_hl(0, "Search", { ctermbg = 214, ctermfg = 235, bg = "#98c379", fg = "#665c54", bold = true })
	vim.api.nvim_set_hl(0, "Visual", { ctermbg = 241, bg = "#665c54", reverse = true, bold = true })
	-- vim.api.nvim_set_hl(0, "Visual", { ctermbg = 241, bg = "#665c54", reverse = true })

	-- spell
	vim.api.nvim_set_hl(
		0,
		"SpellLocal",
		{ undercurl = true, ctermbg = 214, ctermfg = 235, bg = "#B5E8B0", fg = "Grey", bold = true, sp = "#B5E8B0" }
	)
	-- #ffa6ff
	vim.api.nvim_set_hl(
		0,
		"SpellRare",
		{ undercurl = true, ctermbg = 214, ctermfg = 235, bg = "#ff0000", fg = "#f5f5f5", bold = true, sp = "#ff0000" }
	)
end

-- ======================= plugin highlight =======================
-- HopUnmatched   xxx ctermfg=242 guifg=#666666 guibg=bg guisp=#666666

local function set_gitsigns_hl()
	-- gitsigns
	-- #b8bb26 #d3869b
	vim.api.nvim_set_hl(0, "GitSignsAdd", { ctermfg = 142, ctermbg = 239, bg = "none", fg = "#98c379" })
	-- vim.api.nvim_set_hl(0, "GitSignsChange", { ctermfg = 108, ctermbg = 239, bg = "none", fg = "#8ec07c" })
	vim.api.nvim_set_hl(0, "GitSignsChange", { ctermfg = 108, ctermbg = 239, bg = "none", fg = "#B5E8B0" })
	-- vim.api.nvim_set_hl(0, "GitSignsAdd", { ctermfg = 142, ctermbg = 239, bg = "none", fg = "#b8bb26" })
	-- vim.api.nvim_set_hl(0, "GitSignsChange", { ctermfg = 108, ctermbg = 239, bg = "none", fg = "#d3869b" })
	vim.api.nvim_set_hl(0, "GitSignsDelete", { ctermfg = 167, ctermbg = 239, bg = "none", fg = "#fb4934" })
end
local function set_nvimtree_hl()
	-- nvimtree
	vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = "#928374", bold = true })
	vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#928374", bold = true })
	vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "#928374", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "#959595", bold = true })

	vim.api.nvim_set_hl(0, "NvimTreeOpenedFile", { fg = "#50de60", bold = true })
	vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = "#98c379", bold = true })
	vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#98c379", bold = true })
	vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#8094b4", bold = true })

	vim.api.nvim_set_hl(0, "NvimTreeSymlink", { fg = "#00d0c0", bold = true })
	vim.api.nvim_set_hl(0, "NvimTreeImageFile", { fg = "#bb0099", bold = true })
	vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = "#50de60", bold = true })
	vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { fg = "#fe8019", underline = true, bold = true })
	vim.api.nvim_set_hl(0, "NvimTreeBookmark", { fg = "#50de60", bold = true })

	vim.api.nvim_set_hl(0, "NvimTreeLiveFilterPrefix", { fg = "#bb0099", bold = true })
	vim.api.nvim_set_hl(0, "NvimTreeLiveFilterValue", { bold = true })
	vim.api.nvim_set_hl(0, "NvimTreeWindowPicker", { fg = "#ededed", bg = "#4493c8", bold = true })

	vim.api.nvim_set_hl(0, "NvimTreeFileIgnored", { fg = "#928374", bold = true })
	vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { fg = "#928374", bold = true })

	-- bufferline offset
	vim.api.nvim_set_hl(0, "BufferlineCustomeNvimtree", { fg = "#928374", bg = "#181B20", bold = true })
	vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { fg = "#181B20", bg = "#181B20", bold = true })

	-- vim.api.nvim_set_hl(0, "NvimTreeGitMerge", { fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeGitRenamed", { fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeModifiedFile", { fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeClosedFolderIcon", { fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderIcon", { fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeFileDirty", { fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeFileNew", { fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeFileStaged", { fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeGitUnStaged", { fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = "#98c379", bold = true })
end
local function set_navic_hl()
	-- navic
	vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, fg = "#98c379", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, fg = "#bb0099", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, fg = "#A5B4FC", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, fg = "#BAE6FD", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, fg = "#DDD6FE", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, fg = "#ffa6ff", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, fg = "#ebdbb2", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, fg = "#D1D5DB", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, fg = "#B5E8B0", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, fg = "#fe8019", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, fg = "#fe8019", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, fg = "#B5E8B0", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, fg = "#E8D4B0", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, fg = "#99BBBD", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, fg = "#BAE6FD", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, fg = "#D1D5DB", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, fg = "#fff073", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, fg = "#fdb095", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, fg = "#BAE6FD", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, fg = "#c678dd", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, fg = "#DDD6FE", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, fg = "#bb0099", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, fg = "#FCA5A5", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, fg = "#FECDD3", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, fg = "#FBC19D", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, fg = "#ffa6ff", bold = true })

	-- vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = "#ff4090", bold = true })
	-- vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = "LightGrey", bold = true })
	vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = "#B5E8B0", bold = true })
	-- vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, fg = "#98c379", bold = true })
	vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, fg = "#B5E8B0", bold = true })
end
local function set_notify_hl()
	-- notify
	-- vim.api.nvim_set_hl(0, "NotifyERRORTitle", { ctermfg = 167, fg = "#ff0000", bold = true })
	-- vim.api.nvim_set_hl(0, "NotifyERRORIcon", { ctermfg = 167, fg = "#ff0000", bold = true })
	-- vim.api.nvim_set_hl(0, "NotifyERRORBorder", { ctermfg = 167, fg = "#ff0000", bold = true })
	-- vim.api.nvim_set_hl(0, "NotifyWARNTitle", { ctermfg = 208, fg = "#fe8019", bold = true })
	-- vim.api.nvim_set_hl(0, "NotifyWARNIcon", { ctermfg = 208, fg = "#fe8019", bold = true })
	-- vim.api.nvim_set_hl(0, "NotifyWARNBorder", { ctermfg = 208, fg = "#fe8019", bold = true })
	-- vim.api.nvim_set_hl(0, "NotifyINFOTitle", { ctermfg = 142, fg = "#B5E8B0", bold = true })
	-- vim.api.nvim_set_hl(0, "NotifyINFOIcon", { ctermfg = 142, fg = "#B5E8B0", bold = true })
	-- vim.api.nvim_set_hl(0, "NotifyINFOBorder", { ctermfg = 142, fg = "#B5E8B0", bold = true })
	vim.api.nvim_set_hl(0, "NotifyERRORTitle", { ctermfg = 167, fg = "#aaaaaa", bold = true })
	vim.api.nvim_set_hl(0, "NotifyERRORIcon", { ctermfg = 167, fg = "#aaaaaa", bold = true })
	vim.api.nvim_set_hl(0, "NotifyERRORBorder", { ctermfg = 167, fg = "#aaaaaa", bold = true })
	vim.api.nvim_set_hl(0, "NotifyWARNTitle", { ctermfg = 208, fg = "#fe8019", bold = true })
	vim.api.nvim_set_hl(0, "NotifyWARNIcon", { ctermfg = 208, fg = "#fe8019", bold = true })
	vim.api.nvim_set_hl(0, "NotifyWARNBorder", { ctermfg = 208, fg = "#fe8019", bold = true })
	vim.api.nvim_set_hl(0, "NotifyINFOTitle", { ctermfg = 142, fg = "#bdae93", bold = true })
	vim.api.nvim_set_hl(0, "NotifyINFOIcon", { ctermfg = 142, fg = "#bdae93", bold = true })
	vim.api.nvim_set_hl(0, "NotifyINFOBorder", { ctermfg = 142, fg = "#bdae93", bold = true })
end
local function set_indenline_hl()
	-- indentline
	-- vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "LightGrey", bg = "none" })
	-- vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#959595", bg = "none" })
	-- vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#ebdbb2", bg = "none" })
	vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#928374", bg = "none" })

	vim.api.nvim_set_hl(0, "IndentBlanklineSpaceCharBlankline", { ctermfg = 142, fg = "#242a32", nocombine = true })
	-- vim.api.nvim_set_hl(0, "IndentBlanklineSpaceCharBlankline", { ctermfg = 142, fg = "#928374", nocombine = true })
	vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { ctermfg = 142, fg = "#242a32", nocombine = true })
	-- vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { ctermfg = 142, fg = "#928374", nocombine = true })
	vim.api.nvim_set_hl(0, "IndentBlanklineChar", { ctermfg = 142, fg = "#242a32", nocombine = true })
	-- vim.api.nvim_set_hl(0, "IndentBlanklineChar", { ctermfg = 142, fg = "#928374", nocombine = true })
end
local function set_lsp_hl()
	-- lsp
	vim.api.nvim_set_hl(0, "LspReferenceText", { fg = "#B5E8B0" })
	vim.api.nvim_set_hl(0, "LspReferenceRead", { fg = "#B5E8B0" })
	vim.api.nvim_set_hl(0, "LspReferenceWrite", { fg = "#B5E8B0" })
	vim.api.nvim_set_hl(0, "LspCodeLens", { fg = "#928374" })
	vim.api.nvim_set_hl(0, "LspCodeLensSeparator", { fg = "LightGrey" })
	vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = "#ffa6ff" })

	-- vim.api.nvim_set_hl(0, "DiagnosticError", { ctermfg = 1, fg = "Red", bold = true })
	-- vim.api.nvim_set_hl(0, "DiagnosticError", { ctermfg = 1, fg = "#fb4934", italic = true })
	vim.api.nvim_set_hl(0, "DiagnosticError", { ctermfg = 1, fg = "#fb4934", bold = true })

	-- vim.api.nvim_set_hl(0, "DiagnosticWarn", { ctermfg = 3, fg = "Orange", bold = true })
	-- vim.api.nvim_set_hl(0, "DiagnosticWarn", { ctermfg = 3, fg = "#fe8019", italic = true })
	vim.api.nvim_set_hl(0, "DiagnosticWarn", { ctermfg = 3, fg = "#fe8019", bold = true })
	-- vim.api.nvim_set_hl(0, "DiagnosticWarn", { ctermfg = 3, fg = "#83a598", italic = true })

	-- vim.api.nvim_set_hl(0, "DiagnosticInfo", { ctermfg = 4, fg = "LightBlue", bold = true })
	-- vim.api.nvim_set_hl(0, "DiagnosticInfo", { ctermfg = 4, fg = "#add8e6", bold = true })
	-- vim.api.nvim_set_hl(0, "DiagnosticInfo", { ctermfg = 4, fg = "#8ec07c", italic = true })
	vim.api.nvim_set_hl(0, "DiagnosticInfo", { ctermfg = 4, fg = "#8ec07c", bold = true })
	-- vim.api.nvim_set_hl(0, "DiagnosticInfo", { ctermfg = 4, fg = "#BAE6FD", bold = true })

	-- vim.api.nvim_set_hl(0, "DiagnosticHint", { ctermfg = 7, fg = "#d3d3d3", bold = true })
	-- vim.api.nvim_set_hl(0, "DiagnosticHint", { ctermfg = 7, fg = "#bdae93", italic = true })
	vim.api.nvim_set_hl(0, "DiagnosticHint", { ctermfg = 7, fg = "#bdae93", bold = true })

	-- vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { standout = true, strikethrough = true, sp = "Red" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { strikethrough = true, sp = "#fb4934" })
	-- vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { standout = true, sp = "Orange" })
	-- vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { standout = true, sp = "#fe8019" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#fe8019" })
end

local function setsyntax()
	-- #990808 #aaaaaa #990606 #B30909
	-- sytax
	vim.api.nvim_set_hl(0, "Comment", { ctermfg = 245, fg = "#928374" })
	vim.api.nvim_set_hl(0, "Constant", { ctermfg = 175, fg = "#c678dd", bold = true })
	vim.api.nvim_set_hl(0, "String", { ctermfg = 142, fg = "#98c379", italic = true })
	vim.api.nvim_set_hl(0, "Identifier", { ctermfg = 109, fg = "#83a598" })

	vim.api.nvim_set_hl(0, "Function", { ctermfg = 142, fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "Function", { ctermfg = 142, fg = "#B5E8B0", bold = true })

	vim.api.nvim_set_hl(0, "Statement", { ctermfg = 167, fg = "#fb4934" })
	vim.api.nvim_set_hl(0, "Operator", { ctermfg = 223, fg = "#ebdbb2", bold = true })

	vim.api.nvim_set_hl(0, "keyword", { ctermfg = 167, fg = "#fb4934", bold = true })
	-- vim.api.nvim_set_hl(0, "keyword", { ctermfg = 167, fg = "#fb4934", bold = true, italic = true })

	vim.api.nvim_set_hl(0, "PreProc", { ctermfg = 108, fg = "#8ec07c", bold = true, italic = true })
	-- vim.api.nvim_set_hl(0, "PreProc", { ctermfg = 108, fg = "#B5E8B0", bold = true, italic = true })

	vim.api.nvim_set_hl(0, "Type", { ctermfg = 214, fg = "#fabd2f", bold = true })
	vim.api.nvim_set_hl(0, "StorageClass", { ctermfg = 208, fg = "#fe8019" })
	vim.api.nvim_set_hl(0, "Structure", { ctermfg = 108, fg = "#8ec07c" })
	vim.api.nvim_set_hl(0, "Typedef", { ctermfg = 214, fg = "#fabd2f" })
	vim.api.nvim_set_hl(0, "Special", { ctermfg = 208, fg = "#fe8019" })
	vim.api.nvim_set_hl(0, "Repeat", { ctermfg = 167, fg = "#fb4934" })
	vim.api.nvim_set_hl(0, "Boolean", { ctermfg = 175, fg = "#c678dd", bold = true, italic = true })
	vim.api.nvim_set_hl(0, "Conditional", { ctermfg = 167, fg = "#fb4934" })
	vim.api.nvim_set_hl(0, "Number", { ctermfg = 175, fg = "#c678dd", bold = true })
	vim.api.nvim_set_hl(0, "Float", { ctermfg = 175, fg = "#c678dd", bold = true })

	-- vim.api.nvim_set_hl(0, "Exception", { ctermfg = 167, fg = "#fb4934", bold = true })
	vim.api.nvim_set_hl(0, "Exception", { fg = "#B30909", bold = true })
	-- vim.api.nvim_set_hl(0, "Exception", { fg = "#FF0000", bold = true })

	vim.api.nvim_set_hl(0, "Macro", { ctermfg = 108, fg = "#8ec07c", bold = true })
	vim.api.nvim_set_hl(0, "Delimiter", { ctermfg = 208, fg = "#fe8019" })
	vim.api.nvim_set_hl(0, "Character", { link = "Delimiter" })
	vim.api.nvim_set_hl(0, "Label", { link = "Statement" })
	vim.api.nvim_set_hl(0, "Include", { link = "PreProc" })
	vim.api.nvim_set_hl(0, "Define", { link = "PreProc" })
	vim.api.nvim_set_hl(0, "PreCondit", { link = "PreProc" })
	vim.api.nvim_set_hl(0, "SpecialChar", { link = "Special" })
	vim.api.nvim_set_hl(0, "Tag", { link = "Special" })
	vim.api.nvim_set_hl(0, "SpecialComment", { link = "Special" })
	vim.api.nvim_set_hl(0, "Debug", { link = "Special" })
end

local caseList = {
	camellia = function()
		vim.cmd("highlight clear")
		vim.cmd("colorscheme deus")

		set_editor_hl()
		set_lsp_hl()
		set_gitsigns_hl()
		set_notify_hl()
		set_indenline_hl()
		set_nvimtree_hl()
		set_navic_hl()
		vim.cmd("highlight clear ColorColumn")
		-- syntax
		setsyntax()
		-- treesitter
		-- #990808  #aaaaaa #b8bb26 #d3869b #B5E8B0 #FF0000 #ff4090

		-- Punctuation.
		vim.api.nvim_set_hl(0, "@punct.delimiter", { link = "Delimiter" })
		vim.api.nvim_set_hl(0, "@punct.bracket", { link = "Delimiter" })
		vim.api.nvim_set_hl(0, "@punct.special", { link = "Delimiter" })
		-- Literals.
		vim.api.nvim_set_hl(0, "@string", { link = "String" })
		vim.api.nvim_set_hl(0, "@string.regex", { fg = "#ff4090", italic = true })
		vim.api.nvim_set_hl(0, "@string.escape", { fg = "#B5E8B0", bold = true })
		vim.api.nvim_set_hl(0, "@string.special", { fg = "#B5E8B0", italic = true })
		vim.api.nvim_set_hl(0, "@character", { link = "SpecialKey" })
		vim.api.nvim_set_hl(0, "@character.special", { link = "SpecialKey" })
		vim.api.nvim_set_hl(0, "@number", { link = "Number" })
		vim.api.nvim_set_hl(0, "@float", { link = "Float" })
		vim.api.nvim_set_hl(0, "@boolean", { link = "Boolean" })
		-- Functions
		vim.api.nvim_set_hl(0, "@function", { link = "Function" })
		vim.api.nvim_set_hl(0, "@method", { link = "Function" })
		vim.api.nvim_set_hl(0, "@method.call", { link = "Function" })
		vim.api.nvim_set_hl(0, "@constructor", { link = "Function" })
		vim.api.nvim_set_hl(0, "@parameter", { fg = "#aaaaaa", italic = true })
		vim.api.nvim_set_hl(0, "@parameter.reference", { link = "@parameter" })

		-- Keywords.
		vim.api.nvim_set_hl(0, "@keyword", { link = "Keyword" })
		vim.api.nvim_set_hl(0, "@keyword.function", { link = "Keyword" })
		vim.api.nvim_set_hl(0, "@keyword.operator", { link = "Exception" })
		vim.api.nvim_set_hl(0, "@keyword.return", { link = "Exception" })
		vim.api.nvim_set_hl(0, "@conditional", { link = "Conditional" })
		vim.api.nvim_set_hl(0, "@repeat", { link = "Repeat" })
		vim.api.nvim_set_hl(0, "@debug", { link = "Debug" })
		vim.api.nvim_set_hl(0, "@label", { link = "Label" })
		vim.api.nvim_set_hl(0, "@include", { link = "Include" })
		vim.api.nvim_set_hl(0, "@exception", { link = "Exception" })
		-- Type
		vim.api.nvim_set_hl(0, "@type", { link = "Type" })
		vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#ebdbb2" })
		vim.api.nvim_set_hl(0, "@type.qualifier", { link = "Type" })
		vim.api.nvim_set_hl(0, "@type.definition", { link = "Type" })
		vim.api.nvim_set_hl(0, "@storageclass", { link = "StorageClass" })
		vim.api.nvim_set_hl(0, "@attribute", { link = "Constant" })

		-- eg: property, member of a class
		vim.api.nvim_set_hl(0, "@field", { fg = "#aaaaaa" })
		vim.api.nvim_set_hl(0, "@property", { link = "@field" })

		-- Identifiers.
		vim.api.nvim_set_hl(0, "@constant", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })

		-- eg: self,this ...
		vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#fabd2f" })

		vim.api.nvim_set_hl(0, "@const.builtin", { fg = "#ff4090", italic = true, bold = true })
		vim.api.nvim_set_hl(0, "@const.macro", { link = "Macro" })
		vim.api.nvim_set_hl(0, "@symbol", { link = "Special" })
		-- Text. -- Markdown
		vim.api.nvim_set_hl(0, "@text", { link = "Normal" })
		vim.api.nvim_set_hl(0, "@text.strong", { fg = "#fb4934", bold = true })
		vim.api.nvim_set_hl(0, "@text.emphasis", { fg = "#fabd2f", bold = true })
		vim.api.nvim_set_hl(0, "@text.underline", { underline = true })
		vim.api.nvim_set_hl(0, "@text.strike", { strikethrough = true })
		vim.api.nvim_set_hl(0, "@text.title", { ctermfg = 167, fg = "#fb4934", bold = true })
		vim.api.nvim_set_hl(0, "@text.literal", { link = "String" })
		vim.api.nvim_set_hl(0, "@text.uri", { fg = "#aaaaaa", bold = true })
		vim.api.nvim_set_hl(0, "@text.math", { link = "Special" })
		vim.api.nvim_set_hl(0, "@text.environment", { link = "Macro" })
		vim.api.nvim_set_hl(0, "@text.environment.name", { link = "Type" })
		vim.api.nvim_set_hl(0, "@text.reference", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@text.danger", { link = "Exception" })
		vim.api.nvim_set_hl(0, "@text.note", { link = "DiagnosticInfo" })
		vim.api.nvim_set_hl(0, "@text.todo", { link = "DiagnosticHint" })
		vim.api.nvim_set_hl(0, "@text.warning", { link = "DiagnosticWarn" })
		-- Tags.
		vim.api.nvim_set_hl(0, "@tag.delimiter", { link = "Comment" })
		vim.api.nvim_set_hl(0, "@tag.attribute", { link = "@parameter" })
		-- Miscellaneous.
		vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
		vim.api.nvim_set_hl(0, "@define", { link = "PreProc" })
		-- @error 在insert模式下，对输入的字符进行高亮 比如让输入的字符加粗
		vim.api.nvim_set_hl(0, "@error", { link = "DiagnosticError" })
		vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })
		vim.api.nvim_set_hl(0, "@preproc", { link = "PreProc" })

		vim.cmd("highlight clear ColorColumn")
	end,
	fragrans = function()
		vim.cmd("highlight clear")
		vim.cmd("colorscheme deus")
		set_editor_hl()
		set_lsp_hl()
		set_gitsigns_hl()
		set_notify_hl()
		set_indenline_hl()
		set_nvimtree_hl()
		set_navic_hl()
		vim.cmd("highlight clear ColorColumn")
		-- sytax
		vim.api.nvim_set_hl(0, "Comment", { ctermfg = 245, fg = "#928374" })
		vim.api.nvim_set_hl(0, "Constant", { ctermfg = 175, fg = "#ffa6ff", bold = true })
		-- vim.api.nvim_set_hl(0, "Constant", { ctermfg = 175, fg = "#c678dd", bold = true })
		vim.api.nvim_set_hl(0, "String", { ctermfg = 142, fg = "#98c379", italic = true })
		vim.api.nvim_set_hl(0, "Identifier", { ctermfg = 109, fg = "#83a598" })
		vim.api.nvim_set_hl(0, "Function", { ctermfg = 142, fg = "#B5E8B0", bold = true })
		vim.api.nvim_set_hl(0, "Statement", { ctermfg = 167, fg = "#FF0000" })
		vim.api.nvim_set_hl(0, "Operator", { ctermfg = 223, fg = "#ebdbb2", bold = true })
		vim.api.nvim_set_hl(0, "keyword", { ctermfg = 167, fg = "#FF0000", bold = true })
		vim.api.nvim_set_hl(0, "PreProc", { ctermfg = 108, fg = "#B5E8B0", bold = true, italic = true })
		vim.api.nvim_set_hl(0, "Type", { ctermfg = 214, fg = "#fabd2f", bold = true })
		vim.api.nvim_set_hl(0, "StorageClass", { ctermfg = 208, fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "Structure", { ctermfg = 108, fg = "#8ec07c" })
		-- vim.api.nvim_set_hl(0, "Typedef", { ctermfg = 214, fg = "#fabd2f" })
		vim.api.nvim_set_hl(0, "Typedef", { ctermfg = 214, fg = "#fff073" })
		vim.api.nvim_set_hl(0, "Special", { ctermfg = 208, fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "Repeat", { ctermfg = 167, fg = "#B5E8B0" })
		vim.api.nvim_set_hl(0, "Boolean", { ctermfg = 175, fg = "#c678dd", bold = true, italic = true })
		vim.api.nvim_set_hl(0, "Conditional", { ctermfg = 167, fg = "#B5E8B0" })
		vim.api.nvim_set_hl(0, "Number", { ctermfg = 175, fg = "#ffa6ff", bold = true })
		vim.api.nvim_set_hl(0, "Float", { ctermfg = 175, fg = "#ffa6ff", bold = true })
		vim.api.nvim_set_hl(0, "Exception", { fg = "#FF0000", bold = true })
		vim.api.nvim_set_hl(0, "Macro", { ctermfg = 108, fg = "#B5E8B0", bold = true })
		vim.api.nvim_set_hl(0, "Delimiter", { ctermfg = 208, fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "Character", { link = "Delimiter" })
		vim.api.nvim_set_hl(0, "Label", { link = "Statement" })
		vim.api.nvim_set_hl(0, "Include", { link = "PreProc" })
		vim.api.nvim_set_hl(0, "Define", { link = "PreProc" })
		vim.api.nvim_set_hl(0, "PreCondit", { link = "PreProc" })
		vim.api.nvim_set_hl(0, "SpecialChar", { link = "Special" })
		vim.api.nvim_set_hl(0, "Tag", { link = "Special" })
		vim.api.nvim_set_hl(0, "SpecialComment", { link = "Special" })
		vim.api.nvim_set_hl(0, "Debug", { link = "Special" })

		--  === treesitter

		-- Punctuation.
		vim.api.nvim_set_hl(0, "@punct.delimiter", { link = "Delimiter" })
		vim.api.nvim_set_hl(0, "@punct.bracket", { link = "Delimiter" })
		vim.api.nvim_set_hl(0, "@punct.special", { link = "Delimiter" })
		-- Literals.
		vim.api.nvim_set_hl(0, "@string", { link = "String" })
		vim.api.nvim_set_hl(0, "@string.regex", { fg = "#ff4090", italic = true })
		vim.api.nvim_set_hl(0, "@string.escape", { fg = "#B5E8B0", bold = true })
		vim.api.nvim_set_hl(0, "@string.special", { fg = "#B5E8B0", italic = true })
		vim.api.nvim_set_hl(0, "@character", { link = "SpecialKey" })
		vim.api.nvim_set_hl(0, "@character.special", { link = "SpecialKey" })
		vim.api.nvim_set_hl(0, "@number", { link = "Number" })
		vim.api.nvim_set_hl(0, "@float", { link = "Float" })
		vim.api.nvim_set_hl(0, "@boolean", { link = "Boolean" })
		-- Functions
		vim.api.nvim_set_hl(0, "@function", { link = "Function" })
		vim.api.nvim_set_hl(0, "@method", { link = "Function" })
		vim.api.nvim_set_hl(0, "@method.call", { link = "Function" })
		vim.api.nvim_set_hl(0, "@constructor", { link = "Function" })
		vim.api.nvim_set_hl(0, "@parameter", { fg = "#aaaaaa", italic = true })
		vim.api.nvim_set_hl(0, "@parameter.reference", { link = "@parameter" })
		-- Keywords.
		vim.api.nvim_set_hl(0, "@keyword", { link = "Keyword" })
		vim.api.nvim_set_hl(0, "@keyword.function", { link = "Keyword" })
		vim.api.nvim_set_hl(0, "@keyword.operator", { link = "Exception" })
		vim.api.nvim_set_hl(0, "@keyword.return", { link = "Exception" })
		vim.api.nvim_set_hl(0, "@conditional", { link = "Conditional" })
		vim.api.nvim_set_hl(0, "@repeat", { link = "Repeat" })
		vim.api.nvim_set_hl(0, "@debug", { link = "Debug" })
		vim.api.nvim_set_hl(0, "@label", { link = "Label" })
		vim.api.nvim_set_hl(0, "@include", { link = "Include" })
		vim.api.nvim_set_hl(0, "@exception", { link = "Exception" })
		-- Type
		vim.api.nvim_set_hl(0, "@type", { link = "Type" })
		vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#ebdbb2" })
		vim.api.nvim_set_hl(0, "@type.qualifier", { link = "Type" })
		vim.api.nvim_set_hl(0, "@type.definition", { link = "Type" })
		vim.api.nvim_set_hl(0, "@storageclass", { link = "StorageClass" })
		vim.api.nvim_set_hl(0, "@attribute", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@field", { link = "@parameter" })
		vim.api.nvim_set_hl(0, "@property", { link = "@field" })
		-- Identifiers.
		vim.api.nvim_set_hl(0, "@constant", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#fff073" })
		vim.api.nvim_set_hl(0, "@const.builtin", { fg = "#ff4090", italic = true, bold = true })
		vim.api.nvim_set_hl(0, "@const.macro", { link = "Macro" })
		vim.api.nvim_set_hl(0, "@symbol", { link = "Special" })
		-- Text. -- Markdown
		vim.api.nvim_set_hl(0, "@text", { link = "Normal" })
		vim.api.nvim_set_hl(0, "@text.strong", { fg = "#FF0000", bold = true })
		vim.api.nvim_set_hl(0, "@text.emphasis", { fg = "#fabd2f", bold = true })
		vim.api.nvim_set_hl(0, "@text.underline", { underline = true })
		vim.api.nvim_set_hl(0, "@text.strike", { strikethrough = true })
		vim.api.nvim_set_hl(0, "@text.title", { fg = "#B5E8B0", bold = true })
		vim.api.nvim_set_hl(0, "@text.literal", { link = "String" })
		vim.api.nvim_set_hl(0, "@text.uri", { fg = "#aaaaaa", bold = true })
		vim.api.nvim_set_hl(0, "@text.math", { link = "Special" })
		vim.api.nvim_set_hl(0, "@text.environment", { link = "Macro" })
		vim.api.nvim_set_hl(0, "@text.environment.name", { link = "Type" })
		vim.api.nvim_set_hl(0, "@text.reference", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@text.danger", { link = "Exception" })
		vim.api.nvim_set_hl(0, "@text.note", { link = "DiagnosticInfo" })
		vim.api.nvim_set_hl(0, "@text.todo", { link = "DiagnosticHint" })
		vim.api.nvim_set_hl(0, "@text.warning", { link = "DiagnosticWarn" })
		-- Tags.
		vim.api.nvim_set_hl(0, "@tag.delimiter", { link = "Comment" })
		vim.api.nvim_set_hl(0, "@tag.attribute", { link = "@parameter" })
		-- Miscellaneous.
		vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
		vim.api.nvim_set_hl(0, "@define", { link = "PreProc" })
		vim.api.nvim_set_hl(0, "@error", { link = "DiagnosticError" })
		vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })
		vim.api.nvim_set_hl(0, "@preproc", { link = "PreProc" })

		-- =====gitsign
		vim.api.nvim_set_hl(0, "GitSignsAdd", { ctermfg = 142, ctermbg = 239, bg = "none", fg = "#98c379" })
		vim.api.nvim_set_hl(0, "GitSignsChange", { ctermfg = 108, ctermbg = 239, bg = "none", fg = "#B5E8B0" })

		vim.cmd("highlight clear ColorColumn")
	end,
	sakura = function()
		vim.cmd("highlight clear")
		vim.cmd("colorscheme deus")
		set_editor_hl()
		set_lsp_hl()
		set_gitsigns_hl()
		set_notify_hl()
		set_indenline_hl()
		set_nvimtree_hl()
		set_navic_hl()
		vim.cmd("highlight clear ColorColumn")

		-- syntax
		setsyntax()

		-- =====treesitter
		-- self,this ...
		vim.api.nvim_set_hl(0, "@variable.builtin", { ctermfg = 203, fg = "#ff4090" })
		-- self.xxx property, member of a class
		vim.api.nvim_set_hl(0, "@field", { ctermfg = 223, fg = "#c678dd" })
		vim.api.nvim_set_hl(0, "@property", { link = "@field" })

		-- parameter
		vim.api.nvim_set_hl(0, "@parameter", { ctermfg = 223, fg = "#c678dd", italic = true })

		-- api.nvim_set_hl(0, "@boolean", { ctermfg = 175, fg = "#c678dd", bold = true, italic = true })
		vim.api.nvim_set_hl(0, "@boolean", { ctermfg = 214, fg = "#fabd2f", bold = true, italic = true })
		vim.api.nvim_set_hl(0, "@operator", { ctermfg = 203, fg = "#ff4090" })
		vim.api.nvim_set_hl(0, "@keyword.operator", { ctermfg = 203, fg = "#ff4090" }) -- and, or, not
		vim.api.nvim_set_hl(0, "@type", { ctermfg = 214, fg = "#fabd2f", bold = true, italic = true }) -- class

		-- api.nvim_set_hl(0, "@variable", { ctermfg = 223, fg = "#EBDBB2" })

		-- api.nvim_set_hl(0, "@string", { ctermfg = 142, fg = "#98c379", italic = true })
		vim.api.nvim_set_hl(0, "@string", { ctermfg = 142, fg = "#ebdbb2", italic = true })

		-- api.nvim_set_hl(0, "@keyword", { ctermfg = 203, fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "@keyword", { ctermfg = 203, fg = "#ff4090" })
		vim.api.nvim_set_hl(0, "@keyword.function", { ctermfg = 167, fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "@keyword.return", { ctermfg = 167, fg = "#fb4934" })

		-- markdown
		vim.api.nvim_set_hl(0, "@text.title", { ctermfg = 167, fg = "#fb4934", bold = true })

		vim.cmd("highlight clear ColorColumn")
	end,
	you = function()
		vim.cmd("highlight clear")
		vim.cmd("syntax clear")
		vim.cmd("syntax reset")
		vim.cmd("colorscheme deus")
		set_editor_hl()
		set_lsp_hl()
		set_gitsigns_hl()
		set_notify_hl()
		set_indenline_hl()
		set_nvimtree_hl()
		-- set_navic_hl()
		-- vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = "#B5E8B0", bold = true })
		-- vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, fg = "#B5E8B0", bold = true })
		vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = "#d5c4a1" })
		vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, fg = "#d5c4a1", bold = true })

		vim.cmd("highlight clear ColorColumn")
		-- dslight0 #d2d2d2 dslight1 #ebdbb2 dslight2 #d5c4a1 dslight3 #bdae93 dslight4 #a89984
		-- Syntax
		vim.api.nvim_set_hl(0, "Comment", { fg = "#928374", italic = true })
		-- Literals
		vim.api.nvim_set_hl(0, "Constant", { fg = "#f0af00" })
		vim.api.nvim_set_hl(0, "String", { fg = "#98C379" })
		vim.api.nvim_set_hl(0, "Character", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "Number", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "Boolean", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "Float", { fg = "#C678DD" })
		-- Identifiers
		vim.api.nvim_set_hl(0, "Identifier", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "Function", { fg = "#98C379", bold = true })
		-- Syntax
		vim.api.nvim_set_hl(0, "Statement", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "Conditional", { fg = "#fb4934", italic = true })
		vim.api.nvim_set_hl(0, "Repeat", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "Label", { fg = "#BD93BD", italic = true })
		vim.api.nvim_set_hl(0, "Operator", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "Keyword", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "Exception", { fg = "#fb4934", bold = true })
		vim.api.nvim_set_hl(0, "Noise", { fg = "#fe8019" })
		-- Metatextual Information
		vim.api.nvim_set_hl(0, "PreProc", { fg = "#f4c069" })
		vim.api.nvim_set_hl(0, "Include", { fg = "#83a598", nocombine = true })
		vim.api.nvim_set_hl(0, "Define", { fg = "#83a598", nocombine = true })
		vim.api.nvim_set_hl(0, "Macro", { fg = "#83a598", italic = true })
		vim.api.nvim_set_hl(0, "PreCondit", { fg = "#f4c069", italic = true })
		-- Semantics
		vim.api.nvim_set_hl(0, "Type", { fg = "#fabd2f" })
		vim.api.nvim_set_hl(0, "StorageClass", { fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "Structure", { fg = "#83a598", bold = true })
		vim.api.nvim_set_hl(0, "Typedef", { fg = "#8ec07c", italic = true })
		-- Edge Cases
		vim.api.nvim_set_hl(0, "Special", { fg = "#d5508f", bold = true })
		vim.api.nvim_set_hl(0, "SpecialChar", { fg = "#ff4090", italic = true })
		vim.api.nvim_set_hl(0, "SpecialKey", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "Tag", { fg = "#2bff99", underline = true })
		vim.api.nvim_set_hl(0, "Delimiter", { fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "SpecialComment", { fg = "#928374", bold = true, nocombine = true })
		vim.api.nvim_set_hl(0, "Debug", { link = "WarningMsg" })

		-- TS treesitter
		vim.api.nvim_set_hl(0, "TSAnnotation", { fg = "#83a598" })
		-- html
		vim.api.nvim_set_hl(0, "TSAttribute", { fg = "#83a598", italic = true })

		vim.api.nvim_set_hl(0, "TSBoolean", { fg = "#C678DD", bold = true })
		vim.api.nvim_set_hl(0, "TSCharacter", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "TSComment", { fg = "#928374" })
		vim.api.nvim_set_hl(0, "TSConditional", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSConstBuiltin", { fg = "#98C379", bold = true })
		vim.api.nvim_set_hl(0, "TSException", { fg = "#fb4934", bold = true })
		vim.api.nvim_set_hl(0, "TSFunction", { fg = "#98C379", bold = true })
		vim.api.nvim_set_hl(0, "TSInclude", { fg = "#83a598", nocombine = true })
		vim.api.nvim_set_hl(0, "TSKeyword", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSKeywordReturn", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSKeywordFunction", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSKeywordOperator", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "TSMethod", { fg = "#98C379", bold = true })
		vim.api.nvim_set_hl(0, "TSNumber", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "TSOperator", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "TSParameter", { fg = "#bdae93", italic = true })
		vim.api.nvim_set_hl(0, "TSProperty", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "TSRepeat", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSString", { fg = "#98C379" })
		vim.api.nvim_set_hl(0, "TSType", { fg = "#98C379", bold = true })
		vim.api.nvim_set_hl(0, "TSTypeBuiltin", { fg = "#83a598", bold = true })
		vim.api.nvim_set_hl(0, "TSTypeQualifier", { fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "TSVariable", { fg = "#d5c4a1" })
		vim.api.nvim_set_hl(0, "TSVariableBuiltin", { fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "TSConstructor", { fg = "#83a598", bold = true })
		vim.api.nvim_set_hl(0, "TSPunctBracket", { bold = true })
		vim.api.nvim_set_hl(0, "TSFuncBuiltin", { fg = "#83a598", bold = true })

		-- Markdown
		vim.api.nvim_set_hl(0, "TSText", { fg = "#d5c4a1" })
		vim.api.nvim_set_hl(0, "@text.uri", { fg = "#83a598", underline = true })
		vim.api.nvim_set_hl(0, "@text.title", { fg = "#98c379", bold = true })
		vim.api.nvim_set_hl(0, "@text.todo", { link = "Todo" })
		vim.api.nvim_set_hl(0, "@text.reference", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "@text.literal", { fg = "#928374", italic = true })
		vim.api.nvim_set_hl(0, "@text.underline", { fg = "#83a598", underline = true })
		vim.api.nvim_set_hl(0, "@text.strong", { fg = "#83a598", bold = true })

		vim.cmd([[
            highlight! link @annotation TSAnnotation
            highlight! link @attribute TSAttribute
            highlight! link @boolean TSBoolean
            highlight! link @character TSCharacter
            highlight! link @comment TSComment
            highlight! link @conditional TSConditional
            highlight! link @constant TSConstant
            highlight! link @constant.builtin TSConstBuiltin
            highlight! link @constant.macro TSConstMacro
            highlight! link @constructor TSConstructor
            highlight! link @exception TSException
            highlight! link @field TSField
            highlight! link @float TSFloat
            highlight! link @function TSFunction
            highlight! link @function.builtin TSFuncBuiltin
            highlight! link @function.macro TSFuncMacro
            highlight! link @include TSInclude
            highlight! link @keyword TSKeyword
            highlight! link @keyword.return TSKeywordReturn
            highlight! link @keyword.function TSKeywordFunction
            highlight! link @keyword.operator TSKeywordOperator
            highlight! link @label TSLabel
            highlight! link @method TSMethod
            highlight! link @namespace TSNamespace
            highlight! link @none TSNone
            highlight! link @number TSNumber
            highlight! link @operator TSOperator
            highlight! link @parameter TSParameter
            highlight! link @parameter.reference TSParameterReference
            highlight! link @property TSProperty
            highlight! link @punctuation.bracket TSPunctBracket
            highlight! link @punctuation.delimiter TSPunctDelimiter
            highlight! link @punctuation.special TSPunctSpecial
            highlight! link @repeat TSRepeat
            highlight! link @storageclass TSStorageClass
            highlight! link @storageclass.lifetime TSStorageClassLifetime
            highlight! link @string TSString
            highlight! link @string.escape TSStringEscape
            highlight! link @string.regex TSStringRegex
            highlight! link @structure TSStructure
            highlight! link @symbol TSSymbol
            highlight! link @tag TSTag
            highlight! link @tag.attribute TSAttribute
            highlight! link @tag.delimiter TSTagDelimiter
            highlight! link @text TSText
            highlight! link @strike TSStrike
            highlight! link @math TSMath
            highlight! link @type TSType
            highlight! link @type.builtin TSTypeBuiltin
            highlight! link @type.qualifier TSTypeQualifier
            highlight! link @uri TSURI
            highlight! link @variable TSVariable
            highlight! link @variable.builtin TSVariableBuiltin
            highlight! link @variable.python pythonTSVariable
            highlight! link @decorator.python pythonTSDecorator
            highlight! link @variable.rust rustTSVariable
            highlight! link @conditional.javascript javascriptTSConditional
            highlight! link @variable.javascript javascriptTSVariable
        ]])
		-- syntax regex
		local syntax_regex = {
			js = {
				jsFuncBlock = "Function",
				jsObjectKey = "Type",
				jsReturn = "Keyword",
				jsVariableDef = "Identifier",
			},
			shell = {
				shDerefSimple = "SpecialChar",
				shFunctionKey = "Function",
				shLoop = "Repeat",
				shParen = "Delimiter",
				shQuote = "Delimiter",
				shSet = "Statement",
				shTestOpr = "Debug",
			},
			python = {
				pythonBrackets = "Delimiter",
				pythonBuiltinFunc = "Operator",
				pythonBuiltinObj = "Type",
				pythonBuiltinType = "Type",
				pythonClass = "Structure",
				pythonClassParameters = "pythonParameters",
				pythonDecorator = "PreProc",
				pythonDottedName = "Identifier",
				pythonError = "Error",
				pythonException = "Exception",
				pythonInclude = "Include",
				pythonIndentError = "pythonError",
				pythonLambdaExpr = "pythonOperator",
				pythonOperator = "Operator",
				pythonParam = "Identifier",
				pythonParameters = "Delimiter",
				pythonSelf = "Statement",
				pythonSpaceError = "pythonError",
				pythonStatement = "Statement",
			},
			go = {
				goBlock = "Delimiter",
				goBoolean = "Boolean",
				goBuiltins = "Operator",
				goField = "Identifier",
				goFloat = "Float",
				goFormatSpecifier = "Character",
				goFunction = "Function",
				goFunctionCall = "goFunction",
				goMethodCall = "goFunctionCall",
				goParamType = "goReceiverType",
				goPointerOperator = "SpecialChar",
				goPredefinedIdentifiers = "Constant",
				goReceiver = "goBlock",
				goReceiverType = "goTypeName",
				goSimpleParams = "goBlock",
				goType = "Type",
				goTypeConstructor = "goFunction",
				goTypeName = "Type",
				goVarAssign = "Identifier",
				goVarDefs = "goVarAssign",
			},
		}
		local syntax_list = {
			js = true,
			python = true,
			shell = true,
			go = true,
		}
		for lang, enable in pairs(syntax_list) do
			if enable then
				for hl_group, link_group in pairs(syntax_regex[lang]) do
					-- vim.cmd("highlight! link " .. hl_group .. " " .. link_group)
					vim.api.nvim_set_hl(0, hl_group, { link = link_group })
				end
			end
		end
	end,
	me = function()
		vim.cmd("highlight clear")
		vim.cmd("syntax clear")
		vim.cmd("syntax reset")
		vim.cmd("colorscheme deus")
		set_editor_hl()
		set_lsp_hl()
		set_gitsigns_hl()
		set_notify_hl()
		set_indenline_hl()
		set_nvimtree_hl()
		set_navic_hl()
		vim.cmd("highlight clear ColorColumn")
		-- dslight0 #d2d2d2 dslight1 #ebdbb2 dslight2 #d5c4a1 dslight3 #bdae93 dslight4 #a89984
		-- Syntax
		vim.api.nvim_set_hl(0, "Comment", { fg = "#928374", italic = true })
		-- Literals
		vim.api.nvim_set_hl(0, "Constant", { fg = "#f0af00" })
		vim.api.nvim_set_hl(0, "String", { fg = "#98C379" })
		vim.api.nvim_set_hl(0, "Character", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "Number", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "Boolean", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "Float", { fg = "#C678DD" })
		-- Identifiers
		vim.api.nvim_set_hl(0, "Identifier", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "Function", { fg = "#98C379", bold = true })
		-- Syntax
		vim.api.nvim_set_hl(0, "Statement", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "Conditional", { fg = "#fb4934", italic = true })
		vim.api.nvim_set_hl(0, "Repeat", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "Label", { fg = "#BD93BD", italic = true })
		vim.api.nvim_set_hl(0, "Operator", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "Keyword", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "Exception", { fg = "#fb4934", bold = true })
		vim.api.nvim_set_hl(0, "Noise", { fg = "#fe8019" })
		-- Metatextual Information
		vim.api.nvim_set_hl(0, "PreProc", { fg = "#f4c069" })
		vim.api.nvim_set_hl(0, "Include", { fg = "#83a598", nocombine = true })
		vim.api.nvim_set_hl(0, "Define", { fg = "#83a598", nocombine = true })
		vim.api.nvim_set_hl(0, "Macro", { fg = "#83a598", italic = true })
		vim.api.nvim_set_hl(0, "PreCondit", { fg = "#f4c069", italic = true })
		-- Semantics
		vim.api.nvim_set_hl(0, "Type", { fg = "#fabd2f" })
		vim.api.nvim_set_hl(0, "StorageClass", { fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "Structure", { fg = "#83a598", bold = true })
		vim.api.nvim_set_hl(0, "Typedef", { fg = "#8ec07c", italic = true })
		-- Edge Cases
		vim.api.nvim_set_hl(0, "Special", { fg = "#d5508f", bold = true })
		vim.api.nvim_set_hl(0, "SpecialChar", { fg = "#ff4090", italic = true })
		vim.api.nvim_set_hl(0, "SpecialKey", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "Tag", { fg = "#2bff99", underline = true })
		vim.api.nvim_set_hl(0, "Delimiter", { fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "SpecialComment", { fg = "#928374", bold = true, nocombine = true })
		vim.api.nvim_set_hl(0, "Debug", { link = "WarningMsg" })

		-- TS treesitter
		vim.api.nvim_set_hl(0, "TSAnnotation", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "TSAttribute", { fg = "#83a598", italic = true })
		vim.api.nvim_set_hl(0, "TSBoolean", { fg = "#C678DD", bold = true })
		vim.api.nvim_set_hl(0, "TSCharacter", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "TSComment", { fg = "#928374" })
		-- vim.api.nvim_set_hl(0, "TSConditional", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSConditional", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "TSConstBuiltin", { fg = "#98C379", bold = true })
		vim.api.nvim_set_hl(0, "TSException", { fg = "#fb4934", bold = true })
		vim.api.nvim_set_hl(0, "TSFunction", { fg = "#98C379", bold = true })
		vim.api.nvim_set_hl(0, "TSInclude", { fg = "#83a598", nocombine = true })
		-- vim.api.nvim_set_hl(0, "TSKeyword", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSKeyword", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "TSKeywordReturn", { fg = "#fb4934", bold = true })
		vim.api.nvim_set_hl(0, "TSKeywordFunction", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSKeywordOperator", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "TSMethod", { fg = "#98C379", bold = true })
		vim.api.nvim_set_hl(0, "TSNumber", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "TSOperator", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "TSParameter", { fg = "#bdae93", italic = true })
		vim.api.nvim_set_hl(0, "TSProperty", { fg = "#83a598" })
		-- vim.api.nvim_set_hl(0, "TSRepeat", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSRepeat", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "TSString", { fg = "#98C379" })
		vim.api.nvim_set_hl(0, "TSType", { fg = "#98C379", bold = true })
		vim.api.nvim_set_hl(0, "TSTypeBuiltin", { fg = "#83a598", bold = true })
		vim.api.nvim_set_hl(0, "TSTypeQualifier", { fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "TSVariable", { fg = "#d5c4a1" })
		vim.api.nvim_set_hl(0, "TSVariableBuiltin", { fg = "#d5c4a1" })
		vim.api.nvim_set_hl(0, "TSConstructor", { fg = "#83a598", bold = true })
		vim.api.nvim_set_hl(0, "TSPunctBracket", { bold = true })
		vim.api.nvim_set_hl(0, "TSFuncBuiltin", { fg = "#83a598", bold = true })

		vim.cmd([[
            highlight! link @annotation TSAnnotation
            highlight! link @attribute TSAttribute
            highlight! link @boolean TSBoolean
            highlight! link @character TSCharacter
            highlight! link @comment TSComment
            highlight! link @conditional TSConditional
            highlight! link @constant TSConstant
            highlight! link @constant.builtin TSConstBuiltin
            highlight! link @constant.macro TSConstMacro
            highlight! link @constructor TSConstructor
            highlight! link @exception TSException
            highlight! link @field TSField
            highlight! link @float TSFloat
            highlight! link @function TSFunction
            highlight! link @function.builtin TSFuncBuiltin
            highlight! link @function.macro TSFuncMacro
            highlight! link @include TSInclude
            highlight! link @keyword TSKeyword
            highlight! link @keyword.return TSKeywordReturn
            highlight! link @keyword.function TSKeywordFunction
            highlight! link @keyword.operator TSKeywordOperator
            highlight! link @label TSLabel
            highlight! link @method TSMethod
            highlight! link @namespace TSNamespace
            highlight! link @none TSNone
            highlight! link @number TSNumber
            highlight! link @operator TSOperator
            highlight! link @parameter TSParameter
            highlight! link @parameter.reference TSParameterReference
            highlight! link @property TSProperty
            highlight! link @punctuation.bracket TSPunctBracket
            highlight! link @punctuation.delimiter TSPunctDelimiter
            highlight! link @punctuation.special TSPunctSpecial
            highlight! link @repeat TSRepeat
            highlight! link @storageclass TSStorageClass
            highlight! link @storageclass.lifetime TSStorageClassLifetime
            highlight! link @string TSString
            highlight! link @string.escape TSStringEscape
            highlight! link @string.regex TSStringRegex
            highlight! link @structure TSStructure
            highlight! link @symbol TSSymbol
            highlight! link @tag TSTag
            highlight! link @tag.attribute TSAttribute
            highlight! link @tag.delimiter TSTagDelimiter
            highlight! link @text TSText
            highlight! link @strike TSStrike
            highlight! link @math TSMath
            highlight! link @type TSType
            highlight! link @type.builtin TSTypeBuiltin
            highlight! link @type.qualifier TSTypeQualifier
            highlight! link @uri TSURI
            highlight! link @variable TSVariable
            highlight! link @variable.builtin TSVariableBuiltin
            " highlight! link @variable.python pythonTSVariable
            highlight! link @decorator.python pythonTSDecorator
            highlight! link @variable.rust rustTSVariable
            highlight! link @conditional.javascript javascriptTSConditional
            highlight! link @variable.javascript javascriptTSVariable
        ]])
	end,
	nice = function()
		vim.cmd("highlight clear")
		vim.cmd("colorscheme deus")
		set_editor_hl()
		set_lsp_hl()
		set_gitsigns_hl()
		set_notify_hl()
		set_indenline_hl()
		set_nvimtree_hl()
		-- navic
		vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = "#B5E8B0", bold = true })
		vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, fg = "#B5E8B0", bold = true })
		vim.cmd("highlight clear ColorColumn")
		-- Syntax
		vim.api.nvim_set_hl(0, "Comment", { fg = "#928374", italic = true })
		-- Literals
		vim.api.nvim_set_hl(0, "Constant", { fg = "#f0af00" })
		vim.api.nvim_set_hl(0, "String", { fg = "#98C379" })
		vim.api.nvim_set_hl(0, "Character", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "Number", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "Boolean", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "Float", { fg = "#C678DD" })
		-- Identifiers
		vim.api.nvim_set_hl(0, "Identifier", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "Function", { fg = "#98C379", bold = true })
		-- Syntax
		vim.api.nvim_set_hl(0, "Statement", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "Conditional", { fg = "#fb4934", italic = true })
		vim.api.nvim_set_hl(0, "Repeat", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "Label", { fg = "#BD93BD", italic = true })
		vim.api.nvim_set_hl(0, "Operator", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "Keyword", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "Exception", { fg = "#fb4934", bold = true })
		vim.api.nvim_set_hl(0, "Noise", { fg = "#fe8019" })
		-- Metatextual Information
		vim.api.nvim_set_hl(0, "PreProc", { fg = "#f4c069" })
		vim.api.nvim_set_hl(0, "Include", { fg = "#83a598", nocombine = true })
		vim.api.nvim_set_hl(0, "Define", { fg = "#83a598", nocombine = true })
		vim.api.nvim_set_hl(0, "Macro", { fg = "#83a598", italic = true })
		vim.api.nvim_set_hl(0, "PreCondit", { fg = "#f4c069", italic = true })
		-- Semantics
		vim.api.nvim_set_hl(0, "Type", { fg = "#fabd2f" })
		vim.api.nvim_set_hl(0, "StorageClass", { fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "Structure", { fg = "#83a598", bold = true })
		vim.api.nvim_set_hl(0, "Typedef", { fg = "#8ec07c", italic = true })
		-- Edge Cases
		vim.api.nvim_set_hl(0, "Special", { fg = "#d5508f", bold = true })
		vim.api.nvim_set_hl(0, "SpecialChar", { fg = "#ff4090", italic = true })
		vim.api.nvim_set_hl(0, "SpecialKey", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "Tag", { fg = "#2bff99", underline = true })
		vim.api.nvim_set_hl(0, "Delimiter", { fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "SpecialComment", { fg = "#928374", bold = true, nocombine = true })
		vim.api.nvim_set_hl(0, "Debug", { link = "WarningMsg" })
		-- TS treesitter
		vim.api.nvim_set_hl(0, "TSAnnotation", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "TSAttribute", { fg = "#83a598", italic = true })
		vim.api.nvim_set_hl(0, "TSBoolean", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "TSCharacter", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "TSComment", { fg = "#928374" })
		vim.api.nvim_set_hl(0, "TSConditional", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSConstBuiltin", { fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "TSException", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSFunction", { fg = "#98C379", bold = true })
		vim.api.nvim_set_hl(0, "TSInclude", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSKeyword", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSKeywordReturn", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSKeywordFunction", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSKeywordOperator", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSMethod", { fg = "#98C379", bold = true })
		vim.api.nvim_set_hl(0, "TSNumber", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "TSOperator", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "TSParameter", { fg = "#bdae93", italic = true })
		vim.api.nvim_set_hl(0, "TSProperty", { fg = "#83a598" })
		vim.api.nvim_set_hl(0, "TSRepeat", { fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "TSString", { fg = "#98C379" })
		vim.api.nvim_set_hl(0, "TSType", { fg = "#fabd2f" })
		vim.api.nvim_set_hl(0, "TSTypeBuiltin", { fg = "#fabd2f" })
		vim.api.nvim_set_hl(0, "TSTypeQualifier", { fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "TSVariable", { fg = "#d5c4a1" })
		vim.api.nvim_set_hl(0, "TSVariableBuiltin", { fg = "#fe8019" })

		vim.cmd([[
            highlight! link @annotation TSAnnotation
            highlight! link @attribute TSAttribute
            highlight! link @boolean TSBoolean
            highlight! link @character TSCharacter
            highlight! link @comment TSComment
            highlight! link @conditional TSConditional
            highlight! link @constant TSConstant
            highlight! link @constant.builtin TSConstBuiltin
            highlight! link @constant.macro TSConstMacro
            highlight! link @constructor TSConstructor
            highlight! link @exception TSException
            highlight! link @field TSField
            highlight! link @float TSFloat
            highlight! link @function TSFunction
            highlight! link @function.builtin TSFuncBuiltin
            highlight! link @function.macro TSFuncMacro
            highlight! link @include TSInclude
            highlight! link @keyword TSKeyword
            highlight! link @keyword.return TSKeywordReturn
            highlight! link @keyword.function TSKeywordFunction
            highlight! link @keyword.operator TSKeywordOperator
            highlight! link @label TSLabel
            highlight! link @method TSMethod
            highlight! link @namespace TSNamespace
            highlight! link @none TSNone
            highlight! link @number TSNumber
            highlight! link @operator TSOperator
            highlight! link @parameter TSParameter
            highlight! link @parameter.reference TSParameterReference
            highlight! link @property TSProperty
            highlight! link @punctuation.bracket TSPunctBracket
            highlight! link @punctuation.delimiter TSPunctDelimiter
            highlight! link @punctuation.special TSPunctSpecial
            highlight! link @repeat TSRepeat
            highlight! link @storageclass TSStorageClass
            highlight! link @storageclass.lifetime TSStorageClassLifetime
            highlight! link @string TSString
            highlight! link @string.escape TSStringEscape
            highlight! link @string.regex TSStringRegex
            highlight! link @structure TSStructure
            highlight! link @symbol TSSymbol
            highlight! link @tag TSTag
            highlight! link @tag.attribute TSAttribute
            highlight! link @tag.delimiter TSTagDelimiter
            highlight! link @text TSText
            highlight! link @strike TSStrike
            highlight! link @math TSMath
            highlight! link @type TSType
            highlight! link @type.builtin TSTypeBuiltin
            highlight! link @type.qualifier TSTypeQualifier
            highlight! link @uri TSURI
            highlight! link @variable TSVariable
            highlight! link @variable.builtin TSVariableBuiltin
            highlight! link @variable.python pythonTSVariable
            highlight! link @decorator.python pythonTSDecorator
            highlight! link @variable.rust rustTSVariable
            highlight! link @conditional.javascript javascriptTSConditional
            highlight! link @variable.javascript javascriptTSVariable
        ]])
	end,
	repo = function()
		-- vim.cmd("highlight clear")
		-- if vim.fn.exists("syntax_on") then
		-- 	vim.cmd("syntax reset")
		-- end
		-- vim.cmd("colorscheme deus")
		-- vim.g.deus_termcolors = 256
		-- set_editor_hl()
		-- set_lsp_hl()
		-- set_gitsigns_hl()
		-- set_notify_hl()
		-- set_indenline_hl()
		-- set_nvimtree_hl()
		-- set_navic_hl()
		-- vim.cmd("highlight clear ColorColumn")

		-- if vim.fn.exists("syntax_on") then
		-- 	vim.cmd("syntax reset")
		-- end
		-- vim.cmd("colorscheme deus")
		-- set_editor_hl()
		-- set_lsp_hl()
		-- set_gitsigns_hl()
		-- set_notify_hl()
		-- set_indenline_hl()
		-- set_nvimtree_hl()
		-- set_navic_hl()
		-- vim.cmd("highlight clear ColorColumn")

		vim.cmd("highlight clear")
		vim.cmd("colorscheme deus")
		set_editor_hl()
		set_lsp_hl()
		set_gitsigns_hl()
		set_notify_hl()
		set_indenline_hl()
		set_nvimtree_hl()
		set_navic_hl()
		vim.cmd("highlight clear ColorColumn")

		return nil
	end,
}

caseList[mode]()

vim.api.nvim_create_user_command("DeusSyntaxColor", function(args)
	if caseList[args.fargs[1]] == nil then
		caseList["camellia"]()
		return
	else
		caseList[args.fargs[1]]()
		return
	end
end, {
	desc = "deus change syntax colorscheme",
	nargs = "?",
	---@diagnostic disable-next-line: unused-local
	complete = function(A, L, P)
		return {
			"camellia",
			"nice",
			"you",
			"fragrans",
			"sakura",
			"repo",
		}
	end,
})

-- local terminal_colors = {
-- 	terminal_color_0 = "#2C323B",
-- 	terminal_color_1 = "#a80000",
-- 	terminal_color_2 = "#50de60",
-- 	terminal_color_3 = "#fe8019",
-- 	terminal_color_4 = "#83a598",
-- 	terminal_color_5 = "#bb0099",
-- 	terminal_color_6 = "#00d0c0",
-- 	terminal_color_7 = "#928374",
-- 	terminal_color_8 = "#3c3836",
-- 	terminal_color_9 = "#fb4934",
-- 	terminal_color_10 = "#98C379",
-- 	terminal_color_11 = "#fabd2f",
-- 	terminal_color_12 = "#2bff99",
-- 	terminal_color_13 = "#C678DD",
-- 	terminal_color_14 = "#8ec07c",
-- 	terminal_color_15 = "#c0c0c0",
-- }

local terminal_colors = {
	terminal_color_0 = "#2C323B",
	terminal_color_1 = "#a80000",
	terminal_color_2 = "#50de60",
	terminal_color_3 = "#fe8019",
	terminal_color_4 = "#83a598",
	terminal_color_5 = "#bb0099",
	terminal_color_6 = "#00d0c0",
	terminal_color_7 = "#928374",
	terminal_color_8 = "#928374",
	-- terminal_color_8 = "#3c3836",
	terminal_color_9 = "#fb4934",
	terminal_color_10 = "#98C379",
	terminal_color_11 = "#fabd2f",
	terminal_color_12 = "#2bff99",
	terminal_color_13 = "#C678DD",
	terminal_color_14 = "#8ec07c",
	terminal_color_15 = "#c0c0c0",
}

-- local terminal_colors = {
-- 	terminal_color_0 = "#000000",
-- 	terminal_color_1 = "#FF5555",
-- 	terminal_color_2 = "#50FA7B",
-- 	terminal_color_3 = "#F1FA8C",
-- 	terminal_color_4 = "#BD93F9",
-- 	terminal_color_5 = "#FF79C6",
-- 	terminal_color_6 = "#8BE9FD",
-- 	terminal_color_7 = "#BFBFBF",
-- 	terminal_color_8 = "#4D4D4D",
-- 	terminal_color_9 = "#FF6E67",
-- 	terminal_color_10 = "#5AF78E",
-- 	terminal_color_11 = "#F4F99D",
-- 	terminal_color_12 = "#CAA9FA",
-- 	terminal_color_13 = "#FF92D0",
-- 	terminal_color_14 = "#9AEDFE",
-- }

for k, v in pairs(terminal_colors) do
	vim.g[k] = v
end
