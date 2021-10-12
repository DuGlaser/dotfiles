local M = {}

local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
	b.formatting.prettierd.with({
		filetypes = { "typescriptreact", "typescript", "javascriptreact", "javascript", "html", "css", "json" },
		condition = function(utils)
			return utils.root_has_file(".prettierrc")
				or utils.root_has_file(".prettierrc.js")
				or utils.root_has_file(".prettierrc.json")
		end,
	}),
	b.diagnostics.write_good,
	b.diagnostics.markdownlint,
	b.diagnostics.teal,
	b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
}

M.setup = function(on_attach)
	require("lspconfig").typescript.setup({
		on_attach = function(client, buffer)
			on_attach(client, buffer)

			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false

			local ts_utils = require("nvim-lsp-ts-utils")

			ts_utils.setup({
				enable_import_on_completion = true,
				import_all_scan_buffers = 100,
				eslint_bin = "eslint_d",
				eslint_enable_diagnostics = true,
				eslint_opts = {
					condition = function(utils)
						return utils.root_has_file(".eslintrc.js")
							or utils.root_has_file(".eslintrc")
							or utils.root_has_file(".eslintrc.json")
					end,
					diagnostics_format = "#{m} [#{c}]",
				},
				enable_formatting = true,
				formatter = "eslint_d",
				update_imports_on_move = true,
				filter_out_diagnostics_by_code = { 80001 },
			})

			ts_utils.setup_client(client)
		end,
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	})

	null_ls.setup({
		sources = sources,
	})
	require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
end

return M
