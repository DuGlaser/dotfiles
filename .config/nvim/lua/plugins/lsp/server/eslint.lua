local common = require("plugins.lsp.common")

local M = {}

M.setup = function()
	return {
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = true
			common.on_attach(client, bufnr)
		end,
	}
end

M.use_lspconfig = true

return M
