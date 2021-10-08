local M = {}

M.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

M.diagnosticsGroup = {
	err_group = {
		highlight = "LspDiagnosticsSignError",
		sign = "🔥",
	},
	warn_group = {
		highlight = "LspDiagnosticsSignWarning",
		sign = "👀",
	},
	hint_group = {
		highlight = "LspDiagnosticsSignHint",
		sign = "💡",
	},
	info_group = {
		highlight = "LspDiagnosticsSignInformation",
		sign = "ℹ️",
	},
}

return M
