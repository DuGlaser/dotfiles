local common = require("plugins.lsp.common")

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
