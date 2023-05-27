local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.setup = function()
  local enable_prettier = require("plugins.lsp.server.null-ls").enable_prettier()

	return {
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = not enable_prettier
		end,
		capabilities = capabilities,
		settings = {
			json = {
				format = {
					enable = not enable_prettier,
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
