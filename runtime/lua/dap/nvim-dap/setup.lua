local dap = require("dap")
local dapui = require("dapui")
require("nvim-dap-virtual-text").setup({})
dapui.setup({
	-- Expand lines larger than the window
	-- Requires >= 0.7
	expand_lines = vim.fn.has("nvim-0.7") == 1,
	layouts = {
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.25 },
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 30, -- 30 columns
			position = "right",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 0.25, -- 25% of total lines
			position = "bottom",
		},
	},
	floating = {
		border = "rounded", -- Border style. Can be "single", "double" or "rounded"
	},
})

--dap-ui config
--  use nvim-dap events to open and close the windows automatically
-- https://github.com/rcarriga/nvim-dap-ui
-- https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt *dap-extensions*  *dap.repl.open()*   *dap-api*
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({ reset = true })
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close({})
	local repl = dap.repl
	repl.close()
	-- close the remaining windows
	-- vim.api.nvim_command([[exe "normal \<c-w>o"]])
	vim.cmd("stopinsert")
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close({})
	local repl = dap.repl
	repl.close()
	-- vim.api.nvim_command([[exe "normal \<c-w>o"]])
	vim.cmd("stopinsert")
end

vim.fn.sign_define("DapBreakpoint", {
	text = "🎃",
	texthl = "LspDiagnosticsSignError",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapStopped", {
	-- text = "🤔",
	text = "👣",
	texthl = "LspDiagnosticsSignInformation",
	linehl = "DiagnosticUnderlineInfo",
	numhl = "LspDiagnosticsSignInformation",
})

vim.fn.sign_define("DapBreakpointRejected", {
	-- text = "😢",
	-- text = "🕵️‍♂",
	text = "🐛",
	texthl = "LspDiagnosticsSignHint",
	linehl = "",
	numhl = "",
})

-- vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>
-- require("dapui").eval(<expression>)
-- require("dapui").float_element(<element ID>, <optional settings>)

-- specific configuration
-- -- 加载调试器配置
local dap_config = {
	-- nodejs = require("dap.nvim-dap.config.nodejs"),
	cpp = require("dap.nvim-dap.config.cpptools"),
	-- go = require("dap.go")
}

dap.adapters.cppdbg = dap_config.cpp.adapter
for _, language in ipairs({ "c", "cpp" }) do
	dap.configurations[language] = dap_config.cpp.configuration
end

-- js
-- dap.adapters.node2 = dap_config.nodejs.adapter
-- dap.configurations.javascript = dap_config.nodejs.configuration

-- python
require("dap-python").setup(os.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

-- js
require("dap-vscode-js").setup({
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
	}
end

-- dap keybindings
require("keybindings").pluginKeys.mapDAP()
