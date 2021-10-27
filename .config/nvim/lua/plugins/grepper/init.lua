vim.cmd([[
  nmap gs  <plug>(GrepperOperator)
  xmap gs  <plug>(GrepperOperator)
  nnoremap <Space>g :Grepper -dir repo -tool rg<cr>

  let g:grepper = {
              \ 'open': 0,
              \ 'quickfix': 1,
              \ 'searchreg': 1,
              \ 'highlight': 0,
              \ 'tools': ['rg'],
              \ 'dir': 'repo',
              \ 'rg': {
              \   'grepprg': 'rg -H --no-heading --vimgrep --sort-files $* .'
              \ }}

  augroup vimrcQfClose
    autocmd!
    autocmd FileType qf if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR> | endif
  augroup END

  augroup Grepper
      autocmd!
      autocmd User Grepper call setqflist([], 'r',
                  \ {'context': {'bqf': {'pattern_hl': histget('/')}}}) |
                  \ botright copen
  augroup END

  hi default link BqfPreviewFloat Normal
  hi default link BqfPreviewBorder Normal
  hi default link BqfPreviewCursor Cursor
  hi default link BqfPreviewRange IncSearch
]])
