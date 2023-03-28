local M = {
	{
		"lifepillar/vim-gruvbox8",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("syntax enable")

			vim.o.termguicolors = true

			vim.g.gruvbox_plugin_hi_groups = 1
			vim.cmd("colorscheme gruvbox8_soft")
		end,
	},
	"tpope/vim-repeat",
	"mbbill/undotree",
	{
		"kana/vim-operator-replace",
		dependencies = {
			{ "kana/vim-operator-user" },
		},
		keys = {
			{ "<Space>s", "<Plug>(operator-replace)", mode = { "n", "o", "v" } },
		},
	},
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		dependencies = {
			"junegunn/fzf.vim",
			dependencies = {
				{ "junegunn/fzf", build = "./install --bin" },
			},
		},
	},
	{
		"tyru/columnskip.vim",
		keys = {
			{ "sj", "<Plug>(columnskip:nonblank:next)", mode = { "n", "o", "x" } },
			{ "sk", "<Plug>(columnskip:nonblank:prev)", mode = { "n", "o", "x" } },
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
		event = "BufReadPre",
	},
	{
		"thinca/vim-zenspace",
		config = function()
			vim.cmd("let g:zenspace#default_mode = 'on'")
		end,
		event = "BufReadPre",
	},
	{
		"levouh/tint.nvim",
		event = "VeryLazy",
		config = function()
			require("tint").setup()
		end,
	},
	{
		"chrisbra/Recover.vim",
	},
	{
		"kana/vim-textobj-user",
		event = "VeryLazy",
	},
	{
		"romgrk/equal.operator",
		event = "VeryLazy",
	},
	{
		"mattn/emmet-vim",
		ft = { "html", "javascriptreact", "typescriptreact", "vue" },
	},
	----------------------------------------
	-- rust
	----------------------------------------
	{
		"rust-lang/rust.vim",
		ft = { "rust" },
		config = function()
			vim.g.rustfmt_autosave = 1
		end,
	},

	----------------------------------------
	-- go
	----------------------------------------
	{
		"rhysd/vim-go-impl",
		ft = { "go" },
	},

	----------------------------------------
	-- graphql
	----------------------------------------
	{
		"jparise/vim-graphql",
		ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "graphql" },
	},

	----------------------------------------
	-- markdown
	----------------------------------------
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_auto_close = 0
		end,
	},
}

return M
