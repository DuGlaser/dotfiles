return {
	"kdheepak/lazygit.nvim",
	config = function()
		vim.g.lazygit_floating_window_winblend = 0
		vim.g.lazygit_floating_window_scaling_factor = 0.9
		vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
		vim.g.lazygit_floating_window_use_plenary = 0
		vim.g.lazygit_use_neovim_remote = 0
	end,
	keys = {
		{
			"<Space>gg",
			":LazyGit<CR>",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}