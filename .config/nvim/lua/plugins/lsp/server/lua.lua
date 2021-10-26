local common = require("plugins.lsp.common")

return require("lua-dev").setup({
	lspconfig = {
		on_attach = common.on_attach,
		collectgarbage = common.capabilities,
	},
})
