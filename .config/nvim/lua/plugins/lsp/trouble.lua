require("trouble").setup({})
local remap = vim.api.nvim_set_keymap

remap("n", "<Space>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
remap("n", "<Space>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", { silent = true, noremap = true })
remap("n", "<Space>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", { silent = true, noremap = true })
remap("n", "<Space>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
