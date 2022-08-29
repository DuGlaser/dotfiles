require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = false,
	},
	indent = {
		enable = true,
	},
	textobjects = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
	},
	-- nvim-ts-autotag
	autotag = {
		enable = true,
	},
})
