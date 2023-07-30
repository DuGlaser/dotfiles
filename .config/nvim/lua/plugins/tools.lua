local M = {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				contrast = "soft",
			})

			vim.cmd("syntax enable")

			vim.o.termguicolors = true
			vim.o.background = "dark"

			vim.cmd("colorscheme gruvbox")

			-- setup floating window color
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#32302f" })
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#fe8019" })

			-- setup DiagnosticUnderline color
			local diagnosticsGroup = require("plugins.lsp.utils").diagnosticsGroup
			for _, g in pairs(diagnosticsGroup) do
				vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. g.type, {
					undercurl = true,
					sp = g.color,
				})
				vim.fn.sign_define(g.highlight, {
					text = g.sign,
					texthl = g.highlight,
				})
			end
		end,
	},
	"tpope/vim-repeat",
	"mbbill/undotree",
	"brooth/far.vim",
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
	{
		"lewis6991/satellite.nvim",
		config = function()
			require("satellite").setup({
				winblend = 20,
			})
		end,
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
