local common = require("plugins.lsp.common")
local nvim_lsp = require("lspconfig")

local M = {}

M.setup = function()
	return {
		on_attach = common.on_attach,
		root_dir = nvim_lsp.util.root_pattern("angular.json"),
		filetypes = { "typescript", "html" },
	}
end

M.use_mason = true

return M
