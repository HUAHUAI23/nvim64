vim.o.background = "dark"
vim.g.deus_termcolors = 256
local colorscheme = "deus"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
	return
end
