-- TODO: Need Refactoring
-- Base on https://github.com/elianiva/dotfiles/blob/master/nvim/.config/nvim/lua/modules/_settings.lua

local cmd = vim.api.nvim_command
local opt = vim.opt;

opt.fileformat = "unix"
opt.fileformats = "unix,dos,mac"
opt.fileencodings = "utf-8,iso-2022-jp,cp932,euc-jp"
opt.cmdheight = 1
opt.encoding = "UTF-8"
opt.number = true
opt.autoindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.hls = true
opt.completeopt = "menuone,noinsert"
opt.ignorecase = true
opt.incsearch = true
opt.inccommand = "split"
opt.conceallevel = 0
opt.signcolumn = "yes"
opt.cursorline = true
opt.splitright = true
opt.showtabline = 2


cmd([[
  set clipboard+=unnamedplus
  set t_Co=256
  set nocompatible
]])

vim.api.nvim_exec([[
  augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
  augroup END
]], true)

-- Highlight on yank(nvim >= 0.5)
cmd('au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=200, on_visual=true}')

-- fold text setting
cmd([[
  function! MyFoldText()
    let line = getline(v:foldstart)
    let foldedlinecount = v:foldend - v:foldstart + 1
    return  line . '   ' . foldedlinecount 
  endfunction
  

  set foldtext=MyFoldText()
  set foldmethod=indent
  set fillchars=fold:\ 

  autocmd FileType json,packer setlocal foldmethod=manual
]])
