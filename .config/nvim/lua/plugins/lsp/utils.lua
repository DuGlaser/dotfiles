local M = {}

M.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

M.colors = {
	error = "Red",
	warn = "Orange",
	hint = "LightGrey",
	info = "LightBlue",
}

M.diagnosticsGroup = {
	err_group = {
		type = "Error",
		color = M.colors.error,
		highlight = "DiagnosticSignError",
		sign = "🔥",
	},
	warn_group = {
		type = "Warn",
		color = M.colors.warn,
		highlight = "DiagnosticSignWarn",
		sign = "👀",
	},
	hint_group = {
		type = "Hint",
		color = M.colors.hint,
		highlight = "DiagnosticSignHint",
		sign = "💡",
	},
	info_group = {
		type = "Info",
		color = M.colors.info,
		highlight = "DiagnosticSignInfo",
		sign = "💬",
	},
}

M.lsp = {}

M.lsp.default_opts = {
	setup = function()
		return {
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
			end,
			flags = {
				debounce_text_changes = 150,
			},
		}
	end,
	use_mason = true,
}

M.lsp.enable_format_opts = {
	setup = function()
		return {
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = true
			end,
			flags = {
				debounce_text_changes = 150,
			},
		}
	end,
	use_mason = true,
}

M.lsp.disable_mason_setting = function(setting)
	return vim.tbl_extend("force", setting, {
		use_mason = false,
	})
end

M.lsp.get_mason_server_key = function(tab)
	local keyset = {}
	for key, value in pairs(tab) do
		if value.use_mason then
			keyset[#keyset + 1] = key
		end
	end

	return keyset
end

M.lsp.apply_filter = function(setting)
	local filter = require("plugins.lsp.filter")
	return vim.tbl_deep_extend("force", setting, {
		on_attach = function(client, bufnr)
			setting.on_attach(client, bufnr)
			require("duglaser.utils").set_timeout(function()
				filter.apply({ client = client, bufnr = bufnr })
			end, 2500)
		end,
	})
end

M.lsp.apply_capabilities = function(setting)
	local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if ok then
		setting.capabilities =
			cmp_nvim_lsp.default_capabilities(setting.capabilities or vim.lsp.protocol.make_client_capabilities())
	end
	return setting
end

return M
