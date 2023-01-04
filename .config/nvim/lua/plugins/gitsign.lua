local M = {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("gitsigns").setup({
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
