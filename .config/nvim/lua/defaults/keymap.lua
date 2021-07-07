local map = vim.api.nvim_set_keymap

map('n', ';', ':', { noremap = true})
map('n', 's', '<Nop>', { noremap = true})
map('x', 's', '<Nop>', { noremap = true})
map('n', 'sv', '<cmd>vsplit <CR><C-w>w<plug>(wintabs_close)<C-w>w', { noremap = true})
map('n', '<Space>l', '<cmd>nohlsearch<CR><C-l>', { noremap = true, silent = true })

-- fold text
map('n', 'zl', 'zo', { noremap = true, silent = true })
map('n', 'zL', 'zO', { noremap = true, silent = true })
map('x', 'zl', 'zo', { noremap = true, silent = true })
map('x', 'zL', 'zO', { noremap = true, silent = true })

map('n', 'zh', 'zc', { noremap = true, silent = true })
map('n', 'zH', 'zC', { noremap = true, silent = true })
map('x', 'zh', 'zc', { noremap = true, silent = true })
map('x', 'zH', 'zC', { noremap = true, silent = true })
