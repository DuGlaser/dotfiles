local M = {}

M.setup = function()
	return vim.tbl_deep_extend("force", require("vtsls").lspconfig, {
		flags = {
			debounce_text_changes = 150,
		},
	})
end

M.use_mason = true

return M
