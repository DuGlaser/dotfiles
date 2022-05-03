local common = require("plugins.lsp.common")

return {
	on_attach = function(client, bufnr)
		vim.cmd([[autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll]])
		client.server_capabilities.document_formatting = true
		common.on_attach(client, bufnr)
	end,
	settings = {
		format = true,
	},
}
