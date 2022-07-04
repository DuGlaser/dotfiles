local M = {}

local utils = require("plugins.lsp.utils")

vim.diagnostic.open_float = (function(orig)
	return function(bufnr, opts)
		local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
		--- @diagnostic disable-next-line: redefined-local
		local opts = opts or {}
		local diagnostics = vim.diagnostic.get(opts.bufnr or 0, { lnum = lnum })
		local max_severity = vim.diagnostic.severity.HINT
		for _, d in ipairs(diagnostics) do
			if d.severity < max_severity then
				max_severity = d.severity
			end
		end
		local border_color = ({
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
			[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
			[vim.diagnostic.severity.ERROR] = "DiagnosticError",
		})[max_severity]

		local coloredBorder = {}
		for _, value in ipairs(utils.border) do
			table.insert(coloredBorder, { value, border_color })
		end

		opts.border = coloredBorder
		orig(bufnr, opts)
	end
end)(vim.diagnostic.open_float)

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

M.on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)

	if client.server_capabilities.documentFormattingProvider then
		vim.cmd([[
      augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ timeout_ms = 1000 })
      augroup END
    ]])
	end

	local border = utils.border
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = border,
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = border,
	})

	-- NOTE: same textDocument/publishDiagnostics
	vim.diagnostic.config({
		underline = true,
		update_in_insert = true,
		virtual_text = { spacing = 4, prefix = "●" },
		severity_sort = true,
		float = {
			source = "always",
		},
	})
end

M.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

return M
