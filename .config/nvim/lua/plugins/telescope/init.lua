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
			theme = "dropdown",
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

local getVisualSelection = function()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

vim.keymap.set("v", "gs", function()
	local text = getVisualSelection()
	builtin.live_grep({ default_text = text })
end, opts)
