local common = require("plugins.lsp.common")

return {
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		common.on_attach(client, bufnr)
	end,
	capabilities = common.capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		Lua = {
			format = {
				enable = false,
			},
		},
	},
}
