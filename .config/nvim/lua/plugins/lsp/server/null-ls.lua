local null_ls = require("null-ls")
local b = null_ls.builtins
local utils = require("null-ls.utils").make_conditional_utils()

local M = {}

local common = require("plugins.lsp.common")

M.prettier_setting_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" }

local sources = {
	function()
		return utils.root_has_file(M.prettier_setting_files) and b.formatting.prettierd
	end,
	b.formatting.stylua,
}

M.setup = function()
	---@diagnostic disable-next-line: redundant-parameter
	null_ls.setup({
		sources = sources,
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = true
			common.on_attach(client, bufnr)
		end,
	})
end

return M
