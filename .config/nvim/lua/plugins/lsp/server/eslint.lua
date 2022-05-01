local common = require("plugins.lsp.common")

return {
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = true
		common.on_attach(client, bufnr)
	end,
	settings = {
		format = { enable = true },
	},
}
