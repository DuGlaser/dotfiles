local common = require("plugins.lsp.common")

local M = {}

M.setup = function()
	return {
		on_attach = common.on_attach,
		capabilities = common.capabilities,
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

M.use_lspconfig = true

return M
