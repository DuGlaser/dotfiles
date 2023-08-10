return {
	"karb94/neoscroll.nvim",
	event = "VeryLazy",
	config = function()
		require("neoscroll").setup({
			pre_hook = function()
				vim.wo.cursorline = false
				vim.opt.eventignore:append({
					"WinScrolled",
					"CursorMoved",
				})
			end,
			post_hook = function()
				vim.wo.cursorline = true
				vim.opt.eventignore:remove({
					"WinScrolled",
					"CursorMoved",
				})
			end,
			easing_function = "sine",
			hide_cursor = true,
			stop_eof = true,
			use_local_scrolloff = false,
			respect_scrolloff = false,
			cursor_scrolls_alone = true,
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
