local remap = vim.api.nvim_set_keymap

remap("", "ss", "<cmd>HopWord<cr>", { noremap = true, silent = true })
