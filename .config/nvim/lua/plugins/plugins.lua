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
  -- use 'tweekmonster/startuptime.vim'

  use {'wbthomason/packer.nvim', opt = true}
  use {'lifepillar/vim-gruvbox8', opt = true}

  use 'machakann/vim-sandwich'
  use 'christoomey/vim-tmux-navigator'
  use 'rhysd/clever-f.vim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'SirVer/ultisnips'
  use 'kevinhwang91/nvim-hlslens'
  use 'tpope/vim-fugitive'
  use 'tversteeg/registers.nvim'
  use 'phaazon/hop.nvim'
  use 'brooth/far.vim'

  use {
    'tyru/columnskip.vim',
    config = function()
      vim.cmd("nmap sj <Plug>(columnskip:nonblank:next)")
      vim.cmd("omap sj <Plug>(columnskip:nonblank:next)")
      vim.cmd("xmap sj <Plug>(columnskip:nonblank:next)")
      vim.cmd("nmap sk <Plug>(columnskip:nonblank:prev)")
      vim.cmd("omap sk <Plug>(columnskip:nonblank:prev)")
      vim.cmd("xmap sk <Plug>(columnskip:nonblank:prev)")
    end
  }
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
    branch = 'main',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }


  use 'mhinz/vim-grepper'
  use 'kevinhwang91/nvim-bqf'
  use {
    'junegunn/fzf.vim', 
    requires = {
      {'junegunn/fzf', run = './install --bin'}
    },
    config = function()
      vim.cmd("nmap gf :GFiles<CR>")
    end
  }

  ----------------------------------------
  -- textobject
  ----------------------------------------
  use 'romgrk/equal.operator'

  ----------------------------------------
  -- treesitter
  ----------------------------------------
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-refactor',
    }
  }

  ----------------------------------------
  -- filer
  ----------------------------------------
  use {
    'Shougo/defx.nvim',
    run = ":UpdateRemotePlugins"
  }


  ----------------------------------------
  -- frontend
  ----------------------------------------
  use {
    'mattn/emmet-vim',
    ft = {'html', 'javascriptreact', 'typescriptreact', 'vue'}
  }

  ----------------------------------------
  -- rust
  ----------------------------------------
  use {
    'rust-lang/rust.vim',
    ft = {'rust'},
    config = function() vim.g.rustfmt_autosave = 1 end
  }

  ----------------------------------------
  -- go
  ----------------------------------------
  use {
    'rhysd/vim-go-impl',
    ft = {'go'}
  }

  ----------------------------------------
  -- graphql
  ----------------------------------------
  use {
    'jparise/vim-graphql',
    ft = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'graphql'}
  }

  ----------------------------------------
  -- markdown
  ----------------------------------------
  use {
    "iamcco/markdown-preview.nvim",
    run = ":call mkdp#util#install()",
    ft = {"markdown"},
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
    end
  }
end)

-- vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')
