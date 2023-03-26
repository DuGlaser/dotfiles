return {
	"romgrk/barbar.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		vim.api.nvim_set_keymap("n", "<C-t><C-t>", "<cmd>BufferPick<CR>", opts)
		vim.api.nvim_set_keymap("n", "<C-t><C-l>", "<cmd>BufferNext<CR>", opts)
		vim.api.nvim_set_keymap("n", "<C-t><C-h>", "<cmd>BufferPrevious<CR>", opts)
		vim.api.nvim_set_keymap("n", "<C-t><C-p>", "<cmd>Bdelete<CR>", opts)
		vim.api.nvim_set_keymap("n", "<C-t><C-P>", "<cmd>Bdelete!<CR>", opts)

		require("bufferline").setup({
			animation = true,
			closable = false,
			clickable = true,
		})
	end,
}
