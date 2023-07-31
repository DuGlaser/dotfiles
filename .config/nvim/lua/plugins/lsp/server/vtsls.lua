local M = {}

local vtsls_settings = {
	preferences = {
		importModuleSpecifier = "relative",
	},
}

M.setup = function()
	return vim.tbl_deep_extend("force", require("vtsls").lspconfig, {
		flags = {
			debounce_text_changes = 150,
		},
		settings = {
			javascript = vtsls_settings,
			typescript = vtsls_settings,
		},
	})
end

M.use_mason = true

return M
