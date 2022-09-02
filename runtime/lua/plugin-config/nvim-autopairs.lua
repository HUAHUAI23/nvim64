local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
    vim.notify("没有找到 nvim-autopairs")
    return
end
autopairs.setup({
    -- Don't add pairs if it already has a close pair in the same line
    enable_check_bracket_line = true,
    -- Don't add pairs if the next char is alphanumeric
    ignored_next_char = "[%w%.]",
    -- use treesitter to check for a pair
    check_ts = true,
    ts_config = {
        lua = { 'string' }, -- it will not add a pair on that treesitter node
        javascript = { 'template_string' },
        java = false, -- don't check treesitter on java
    }
})


-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
