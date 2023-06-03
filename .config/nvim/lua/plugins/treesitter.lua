local function get_file_size(buf)
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	if ok and stats then
		return stats.size
	end

	return nil
end

local function is_file_size_over_limit(buf, limit_size)
	local size = get_file_size(buf)
	return size and size > limit_size
end

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
						return is_file_size_over_limit(buf, max_filesize)
					end,
				},
				incremental_selection = {
					enable = false,
				},
				yati = {
					enable = true,
					default_lazy = true,
					default_fallback = "auto",
				},
				indent = {
					enable = false,
				},
				textobjects = {
					enable = true,
				},
				context_commentstring = {
					enable = true,
				},
				-- nvim-ts-autotag
				autotag = {
					enable = true,
				},
			})

			vim.api.nvim_create_autocmd("BufEnter", {
				callback = function(params)
					if is_file_size_over_limit(params.buf, max_filesize) then
						vim.opt.syntax = "off"
					end
				end,
			})
		end,
	},
}

return M
