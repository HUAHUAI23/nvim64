local status, telescope = pcall(require, "telescope")
if not status then
	vim.notify("没有找到 telescope")
	return
end

telescope.setup({
	defaults = {
		prompt_prefix = "🔍",
		-- 打开弹窗后进入的初始模式，默认为 normal，也可以是 insert
		initial_mode = "normal",
		-- default mappings see https://github.com/nvim-telescope/telescope.nvim
		mappings = {
			n = {
				["q"] = "close",
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
pcall(telescope.load_extension, "fzf")
-- extension telescope-env.nvim
pcall(telescope.load_extension, "env")
-- extension telescope-project
pcall(telescope.load_extension, "projects")
-- extension telescope-dap
pcall(telescope.load_extension, "dap")
-- extension telescope-session
pcall(telescope.load_extension, "xray23")
-- extension telescope-color
pcall(telescope.load_extension, "i42")

-- load session
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

vim.api.nvim_create_user_command("SessionSv", function()
	vim.api.nvim_cmd(vim.api.nvim_parse_cmd("Telescope xray23 save", {}), {})
end, { desc = "load user session,like workspace" })

-- --------load DAP launch
local function load_launch(prompt_bufnr)
	actions.close(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	-- vim.cmd([[echo "]] .. selection[1] .. [["]])
	local vscodeDir = vim.fn.getcwd() .. "/.vscode/"
	-- local adapterAndFt = [[{cppdbg = { "c", "cpp" }}]]
	-- loadstring 将字符串转变成table https://blog.csdn.net/yuanfengyun/article/details/23408549
	-- local typeConf = loadstring("return " .. adapterAndFt)()
	local adapter = vim.fn.input("adapter: ", "")
	local typeConf = {}
	typeConf[adapter] = {}
	local filetype = vim.fn.input("filetype: ", "")
	table.insert(typeConf[adapter], filetype)
	-- print(vim.inspect(typeConf))
	require("dap.ext.vscode").load_launchjs(nil, typeConf)
	-- require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
	vim.cmd([[edit ]] .. vscodeDir .. selection[1])
end

local _manage_launch = function()
	local opts = {
		attach_mappings = function(_, map)
			map("n", "<cr>", load_launch)
			return true
		end,
		find_command = { "ls", ".vscode" },
		prompt_title = "Manage launch",
	}
	require("telescope.builtin").find_files(opts)
end
vim.api.nvim_create_user_command("LoadCodeLaunch", _manage_launch, { desc = "load vscode like launch" })
