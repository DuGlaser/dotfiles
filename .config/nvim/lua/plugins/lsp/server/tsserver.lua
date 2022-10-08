local common = require("plugins.lsp.common")

return {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false

		require("typescript").setup({
			disable_commands = false,
			debug = false,
			go_to_source_definition = {
				fallback = true,
			},
			server = {
				on_attach = common.on_attach(client, bufnr),
			},
		})

		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gd", ":TypescriptGoToSourceDefinition<CR>", bufopts)
		vim.keymap.set("n", "gD", vim.lsp.buf.definition, bufopts)
	end,
	capabilities = common.capabilities,
}
