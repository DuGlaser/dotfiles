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

local enableFormatSetting = vim.tbl_deep_extend("force", default_opts, {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = true
		common.on_attach(client, bufnr)
	end,
})

local lspconfig = require("lspconfig")
local opts = {
	["angularls"] = require("plugins.lsp.server.angularls"),
	["ccls"] = enableFormatSetting,
	["denols"] = require("plugins.lsp.server.denols"),
	["eslint"] = require("plugins.lsp.server.eslint"),
	["gopls"] = enableFormatSetting,
	["jsonls"] = require("plugins.lsp.server.jsonls"),
	["sumneko_lua"] = require("plugins.lsp.server.sumneko_lua"),
	["tsserver"] = require("plugins.lsp.server.tsserver"),
	["yamlls"] = require("plugins.lsp.server.yamlls"),
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"angularls",
		"ccls",
		"eslint",
		"gopls",
		"jsonls",
		"sumneko_lua",
		"tsserver",
		"yamlls",
		"cssls",
		"html",
	},
	automatic_installation = true,
})

local filter = require("plugins.lsp.filter")
require("mason-lspconfig").setup_handlers({
	function(server_name)
		local opt = opts[server_name] and opts[server_name] or default_opts
		local new_opt = vim.tbl_deep_extend("force", opt, {
			on_attach = function(client, bufnr)
				filter.apply(client)
				opt.on_attach(client, bufnr)
			end,
		})

		lspconfig[server_name].setup(new_opt)
	end,
})

require("lsp_signature").setup({
	floating_window = false,
	hint_prefix = "🤔 ",
})

vim.cmd([[hi NormalFloat guibg=#32302f]])
vim.cmd([[hi FloatBorder guifg=#fe8019]])
