local common = require("plugins.lsp.common")

local M = {}

M.setup = function()
	local setting = {
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			common.on_attach(client, bufnr)

			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gd", ":TypescriptGoToSourceDefinition<CR>", bufopts)
			vim.keymap.set("n", "gD", vim.lsp.buf.definition, bufopts)
		end,
	}

	require("typescript").setup({
		disable_commands = false,
		debug = false,
		go_to_source_definition = {
			fallback = true,
		},
		server = setting,
	})

	return setting
end

M.use_mason = false

return M
