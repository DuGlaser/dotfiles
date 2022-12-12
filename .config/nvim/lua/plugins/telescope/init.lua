local M = {}

M.setup = function(use)
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		module = { "telescope" },
		requires = {
			{ "nvim-lua/plenary.nvim", opt = true },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
			{ "nvim-telescope/telescope-live-grep-args.nvim", opt = true },
		},
		wants = {
			"telescope-fzf-native.nvim",
			"telescope-live-grep-args.nvim",
		},
		setup = [[require("plugins.telescope.setup")]],
		config = [[require("plugins.telescope.config")]],
	})
end

return M
