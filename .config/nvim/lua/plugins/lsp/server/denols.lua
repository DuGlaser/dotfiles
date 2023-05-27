local M = {}

M.setup = function()
	return {
		root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
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
end

M.use_mason = true

return M
