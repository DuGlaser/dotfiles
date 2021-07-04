local function runtime(file)
  vim.cmd('runtime lua/plugins/'..file)
end

require 'plugins.plugins'
require 'plugins.defx'
require 'plugins.treesitter'
require 'plugins.bufferline'
require 'plugins.ultisnips'
require 'plugins.gitsigns'
require 'plugins.galaxyline'
require 'plugins.hlslens'
require 'plugins.hop'

runtime 'grepper/init.vim'
