require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		disable = {
			"ruby",
			"c_sharp",
			"vue",
		},
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
	-- ensure_installed = 'all',
	-- nvim-treesitter-refactor
	refactor = {
		highlight_definitions = {
			enable = false,
		},
		highlight_current_scope = {
			enable = false,
		},
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},
		navigation = {
			enable = false,
		},
	},
})
