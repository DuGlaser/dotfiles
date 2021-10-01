local M = {}

local luadev = require("lua-dev").setup()

M.setup = function()
	require("lspconfig").lua.setup(luadev)
end

return M
