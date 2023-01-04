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
	{
		"moll/vim-bbye",
		event = "BufRead",
	},
	{
		"tpope/vim-commentary",
		event = "BufRead",
	},
	"mbbill/undotree",
	{
		"kana/vim-operator-replace",
		dependencies = {
			{ "kana/vim-operator-user" },
		},
		config = function()
			vim.cmd("map <Space>s <Plug>(operator-replace)")
		end,
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
		config = function()
			vim.cmd("nmap sj <Plug>(columnskip:nonblank:next)")
			vim.cmd("omap sj <Plug>(columnskip:nonblank:next)")
			vim.cmd("xmap sj <Plug>(columnskip:nonblank:next)")
			vim.cmd("nmap sk <Plug>(columnskip:nonblank:prev)")
			vim.cmd("omap sk <Plug>(columnskip:nonblank:prev)")
			vim.cmd("xmap sk <Plug>(columnskip:nonblank:prev)")
		end,
	},
	{
		"kana/vim-operator-replace",
		dependencies = {
			{ "kana/vim-operator-user" },
		},
		config = function()
			vim.cmd("map <Space>s <Plug>(operator-replace)")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
		event = "BufRead",
	},
	{
		"thinca/vim-zenspace",
		config = function()
			vim.cmd("let g:zenspace#default_mode = 'on'")
		end,
		event = "BufRead",
	},
	{
		"levouh/tint.nvim",
		config = function()
			require("tint").setup()
		end,
	},
	"kana/vim-textobj-user",
	"romgrk/equal.operator",
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
		build = ":call mkdp#util#install()",
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_auto_close = 1
		end,
	},
}

return M
