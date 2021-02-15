local cmd = vim.cmd

cmd('let g:fern#renderer = "nerdfont"')

cmd('augroup glyph-palette')
cmd('autocmd! *')
cmd('autocmd FileType fern call glyph_palette#apply()')
cmd('autocmd FileType nerdtree,startify call glyph_palette#apply()')
cmd('augroup END')
