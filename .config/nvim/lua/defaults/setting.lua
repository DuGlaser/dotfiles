vim.loader.enable()

vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix,dos,mac"
vim.opt.fileencodings = "utf-8,iso-2022-jp,cp932,euc-jp"
vim.opt.cmdheight = 1
vim.opt.encoding = "UTF-8"
vim.opt.number = false
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.hls = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.conceallevel = 0
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.showtabline = 2
vim.opt.laststatus = 3
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"

local is_wsl = os.getenv("IS_WSL") ~= nil
if is_wsl then
	vim.g.clipboard = {
		name = "wsl clipboard",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = true,
	}
end

-- stop default plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

vim.cmd([[
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
    autocmd FileType lazy setlocal nofoldenable
    autocmd FileType far setlocal nofoldenable
  augroup END
]])
