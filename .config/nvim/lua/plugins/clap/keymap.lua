local map = vim.api.nvim_set_keymap

map('n', '<Space>cf', '<cmd>Clap files<cr>', { noremap = true, silent = true })
map('n', '<Space>cg', '<cmd>Clap grep<cr>', { noremap = true, silent = true })
map('n', '<Space>cd', '<cmd>Clap grep ++query=<cword><cr>', { noremap = true, silent = true })
map('n', '<Space>cb', '<cmd>Clap buffers<cr>', { noremap = true, silent = true })
