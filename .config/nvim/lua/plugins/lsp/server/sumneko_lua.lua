local common = require("plugins.lsp.common")

local M = {}

M.setup = function()
	return {
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			common.on_attach(client, bufnr)
		end,
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
end

M.use_mason = true

return M
