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

		require("bufferline").setup({
			animation = false,
			clickable = true,
			pinned = {
				button = "📌",
			},
		})
	end,
}
