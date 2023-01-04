local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = { "kyazdani42/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local function getFileName()
			local path = vim.fn.expand("%:p")
			local git_path = vim.fn.finddir(".git/..", vim.fn.expand("%:p:h") .. ";")

			if git_path == "" then
				return vim.fn.expand("%:t")
			end

			return string.sub(path, string.len(git_path) + 2)
		end

		local diagnosticsGroup = require("plugins.lsp.utils").diagnosticsGroup

		local lualine_c = {
			{
				"diff",
				symbols = { added = " ", modified = "柳 ", removed = " " },
			},
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = {
					error = diagnosticsGroup.err_group.sign .. " ",
					warn = diagnosticsGroup.warn_group.sign .. " ",
					info = diagnosticsGroup.info_group.sign .. " ",
				},
				diagnostics_color = {
					color_error = { fg = diagnosticsGroup.err_group.highlight },
					color_warn = { fg = diagnosticsGroup.warn_group.highlight },
					color_info = { fg = diagnosticsGroup.info_group.highlight },
				},
			},
		}

		require("lualine").setup({
			options = {
				theme = "auto",
				globalstatus = true,
			},
			sections = {
				lualine_a = { "branch" },
				lualine_b = { getFileName },
				lualine_c = lualine_c,
				lualine_x = { "filetype" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_b = { getFileName },
				lualine_c = lualine_c,
			},
		})
	end,
}

return M
