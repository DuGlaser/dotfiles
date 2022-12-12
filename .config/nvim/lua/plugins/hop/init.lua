local M = {}

M.setup = function(use)
	use({
		"phaazon/hop.nvim",
		module = { "hop" },
		setup = [[require('plugins.hop.setup')]],
		config = [[require('plugins.hop.config')]],
	})
end

return M
