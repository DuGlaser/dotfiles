local M = {}

local get_clients_table = function()
	local table = {}

	local active_clients = vim.lsp.get_active_clients()
	for _, client in pairs(active_clients) do
		table[client.name] = client
	end

	return table
end

M.for_deno = function(client, clients_table)
	if client.name == "denols" then
		if clients_table["tsserver"] ~= nil then
			clients_table["tsserver"].stop()
		end
	elseif client.name == "tsserver" then
		if clients_table["denols"] ~= nil then
			client.stop()
		end
	end
end

M.apply = function(client)
	local clients_table = get_clients_table()
	M.for_deno(client, clients_table)
end

return M
