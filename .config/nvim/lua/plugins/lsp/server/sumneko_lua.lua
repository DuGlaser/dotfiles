local common = require("plugins.lsp.common")

return {
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = true
		common.on_attach(client, bufnr)
	end,
	capabilities = common.capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}
