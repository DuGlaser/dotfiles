local M = {
	"numToStr/Comment.nvim",
	config = function()
		local ft = require("Comment.ft")
		local commentstr = "<!--%s-->"
		ft.set("angular", { commentstr, commentstr })

		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}

return M
