local remap = vim.api.nvim_set_keymap

remap("n", "<Space>u", "<cmd>Fern . -drawer -width=40 -reveal=% <CR><C-w>=", { noremap = true })

vim.cmd([[
let g:fern#disable_default_mappings = 1
let hide_dirs  = '^\%(\.git\|node_modules\)$'
let hide_files = '\%(\.byebug\|\.ruby-\)\+'

let g:fern#default_exclude = hide_dirs . '\|' . hide_files

function! s:init_fern() abort
  nmap <buffer> <Space>u <cmd>Fern . -drawer -toggle -width=35 -reveal=% <CR><C-w>=

  nmap <buffer> E <Plug>(fern-action-open:side)
  nmap <buffer> ! <Plug>(fern-action-hidden:toggle)
  nmap <buffer> a <Plug>(fern-action-mark:toggle)
  nmap <buffer> h <Plug>(fern-action-collapse-or-leave)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> c <Plug>(fern-action-new-file)
  nmap <buffer> l <Plug>(fern-action-open-or-expand)
  nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> D <Plug>(fern-action-trash)
  nmap <buffer> y <Plug>(fern-action-yank)
  nmap <buffer> dd <Plug>(fern-action-remove)
  nmap <buffer> ? <Plug>(fern-action-help)
  nmap <buffer> <C-r> <Plug>(fern-action-reload)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
]])
