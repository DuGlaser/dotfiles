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
	-- use("tweekmonster/startuptime.vim")

	use({ "wbthomason/packer.nvim", event = "VimEnter", opt = true })
	use({ "lifepillar/vim-gruvbox8", opt = true })
	use({
		"lewis6991/impatient.nvim",
		config = [[require("impatient")]],
	})
	use({
		"antoinemadec/FixCursorHold.nvim",
		config = function()
			vim.g.cursorhold_updatetime = 100
		end,
	})
	use({
		"MattesGroeger/vim-bookmarks",
		config = [[require("plugins.bookmarks")]],
	})
	use({
		"aserowy/tmux.nvim",
		config = [[require("plugins.tmux")]],
	})
	use({ "tpope/vim-repeat" })
	use({
		"tpope/vim-commentary",
		event = "BufRead",
	})
	use({
		"moll/vim-bbye",
		event = "BufRead",
	})
	use({
		"machakann/vim-sandwich",
		config = [[require("plugins.sandwich")]],
	})
	use({
		"hrsh7th/vim-vsnip",
		config = [[require("plugins.vsnip")]],
		requires = {
			"hrsh7th/vim-vsnip-integ",
		},
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
		"lewis6991/gitsigns.nvim",
		config = [[require("plugins.gitsign")]],
		event = "BufRead",
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
		config = [[require("plugins.choosewin")]],
	})
	use({
		"mbbill/undotree",
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
		config = [[require("colorizer").setup()]],
		event = "BufRead",
	})
	use({
		"thinca/vim-zenspace",
		config = function()
			vim.cmd("let g:zenspace#default_mode = 'on'")
		end,
		event = "BufRead",
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = [[require("plugins.lualine")]],
	})

	use({ "kevinhwang91/nvim-bqf", ft = "qf" })
	use({
		"junegunn/fzf.vim",
		requires = {
			{ "junegunn/fzf", run = "./install --bin" },
		},
	})

	----------------------------------------
	-- textobject
	----------------------------------------
	use("kana/vim-textobj-user")
	use("romgrk/equal.operator")

	----------------------------------------
	-- treesitter
	----------------------------------------
	use({
		"nvim-treesitter/nvim-treesitter",
		config = [[require("plugins.treesitter")]],
		requires = {
			{ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
			{ "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
		},
	})

	----------------------------------------
	-- filer
	----------------------------------------
	use({
		"lambdalisue/fern.vim",
		config = [[require("plugins.fern")]],
		requires = {
			"hrsh7th/fern-mapping-collapse-or-leave.vim",
		},
	})

	----------------------------------------
	-- telescope
	----------------------------------------
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
		config = [[require("plugins.telescope")]],
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
	use("jose-elias-alvarez/null-ls.nvim")
	use("folke/neodev.nvim")
	use("simrat39/rust-tools.nvim")
	-- use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("b0o/schemastore.nvim")
	use("j-hui/fidget.nvim")
	use("ray-x/lsp_signature.nvim")

	----------------------------------------
	-- lsp
	----------------------------------------
	use({
		"neovim/nvim-lspconfig",
		config = [[require("plugins.lsp")]],
	})
	use({
		"williamboman/mason.nvim",
		requires = {
			"williamboman/mason-lspconfig.nvim",
		},
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind.nvim",
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
		},
		config = [[require("plugins.lsp.nvim-cmp")]],
	})
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
			})
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
		after = "nvim-cmp",
	})
	use("jose-elias-alvarez/typescript.nvim")
end

local packer = require("packer")

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
		prompt_border = "single",
	},
	git = {
		clone_timeout = 800,
	},
	compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
	auto_clean = true,
	compile_on_sync = true,
})

return require("packer").startup(plugins)
