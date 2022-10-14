local common = require("plugins.lsp.common")

local M = {}

M.setup = function()
	return {
		on_attach = function(client, bufnr)
			vim.cmd([[autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll]])
			client.server_capabilities.documentFormattingProvider = true
			common.on_attach(client, bufnr)
		end,
		settings = {
			format = true,
		},
	}
end

M.use_lspconfig = true

return M
