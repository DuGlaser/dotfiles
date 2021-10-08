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

return M
