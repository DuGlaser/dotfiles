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
	require("plugins.hop").setup(use)
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
		opt = true,
		cmd = { "Far" },
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

	use({
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		requires = {
			"junegunn/fzf.vim",
			requires = {
				{ "junegunn/fzf", run = "./install --bin" },
			},
		},
	})
	use({
		"levouh/tint.nvim",
		config = function()
			require("tint").setup()
		end,
	})
	use({
		"RRethy/vim-illuminate",
		config = [[require("plugins.illuminate")]],
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
	require("plugins.telescope").setup(use)

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
	require("plugins.trouble").setup(use)
	use("jose-elias-alvarez/null-ls.nvim")
	use("simrat39/rust-tools.nvim")
	use("b0o/schemastore.nvim")
	use("j-hui/fidget.nvim")
	use("jose-elias-alvarez/typescript.nvim")
	use({
		"ray-x/lsp_signature.nvim",
		event = { "InsertEnter" },
		config = function()
			require("lsp_signature").setup({
				floating_window = false,
				hint_prefix = "🤔 ",
			})
		end,
	})

	----------------------------------------
	-- lsp
	----------------------------------------
	use({
		"neovim/nvim-lspconfig",
		config = [[require("plugins.lsp")]],
		requires = {
			{ "folke/neodev.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
		},
	})

	require("plugins.cmp").setup(use)
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
