local common = require("plugins.lsp.common")

return {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		common.on_attach(client, bufnr)
	end,
	capabilities = common.capabilities,
	settings = {
		Lua = {
			format = {
				enable = false,
			},
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}
