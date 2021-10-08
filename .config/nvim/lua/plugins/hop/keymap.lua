local remap = vim.api.nvim_set_keymap

remap("", "<A-f>", "<cmd>HopWord<cr>", { noremap = true, silent = true })
remap("", "<A-d>", "<cmd>HopChar2<cr>", { noremap = true, silent = true })
