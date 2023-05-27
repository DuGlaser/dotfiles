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
		local dropdown_config = {
			theme = "dropdown",
			previewer = true,
			prompt_title = false,
			results_title = false,
			layout_config = {
				width = 0.8,
				height = 20,
			},
		}

		telescope.setup({
			defaults = {
				dynamic_preview_title = true,
				color_devicons = true,
			},
			pickers = {
				find_files = dropdown_config,
				buffers = dropdown_config,
				live_grep = dropdown_config,
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				live_grep_args = vim.tbl_deep_extend("force", dropdown_config, {
					auto_quoting = true,
					mappings = {
						i = {
							["<C-k>"] = lga_actions.quote_prompt(),
						},
					},
				}),
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")
	end,
}

return M
