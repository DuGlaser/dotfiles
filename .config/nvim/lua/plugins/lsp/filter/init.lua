local M = {}

local get_clients_table = function()
	local table = {}

	local active_clients = vim.lsp.get_active_clients()
	for _, client in pairs(active_clients) do
		table[client.name] = client
	end

	return table
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

	M.for_deno(ctx)
	M.for_angular(ctx)
	M.for_ccls(ctx)
end

return M
