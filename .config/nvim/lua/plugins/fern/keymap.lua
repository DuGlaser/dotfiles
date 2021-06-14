local remap = vim.api.nvim_set_keymap

remap('n', '<Space>f', '<cmd>Fern . -reveal=% -wait <CR><C-w>=', { noremap = true})
