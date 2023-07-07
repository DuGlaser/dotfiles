local M = {}

M.setup = function()
	return {
		root_dir = require("lspconfig").util.root_pattern("angular.json"),
	}
end

M.use_mason = true

return M
