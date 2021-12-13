local null_ls = require("null-ls")
local b = null_ls.builtins
local sources = {
	b.formatting.prettier.with({
		condition = function(utils)
			return utils.root_has_file(".prettierrc")
				or utils.root_has_file(".prettierrc.js")
				or utils.root_has_file(".prettierrc.json")
		end,
	}),
	b.formatting.stylua,
}

local M = {}

M.setup = function()
	null_ls.setup({
		sources = sources,
	})
end

return M
