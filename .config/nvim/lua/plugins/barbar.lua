return {
	"romgrk/barbar.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		vim.api.nvim_set_keymap("n", "<C-t><C-t>", "<cmd>BufferPick<CR>", opts)
		vim.api.nvim_set_keymap("n", "<C-t><C-l>", "<cmd>BufferNext<CR>", opts)
		vim.api.nvim_set_keymap("n", "<C-t><C-h>", "<cmd>BufferPrevious<CR>", opts)
		vim.api.nvim_set_keymap("n", "<C-t><C-p>", "<cmd>BufferClose<CR>", opts)
		vim.api.nvim_set_keymap("n", "<C-t><C-P>", "<cmd>BufferClose!<CR>", opts)
		vim.api.nvim_set_keymap("n", "<C-t><C-m>", "<cmd>BufferPin<CR>", opts)

		local diagnosticsGroup = require("plugins.lsp.utils").diagnosticsGroup

		require("bufferline").setup({
			animation = false,
			clickable = true,
			icons = {
				button = false,
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = {
						enabled = true,
						icon = diagnosticsGroup.err_group.sign,
					},
				},
				pinned = {
					button = "📌",
				},
			},
		})
	end,
}
