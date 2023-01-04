local M = {
	"akinsho/nvim-bufferline.lua",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	config = function()
		local opts = { noremap = true, silent = true }

		vim.api.nvim_set_keymap("n", "<C-t><C-t>", "<cmd>BufferLinePick<CR>", opts)
		vim.api.nvim_set_keymap("n", "<C-t><C-l>", "<cmd>BufferLineCycleNext<CR>", opts)
		vim.api.nvim_set_keymap("n", "<C-t><C-h>", "<cmd>BufferLineCyclePrev<CR>", opts)
		vim.api.nvim_set_keymap("n", "<C-t><C-p>", "<cmd>Bdelete<CR>", opts)
		vim.api.nvim_set_keymap("n", "<C-t><C-P>", "<cmd>Bdelete!<CR>", opts)

		require("bufferline").setup({
			options = {
				numbers = "none",
				close_command = "bdelete! %d",
				right_mouse_command = "bdelete! %d",
				left_mouse_command = "buffer %d",
				middle_mouse_command = nil,
				max_name_length = 18,
				max_prefix_length = 15,
				tab_size = 20,
				diagnostics = false,
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					return "(" .. count .. ")"
				end,
				custom_filter = function(buf_number, buf_numbers)
					if vim.bo[buf_number].filetype == "qf" then
						return false
					end

					return true
				end,
				offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "left" } },
				show_buffer_icons = true,
				show_buffer_close_icons = false,
				show_tab_indicators = true,
				persist_buffer_sort = true,
				separator_style = "slant",
				enforce_regular_tabs = true,
				always_show_bufferline = true,
				sort_by = "id",
			},
		})
	end,
}

return M
