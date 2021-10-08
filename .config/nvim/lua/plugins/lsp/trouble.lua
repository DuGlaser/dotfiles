require("trouble").setup({})
local remap = vim.api.nvim_set_keymap

remap("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
remap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", { silent = true, noremap = true })
remap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", { silent = true, noremap = true })
remap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
