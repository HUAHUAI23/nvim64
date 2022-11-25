-- command open dap
-- refer: https://github.com/rcarriga/nvim-dap-ui
vim.api.nvim_create_user_command("DapFloatWin", function()
	require("dapui").float_element()
end, { desc = "load user session,like workspace" })

-- command close dap
-- refer: https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt
vim.api.nvim_create_user_command("DapCloseWin", function()
	local ok, dap = pcall(require, "dap")
	dap.close()
	dap.terminate()
	local repl = dap.repl
	repl.close()
	dap.clear_breakpoints()
end, { desc = "close dap session" })
