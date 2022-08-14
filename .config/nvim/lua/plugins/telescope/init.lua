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
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		live_grep_args = {
			auto_quoting = true,
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")

local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Space>F", builtin.find_files, opts)
vim.keymap.set("n", "<Space>B", builtin.buffers, opts)
vim.keymap.set(
	"n",
	"<Space>G",
	":lua require('telescope').extensions.live_grep_args.live_grep_args(require('telescope.themes').get_dropdown({}))<CR>",
	opts
)
