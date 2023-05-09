local null_ls = require("null-ls")
local b = null_ls.builtins
local h = require("null-ls.helpers")
local utils = require("null-ls.utils")

local M = {}

local common = require("plugins.lsp.common")

M.prettier_setting_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.cjs", ".prettierrc.json" }
M.eslint_setting_files = { ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" }
M.root_dir = { ".git", "package.json", "Makefile" }

M.enable_prettier = utils.make_conditional_utils().root_has_file(M.prettier_setting_files)

local generate_runtime_condition = function(root_pattern)
	return h.cache.by_bufnr(function(params)
		local root_path = require("lspconfig").util.root_pattern(root_pattern)(params.bufname)
		if root_path == nil then
			return false
		end

		return true
	end)
end

local apply_runtime_condition = function(setting, pattern)
	return setting.with({
		runtime_condition = generate_runtime_condition(pattern),
	})
end

local function get_null_ls_sources(source_name, types, fn)
	local tbl = {}
	if fn ~= nil then
		for _, type in ipairs(types) do
			table.insert(tbl, fn(b[type][source_name], type))
		end

		return tbl
	end

	for _, type in ipairs(types) do
		table.insert(tbl, b[type][source_name])
	end

	return tbl
end

local function merge_sources(...)
	local tbl = {}
	for i = 1, select("#", ...) do
		local sources = (select(i, ...))
		for _, source in ipairs(sources) do
			table.insert(tbl, source)
		end
	end

	return tbl
end

local TYPES = {
	CODE_ACTIONS = "code_actions",
	DIAGNOSTICS = "diagnostics",
	FORMATTING = "formatting",
}

local eslint_sources = get_null_ls_sources(
	"eslint_d",
	{ TYPES.CODE_ACTIONS, TYPES.DIAGNOSTICS, TYPES.FORMATTING },
	function(setting)
		return apply_runtime_condition(setting, M.eslint_setting_files)
	end
)

local get_cspell_sources = function()
	local cspell = require("cspell")

	local code_actions = cspell.code_actions
	local diagnostics = cspell.diagnostics.with({
		diagnostics_postprocess = function(diagnostic)
			diagnostic.severity = vim.diagnostic.severity["WARN"]
		end,
	})

	return { diagnostics, code_actions }
end

local prettierd_sources = get_null_ls_sources("prettierd", { TYPES.FORMATTING }, function(setting)
	return apply_runtime_condition(
		setting.with({
			disabled_filetypes = { "markdown", "markdown.mdx" },
		}),
		M.prettier_setting_files
	)
end)

local shellcheck_sources = get_null_ls_sources(
	"shellcheck",
	{ TYPES.CODE_ACTIONS, TYPES.DIAGNOSTICS },
	function(setting)
		return setting.with({
			runtime_condition = h.cache.by_bufnr(function(params)
				return params.bufname:match("%.env$") == nil
			end),
		})
	end
)

local sources = merge_sources(
	{ require("typescript.extensions.null-ls.code-actions") },
	get_cspell_sources(),
	eslint_sources,
	prettierd_sources,
	shellcheck_sources,
	get_null_ls_sources("jsonlint", { TYPES.DIAGNOSTICS }),
	get_null_ls_sources("markdownlint", { TYPES.DIAGNOSTICS, TYPES.FORMATTING }),
	get_null_ls_sources("stylua", { TYPES.FORMATTING }),
	get_null_ls_sources("yamllint", { TYPES.DIAGNOSTICS })
)

M.setup = function()
	require("duglaser.utils").set_timeout(function()
		null_ls.setup({
			root_dir = utils.root_pattern(M.root_dir),
			sources = sources,
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = true
				common.on_attach(client, bufnr)
			end,
		})
	end, 1000)
end

M.use_mason = false

return M
