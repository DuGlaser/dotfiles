local M = {}

M.setup = function(use)
	use({
		"hrsh7th/nvim-cmp",
		module = { "cmp" },
		requires = {
			{ "hrsh7th/cmp-nvim-lsp", event = { "InsertEnter" } },
			{ "onsails/lspkind.nvim", module = { "lspkind" } },
			{ "hrsh7th/cmp-buffer", event = { "InsertEnter" } },
			{ "hrsh7th/cmp-nvim-lua", ft = "lua" },
			{ "hrsh7th/cmp-path", event = { "InsertEnter" } },
			{
				"hrsh7th/cmp-vsnip",
				event = { "InsertEnter" },
				requires = {
					"hrsh7th/vim-vsnip",
					config = [[require("plugins.vsnip")]],
					after = "nvim-cmp",
				},
			},
			{
				"windwp/nvim-autopairs",
				event = { "InsertEnter" },
				config = function()
					require("nvim-autopairs").setup({
						check_ts = true,
					})
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					local cmp = require("cmp")
					cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
		},
		config = [[require("plugins.cmp.config")]],
		setup = [[require("plugins.cmp.setup")]],
	})
end

return M
