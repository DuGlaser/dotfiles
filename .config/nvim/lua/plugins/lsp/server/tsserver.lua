local common = require("plugins.lsp.common")

return {
	init_options = require("nvim-lsp-ts-utils").init_options,
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		common.on_attach(client, bufnr)

		local ts_utils = require("nvim-lsp-ts-utils")

		-- defaults
		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = false,

			import_all_scan_buffers = 100,
			import_all_select_source = false,

			-- filter diagnostics
			filter_out_diagnostics_by_severity = {},
			filter_out_diagnostics_by_code = {},

			-- inlay hints
			auto_inlay_hints = false,
			inlay_hints_highlight = "Comment",

			-- update imports on file move
			update_imports_on_move = false,
			require_confirmation_on_move = false,
			watch_dir = nil,
		})

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)
	end,
	capabilities = common.capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}
