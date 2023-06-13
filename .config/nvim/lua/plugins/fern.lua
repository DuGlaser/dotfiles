local M = {
	"lambdalisue/fern.vim",
	dependencies = {
		"hrsh7th/fern-mapping-collapse-or-leave.vim",
		"lambdalisue/nerdfont.vim",
		"lambdalisue/fern-renderer-nerdfont.vim",
		"lambdalisue/glyph-palette.vim",
		{
			"s1n7ax/nvim-window-picker",
			commit = "65bbc52c27b0cd4b29976fe03be73cc943357528",
			name = "window-picker",
			config = function()
				local function filter_floating_windows(window_ids)
					local non_floating_windows = {}

					for _, win_id in ipairs(window_ids) do
						local is_floating = vim.api.nvim_win_get_config(win_id).relative ~= ""
						if not is_floating then
							table.insert(non_floating_windows, win_id)
						end
					end

					return non_floating_windows
				end

				require("window-picker").setup({
					selection_chars = "ABCDEFG",
					picker_config = {
						statusline_winbar_picker = {
							selection_display = function(char)
								return "%=" .. char .. "%="
							end,
							use_winbar = "smart",
						},
					},
					show_prompt = false,
					filter_func = function(window_ids)
						window_ids = require("window-picker").filter_windows(window_ids)
						return filter_floating_windows(window_ids)
					end,
					filter_rules = {
						autoselect_one = true,
						include_current_win = false,
						bo = {
							filetype = { "fern" },
						},
						wo = {},
						file_path_contains = {},
						file_name_contains = {},
					},
				})
			end,
		},
	},
	keys = {
		{
			"<Space>u",
			"<cmd>Fern . -drawer -width=35 -reveal=% <CR><C-w>=",
		},
	},
	config = function()
		vim.g["fern#disable_default_mappings"] = 1
		vim.g["fern#renderer"] = "nerdfont"
		vim.g["fern#renderer#nerdfont#indent_markers"] = 1

		local hide_dirs = "^%(.git|node_modules)$"
		local hide_files = "%(.byebug|.ruby-)+"
		vim.g["fern#default_exclude"] = hide_dirs .. "|" .. hide_files

		local function fern_picker()
			local node = vim.api.nvim_exec(
				[[
          let helper = fern#helper#new()
          echo helper.sync.get_selected_nodes()[0]["_path"]
        ]],
				true
			)
			local picked_window_id = require("window-picker").pick_window()
			if picked_window_id == nil then
				return
			end

			vim.api.nvim_set_current_win(picked_window_id)
			vim.cmd.edit(node)
		end

		local function init_fern()
			local options = { buffer = 0 }
			vim.keymap.set("n", "E", "<Plug>(fern-action-open:side)", options)
			vim.keymap.set("n", "!", "<Plug>(fern-action-hidden:toggle)", options)
			vim.keymap.set("n", "a", "<Plug>(fern-action-mark:toggle)", options)
			vim.keymap.set("n", "A", "<Plug>(fern-action-choice)", options)
			vim.keymap.set("n", "h", "<Plug>(fern-action-collapse-or-leave)", options)
			vim.keymap.set("n", "M", "<Plug>(fern-action-move)", options)
			vim.keymap.set("n", "c", "<Plug>(fern-action-new-file)", options)
			vim.keymap.set("n", "n", "<Plug>(fern-action-new-dir)", options)
			vim.keymap.set("n", "l", "<Plug>(fern-action-open-or-expand)", options)
			vim.keymap.set("n", "<Plug>(fern-action-open:picker)", fern_picker, options)
			vim.keymap.set("n", "<Plug>(fern-action-open)", "<Plug>(fern-action-open:picker)", options)
			vim.keymap.set("n", "t", "<Plug>(fern-action-open:tabedit)", options)
			vim.keymap.set("n", "r", "<Plug>(fern-action-rename)", options)
			vim.keymap.set("n", "D", "<Plug>(fern-action-trash)", options)
			vim.keymap.set("n", "y", "<Plug>(fern-action-yank)", options)
			vim.keymap.set("n", "Y", "<Plug>(fern-action-copy)", options)
			vim.keymap.set("n", "dd", "<Plug>(fern-action-remove)", options)
			vim.keymap.set("n", "?", "<Plug>(fern-action-help)", options)
			vim.keymap.set("n", "<C-r>", "<Plug>(fern-action-reload)", options)
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fern",
			callback = init_fern,
		})

		vim.cmd([[
      augroup my-glyph-palette
        autocmd! *
        autocmd FileType fern call glyph_palette#apply()
        autocmd FileType nerdtree,startify call glyph_palette#apply()
      augroup END
    ]])
	end,
}

return M
