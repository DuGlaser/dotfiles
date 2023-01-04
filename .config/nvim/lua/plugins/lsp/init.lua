local M = {
	"jose-elias-alvarez/null-ls.nvim",
	{ "simrat39/rust-tools.nvim", ft = "rust" },
	"b0o/schemastore.nvim",
	"j-hui/fidget.nvim",
	"jose-elias-alvarez/typescript.nvim",
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
		dependencies = {
			{ "folke/neodev.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
		},
	},
}

return M
