local api = vim.api
-- command open dapui float
-- refer: https://github.com/rcarriga/nvim-dap-ui
api.nvim_create_user_command("DapFloatWin", function(args)
	local dapfloat = {
		"scopes",
		"stacks",
		"console",
		"breakpoints",
		"watches",
		"repl",
	}
	if vim.tbl_contains(dapfloat, args.fargs[1]) then
		require("dapui").float_element(args.fargs[1], { enter = true })
	else
		---@diagnostic disable-next-line: missing-parameter
		require("dapui").float_element()
	end
end, {
	desc = "load dapui float",
	nargs = "?",
	---@diagnostic disable-next-line: unused-local
	complete = function(A, L, P)
		return {
			"scopes",
			"stacks",
			"console",
			"breakpoints",
			"watches",
			"repl",
		}
	end,
})

-- command close dap
-- refer: https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt
api.nvim_create_user_command("DapCloseWin", function()
	local ok, dap = pcall(require, "dap")
	if not ok then
		vim.notify("没有找到 dap")
		return
	end
	dap.terminate()
end, { desc = "close dap session" })

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
	vim.api.nvim_cmd(api.nvim_parse_cmd("CloseAllterm", {}), {})
	leftSidebarAutoClose(ftAndCmandLeft, "undotree")
	vim.api.nvim_cmd(api.nvim_parse_cmd("UndotreeToggle", {}), {})
end, { desc = "undotree enhanced" })
api.nvim_create_user_command("NvimTrr", function()
	vim.api.nvim_cmd(api.nvim_parse_cmd("CloseAllterm", {}), {})
	leftSidebarAutoClose(ftAndCmandLeft, "NvimTree")
	vim.api.nvim_cmd(api.nvim_parse_cmd("NvimTreeToggle", {}), {})
end, { desc = "NvimTree enhanced" })

local ftAndCmandRight = {
	dapui_scopes = "DapCloseWin",
	-- lspsagaoutline = "Lspsaga outline",
	Outline = "SymbolsOutline",
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
	vim.api.nvim_cmd(api.nvim_parse_cmd("CloseAllterm", {}), {})
	rightSidebarAutoClose(ftAndCmandRight, "Outline")
	vim.api.nvim_cmd(api.nvim_parse_cmd("SymbolsOutline", {}), {})
end, { desc = "LSoutlineToggle enhanced" })
api.nvim_create_user_command("DapContinuee", function()
	vim.api.nvim_cmd(api.nvim_parse_cmd("CloseAllterm", {}), {})
	rightSidebarAutoClose(ftAndCmandRight, "dapui_scopes")
	vim.api.nvim_cmd(api.nvim_parse_cmd("DapContinue", {}), {})
end, { desc = "DapContinue enhanced" })

-- redirect command output
vim.api.nvim_create_user_command("RecommandTo", function(args)
	local cmd = ""
	for _, v in ipairs(args.fargs) do
		cmd = cmd .. v .. " "
	end
	cmd = cmd:gsub("^%s*(.-)%s*$", "%1")
	local text = vim.api.nvim_exec(cmd, true)
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n", { trimempty = true, plain = true }))
	vim.api.nvim_set_current_buf(buf)
end, {
	desc = "redirect command output",
	nargs = "*",
	complete = function(_, _, _)
		return {
			"messages",
		}
	end,
})
