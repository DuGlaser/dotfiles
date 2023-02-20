local M = {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"windwp/nvim-ts-autotag",
			"yioneko/nvim-yati",
		},

		config = function()
			local max_filesize = 100 * 1024

			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					disable = function(_, buf)
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				incremental_selection = {
					enable = false,
				},
				yati = {
					enable = true,
				},
				indent = {
					enable = false,
				},
				textobjects = {
					enable = true,
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
				-- nvim-ts-autotag
				autotag = {
					enable = true,
				},
			})

			vim.api.nvim_create_autocmd("BufEnter", {
				callback = function(params)
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(params.buf))
					if ok and stats and stats.size > max_filesize then
						vim.opt.syntax = "off"
					end
				end,
			})
		end,
	},
}

return M
