local common = require("plugins.lsp.common")
local nvim_lsp = require("lspconfig")

return {
	on_attach = common.on_attach,
	capabilities = common.capabilities,
	root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
	flags = {
		debounce_text_changes = 150,
	},
	single_file_support = false,
	init_options = {
		lint = true,
		unstable = true,
		suggest = {
			imports = {
				hosts = {
					["https://deno.land"] = true,
					["https://cdn.nest.land"] = true,
					["https://crux.land"] = true,
				},
			},
		},
	},
}
