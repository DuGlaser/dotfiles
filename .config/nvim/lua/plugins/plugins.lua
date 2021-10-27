---@diagnostic disable: undefined-global
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
	if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
		return
	end

	local execute = vim.api.nvim_command
	local fn = vim.fn

	local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute("packadd packer.nvim")

	return
end

local plugins = function()
	use("tweekmonster/startuptime.vim")

	use({ "wbthomason/packer.nvim", opt = true })
	use({
		"lewis6991/impatient.nvim",
		rocks = "mpack",
	})

	use({ "lifepillar/vim-gruvbox8", opt = true })

	use("christoomey/vim-tmux-navigator")
	use("rhysd/clever-f.vim")
	use("tpope/vim-repeat")
	use("tpope/vim-commentary")
	use("moll/vim-bbye")
	use("kamykn/spelunker.vim")

	use({
		"machakann/vim-sandwich",
		config = [[require("plugins.sandwich")]],
	})
	use({
		"SirVer/ultisnips",
		config = [[require("plugins.ultisnips")]],
	})
	use({
		"phaazon/hop.nvim",
		config = [[require('plugins.hop')]],
	})
	use({
		"kevinhwang91/nvim-hlslens",
		config = [[require("plugins.hlslens")]],
	})
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
			require("nvim-autopairs.completion.cmp").setup({
				map_cr = true,
				map_complete = true,
				auto_select = true,
				insert = false,
				map_char = {
					all = "(",
					tex = "{",
				},
			})
		end,
		opt = true,
		after = "nvim-cmp",
	})
	use({
		"lewis6991/gitsigns.nvim",
		config = [[require("plugins.gitsign")]],
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	use({
		"brooth/far.vim",
		config = function()
			vim.cmd('let g:far#source="rg"')
		end,
	})
	use({
		"t9md/vim-choosewin",
		config = function()
			vim.cmd([[
      nmap  -  <Plug>(choosewin)
      ]])
		end,
	})
	use({
		"mbbill/undotree",
		config = function()
			vim.cmd("nmap <Space>u :UndotreeToggle<cr>")
		end,
	})
	use({
		"tyru/columnskip.vim",
		config = function()
			vim.cmd("nmap sj <Plug>(columnskip:nonblank:next)")
			vim.cmd("omap sj <Plug>(columnskip:nonblank:next)")
			vim.cmd("xmap sj <Plug>(columnskip:nonblank:next)")
			vim.cmd("nmap sk <Plug>(columnskip:nonblank:prev)")
			vim.cmd("omap sk <Plug>(columnskip:nonblank:prev)")
			vim.cmd("xmap sk <Plug>(columnskip:nonblank:prev)")
		end,
	})
	use({
		"akinsho/nvim-bufferline.lua",
		config = [[require("plugins.bufferline")]],
		requires = {
			{ "kyazdani42/nvim-web-devicons" },
		},
	})
	use({
		"kana/vim-operator-replace",
		requires = {
			{ "kana/vim-operator-user" },
		},
		config = function()
			vim.cmd("map <Space>s <Plug>(operator-replace)")
		end,
	})
	use({
		"itchyny/vim-parenmatch",
		config = function()
			vim.g.loaded_matchparen = 1
		end,
	})
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})
	use({
		"thinca/vim-zenspace",
		config = function()
			vim.cmd("let g:zenspace#default_mode = 'on'")
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = [[require("plugins.lualine")]],
	})

	use({
		"mhinz/vim-grepper",
		config = [[require("plugins.grepper")]],
	})
	use("kevinhwang91/nvim-bqf")
	use({
		"junegunn/fzf.vim",
		requires = {
			{ "junegunn/fzf", run = "./install --bin" },
		},
		config = function()
			vim.cmd([[
        let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
        nmap  <Space>F  :FZF<CR>
      ]])
		end,
	})

	----------------------------------------
	-- textobject
	----------------------------------------
	use("romgrk/equal.operator")

	----------------------------------------
	-- treesitter
	----------------------------------------
	use({
		"nvim-treesitter/nvim-treesitter",
		config = [[require("plugins.treesitter")]],
		requires = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-refactor",
			"windwp/nvim-ts-autotag",
		},
	})

	----------------------------------------
	-- filer
	----------------------------------------
	use({
		"Shougo/defx.nvim",
		run = ":UpdateRemotePlugins",
		config = [[require("plugins.defx")]],
	})

	----------------------------------------
	-- frontend
	----------------------------------------
	use({
		"mattn/emmet-vim",
		ft = { "html", "javascriptreact", "typescriptreact", "vue" },
	})

	----------------------------------------
	-- rust
	----------------------------------------
	use({
		"rust-lang/rust.vim",
		ft = { "rust" },
		config = function()
			vim.g.rustfmt_autosave = 1
		end,
	})

	----------------------------------------
	-- go
	----------------------------------------
	use({
		"rhysd/vim-go-impl",
		ft = { "go" },
	})

	----------------------------------------
	-- graphql
	----------------------------------------
	use({
		"jparise/vim-graphql",
		ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "graphql" },
	})

	----------------------------------------
	-- markdown
	----------------------------------------
	use({
		"iamcco/markdown-preview.nvim",
		run = ":call mkdp#util#install()",
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_auto_close = 1
		end,
	})

	----------------------------------------
	-- lsp utils
	----------------------------------------
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use({
		"ray-x/lsp_signature.nvim",
		after = "nvim-cmp",
		config = [[require("plugins.lsp.signature")]],
	})
	use("tami5/lspsaga.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	use("folke/lua-dev.nvim")

	----------------------------------------
	-- lsp
	----------------------------------------
	use({
		"neovim/nvim-lspconfig",
		config = [[require("plugins.lsp")]],
	})
	use("williamboman/nvim-lsp-installer")
	use({
		"hrsh7th/nvim-cmp",
		commit = "e699962a49490c8a7ca2426386467ba118d0a94f",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "quangnguyen30192/cmp-nvim-ultisnips", after = "nvim-cmp" },
		},
		config = [[require("plugins.lsp.nvim-cmp")]],
		event = "InsertEnter *",
	})
end

return require("packer").startup({
	plugins,
	config = {
		compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
	},
})
