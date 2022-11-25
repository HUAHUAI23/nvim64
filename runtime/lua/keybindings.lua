-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local keybindingAlias = require("keybindingAlias")

local map = vim.api.nvim_set_keymap
-- silent = true 结果不会在command栏显示 为false会在command栏显示
local opt = { noremap = true, silent = true }

-- leader key ";"
vim.g.mapleader = keybindingAlias.norl.leader_key
vim.g.maplocalleader = keybindingAlias.norl.leader_key

-- 取消insert模式下 f1键的默认功能
map("i", "<F1>", "", opt)

-- insert模式下键盘映射
local inser = keybindingAlias.insert
map("i", inser.goto_command_mode, "<Esc>:", { noremap = true, silent = false })
map("i", inser.goto_normal_mode, "<Esc>", { noremap = true, silent = false })

--- normal模式下键盘映射

-- 取消normal模式下 s 默认功能 s在normal模式下为进入插入模式
map("n", "s", "", opt)
-- 取消normal模式下 H L键默认功能
map("n", "H", "", opt)
map("n", "L", "", opt)
-- 取消normal模式下 f1键的默认功能
map("n", "<F1>", "", opt)
-- 取消normal模式下 qq键的默认功能(连续点击两下q键)
map("n", "qq", "", opt)

-- magic search
map("n", "/", "/\\v", { noremap = true, silent = false })

local norl = keybindingAlias.norl
map("n", norl.goto_command_mode, ":", { noremap = true, silent = false })

map("n", norl.go_left35, "35h", opt)
map("n", norl.go_right35, "35l", opt)

-- 设置快捷键 sp 进入粘贴模式，shift p退出粘贴模式
-- 粘贴模式可以防止从网页复制内容到vim而出现奇怪的缩进问题
-- 因为vim的缩减处理和一般文本编辑器不一样
-- "<cr>是enter键

map("n", norl.goto_paste_mode, ":set paste<CR>", opt)
map("n", norl.exit_paste_mode, ":set nopaste<CR>", opt)

-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", norl.go_up_10line, "10k", opt)
map("n", norl.go_down_10line, "10j", opt)

-- 上下滚动浏览
map("n", norl.go_down_5line, "5j", opt)
map("n", norl.go_up_5line, "5k", opt)

-- 定义快捷键关闭当前buffer
map("n", norl.quit_buffer, ":bd<CR>", opt)
-- 定义快捷键关闭当前分割窗口
map("n", norl.quit_window, ":q<CR>", opt)
-- 定义快捷键保存当前窗口内容
map("n", norl.save_window, ":w<CR>", opt)
-- 定义快捷键保存所有窗口内容并退出 vim
map("n", norl.saveALL_and_exitALL, ":wa<CR>:q<CR>", opt)
-- 不做任何保存，直接退出 vim
map("n", norl.quit_without_save, ":qa!<CR>", opt)

-- 垂直分割窗口，水平分割窗口
map("n", norl.horizontal_split, ":sp<CR>", opt)
map("n", norl.vertical_split, ":vsp<CR>", opt)

-- s + 方向键 窗口之间跳转
map("n", norl.window_left, "<C-w>h", opt)
map("n", norl.window_down, "<C-w>j", opt)
map("n", norl.window_up, "<C-w>k", opt)
map("n", norl.window_right, "<C-w>l", opt)
-- 依次遍历子窗口
map("n", norl.goto_window_sequence, "<C-W><C-W>", opt)
-- 上下比例
map("n", norl.move_2up, ":res +2<CR>", opt)
map("n", norl.move_2down, ":res -2<CR>", opt)
-- 左右比例
map("n", norl.move_2left, ":vertical resize+2<CR>", opt)
map("n", norl.move_2right, ":vertical resize-2<CR>", opt)
-- 相等比例
map("n", norl.move_resize, "<C-w>=", opt)

--- visual模式下键盘映射
-- magic search
local visul = keybindingAlias.visul
map("v", "/", "/\\v", { noremap = true, silent = false })
-- 上下滚动浏览
map("v", visul.go_down_5line, "5j", opt)
map("v", visul.go_up_5line, "5k", opt)

--- command模式下键盘映射
local cmand = keybindingAlias.cmand
map("c", cmand.select_next, "<C-n>", { noremap = false })
map("c", cmand.select_pre, "<C-p>", { noremap = false })

