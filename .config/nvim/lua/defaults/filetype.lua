local cmd = vim.cmd

cmd('autocmd FileType vue syntax sync fromstart')
cmd('autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx')
cmd('autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx')
