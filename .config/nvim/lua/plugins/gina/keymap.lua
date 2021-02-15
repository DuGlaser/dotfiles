local remap = vim.api.nvim_set_keymap

remap('n', '<Space>gs', '<cmd>Gina status --opener="botright split"<cr>', { noremap = true, silent = true})
remap('n', '<Space>ct', '<cmd>Gina commit<cr>', { noremap = true, silent = true})
