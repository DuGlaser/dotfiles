local common = require("plugins.lsp.common")
local nvim_lsp = require("lspconfig")

return {
	on_attach = common.on_attach,
	capabilities = common.capabilities,
	root_dir = nvim_lsp.util.root_pattern("angular.json"),
	flags = {
		debounce_text_changes = 150,
	},
	filetypes = { "typescript", "html" },
}
