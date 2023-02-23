local status, fidget = pcall(require, "fidget")
if not status then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("没有找到 fidget", "error")
	return
end
fidget.setup({
	text = {
		-- done = "✔️", -- character shown when all tasks are complete
		done = "✔",
	},
	-- fmt = {
	-- 	-- function to format each task line
	-- 	task = function(task_name, message, percentage)
	-- 		if task_name == "code_action" then
	-- 			return nil
	-- 		else
	-- 			return string.format(
	-- 				"%s%s [%s]",
	-- 				message,
	-- 				percentage and string.format(" (%s%%)", percentage) or "",
	-- 				task_name
	-- 			)
	-- 		end
	-- 	end,
	-- },
	sources = {
		["null-ls"] = {
			ignore = false,
		},
	},
})
