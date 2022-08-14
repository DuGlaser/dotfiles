-- TODO: Need Refactoring
-- Base on https://github.com/elianiva/dotfiles/blob/master/nvim/.config/nvim/lua/modules/_settings.lua

local opt = vim.opt
local g = vim.g

opt.fileformat = "unix"
opt.fileformats = "unix,dos,mac"
opt.fileencodings = "utf-8,iso-2022-jp,cp932,euc-jp"
opt.cmdheight = 1
opt.encoding = "UTF-8"
opt.number = false
opt.autoindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.hls = true
opt.completeopt = "menu,menuone,noselect"
opt.ignorecase = true
opt.incsearch = true
opt.inccommand = "split"
opt.conceallevel = 0
opt.signcolumn = "yes"
opt.cursorline = true
opt.splitright = true
opt.showtabline = 2
opt.laststatus = 3
-- opt.cmdheight = 0

-- stop default plugins
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_rrhelper = 1
g.loaded_2html_plugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1

vim.cmd([[
  set clipboard+=unnamedplus
  set t_Co=256
  set nocompatible
  set mouse=
]])

vim.cmd([[
  augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
  augroup END
]])

-- Highlight on yank(nvim >= 0.5)
vim.cmd('au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=200, on_visual=true}')

-- fold text setting
vim.cmd([[
  function! MyFoldText()
    let line = getline(v:foldstart)
    let foldedlinecount = v:foldend - v:foldstart + 1
    return  line . '   ' . foldedlinecount 
  endfunction
  

  set foldtext=MyFoldText()
  set foldmethod=indent
  set fillchars=fold:\ 

  augroup filetype_fold
    autocmd!
    autocmd FileType json,packer setlocal foldmethod=manual
    autocmd FileType TelescopeResults setlocal nofoldenable
  augroup END
]])
