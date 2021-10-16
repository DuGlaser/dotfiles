local common = require("plugins.lsp.common")

return {
	on_attach = function(client, buffer)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false

		common.on_attach(client, buffer)
	end,
	capabilities = common.capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}
