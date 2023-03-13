local common = require("plugins.lsp.common")
local enable_prettier = require("plugins.lsp.server.null-ls").enable_prettier

local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.setup = function()
	return {
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = not enable_prettier
			common.on_attach(client, bufnr)
		end,
		capabilities = capabilities,
		settings = {
			yaml = {
				format = {
					enable = not enable_prettier,
				},
				schemas = require("schemastore").yaml.schemas(),
				validate = { enable = true },
			},
		},
	}
end

M.use_mason = true

return M
