local M = {
	{
		"ray-x/lsp_signature.nvim",
		event = { "InsertEnter" },
		config = function()
			require("lsp_signature").setup({
				floating_window = false,
				hint_prefix = "🤔 ",
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lsp.lsp")
		end,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neodev.nvim" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "simrat39/rust-tools.nvim", ft = "rust" },
			{ "b0o/schemastore.nvim" },
			{ "j-hui/fidget.nvim" },
			{ "jose-elias-alvarez/typescript.nvim" },
			{
				"hrsh7th/cmp-nvim-lsp",
				cond = function()
					return require("lazy.core.config").plugins["nvim-cmp"]
				end,
			},
		},
	},
}

return M
