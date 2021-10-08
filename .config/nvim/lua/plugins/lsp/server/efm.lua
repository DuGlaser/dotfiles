local M = {}

M.setup = function(on_attach)
	local prettierd = require("plugins.lsp.efm.prettierd")
	local eslint_d = require("plugins.lsp.efm.eslint_d")

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
				typescriptreact = { prettierd, eslint_d },
				typescript = { prettierd, eslint_d },
				javascriptreact = { prettierd, eslint_d },
				javascript = { prettierd, eslint_d },
				json = { prettierd },
				html = { prettierd },
				css = { prettierd },
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
