-- https://github.com/kyazdani42/nvim-tree.lua
-- 完整的设置参考
-- https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
    vim.notify("没有找到 nvim-tree")
    return
end

nvim_tree.setup({
    -- needed by project-----
    sync_root_with_cwd = true,
    sort_by = "case_sensitive",
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true
    },
    -- -------
    view = {
        adaptive_size = true,
        -- hide_root_folder = true,
    },
    filters = {
        -- 不显示.开头的文件
        dotfiles = true,
        -- custom = { "" },
    },
})
