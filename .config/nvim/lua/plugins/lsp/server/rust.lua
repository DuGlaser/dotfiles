local common = require("plugins.lsp.common")

return {
	on_attach = common.on_attach,
	capabilities = common.capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}
