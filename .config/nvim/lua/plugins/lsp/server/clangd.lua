-- { "clangd" }

local M = {}

M.setup = function()
	return {
		cmd = {
			"clangd",
			"--header-insertion=never",
			"--clang-tidy",
			"--enable-config",
		},
	}
end

M.use_mason = true

return M
