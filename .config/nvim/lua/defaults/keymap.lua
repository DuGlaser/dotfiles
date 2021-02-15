local map = vim.api.nvim_set_keymap

map('n', ';', ':', { noremap = true})
map('n', 's', '<Nop>', { noremap = true})
map('x', 's', '<Nop>', { noremap = true})
map('n', 'sv', '<cmd>vsplit <CR><C-w>w<plug>(wintabs_close)<C-w>w', { noremap = true})
map('n', '<Space>l', '<cmd>nohlsearch<CR><C-l>', { noremap = true, silent = true })
