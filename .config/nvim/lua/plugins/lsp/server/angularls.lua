local M = {}

M.setup = function()
	return {
		root_dir = require("lspconfig").util.root_pattern("angular.json"),
		filetypes = { "typescript", "html" },
	}
end

M.use_mason = true

return M
