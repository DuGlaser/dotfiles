local M = {}

local get_clients_table = function()
	local table = {}

	local active_clients = vim.lsp.get_active_clients()
	for _, client in pairs(active_clients) do
		table[client.name] = client
	end

	return table
end

M.for_json = function(ctx)
	local jsonls = ctx.active_clients["jsonls"]
	local null_ls = ctx.active_clients["null-ls"]

	if jsonls ~= nil and null_ls ~= nil then
		if require("plugins.lsp.server.null-ls").enable_prettier() then
			jsonls.server_capabilities.documentFormattingProvider = false
		end
	end
end

M.for_yaml = function(ctx)
	local yamlls = ctx.active_clients["yamlls"]
	local null_ls = ctx.active_clients["null-ls"]

	if yamlls ~= nil and null_ls ~= nil then
		if require("plugins.lsp.server.null-ls").enable_prettier() then
			yamlls.server_capabilities.documentFormattingProvider = false
		end
	end
end

M.for_ccls = function(ctx)
	local ccls = ctx.active_clients["ccls"]
	local null_ls = ctx.active_clients["null-ls"]

	if ccls ~= nil and null_ls ~= nil then
		null_ls.stop()
	end
end

M.for_deno = function(ctx)
	local vtsls = ctx.active_clients["vtsls"]
	local denols = ctx.active_clients["denols"]

	if vtsls ~= nil and denols ~= nil then
		vtsls.stop()
	end
end

M.for_angular = function(ctx)
	local vtsls = ctx.active_clients["vtsls"]
	local angular = ctx.active_clients["angularls"]

	if vtsls ~= nil and angular ~= nil then
		angular.server_capabilities.renameProvider = false
	end
end

M.apply = function(ctx)
	ctx.active_clients = get_clients_table()

	M.for_angular(ctx)
	M.for_ccls(ctx)
	M.for_deno(ctx)
	M.for_json(ctx)
	M.for_yaml(ctx)
end

return M
