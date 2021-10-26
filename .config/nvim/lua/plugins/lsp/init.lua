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
require("plugins.lsp.server.null-ls").setup(common.on_attach)

-- Custom initialize
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local default_opts = {
		on_attach = common.on_attach,
		capabilities = common.capabilities,
	}

	local opts = {
		["typescript"] = require("plugins.lsp.server.typescript"),
		["sumneko_lua"] = require("plugins.lsp.server.lua"),
		["rust_analyzer"] = require("plugins.lsp.server.rust"),
		["eslint"] = require("plugins.lsp.server.eslint"),
	}

	server:setup(opts[server.name] and opts[server.name] or default_opts)
	vim.cmd([[ do User LspAttachBuffers ]])
end)

vim.cmd([[hi NormalFloat guibg=#32302f]])
vim.cmd([[hi FloatBorder guifg=#fe8019]])