-- terminal模式下键盘映射
local term = keybindingAlias.term
map("n", term.horizontal_split, ":sp | terminal<CR>", opt)
map("n", term.vertical_split, ":vsp | terminal<CR>", opt)
-- Esc 回 Normal 模式
map("t", term.term_to_normal, "<C-\\><C-n>", opt)
map("t", term.window_left, [[ <C-\><C-N><C-w>h ]], opt)
map("t", term.window_down, [[ <C-\><C-N><C-w>j ]], opt)
map("t", term.window_up, [[ <C-\><C-N><C-w>k ]], opt)
map("t", term.window_right, [[ <C-\><C-N><C-w>l ]], opt)

--------------------------------------------------------------------
local pluginKeys = {}

-- 插件快捷键
-- nvim-tree
local nvimTree = keybindingAlias.nvimTree
map("n", nvimTree.NvimTreeToggle, ":NvimTreeToggle<CR>", opt)

--  bufferline.nvim
local bufferline = keybindingAlias.bufferline
map("n", bufferline.BufferLineCyclePrev, ":BufferLineCyclePrev<CR>", opt)
map("n", bufferline.BufferLineCycleNext, ":BufferLineCycleNext<CR>", opt)
map("n", bufferline.BufferLineMovePrev, ":BufferLineMovePrev<CR>", opt)
map("n", bufferline.BufferLineMoveNext, ":BufferLineMoveNext<CR>", opt)

-- comment
pluginKeys.comment = {
	-- Normal 模式快捷键
	toggler = {
		line = "gcc", -- 行注释
		block = "gbc", -- 块注释
	},
	-- Visual 模式
	opleader = {
		line = "gc",
		bock = "gb",
	},
}
-- ctrl + /
map("n", "<C-_>", "gccA<Space>", { noremap = false })
map("v", "<C-_>", "gc", { noremap = false })
map("i", "<C-_>", "<Esc>gccA<Space>", { noremap = false })

--- telescope
local telesp = keybindingAlias.telescope
--  取消ctrl-f 默认功能
map("n", "<C-f>", "", opt)
map(
	"n",
	telesp.find_files,
	"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({initial_mode = 'insert'})<CR>",
	opt
)
map(
	"i",
	telesp.find_files_insertmode,
	"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({initial_mode = 'insert'})<CR>",
	opt
)

-- LSP
local lsp = keybindingAlias.lsp
pluginKeys.mapLSP = function(mapbuf)
	mapbuf("n", lsp.definition, function()
		require("telescope.builtin").lsp_definitions(
			require("telescope.themes").get_cursor({ initial_mode = "normal" })
		)
	end)
	mapbuf("n", lsp.references, function()
		require("telescope.builtin").lsp_references(require("telescope.themes").get_cursor({ initial_mode = "normal" }))
	end)
	mapbuf("n", lsp.hover, "<cmd>lua vim.lsp.buf.hover()<CR>")
	mapbuf("n", lsp.open_flow, "<cmd>lua vim.diagnostic.open_float()<CR>")
	mapbuf("n", lsp.goto_next, "<cmd>lua vim.diagnostic.goto_next()<CR>")
	mapbuf("n", lsp.goto_prev, "<cmd>lua vim.diagnostic.goto_prev()<CR>")
	mapbuf("n", lsp.rename, "<cmd>lua vim.lsp.buf.rename()<CR>")
	mapbuf("n", lsp.code_action, "<cmd>lua vim.lsp.buf.code_action()<CR>")
	mapbuf("n", lsp.format, "<cmd>lua vim.lsp.buf.format()<CR>")
end

-- nvim-dap
local dapp = keybindingAlias.dap
pluginKeys.mapDAP = function()
	-- 结束
	map(
		"n",
		dapp.debugg_end,
		":lua require'dap'.close()<CR>"
			.. ":lua require'dap'.terminate()<CR>"
			.. ":lua require'dap.repl'.close()<CR>"
			.. ":lua require'dapui'.close()<CR>"
			.. ":lua require('dap').clear_breakpoints()<CR>"
			.. "<C-w>o<CR>",
		opt
	)
	-- 继续
	map("n", dapp.debugg, ":lua require'dap'.continue()<CR>", opt)
	-- 设置断点
	map("n", dapp.toggle_breakpoint, ":lua require('dap').toggle_breakpoint()<CR>", opt)
	map("n", dapp.clear_breakpoints, ":lua require('dap').clear_breakpoints()<CR>", opt)
	--  stepOver, stepOut, stepInto
	map("n", dapp.debugg_step_over, ":lua require'dap'.step_over()<CR>", opt)
	-- map("n", "<F10>", ":lua require'dap'.step_over()<CR>", opt)
	-- map("n", "<F11>", ":lua require'dap'.step_into()<CR>", opt)
	-- map("n", "<F12> ", ":lua require'dap'.step_out()<CR>", opt)

	-- 弹窗
	-- require("dapui").eval(<expression>)
	map("n", dapp.eval_expression, ":lua require'dapui'.eval()<CR>", opt)
	map("v", dapp.eval_expression_visual, ":lua require('dapui').eval()<CR>", opt)
