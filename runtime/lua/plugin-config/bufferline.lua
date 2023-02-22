local status, bufferline = pcall(require, "bufferline")
if not status then
	vim.notify("没有找到 bufferline")
	return
end
-- bfferline 配置
-- https://github.com/akinsho/bufferline.nvim/blob/main/doc/bufferline.txt
bufferline.setup({
	options = {
		middle_mouse_command = function()
			require("bufferline").sort_buffers_by(function(buf_a, buf_b)
				return buf_a.id < buf_b.id
			end)
		end,
		-- numbers = "buffer_id",
		-- indicator = {
		-- 	style = "icon",
		-- },
		-- color_icons = false,
		diagnostics = "nvim_lsp",
		---@diagnostic disable-next-line: unused-local
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			-- -- current buffer don't show LSP indicators
			-- if context.buffer:current() then
			--     return ''
			-- end
			local s = " "
			-- e=level,n=count
			for e, n in pairs(diagnostics_dict) do
				-- sym  symbol的缩写
				local sym = e == "error" and " " or (e == "warning" and " " or "")
				s = s .. n .. sym
			end
			return s
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer🗂️",
				highlight = "Directory",
				text_align = "left",
			},
			{
				filetype = "lspsagaoutline",
				text = "👾outline",
				text_align = "right",
			},
			{
				filetype = "Outline",
				text = "👾outline",
				text_align = "right",
			},
			{
				filetype = "undotree",
				text = "👾undo Tree",
				text_align = "left",
			},
		},
		-- hover = {
		-- 	enabled = true,
		-- 	delay = 200,
		-- 	reveal = { "close" },
		-- },

		-- see more: https://github.com/akinsho/bufferline.nvim/blob/main/doc/bufferline.txt
		-- highlights = {
		-- 	buffer_visible = {
		-- 		fg = "#ebdbb2",
		-- 	},
		-- },
	},
})
-- bufferline will override showtabline to 2
-- vim.o.showtabline = 0
