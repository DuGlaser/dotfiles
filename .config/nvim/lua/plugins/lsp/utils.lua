local M = {}

M.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

M.diagnosticsGroup = {
	err_group = {
		type = "Error",
		color = "Red",
		highlight = "DiagnosticSignError",
		sign = "🔥",
	},
	warn_group = {
		type = "Warn",
		color = "Orange",
		highlight = "DiagnosticSignWarn",
		sign = "👀",
	},
	hint_group = {
		type = "Hint",
		color = "LightGrey",
		highlight = "DiagnosticSignHint",
		sign = "💡",
	},
	info_group = {
		type = "Info",
		color = "LightBlue",
		highlight = "DiagnosticSignInfo",
		sign = "💬",
	},
}

return M
