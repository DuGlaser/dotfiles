require("fidget").setup({})

local diagnosticsGroup = require("plugins.lsp.utils").diagnosticsGroup
for _, g in pairs(diagnosticsGroup) do
	-- undercurlを使うようにする
	local hi = string.format("hi DiagnosticUnderline%s cterm=undercurl gui=undercurl guisp=%s", g.type, g.color)
	vim.cmd(hi)
	vim.fn.sign_define(g.highlight, {
		text = g.sign,
		texthl = g.highlight,
	})
end

local common = require("plugins.lsp.common")
local lsp_utils = require("plugins.lsp.utils").lsp

local default_opts = lsp_utils.default_opts
local enable_format_opts = lsp_utils.enable_format_opts
local disable_mason_setting = lsp_utils.disable_mason_setting

local lspconfig = require("lspconfig")
local servers = {
	["angularls"] = require("plugins.lsp.server.angularls"),
	["ccls"] = disable_mason_setting(enable_format_opts),
	["cssls"] = default_opts,
	["denols"] = require("plugins.lsp.server.denols"),
	["dockerls"] = enable_format_opts,
	["gopls"] = enable_format_opts,
	["html"] = default_opts,
	["jsonls"] = require("plugins.lsp.server.jsonls"),
	["null-ls"] = require("plugins.lsp.server.null-ls"),
	["pyright"] = require("plugins.lsp.server.pyright"),
	["lua_ls"] = require("plugins.lsp.server.lua_ls"),
	["terraformls"] = enable_format_opts,
	["tsserver"] = require("plugins.lsp.server.tsserver"),
	["yamlls"] = require("plugins.lsp.server.yamlls"),
}

local get_mason_server_key = lsp_utils.get_mason_server_key

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = get_mason_server_key(servers),
	automatic_installation = true,
})
require("mason-tool-installer").setup({
	ensure_installed = {
		"cspell",
		"eslint_d",
		"jsonlint",
		"prettierd",
		"shellcheck",
		"stylua",
		"yamllint",
	},
	auto_update = false,
	run_on_start = false,
})

local apply_filter = lsp_utils.apply_filter
local apply_capabilities = lsp_utils.apply_capabilities

require("mason-lspconfig").setup_handlers({
	function(server_name)
		local opt = servers[server_name] and servers[server_name] or default_opts

		if not opt.use_mason then
			return
		end

		local setting = opt.setup()
		if setting == nil then
			return
		end

		lspconfig[server_name].setup(apply_capabilities(apply_filter(setting)))
	end,
})

-- manual setup
for key, value in pairs(servers) do
	if not value.use_mason then
		local setting = value.setup()

		if setting ~= nil then
			lspconfig[key].setup(apply_capabilities(apply_filter(setting)))
		end
	end
end

vim.cmd([[hi NormalFloat guibg=#32302f]])
vim.cmd([[hi FloatBorder guifg=#fe8019]])
