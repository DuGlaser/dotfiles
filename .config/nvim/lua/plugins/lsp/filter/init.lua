local M = {}

local get_clients_table = function()
	local table = {}

	local active_clients = vim.lsp.get_active_clients()
	for _, client in pairs(active_clients) do
		table[client.name] = client
	end

	return table
end

M.for_deno = function(ctx)
	local tsserver = ctx.active_clients["tsserver"]
	local denols = ctx.active_clients["denols"]

	if tsserver ~= nil and denols ~= nil then
		tsserver.stop()
	end
end

M.for_angular = function(ctx)
	local tsserver = ctx.active_clients["tsserver"]
	local angular = ctx.active_clients["angularls"]

	if tsserver ~= nil and angular ~= nil then
		angular.server_capabilities.renameProvider = false
	end
end

M.apply = function(ctx)
	ctx.active_clients = get_clients_table()

	M.for_deno(ctx)
	M.for_angular(ctx)
end

return M
