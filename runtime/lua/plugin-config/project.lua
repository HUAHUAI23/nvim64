-- https://github.com/ahmedkhalf/project.nvim
-- 输出保存目录
-- :lua print(require("project_nvim.utils.path").historyfile)
-- 我的文件在
--  ~/.local/share/nvim/project_nvim/project_history

local status, project = pcall(require, "project_nvim")
if not status then
    vim.notify("没有找到 project_nvim")
    return
end
project.setup({
    detection_methods = { "pattern" },
    datapath = vim.fn.stdpath("data"),
    patterns = { "project.md" },
})
