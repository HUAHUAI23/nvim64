local commConf = require("commConf")
local loop, api = vim.loop, vim.api
-- clear=true 如果创建的autocommand组已经存在，则将已经存在的autocommand组删除
-- see more: https://github.com/glepnir/nvim-lua-guide-zh
local myAutoGroupt = api.nvim_create_augroup("myAutoGroupt", {
	clear = true,
})
-- local mylspAutoGroup = api.nvim_create_augroup("mylspAutoGroup", {
-- 	clear = true,
-- })

-- 创建autocommand
local autocmd = api.nvim_create_autocmd

-- 进入Terminal 自动进入插入模式
autocmd({ "TermOpen" }, {
	group = myAutoGroupt,
	command = "startinsert | set nonumber",
	-- command = "startinsert",
})

-- 自动保存
-- autocmd({ "InsertLeave", "TextChanged" }, {
-- 	group = myAutoGroup,
-- 	pattern = { "*" },
-- 	command = "silent! wall",
-- })

-- 保存时自动格式化 null-ls config this
-- autocmd("BufWritePre", {
-- 	group = myAutoGroup,
-- 	pattern = { "*.lua", "*.py", "*.sh" },
-- 	callback = vim.lsp.buf.format,
-- })

-- Highlight on yank   yanky config this
-- autocmd("TextYankPost", {
-- 	callback = function()
-- 		vim.highlight.on_yank()
-- 	end,
-- 	group = myAutoGroup,
-- 	pattern = "*",
-- })

-- 用o换行不要延续注释
autocmd("BufEnter", {
	group = myAutoGroupt,
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions
			- "o" -- O and o, don't continue comments
			+ "r" -- But do continue when pressing enter.
	end,
})
-- 当在wsl环境下，剪切内容到系统寄存器时会将内容同步复制到win的剪切板中
-- v:event.regname ==# '+' 参考: https://yianwillis.github.io/vimcdoc/doc/change.html#registers
-- ==# vim 运算符  参考: https://stackoverflow.com/questions/45842690/what-does-the-hash-sign-mean-after-two-equal-signs-in-vim
-- v:<name>是vim中预定义的变量，参考 :h v:var
-- :h v:event
if vim.fn.has("wsl") then
	vim.cmd([[
    augroup wslYank
    autocmd!
    autocmd TextYankPost * if v:event.regname ==# '+' | call system('/mnt/c/windows/system32/clip.exe ',@") | endif
    augroup END
    ]])
end

-- NOTE: after file is loaded,determine whether to load indentline and autopair
autocmd("BufReadPost", {
	group = myAutoGroupt,
	pattern = "*",
	callback = function()
		local max_filesize = commConf.largefileEdge -- 100 KB
		local ok, stats = pcall(loop.fs_stat, api.nvim_buf_get_name(api.nvim_get_current_buf()))
		if ok and stats and stats.size < max_filesize then
			-- require("plugin-config.todo-comments")
			require("indent_blankline.commands").enable()
			require("nvim-autopairs").enable()
			require("illuminate.engine").toggle()
			-- vim.cmd("setlocal spell spelllang=en_us")
		end
	end,
})
-- NOTE: disable indentline,autopair,illuminate before loading file, this time the buffer is loaded but file is still not loaded
autocmd("BufReadPre", {
	group = myAutoGroupt,
	pattern = "*",
	callback = function()
		-- vim.api.nvim_cmd(vim.api.nvim_parse_cmd("IndentBlanklineDisable", {}), {})
		require("indent_blankline.commands").disable()
		require("nvim-autopairs").disable()
		require("illuminate.engine").toggle()
		-- vim.cmd("setlocal nospell")
	end,
})
