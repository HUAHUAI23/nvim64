local mkd = require("keybindingAlias").mkdnflow
if type(mkd) == "table" and mkd.enable then
	require("mkdnflow").setup({
		mappings = {
			MkdnDestroyLink = { "n", mkd.mkdnDestroyLink },
			MkdnTagSpan = { "v", mkd.mkdnTagSpan },
			MkdnToggleToDo = { { "n", "v" }, mkd.mkdnToggleToDo },
			MkdnTablePrevRow = { "i", mkd.mkdnTablePrevRow },
			MkdnFoldSection = { "n", mkd.mkdnFoldSection },
			MkdnUnfoldSection = { "n", mkd.mkdnUnfoldSection },
			MkdnTableNextCell = { "i", mkd.mkdnTableNextCell },
			MkdnTablePrevCell = { "i", mkd.mkdnTablePrevCell },
		},
	})

	-- 创建 mkdnflowGroup autocommand group
	-- local mkdnflowGroup = vim.api.nvim_create_augroup("mkdnflowGroup", {
	-- 	clear = true,
	-- })
	-- vim.api.nvim_create_autocmd("FileType", {
	-- 	group = mkdnflowGroup,
	-- 	pattern = { "markdown", "md", "mdx" },
	-- 	callback = function()
	-- 		local opts = { buffer = vim.api.nvim_get_current_buf() }
	-- 		keymap("n", mkd.mkdnDestroyLink, "<cmd>MkdnDestroyLink<CR>", opts)
	-- 		keymap("n", mkd.mkdnTagSpan, "<cmd>MkdnTagSpan<CR>", opts)
	-- 		keymap({ "n", "v" }, mkd.mkdnToggleToDo, "<cmd>MkdnToggleToDo<CR>", opts)
	-- 		keymap("n", mkd.mkdnFoldSection, "<cmd>MkdnFoldSection<CR>", opts)
	-- 		keymap("n", mkd.mkdnUnfoldSection, "<cmd>MkdnUnfoldSection<CR>", opts)
	-- 	end,
	-- })
end
