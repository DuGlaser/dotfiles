local M = {}

M.setup = function(on_attach)
	require("lspconfig").rust.setup({
		on_attach = on_attach,
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	})
end

return M
