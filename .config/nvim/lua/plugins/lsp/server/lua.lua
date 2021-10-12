local M = {}

local luadev = require("lua-dev").setup()

M.setup = function(on_attach)
	require("lspconfig").lua.setup(luadev)

	require("plugins.lsp.server.efm").setup(on_attach)
end

return M
