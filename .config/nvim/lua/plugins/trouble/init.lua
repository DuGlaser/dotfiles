local M = {}

M.setup = function(use)
	use({
		"folke/trouble.nvim",
		module = { "trouble" },
		requires = "kyazdani42/nvim-web-devicons",
		setup = [[require("plugins.trouble.setup")]],
		config = function()
			require("trouble").setup({})
		end,
	})
end

return M