end

--  cmp

pluginKeys.cmp = function(luasnip, cmp)
	local cmpp = keybindingAlias.cmp

	-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end
	local mapping = {
		[cmpp.cmp_next] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		[cmpp.cmp_pre] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		[cmpp.cmp_scroll_doc_down] = cmp.mapping.scroll_docs(-4),
		[cmpp.cmp_scroll_doc_up] = cmp.mapping.scroll_docs(4),
		[cmpp.cmp_select_next_item] = cmp.mapping(
			cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior }),
			{ "i", "c" }
		),
		[cmpp.cmp_select_prev_item] = cmp.mapping(
			cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior }),
			{ "i", "c" }
		),
		[cmpp.cmp_trigge] = cmp.mapping.complete(),
		[cmpp.cmp_abort] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
		[cmpp.cmp_confirm] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() then
					cmp.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Replace,
					})
				else
					fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
				end
			end,
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({
						select = false,
						behavior = cmp.ConfirmBehavior.Replace,
					})
				else
					fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
				end
			end,
		}),
	}
	return mapping
end

-- toggleterm
-- <leader>ta 浮动
-- <leader>tb 右侧
-- <leader>tc 下方
local toggletermm = keybindingAlias.toggerterm
pluginKeys.mapToggleTerm = function(toggleterm)
	vim.keymap.set({ "n", "t" }, toggletermm.toggleA, toggleterm.toggleA)
	vim.keymap.set({ "n", "t" }, toggletermm.toggleB, toggleterm.toggleB)
	vim.keymap.set({ "n", "t" }, toggletermm.toggleC, toggleterm.toggleC)
	vim.keymap.set({ "n", "t" }, toggletermm.toggleG, toggleterm.toggleG)
end

-- gitsigns
pluginKeys.gitsigns_on_attach = function(bufnr)
	local gitsignss = require("keybindingAlias").gitsigns
	local gs = package.loaded.gitsigns

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	map("n", gitsignss.gs_next_hunk, function()
		if vim.wo.diff then
			return "<leader>gj"
		end
		vim.schedule(function()
			gs.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	map("n", gitsignss.gs_pre_hunk, function()
		if vim.wo.diff then
			return "<leader>gk"
		end
		vim.schedule(function()
			gs.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	-- Actions
	map({ "n", "v" }, gitsignss.stage_hunk, ":Gitsigns stage_hunk<CR>")
	map({ "n", "v" }, gitsignss.reset_hunk, ":Gitsigns reset_hunk<CR>")
	map("n", gitsignss.stage_buffer, gs.stage_buffer)
	map("n", gitsignss.undo_stage_hunk, gs.undo_stage_hunk)
	map("n", gitsignss.reset_buffer, gs.reset_buffer)
	map("n", gitsignss.preview_hunk, gs.preview_hunk)
	map("n", gitsignss.blame_line, function()
		gs.blame_line({ full = true })
	end)
	map("n", gitsignss.diffthis, gs.diffthis)
	map("n", gitsignss.diffthiss, function()
		gs.diffthis("~")
	end)
	-- toggle
	map("n", gitsignss.toggle_current_line_blame, gs.toggle_current_line_blame)
	map("n", gitsignss.toggle_deleted, gs.toggle_deleted)

	-- Text object
	map({ "o", "x" }, gitsignss.select_hunk, ":<C-U>Gitsigns select_hunk<CR>")
end

-- yanky
local yankyy = require("keybindingAlias").yanky
vim.keymap.set({ "n", "x" }, yankyy.yanky_after, "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, yankyy.yanky_before, "<Plug>(YankyPutBefore)")

return pluginKeys
