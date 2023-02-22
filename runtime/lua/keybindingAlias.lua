local M = {
	config_path = vim.fn.stdpath("config"),
	-- Modes
	--   normal_mode = "n",
	--   insert_mode = "i",
	--   visual_mode = "v",
	--   visual_block_mode = "x",
	--   term_mode = "t",
	--   command_mode = "c",
	--   select_mode = "s"

	-- 前导键 空格 <space>
	leader_key = " ",
	-- normal模式下键盘映射
	norl = {

		goto_command_mode = "<F1>",
		undo = "<space>u",
		paste = "<space>p",

		go_left35 = "H",
		go_right35 = "L",

		-- -- 粘贴模式可以防止从网页复制内容到vim而出现奇怪的缩进问题
		-- 因为vim的缩减处理和一般文本编辑器不一样
		goto_paste_mode = "sp",
		exit_paste_mode = "sP",
		-- cursor move in normal mode
		go_up_10line = "<C-u>",
		go_down_10line = "<C-d>",
		go_up_5line = "<C-k>",
		go_down_5line = "<C-j>",
		-- save exit and exit all  buffer behavior
		quit_buffer = "qq",
		quit_window = "<Leader>q",
		save_buffer = "<Leader>w",
		saveALL_and_exitALL = "<Leader>WQ",
		quit_without_save = "<Leader>Q",
		-- window split
		horizontal_split = "sh",
		vertical_split = "sv",
		-- window motion
		window_left = "s<left>",
		window_down = "s<down>",
		window_up = "s<up>",
		window_right = "s<right>",
		goto_window_sequence = "sw",
		-- adjust window size
		move_2up = "sk",
		move_2down = "sj",
		move_2left = "s,",
		move_2right = "s.",
		move_resize = "s=",
		-- terminal split
		term_horizontal_split = "st",
		term_vertical_split = "stv",
	},
	-- insert 模式下键盘映射
	insert = {
		goto_command_mode = "<F1>",
	},
	-- visual 模式下键盘映射
	visul = {
		-- goto command mode from visual mode
		goto_command_mode = "<F1>",
		-- cursor move in visual mode
		go_up_5line = "<C-k>",
		go_down_5line = "<C-j>",
		cp_to_sysClipboard = "Y",
	},
	-- command 模式下键盘映射
	cmand = {
		-- 命令补全下拉菜单中 上下选择
		select_next = "<C-j>",
		select_pre = "<C-k>",
	},
	------------------------------------------
	--插件键位映射
	nvimTree = {
		NvimTreeToggle = "<space>1",
	},
	undotree = {
		UndotreeToggle = "<space>2",
	},
	lsp = {
		--treesitter rename
		tsRename = "<leader>ra",
		rename = "<leader>rn",
		code_action = "<leader>ca",
		definition = "gd",
		hover = "gh",
		references = "gr",
		signature_help = "<leader>gh",
		type_definitions = "<leader>gl",
		implementations = "<leader>gi",
		declaration = "gD",
		-- diagnostic
		open_flow = "gl",
		goto_next = "g<left>",
		goto_prev = "g<right>",
		format = "<leader>f",
		-- TODO:
		-- lsp_signature
		-- outline
		outline = "<space>3",
	},
	bufferline = {
		BufferLineCyclePrev = "<Leader>j",
		BufferLineCycleNext = "<Leader>k",
		BufferLineMovePrev = "<Leader>h",
		BufferLineMoveNext = "<Leader>l",
	},
	telescope = {
		fuzzy_find = "<C-f>",
		fuzzy_find_insertmode = "<C-f>",
		find_files = "<space>4",
		buffer_select = "<space>5",
		session_load = "<space>s",
	},
	dap = {
		debugg = "<F5>",
		debugg_step_over = "<F6>",
		debugg_end = "<Leader>de",
		clear_breakpoints = "<Leader>dc",
		toggle_breakpoint = "<Leader>dt",
		-- dapUI
		eval_expression = "<Leader>dh",
		eval_expression_visual = "<Leader>dh",
	},
	cmp = {
		cmp_next = "<Tab>",
		cmp_pre = "<S-Tab>",
		cmp_confirm = "<CR>",
		cmp_scroll_doc_up = "<C-u>",
		cmp_scroll_doc_down = "<C-d>",
		cmp_select_prev_item = "<C-k>",
		cmp_select_next_item = "<C-j>",
		cmp_trigge = "<M-h>",
		-- PERF:
		cmp_abort = "<M-k>",
		-- luasnip
		luasnip_node_next = "<C-j>",
		luasnip_node_prev = "<C-k>",
	},
	toggerterm = {
		toggleA = "<leader>ta",
		toggleB = "<leader>tb",
		toggleC = "<leader>tc",
		toggleD = "<leader>td",
		toggleG = "<Leader>tg",
	},
	gitsigns = {
		gs_next_hunk = "<space>gj",
		gs_pre_hunk = "<space>gk",
		stage_hunk = "<leader>gs",
		reset_hunk = "<leader>gr",
		stage_buffer = "<leader>gS",
		undo_stage_hunk = "<leader>gu",
		reset_buffer = "<leader>gR",
		preview_hunk = "<leader>gp",
		blame_line = "<leader>gb",
		diffthis = "<leader>gd",
		diffthiss = "<leader>gD",
		toggle_current_line_blame = "<leader>gtb",
		toggle_deleted = "<leader>gtd",
		select_hunk = "ig",
	},
	mkdnflow = {
		enable = true,
		mkdnNextLink = "<leader>mln",
		mkdnPrevLink = "<leader>mlp",
		mkdnDestroyLink = "<Leader>md",
		mkdnTagSpan = "<Leader>md",
		mkdnMoveSource = "<Leader>mm",
		mkdnYankAnchorLink = "<leader>ma",
		mkdnYankFileAnchorLink = "<leader>mfa",
		mkdnToggleToDo = "<Leader>mt",
		mkdnUpdateNumbering = "<Leader>mn",
		mkdnTableNextRow = "<M-.>",
		mkdnTablePrevRow = "<M-,>",
		mkdnFoldSection = "<Leader>mz",
		mkdnUnfoldSection = "<leader>mZ",
		mkdnTableNextCell = "<M-n>",
		mkdnTablePrevCell = "<M-m>",
		mkdnTableNewRowBelow = "<Leader>mr",
		mkdnTableNewRowAbove = "<Leader>mR",
		mkdnTableNewColAfter = "<Leader>mc",
		mkdnTableNewColBefore = "<Leader>mC",
		mkdnCreateLinkFromClipboard = "<Leader>mp",
	},
	yanky = {

		yanky_after = "<leader>p",
		yanky_before = "P",
		-- PERF:
		iopen_yank_history = "<F3>",
		nopen_yank_history = "<F3>",
		--
	},
	hop = {
		-- PERF:
		-- <F7>,<F8>,<F9> <C-x> <space>gv
		nhop_pattern = ";<space>",
		nhop_word = "<space>gg",
		nhop_line = ";;",
		-- ihop_pattern = "<F8>",
		-- ihop_line = "<F7>",
		-- ihop_word = "<C-x>",
	},
	translate = {
		translate_float = ";g",
		translate_split = ";t",
	},
	comment = {
		iline_comment = [[<C-_>]],
		vline_comment = [[<C-_>]],
		nline_comment = [[<C-_>]],
	},
	copilot = {
		copilotAccept = "<M-j>",
	},
	switch = {
		vmagicSearch = "on",
		nmagicSearch = "on",
	},
}

return M
