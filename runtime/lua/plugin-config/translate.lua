local status, translate = pcall(require, "translate")
if not status then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("没有找到 translate 插件", "error")
	return
end

translate.setup({
	default = {
		command = "google",
	},
	preset = {
		output = {
			split = {
				append = true,
			},
			floating = {
				border = "rounded",
			},
		},
	},
	replace_symbols = {
		translate_shell = {
			["="] = "{@E@}",
			["#"] = "{@S@}",
			["/"] = "{@C@}",
		},
		deepl_free = {},
		deepl_pro = {},
		google = {},
	},
	silent = false,
})
