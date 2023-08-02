return {
	"karb94/neoscroll.nvim",
	config = function()
		require("neoscroll").setup({
			pre_hook = function()
				vim.opt.eventignore:append({
					"WinScrolled",
					"CursorMoved",
				})
			end,
			post_hook = function()
				vim.opt.eventignore:remove({
					"WinScrolled",
					"CursorMoved",
				})
			end,
			easing_function = "sine",
		})

		local t = {}
		t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "125" } }
		t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "125" } }

		require("neoscroll.config").set_mappings(t)
	end,
	keys = {
		{
			"<C-d>",
			mode = { "n", "x" },
		},
		{
			"<C-u>",
			mode = { "n", "x" },
		},
	},
}
