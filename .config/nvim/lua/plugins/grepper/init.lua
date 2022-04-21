vim.g.grepper = { tools = { "rg", "grep" }, searchreg = 1 }
vim.cmd(([[
    aug Grepper
        au!
        au User Grepper ++nested %s
    aug END
]]):format([[call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\%#' . getreg('/')}}})]]))

vim.cmd([[
  nmap gs  <plug>(GrepperOperator)
  xmap gs  <plug>(GrepperOperator)
  nnoremap <Space>g :Grepper -dir repo -tool rg<cr>

  hi default link BqfPreviewFloat Normal
  hi default link BqfPreviewBorder Normal
  hi default link BqfPreviewCursor Cursor
  hi default link BqfPreviewRange IncSearch
]])
