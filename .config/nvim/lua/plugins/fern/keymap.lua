local remap = vim.api.nvim_set_keymap

remap('n', '<Space>f', '<cmd>Fern . -reveal=% <CR><C-w>=', { noremap = true})
