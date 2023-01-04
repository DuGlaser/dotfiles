local M = {
	"lambdalisue/fern.vim",
	dependencies = {
		"hrsh7th/fern-mapping-collapse-or-leave.vim",
		"lambdalisue/nerdfont.vim",
		"lambdalisue/fern-renderer-nerdfont.vim",
	},
	keys = {
		{
			"<Space>u",
			"<cmd>Fern . -drawer -width=35 -reveal=% <CR><C-w>=",
		},
	},
	config = function()
		vim.cmd([[
      let g:fern#disable_default_mappings = 1
      let g:fern#renderer = "nerdfont"
      let g:fern#renderer#nerdfont#indent_markers = 1
      let hide_dirs  = '^\%(\.git\|node_modules\)$'
      let hide_files = '\%(\.byebug\|\.ruby-\)\+'

      let g:fern#default_exclude = hide_dirs . '\|' . hide_files

      function! s:init_fern() abort
        nmap <buffer> <Space>u <cmd>Fern . -drawer -toggle -width=35 -reveal=% <CR><C-w>=

        nmap <buffer> E <Plug>(fern-action-open:side)
        nmap <buffer> ! <Plug>(fern-action-hidden:toggle)
        nmap <buffer> a <Plug>(fern-action-mark:toggle)
        nmap <buffer> A <Plug>(fern-action-choice)
        nmap <buffer> h <Plug>(fern-action-collapse-or-leave)
        nmap <buffer> M <Plug>(fern-action-move)
        nmap <buffer> c <Plug>(fern-action-new-file)
        nmap <buffer> n <Plug>(fern-action-new-dir)
        nmap <buffer> l <Plug>(fern-action-open-or-expand)
        nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
        nmap <buffer> t <Plug>(fern-action-open:tabedit)
        nmap <buffer> r <Plug>(fern-action-rename)
        nmap <buffer> D <Plug>(fern-action-trash)
        nmap <buffer> y <Plug>(fern-action-yank)
        nmap <buffer> Y <Plug>(fern-action-copy)
        nmap <buffer> dd <Plug>(fern-action-remove)
        nmap <buffer> ? <Plug>(fern-action-help)
        nmap <buffer> <C-r> <Plug>(fern-action-reload)
      endfunction

      augroup fern-custom
        autocmd! *
        autocmd FileType fern call s:init_fern()
      augroup END
    ]])
	end,
}

return M
