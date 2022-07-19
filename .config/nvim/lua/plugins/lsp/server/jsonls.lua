local common = require("plugins.lsp.common")
local enable_prettier = require("plugins.lsp.server.null-ls").enable_prettier

return {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = not enable_prettier
		common.on_attach(client, bufnr)
	end,
	capabilities = common.capabilities,
	settings = {
		json = {
			format = {
				enable = not enable_prettier,
			},
			schemas = require("schemastore").json.schemas(),
		},
	},
}
