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

return M
