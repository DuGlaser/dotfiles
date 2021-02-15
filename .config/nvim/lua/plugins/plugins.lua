local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local execute = vim.api.nvim_command
  local fn = vim.fn

  local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'

  return
end

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use {'gruvbox-community/gruvbox', opt = true}

  use 'machakann/vim-sandwich'
  use 'christoomey/vim-tmux-navigator'
  use 'romgrk/equal.operator'
  use 'rhysd/clever-f.vim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'SirVer/ultisnips'
  use 'lambdalisue/gina.vim'
  use 'kevinhwang91/nvim-hlslens'
  use 'mattn/emmet-vim'
  use 'tpope/vim-fugitive'
  use 'liuchengxu/vim-clap'

  use {
    'neoclide/coc.nvim', 
    run = 'yarn install --frozen-lockfile'
  }
  use {
    'akinsho/nvim-bufferline.lua',
    requires = {
      {'kyazdani42/nvim-web-devicons'},
    }
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  }
  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup() end
  }
  use {
    'kana/vim-operator-replace',
    requires = {
      {'kana/vim-operator-user'}
    },
    config = function() vim.cmd('map <Space>s <Plug>(operator-replace)') end
  }
  use {
    't9md/vim-choosewin',
    config = function() vim.cmd('nmap  -  <Plug>(choosewin)') end
  }
  use {
    'itchyny/vim-parenmatch',
    config = function() vim.g.loaded_matchparen = 1 end
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require'colorizer'.setup() end
  }
  use {
    'thinca/vim-zenspace',
    config = function() vim.cmd("let g:zenspace#default_mode = 'on'") end
  }
  use {
    'machakann/vim-highlightedyank',
    config = function() vim.g.highlightedyank_highlight_duration = 200 end
  }
  use {
    'glepnir/galaxyline.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  -- treesitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-refactor'

  -- fern
  use 'lambdalisue/fern.vim'
  use 'lambdalisue/fern-hijack.vim'
  use 'hrsh7th/fern-mapping-collapse-or-leave.vim'
  use {
    'lambdalisue/fern-renderer-nerdfont.vim',
    requires = {
      'lambdalisue/nerdfont.vim',
      'lambdalisue/glyph-palette.vim'
    }
  }

  -- js
  use {
    'MaxMEllon/vim-jsx-pretty',
    ft = {'typescriptreact', 'javascriptreact', 'typescript.tsx', 'javascript.jsx'},
    config = function() vim.g.vim_jsx_pretty_enable_jsx_highlight = 0 end
  }

  -- rust
  use {
    'rust-lang/rust.vim',
    ft = {'rust'},
    config = function() vim.g.rustfmt_autosave = 1 end
  }

  -- go
  use {
    'rhysd/vim-go-impl',
    ft = {'go'}
  }
end)

-- vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')
