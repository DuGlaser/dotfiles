local null_ls = require("null-ls")
local b = null_ls.builtins

local M = {}

local common = require("plugins.lsp.common")

M.prettier_setting_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" }

local sources = {
	b.formatting.prettierd.with({
		condition = function(utils)
			return utils.root_has_file(M.prettier_setting_files)
		end,
	}),
	b.formatting.stylua,
}

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
