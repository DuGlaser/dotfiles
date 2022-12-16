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

local default_opts = {
	setup = function()
		return {
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				common.on_attach(client, bufnr)
			end,
			capabilities = common.capabilities,
			flags = {
				debounce_text_changes = 150,
			},
		}
	end,
	use_mason = true,
}

local enable_format_opts = {
	setup = function()
		return {
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = true
				common.on_attach(client, bufnr)
			end,
			capabilities = common.capabilities,
			flags = {
				debounce_text_changes = 150,
			},
		}
	end,
	use_mason = true,
}

local lspconfig = require("lspconfig")
local servers = {
	["angularls"] = require("plugins.lsp.server.angularls"),
	["ccls"] = vim.tbl_deep_extend("force", enable_format_opts, {
		use_mason = false,
	}),
	["cssls"] = default_opts,
	["denols"] = require("plugins.lsp.server.denols"),
	["gopls"] = enable_format_opts,
	["html"] = default_opts,
	["jsonls"] = require("plugins.lsp.server.jsonls"),
	["null-ls"] = require("plugins.lsp.server.null-ls"),
	["pyright"] = require("plugins.lsp.server.pyright"),
	["sumneko_lua"] = require("plugins.lsp.server.sumneko_lua"),
	["tsserver"] = require("plugins.lsp.server.tsserver"),
	["yamlls"] = require("plugins.lsp.server.yamlls"),
}

local function getMasonServerKey(tab)
	local keyset = {}
	for key, value in pairs(tab) do
		if value.use_mason then
			keyset[#keyset + 1] = key
		end
	end

	return keyset
end

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = getMasonServerKey(servers),
	automatic_installation = true,
})

local filter = require("plugins.lsp.filter")
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

		local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		if ok then
			setting.capabilities =
				cmp_nvim_lsp.default_capabilities(setting.capabilities or vim.lsp.protocol.make_client_capabilities())
		end

		local new_setting = vim.tbl_deep_extend("force", setting, {
			on_attach = function(client, bufnr)
				setting.on_attach(client, bufnr)
				filter.apply({ client = client, bufnr = bufnr })
			end,
		})

		lspconfig[server_name].setup(new_setting)
	end,
})

-- manual setup
for key, value in pairs(servers) do
	if not value.use_mason then
		local setting = value.setup()

		if setting ~= nil then
			lspconfig[key].setup(setting)
		end
	end
end

vim.cmd([[hi NormalFloat guibg=#32302f]])
vim.cmd([[hi FloatBorder guifg=#fe8019]])
