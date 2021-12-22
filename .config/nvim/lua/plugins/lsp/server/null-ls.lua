local null_ls = require("null-ls")
local b = null_ls.builtins
local sources = {
	b.formatting.prettier.with({
		condition = function(utils)
			return utils.root_has_file({ ".prettierrc", ".prettierrc.js", ".prettierrc.json" })
		end,
	}),
	b.formatting.stylua,
}

local M = {}

local common = require("plugins.lsp.common")

M.setup = function()
	null_ls.setup({
		sources = sources,
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = true
			common.on_attach(client, bufnr)
		end,
	})
end

return M
