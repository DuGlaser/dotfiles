local remap = vim.api.nvim_set_keymap

remap("", "<A-u>", "<cmd>HopWord<cr>", { noremap = true, silent = true })
remap("", "<A-i>", "<cmd>HopChar2<cr>", { noremap = true, silent = true })
