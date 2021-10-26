local M = {}

M.setup = function(on_attach)
	require("lspconfig").efm.setup({
		on_attach = on_attach,
		init_options = {
			documentFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			rootMarkers = { ".git/" },
			languages = {
				lua = {
					{
						formatCommand = "stylua -",
						formatStdin = true,
					},
				},
			},
		},
	})
end

return M
