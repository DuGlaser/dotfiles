return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = false,
					dissmiss = "<M-e>",
					prev = "<M-Down>",
					next = "<M-Up>",
				},
			},
		})
	end,
}
