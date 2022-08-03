local telescope = require("telescope")

telescope.setup({
	pickers = {
		find_files = {
			theme = "dropdown",
		},
		buffers = {
			theme = "dropdown",
		},
		live_grep = {
			theme = "dropdown",
		},
	},
})

telescope.load_extension("fzy_native")

local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Space>F", builtin.find_files, opts)
vim.keymap.set("n", "<Space>B", builtin.buffers, opts)
vim.keymap.set("n", "<Space>G", builtin.live_grep, opts)
