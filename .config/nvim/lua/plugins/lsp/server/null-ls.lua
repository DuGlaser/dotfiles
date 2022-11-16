local null_ls = require("null-ls")
local b = null_ls.builtins
local h = require("null-ls.helpers")
local utils = require("null-ls.utils")

local M = {}

local common = require("plugins.lsp.common")

M.prettier_setting_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" }
M.eslint_setting_files = { ".eslintrc", ".eslintrc.js", ".eslintrc.json" }
M.root_dir = { "Makefile", ".git", "package.json" }

local generate_runtime_condition = function(root_pattern, target_file)
	return h.cache.by_bufnr(function(params)
		local root_path = require("lspconfig").util.root_pattern(root_pattern)(params.bufname)
		if root_path == nil then
			return false
		end

		local condition = false

		for _, file in pairs(target_file) do
			condition = condition or vim.fn.findfile(file, root_path .. ";") ~= ""
		end

		return condition
	end)
end

local apply_eslint = function(setting)
	return setting.with({
		runtime_condition = generate_runtime_condition(M.root_dir, M.eslint_setting_files),
	})
end

M.enable_prettier = utils.make_conditional_utils().root_has_file(M.prettier_setting_files)

local sources = {
	function()
		return utils.make_conditional_utils().root_has_file(M.prettier_setting_files) and b.formatting.prettierd
	end,
	apply_eslint(b.code_actions.eslint_d),
	apply_eslint(b.diagnostics.eslint_d),
	apply_eslint(b.formatting.eslint_d),
	b.formatting.stylua,
	b.diagnostics.shellcheck,
	b.diagnostics.jsonlint,
	b.code_actions.shellcheck,
}

M.setup = function()
	null_ls.setup({
		---@diagnostic disable-next-line: param-type-mismatch
		root_dir = utils.root_pattern(M.root_dir),
		sources = sources,
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = true
			common.on_attach(client, bufnr)
		end,
	})
end

M.use_lspconfig = true

return M
