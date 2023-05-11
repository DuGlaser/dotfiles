local M = {}

M.setup = function()
	return vim.tbl_deep_extend("force", require("vtsls").lspconfig, {
		on_attach = require("plugins.lsp.common").on_attach,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

M.use_mason = true

return M
