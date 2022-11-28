local api = vim.api
-- command open dapui float
-- refer: https://github.com/rcarriga/nvim-dap-ui
api.nvim_create_user_command("DapFloatWin", function()
	---@diagnostic disable-next-line: missing-parameter
	require("dapui").float_element()
end, { desc = "load dapui float" })

-- command close dap
-- refer: https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt
api.nvim_create_user_command("DapCloseWin", function()
	local ok, dap = pcall(require, "dap")
	if not ok then
		vim.notify("没有找到 dap")
		return
	end
	require("dapui").close({})
	dap.close()
	dap.terminate()
	local repl = dap.repl
	repl.close()
	-- api.nvim_command([[exe "normal \<c-w>o"]])
	-- vim.api.nvim_command([[exe "normal \<Esc>0"]])
	--  refer:https://vi.stackexchange.com/questions/27796/how-to-change-editor-mode-from-lua-or-viml
	vim.cmd("stopinsert")
	-- dap.clear_breakpoints()
end, { desc = "close dap session" })

-- TODO: add some description
--
-- local function setUndotreeWinSize()
-- 	local winList = api.nvim_list_wins()
-- 	for _, winHandle in ipairs(winList) do
-- 		if
-- 			api.nvim_win_is_valid(winHandle)
-- 			and api.nvim_buf_get_option(api.nvim_win_get_buf(winHandle), "filetype") == "undotree"
-- 		then
-- 			api.nvim_win_set_width(winHandle, vim.g.undotree_SplitWidth)
-- 		end
-- 	end
-- end
--
-- api.nvim_create_user_command("Ut", function()
-- 	api.nvim_cmd(api.nvim_parse_cmd("UndotreeToggle", {}), {})
-- 	setUndotreeWinSize()
-- end, { desc = "load undotree" })

-- TODO: add some description
--
local ftAndCmandLeft = {
	undotree = "UndotreeToggle",
	NvimTree = "NvimTreeToggle",
}
local function leftSidebarAutoClose(ftAcmdLeft, currentSelfLeft)
	local winList = vim.api.nvim_list_wins()
	for _, winHandle in ipairs(winList) do
		for k, v in pairs(ftAcmdLeft) do
			if
				vim.api.nvim_win_is_valid(winHandle)
				and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winHandle), "filetype") == k
				and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winHandle), "filetype") ~= currentSelfLeft
			then
				vim.api.nvim_cmd(api.nvim_parse_cmd(v, {}), {})
			end
		end
	end
end

api.nvim_create_user_command("Ut", function()
	leftSidebarAutoClose(ftAndCmandLeft, "undotree")
	vim.api.nvim_cmd(api.nvim_parse_cmd("UndotreeToggle", {}), {})
end, { desc = "undotree enhanced" })
api.nvim_create_user_command("NvimTrr", function()
	leftSidebarAutoClose(ftAndCmandLeft, "NvimTree")
	vim.api.nvim_cmd(api.nvim_parse_cmd("NvimTreeToggle", {}), {})
end, { desc = "NvimTree enhanced" })

local ftAndCmandRight = {
	dapui_scopes = "DapCloseWin",
	lspsagaoutline = "LSoutlineToggle",
}
local function rightSidebarAutoClose(ftAcmdRight, currentSelfRight)
	local winList = vim.api.nvim_list_wins()
	for _, winHandle in ipairs(winList) do
		for k, v in pairs(ftAcmdRight) do
			-- print(vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winHandle), "filetype"))
			if
				vim.api.nvim_win_is_valid(winHandle)
				and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winHandle), "filetype") == k
				and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winHandle), "filetype") ~= currentSelfRight
			then
				vim.api.nvim_cmd(api.nvim_parse_cmd(v, {}), {})
			end
		end
	end
end

api.nvim_create_user_command("LSoutline", function()
	rightSidebarAutoClose(ftAndCmandRight, "lspsagaoutline")
	vim.api.nvim_cmd(api.nvim_parse_cmd("LSoutlineToggle", {}), {})
end, { desc = "LSoutlineToggle enhanced" })
api.nvim_create_user_command("DapContinuee", function()
	rightSidebarAutoClose(ftAndCmandRight, "dapui_scopes")
	vim.api.nvim_cmd(api.nvim_parse_cmd("DapContinue", {}), {})
end, { desc = "DapContinue enhanced" })
