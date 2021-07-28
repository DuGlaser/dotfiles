-- TODO: Need Refactoring
-- Base on https://github.com/elianiva/dotfiles/blob/master/nvim/.config/nvim/lua/modules/_settings.lua

local cmd = vim.api.nvim_command

local apply_options = function(opts)
  for k, v in pairs(opts) do
    if v == true then
      cmd('set ' .. k)
    elseif v == false then
      cmd(string.format('set no%s', k))
    else
      cmd(string.format('set %s=%s', k, v))
    end
  end
end

local options = {
	fileformat = "unix",
	fileformat = "unix",
	fileformats = "unix,dos,mac",
	fileencodings = "utf-8,iso-2022-jp,cp932,euc-jp",
	cmdheight = 1,
	encoding = "UTF-8",
	number = true,
	autoindent = true,
	expandtab = true,
	tabstop = 2,
	shiftwidth = 2,
	hls = true,
	completeopt = "menuone,noinsert",
	t_Co = 256,
	nocompatible = true,
	ignorecase = true,
	incsearch = true,
	inccommand = "split", 
	conceallevel = 0,
	signcolumn = "yes",
	cursorline = true,
	splitright = true,  
  showtabline = 2,
}

cmd('set clipboard+=unnamedplus')
apply_options(options)


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
