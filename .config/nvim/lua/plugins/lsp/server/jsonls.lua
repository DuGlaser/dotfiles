local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.setup = function()
	return {
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = true
		end,
		capabilities = capabilities,
		settings = {
			json = {
				format = {
					enable = true,
				},
				schemas = require("schemastore").json.schemas(),
				completion = true,
				hover = true,
				validate = true,
			},
		},
	}
end

M.use_mason = true

return M
