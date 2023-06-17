local M = {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("gitsigns").setup({
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 1000,
				ignore_whitespace = false,
			},
			signs = {
				add = { hl = "GitGutterAdd", text = "▌" },
				change = { hl = "GitGutterChange", text = "▌" },
				delete = { hl = "GitGutterDelete", text = "▌" },
				topdelete = { hl = "GitGutterDelete", text = "▌" },
				changedelete = { hl = "GitGutterChange", text = "▌" },
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
		})
	end,
}

return M
