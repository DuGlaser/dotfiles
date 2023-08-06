require("fidget").setup({})

local lsp_utils = require("plugins.lsp.utils").lsp

local default_opts = lsp_utils.default_opts
local enable_format_opts = lsp_utils.enable_format_opts
local disable_mason_setting = lsp_utils.disable_mason_setting

local servers = {
	["angularls"] = require("plugins.lsp.server.angularls"),
	["clangd"] = require("plugins.lsp.server.clangd"),
	["cssls"] = default_opts,
	["denols"] = require("plugins.lsp.server.denols"),
	["dockerls"] = enable_format_opts,
	["gopls"] = enable_format_opts,
	["html"] = default_opts,
	["jsonls"] = require("plugins.lsp.server.jsonls"),
	["pyright"] = require("plugins.lsp.server.pyright"),
	["lua_ls"] = require("plugins.lsp.server.lua_ls"),
	["terraformls"] = enable_format_opts,
	["vtsls"] = require("plugins.lsp.server.vtsls"),
	["yamlls"] = require("plugins.lsp.server.yamlls"),
}

local get_mason_server_key = lsp_utils.get_mason_server_key

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = get_mason_server_key(servers),
	automatic_installation = false,
})

local apply_filter = lsp_utils.apply_filter
local apply_capabilities = lsp_utils.apply_capabilities
local filetype_filter = lsp_utils.filetype_filter

require("mason-lspconfig").setup_handlers({
	function(server_name)
		if not filetype_filter() then
			return
		end

		local opt = servers[server_name] and servers[server_name] or default_opts

		if not opt.use_mason then
			return
		end

		local setting = opt.setup()
		if setting == nil then
			return
		end

		require("lspconfig")[server_name].setup(apply_capabilities(setting))
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local buffer = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		require("plugins.lsp.common").on_attach(client, buffer)
		apply_filter(client, buffer)
	end,
})

-- manual setup
for key, value in pairs(servers) do
	if not value.use_mason then
		if not filetype_filter() then
			return
		end

		local setting = value.setup()

		if setting ~= nil then
			require("lspconfig")[key].setup(apply_capabilities(setting))
		end
	end
end

require("duglaser.utils").set_timeout(function()
	if not filetype_filter() then
		return
	end

	require("plugins.lsp.server.null-ls").setup()
end, 2000)
