local M = {
	"phaazon/hop.nvim",
	keys = {
		{
			"ss",
			function()
				require("hop").hint_words()
			end,
		},
	},
	config = function()
		require("hop").setup({ keys = "etovxqpdygfblzhckisuran", term_seq_bias = 0.5 })
	end,
}

return M
