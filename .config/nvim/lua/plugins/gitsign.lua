local M = {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
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
			numhl = false,
			keymaps = {
				["o ig"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
				["x ig"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
			},
		})
	end,
}

return M
