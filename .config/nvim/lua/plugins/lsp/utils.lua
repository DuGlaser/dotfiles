local M = {}

M.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

M.diagnosticsGroup = {
	err_group = {
		highlight = "DiagnosticSignError",
		sign = "🔥",
	},
	warn_group = {
		highlight = "DiagnosticSignWarn",
		sign = "👀",
	},
	hint_group = {
		highlight = "DiagnosticSignHint",
		sign = "💡",
	},
	info_group = {
		highlight = "DiagnosticSignInfo",
		sign = "ℹ️",
	},
}

M.formatWithEfm = function(client)
	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_exec(
			[[
           augroup LspFormatOnSave
               autocmd! * <buffer>
               autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_seq_sync(nil, 10000, {"efm"})
           augroup END
      ]],
			false
		)
	end
end

return M
