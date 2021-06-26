vim.cmd([[
  highlight Directory guifg=#FF8800

  let g:fern#default_exclude = '^\%(\.git\|node_modules\)$'
  let g:fern#renderer#default#leading='  '
  let g:fern#renderer#default#collapsed_symbol=' '
  let g:fern#renderer#default#expanded_symbol=' '
  let g:fern#renderer#default#leaf_symbol='- '
]])
