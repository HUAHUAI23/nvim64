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

-- load session
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local sessionDir = vim.env.VIM .. "/vimSession/"

local function delete_selection(prompt_bufnr, map)
	actions.close(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	-- source session
	vim.cmd([[!rm ]] .. sessionDir .. selection[1])
end

local function load_session(prompt_bufnr)
	actions.close(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	-- source session
	vim.cmd([[
    bufdo bwipe
    source ]] .. sessionDir .. selection[1])
end

local _manage_session = function()
	local opts = {
		attach_mappings = function(_, map)
			map("n", "<cr>", load_session)
			map("n", "d", delete_selection)
			return true
		end,
		find_command = {
			"ls",
			sessionDir,
		},
		prompt_title = "Manage session",
	}
	require("telescope.builtin").find_files(opts)
end

vim.keymap.set("n", "<space>s", _manage_session)
vim.api.nvim_create_user_command("LoadSession", _manage_session, { desc = "load user session,like workspace" })
