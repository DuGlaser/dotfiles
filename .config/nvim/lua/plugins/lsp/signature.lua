local border = require("plugins.lsp.utils").border

require("lsp_signature").on_attach({
	bind = true,
	hint_enable = true,
	hint_prefix = "🤔 ",
	handler_opts = {
		border = border,
	},
})
