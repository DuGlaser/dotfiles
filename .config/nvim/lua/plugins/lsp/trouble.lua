require("trouble").setup({})
local remap = vim.api.nvim_set_keymap

remap("n", "<Space>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
remap("n", "<Space>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
remap("n", "<Space>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
remap("n", "<Space>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
