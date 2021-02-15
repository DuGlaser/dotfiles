local map = vim.api.nvim_set_keymap

map('n', 'n', "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", { noremap = true, silent = true })
map('n', 'N', "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", { noremap = true, silent = true })
map('n', '*', "*<Cmd>lua require('hlslens').start()<CR>", { noremap = true })
map('n', '#', "#<Cmd>lua require('hlslens').start()<CR>", { noremap = true })
map('n', 'g*', "g*<Cmd>lua require('hlslens').start()<CR>", { noremap = true })
map('n', 'g#', "g#<Cmd>lua require('hlslens').start()<CR>", { noremap = true })

