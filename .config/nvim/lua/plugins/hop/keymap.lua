local remap = vim.api.nvim_set_keymap

remap('','<A-f>', ':HopWord<cr>', { noremap = true, silent = true })
remap('','<A-d>', ':HopChar2<cr>', { noremap = true, silent = true })
