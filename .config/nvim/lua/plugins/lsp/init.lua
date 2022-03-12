require("plugins.lsp.trouble")
require("plugins.lsp.saga")

local utils = require("plugins.lsp.utils")
-- NOTE: same lspsaga.nvim
local diagnosticsGroup = utils.diagnosticsGroup
for _, g in pairs(diagnosticsGroup) do
	vim.fn.sign_define(g.highlight, {
		text = g.sign,
		texthl = g.highlight,
		linehl = string.format("%sLine", g.highlight),
	})
end

local common = require("plugins.lsp.common")
require("plugins.lsp.server.null-ls").setup()

-- Custom initialize
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local default_opts = {
		on_attach = common.on_attach,
		capabilities = common.capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}

	local opts = {
		["angularls"] = require("plugins.lsp.server.angularls"),
		["eslint"] = require("plugins.lsp.server.eslint"),
		["jsonls"] = require("plugins.lsp.server.jsonls"),
		["sumneko_lua"] = require("plugins.lsp.server.sumneko_lua"),
		["tsserver"] = require("plugins.lsp.server.tsserver"),
		["yamlls"] = require("plugins.lsp.server.yamlls"),
	}

	if server.name == "rust_analyzer" then
		local ra = require("plugins.lsp.server.rust-analyzer")
		local rustServer = vim.tbl_deep_extend("force", server:get_default_options(), ra)

		require("rust-tools").setup({
			tools = {
				autoSetHints = true,
				hover_with_actions = true,
				inlay_hints = {
					show_parameter_hints = false,
					parameter_hints_prefix = "",
					other_hints_prefix = "",
				},
			},
			server = rustServer,
		})
		server:attach_buffers()
		return
	end
	server:setup(opts[server.name] and opts[server.name] or default_opts)
	vim.cmd([[ do User LspAttachBuffers ]])
end)

vim.cmd([[hi NormalFloat guibg=#32302f]])
vim.cmd([[hi FloatBorder guifg=#fe8019]])
