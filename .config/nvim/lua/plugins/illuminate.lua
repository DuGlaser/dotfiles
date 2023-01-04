local M = {
	"RRethy/vim-illuminate",
	event = "VeryLazy",
	config = function()
		require("illuminate").configure({
			providers = {
				"lsp",
				"treesitter",
				"regex",
			},
			delay = 300,
			filetype_overrides = {},
			filetypes_denylist = {
				"dirvish",
				"fugitive",
				"fern",
				"TelescopePrompt",
				"mason",
				"qf",
			},
			filetypes_allowlist = {},
			modes_denylist = {},
			modes_allowlist = {},
			providers_regex_syntax_denylist = {},
			providers_regex_syntax_allowlist = {},
			under_cursor = true,
			large_file_cutoff = nil,
			large_file_overrides = nil,
			min_count_to_highlight = 1,
		})

		vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#4a4a4a" })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#4a4a4a" })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#4a4a4a" })
	end,
}

return M
