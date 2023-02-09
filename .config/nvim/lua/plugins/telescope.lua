local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
	},
	keys = {
		{
			"<Space>F",
			function()
				return require("telescope.builtin").find_files()
			end,
		},
		{
			"<Space>B",
			function()
				return require("telescope.builtin").buffers()
			end,
		},
		{
			"<Space>G",
			function()
				require("telescope").extensions.live_grep_args.live_grep_args()
			end,
		},
		{
			"gs",
			function()
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

				local text = getVisualSelection()
				require("telescope.builtin").live_grep({ default_text = text })
			end,
			mode = { "v" },
		},
	},
	config = function()
		local telescope = require("telescope")
		local lga_actions = require("telescope-live-grep-args.actions")

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
					mappings = {
						i = {
							["<C-k>"] = lga_actions.quote_prompt(),
						},
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")
	end,
}

return M
