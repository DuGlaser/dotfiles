local M = {}

M.setup = function(on_attach)
	require("lspconfig").typescript.setup({
		on_attach = function(client, buffer)
			on_attach(client, buffer)

			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false

			local ts_utils = require("nvim-lsp-ts-utils")

			ts_utils.setup({
				debug = false,
				disable_commands = false,
				enable_import_on_completion = false,

				import_all_timeout = 5000,
				import_all_priorities = {
					buffers = 4,
					buffer_content = 3,
					local_files = 2,
					same_file = 1,
				},
				import_all_scan_buffers = 100,
				import_all_select_source = false,

				eslint_enable_code_actions = true,
				eslint_enable_disable_comments = true,
				eslint_bin = "eslint_d",
				eslint_enable_diagnostics = false,
				eslint_opts = {},

				enable_formatting = false,

				update_imports_on_move = false,
				require_confirmation_on_move = false,
				watch_dir = nil,

				filter_out_diagnostics_by_severity = {},
				filter_out_diagnostics_by_code = {},
			})

			ts_utils.setup_client(client)
		end,
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	})
end

return M
