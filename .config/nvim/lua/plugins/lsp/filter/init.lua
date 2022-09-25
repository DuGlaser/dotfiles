local M = {}

local get_clients_table = function()
	local table = {}

	local active_clients = vim.lsp.get_active_clients()
	for _, client in pairs(active_clients) do
		table[client.name] = client
	end

	return table
end

M.for_deno = function(clients_table)
	local tsserver = clients_table["tsserver"]
	local denols = clients_table["denols"]

	if tsserver ~= nil and denols ~= nil then
		tsserver.stop()
	end
end

M.for_angular = function(clients_table, ctx)
	local currentServer = ctx.client.name
	local angular = clients_table["angularls"]

	if currentServer == "tsserver" and angular then
		ctx.client.server_capabilities.renameProvider = false
	end
end

M.apply = function(ctx)
	local clients_table = get_clients_table()
	M.for_deno(clients_table)
	M.for_angular(clients_table, ctx)
end

return M
