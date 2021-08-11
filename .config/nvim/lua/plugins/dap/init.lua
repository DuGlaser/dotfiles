local M = {}

local install_path = os.getenv("HOME") .. '/.config/nvim/dapinstall/'

function M.dapinstall_setting()
  local dap_install = require("dap-install")
  dap_install.setup({
    installation_path = install_path,
    verbosely_call_debuggers = false,
  })
end

function M.dap_setting()
  local dap = require("dap")
  vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapStopped', { text = '🟢', texthl = '', linehl = '', numhl = '' })

  dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = {
      install_path .. "jsnode_dbg/vscode-node-debug2/out/src/nodeDebug.js",
    },
  }
  dap.configurations.javascript = {
    {
      type = "node2",
      request = "launch",
      program = "${workspaceFolder}/${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
    },
  }
  dap.configurations.typescript = dap.configurations.javascript

  require('dap.ext.vscode').load_launchjs()
end

function M.dapui_setting()
  require("dapui").setup({
    sidebar = { width = 80 },
    tray = {},
    floating = { max_width = 0.9, max_height = 0.5 },
  })
end

M.dapinstall_setting()
M.dap_setting()
M.dapui_setting()

return M
