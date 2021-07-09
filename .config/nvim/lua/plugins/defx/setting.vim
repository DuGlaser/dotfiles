call defx#custom#option('_', {
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 1,
      \ 'buffer_name': 'exlorer',
      \ 'resume': 1,
      \ })

call defx#custom#column('icon', {
      \ 'directory_icon': '',
      \ 'opened_icon': '',
      \ 'root_icon': ' ',
      \ })

nnoremap <silent> <Space>f :Defx<CR>

function! s:defx_my_settings() abort
  nnoremap <buffer><silent><expr> l
        \ defx#is_directory()
        \ ? defx#do_action('open_or_close_tree')
        \ : defx#do_action('open')
  nnoremap <silent><buffer><expr> E defx#do_action('open', 'vsplit')
  nnoremap <buffer><silent><expr> h defx#do_action('close_tree')
  nnoremap <buffer><silent><expr> L defx#do_action('cd', defx#get_candidate().action__path)
  nnoremap <buffer><silent><expr> H defx#do_action('cd', ['..'])
  nnoremap <buffer><silent><expr> gh defx#do_action('cd', getcwd())

  " Selection
  nnoremap <buffer><silent><expr> a defx#do_action('toggle_select') .. 'j'
  xnoremap <buffer><silent><expr> a defx#do_action('toggle_select_visual')
  nnoremap <buffer><silent><expr> uv defx#do_action('clear_select_all')

  " Operations
  nnoremap <buffer><silent><expr> yy defx#do_action('copy')
  xnoremap <buffer><silent><expr> yy defx#do_action('copy')
  nnoremap <buffer><silent><expr> m defx#do_action('move')
  nnoremap <buffer><silent><expr> dd defx#do_action('remove_trash')
  nnoremap <buffer><silent><expr> p defx#do_action('paste')
  nnoremap <buffer><silent><expr> r defx#do_action('rename')
  nnoremap <buffer><silent><expr><nowait> c defx#do_action('new_multiple_files')

  " Other
  nnoremap <buffer><silent><expr> ! defx#do_action('toggle_ignored_files')
  nnoremap <buffer><silent><expr> yp defx#do_action('yank_path')
endfunction

function! s:open_defx_if_directory()
  try
    let l:full_path = expand(expand('%:p'))
  catch
    return
  endtry

  if isdirectory(l:full_path)
    execute "Defx `expand('%:p')` | bd " . expand('%:r')
  endif
endfunction

augroup defx_config
  autocmd!
  autocmd FileType defx call s:defx_my_settings()

  autocmd BufEnter * call s:open_defx_if_directory()

  autocmd BufWritePost * call defx#redraw()
  autocmd BufEnter * call defx#redraw()
augroup END

