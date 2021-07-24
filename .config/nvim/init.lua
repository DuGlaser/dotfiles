require 'defaults'
require 'plugins'

vim.cmd('runtime coc-options.vim')
vim.cmd('autocmd BufWritePost lua.plugins PackerCompile')
