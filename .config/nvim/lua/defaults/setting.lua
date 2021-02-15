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

cmd('augroup auto_comment_off')
cmd('autocmd!')
cmd('autocmd BufEnter * setlocal formatoptions-=r')
cmd('autocmd BufEnter * setlocal formatoptions-=o')
cmd('augroup END')
