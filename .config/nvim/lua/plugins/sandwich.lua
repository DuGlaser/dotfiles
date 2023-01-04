local M = {
	"machakann/vim-sandwich",
	config = function()
		vim.cmd([[
      let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
      let g:sandwich#recipes += [
            \    {'buns': ['${', '}'], 'input': ['js']}
            \  ]
    ]])
	end,
}

return M
