local status, mkdnflow = pcall(require, "mkdnflow")
if not status then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("没有找到 mkdnflow 插件", "error")
	return
end
local mkd = require("keybindingAlias").mkdnflow
if type(mkd) == "table" and mkd.enable then
	mkdnflow.setup({
		perspective = {
			priority = "current",
			fallback = "first",
		},
		-- wrap = true,
		mappings = {
			-- buffer go forward or backward
			MkdnGoBack = false,
			MkdnGoForward = false,
			MkdnNextLink = { "n", mkd.mkdnNextLink },
			MkdnPrevLink = { "n", mkd.mkdnPrevLink },
			MkdnDestroyLink = { "n", mkd.mkdnDestroyLink },
			MkdnTagSpan = { "v", mkd.mkdnTagSpan },
			MkdnMoveSource = { "n", mkd.mkdnMoveSource },
			MkdnYankAnchorLink = { "n", mkd.mkdnYankAnchorLink },
			MkdnYankFileAnchorLink = { "n", mkd.mkdnYankFileAnchorLink },
			MkdnToggleToDo = { { "n", "v" }, mkd.mkdnToggleToDo },
			MkdnUpdateNumbering = { "n", mkd.mkdnUpdateNumbering },
			MkdnTableNextRow = { "i", mkd.mkdnTableNextRow },
			MkdnTablePrevRow = { "i", mkd.mkdnTablePrevRow },
			MkdnFoldSection = { "n", mkd.mkdnFoldSection },
			MkdnUnfoldSection = { "n", mkd.mkdnUnfoldSection },
			MkdnTableNextCell = { "i", mkd.mkdnTableNextCell },
			MkdnTablePrevCell = { "i", mkd.mkdnTablePrevCell },
			MkdnTableNewRowBelow = { "n", mkd.mkdnTableNewRowBelow },
			MkdnTableNewRowAbove = { "n", mkd.mkdnTableNewRowAbove },
			MkdnTableNewColAfter = { "n", mkd.mkdnTableNewColAfter },
			MkdnTableNewColBefore = { "n", mkd.mkdnTableNewColBefore },
			MkdnCreateLinkFromClipboard = { { "n", "v" }, mkd.mkdnCreateLinkFromClipboard },
		},
	})
end
