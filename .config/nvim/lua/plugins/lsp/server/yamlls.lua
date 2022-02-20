local common = require("plugins.lsp.common")
local utils = require("null-ls.utils").make_conditional_utils()
local setting_file_list = require("plugins.lsp.server.null-ls").prettier_setting_files

return {
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = not utils.root_has_file(setting_file_list)
		common.on_attach(client, bufnr)
	end,
	capabilities = common.capabilities,
	settings = {
		json = {
			format = {
				enable = false,
			},
			schemas = require("schemastore").json.schemas(),
		},
	},
}
