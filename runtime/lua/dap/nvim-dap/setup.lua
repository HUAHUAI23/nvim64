local dap = require('dap')
local dapui = require("dapui")
require("nvim-dap-virtual-text").setup({})
dapui.setup({})

--dap-ui config
--  use nvim-dap events to open and close the windows automatically
-- https://github.com/rcarriga/nvim-dap-ui
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.fn.sign_define("DapBreakpoint", {
    text = "🎃",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
})

vim.fn.sign_define("DapStopped", {
    -- text = "🤔",
    text = "👣",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
})

vim.fn.sign_define("DapBreakpointRejected", {
    -- text = "😢",
    -- text = "🕵️‍♂",
    text = "🐛",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = "",
})



-- vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>
-- require("dapui").eval(<expression>)
-- require("dapui").float_element(<element ID>, <optional settings>)

-- specific configuration
-- python
require('dap-python').setup(vim.env.VIM .. '/abc/nvim/mason/packages/debugpy/venv/bin/python')

-- -- 加载调试器配置
local dap_config = {
    -- nodejs = require("dap.nvim-dap.config.nodejs"),
    cpp = require("dap.nvim-dap.config.cpp"),
    -- go = require("dap.go")
}

dap.adapters.cppdbg = dap_config.cpp.adapter
for _, language in ipairs({ "c", "cpp" }) do
    dap.configurations[language] = dap_config.cpp.configuration
end

-- dap.adapters.node2 = dap_config.nodejs.adapter
-- dap.configurations.javascript = dap_config.nodejs.configuration

-- js
require("dap-vscode-js").setup({
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
        }
    }
end

-- dap keybindings
require("keybindings").mapDAP()
