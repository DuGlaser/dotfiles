require("plugins.lsp.trouble")

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
require("plugins.lsp.server.null-ls").setup()

local default_opts = {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		common.on_attach(client, bufnr)
	end,
	capabilities = common.capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}

local enableFormatOpts = vim.tbl_deep_extend("force", default_opts, {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = true
		common.on_attach(client, bufnr)
	end,
})

local lspconfig = require("lspconfig")
local servers = {
	["angularls"] = require("plugins.lsp.server.angularls"),
	["ccls"] = enableFormatOpts,
	["denols"] = require("plugins.lsp.server.denols"),
	["eslint"] = require("plugins.lsp.server.eslint"),
	["gopls"] = enableFormatOpts,
	["jsonls"] = require("plugins.lsp.server.jsonls"),
	["sumneko_lua"] = require("plugins.lsp.server.sumneko_lua"),
	["tsserver"] = require("plugins.lsp.server.tsserver"),
	["yamlls"] = require("plugins.lsp.server.yamlls"),
	["cssls"] = default_opts,
	["html"] = default_opts,
}

local function getTableKeys(tab)
	local keyset = {}
	for k, _ in pairs(tab) do
		keyset[#keyset + 1] = k
	end

	return keyset
end

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = getTableKeys(servers),
	automatic_installation = true,
})

local filter = require("plugins.lsp.filter")
require("mason-lspconfig").setup_handlers({
	function(server_name)
		local opt = servers[server_name] and servers[server_name] or default_opts
		local new_opt = vim.tbl_deep_extend("force", opt, {
			on_attach = function(client, bufnr)
				opt.on_attach(client, bufnr)
				filter.apply({ client = client, bufnr = bufnr })
			end,
		})

		lspconfig[server_name].setup(new_opt)
	end,
})

-- manual setup
lspconfig.ccls.setup(servers["ccls"])

require("lsp_signature").setup({
	floating_window = false,
	hint_prefix = "🤔 ",
})

vim.cmd([[hi NormalFloat guibg=#32302f]])
vim.cmd([[hi FloatBorder guifg=#fe8019]])
