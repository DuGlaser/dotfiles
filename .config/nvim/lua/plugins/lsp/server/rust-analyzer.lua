local M = {}

M.setup = function()
	return {
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy",
				},
				diagnostics = {
					disabled = { "macro-error" },
				},
			},
		},
	}
end

M.use_mason = true

return M
