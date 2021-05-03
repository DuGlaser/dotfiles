local remap = vim.api.nvim_set_keymap

remap('','<A-d>', ':HopWord<cr>', { noremap = true, silent = true })
remap('','<A-f>', ':HopChar2<cr>', { noremap = true, silent = true })
