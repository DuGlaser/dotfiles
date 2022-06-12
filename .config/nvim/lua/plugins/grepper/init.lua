vim.g.grepper = {
	tools = { "rg", "git" },
	searchreg = 1,
	simple_prompt = 1,
}

vim.cmd(([[
    aug Grepper
        au!
        au User Grepper ++nested %s
    aug END
]]):format([[call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\%#' . getreg('/')}}})]]))

vim.cmd([[
  nmap gs  <plug>(GrepperOperator)
  xmap gs  <plug>(GrepperOperator)
  nnoremap <Space>g :Grepper -dir repo<cr>

  hi default link BqfPreviewFloat Normal
  hi default link BqfPreviewBorder Normal
  hi default link BqfPreviewCursor Cursor
  hi default link BqfPreviewRange IncSearch
]])
