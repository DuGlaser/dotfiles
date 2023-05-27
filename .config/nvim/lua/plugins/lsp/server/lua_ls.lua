local M = {}

M.setup = function()
	require("neodev").setup({})

	return {
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
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
