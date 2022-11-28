local M = {}
M.adapter = {
	type = "server",
	port = 1300,
	executable = {
		-- CHANGE THIS to your path!
		command = "codelldb",
		args = { "--port", "1300" },

		-- On windows you may have to uncomment this:
		-- detached = false,
	},
}
M.configuration = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
	},
}
return M
