vim.cmd([[
  function ChooseWinShowingStatusLine()
  let current = &laststatus
  set laststatus=2
  ChooseWin
  exec 'set laststatus=' . current
  endfunction

  nnoremap - <cmd>call ChooseWinShowingStatusLine()<CR>
]])
