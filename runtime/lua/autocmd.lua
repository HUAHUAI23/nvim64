local commConf = require("commConf")
local loop, api = vim.loop, vim.api
-- clear=true 如果创建的autocommand组已经存在，则将已经存在的autocommand组删除
-- see more: https://github.com/glepnir/nvim-lua-guide-zh
local myAutoGroup = api.nvim_create_augroup("myAutoGroup", {
	clear = true,
})
-- local mylspAutoGroup = api.nvim_create_augroup("mylspAutoGroup", {
-- 	clear = true,
-- })

-- 创建autocommand
local autocmd = api.nvim_create_autocmd

-- nvim-tree  quit nvim when there is only one window and the filetype of window's buffer is nvim-tree
-- autocmd("BufEnter", {
-- 	nested = true,
-- 	group = myAutoGroup,
-- 	callback = function()
-- 		if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
-- 			vim.cmd("quit")
-- 		end
-- 	end,
-- })

-- 进入Terminal 自动进入插入模式
autocmd("TermOpen", {
	group = myAutoGroup,
	command = "startinsert",
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
	group = myAutoGroup,
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
--  debug eg: "1yy "+yy will output 1 and +, 1 and + is  the name of register
-- if vim.fn.has("wsl") then
-- 	vim.cmd([[
--     augroup wslYank
--     autocmd!
--     autocmd TextYankPost * :echo v:event.regname
--     augroup END
--     ]])
-- end

-- markdown文件，当行字数达到78时，自动换行
-- autocmd("CursorMovedI", {
-- 	group = myAutoGroup,
-- 	pattern = { "*.md" },
-- 	callback = function()
-- 		-- :h nr2char() :h string :h getchar()
-- 		-- https://neovim.io/doc/user/eval.html#String
-- 		-- https://neovim.io/doc/user/builtin.html  *getchar()*
-- 		-- if vim.fn.getchar() ~= "\x80kb" and vim.fn.virtcol(".") == 77 then
-- 		if
-- 			vim.fn.virtcol(".") == 77
-- 			or vim.fn.virtcol(".") == 78
-- 			or vim.fn.virtcol(".") == 79
-- 			or vim.fn.virtcol(".") == 80
-- 			or vim.fn.virtcol(".") == 81
-- 		then
-- 			-- see more:https://www.reddit.com/r/neovim/comments/psux8f/how_to_use_a_lua_function_to_insert_text/
-- 			local pos = vim.api.nvim_win_get_cursor(0)
-- 			local line = vim.api.nvim_get_current_line()
-- 			-- sub substring
-- 			local nline = line:sub(0, pos[2] + 1) .. "  "
-- 			vim.api.nvim_set_current_line(nline)
-- 			vim.api.nvim_buf_set_lines(0, pos[1], pos[1], false, { "" })
-- 			vim.api.nvim_win_set_cursor(0, { pos[1] + 1, 1 })
-- 		end
-- 	end,
-- })
-- NOTE: after file loaded,determine whether to load indentline
autocmd("BufReadPost", {
	group = myAutoGroup,
	pattern = "*",
	callback = function()
		local max_filesize = commConf.largefileEdge -- 100 KB
		local ok, stats = pcall(loop.fs_stat, api.nvim_buf_get_name(api.nvim_get_current_buf()))
		if ok and stats and stats.size < max_filesize then
			-- require("plugin-config.todo-comments")
			require("indent_blankline.commands").enable()
			require("nvim-autopairs").enable()
		end
	end,
})
-- NOTE: disable indentline before loading file, this time the buffer is loaded but file is still not loaded
autocmd("BufReadPre", {
	group = myAutoGroup,
	pattern = "*",
	callback = function()
		-- vim.api.nvim_cmd(vim.api.nvim_parse_cmd("IndentBlanklineDisable", {}), {})
		require("indent_blankline.commands").disable()
		require("nvim-autopairs").disable()
	end,
})

-- auto close LSP for large file
-- autocmd("BufReadPost", {
-- 	group = mylspAutoGroup,
-- 	pattern = "*",
-- 	callback = function()
-- 		if api.nvim_buf_line_count(0) > commConf.lspLargefileEdge then
-- 			-- https://neovim.io/doc/user/lua.html#vim.defer_fn()
-- 			vim.defer_fn(function()
-- 				vim.lsp.stop_client(lsp.get_active_clients())
-- 			end, 1000)
-- 		end
-- 	end,
-- })
