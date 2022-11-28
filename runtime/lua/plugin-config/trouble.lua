local status, trouble = pcall(require, "trouble")
if not status then
	vim.notify("没有找到 trouble.nvim")
	return
end
trouble.setup({
	signs = {
		-- icons / text used for a diagnostic
		error = "🤕",
		-- error = "🥵",
		-- warning = "😢",
		warning = "😦",
		hint = "😐",
		information = "🤔",
		other = "🤨",
	},
})
