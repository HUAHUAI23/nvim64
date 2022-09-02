local status, fidget = pcall(require, "fidget")
if not status then
    vim.notify("没有找到 fidget")
    return
end
fidget.setup({
    text = {
        -- done = "✔️", -- character shown when all tasks are complete
        done = "✔",
    },
    -- sources = {
    --     ["null-ls"] = {
    --         ignore = true,
    --     },
    -- },
})
