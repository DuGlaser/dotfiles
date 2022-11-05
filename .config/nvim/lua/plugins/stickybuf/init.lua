require("stickybuf").setup({
	buftype = {
		[""] = false,
		acwrite = false,
		help = "buftype",
		nofile = false,
		nowrite = false,
		quickfix = "buftype",
		terminal = false,
		prompt = "bufnr",
	},
	wintype = {
		autocmd = false,
		popup = "bufnr",
		preview = false,
		command = false,
		[""] = false,
		unknown = false,
		floating = false,
	},
	filetype = {
		aerial = "filetype",
		nerdtree = "filetype",
		["neotest-summary"] = "filetype",
	},
	bufname = {
		["Neogit.*Popup"] = "bufnr",
	},
	autocmds = {
		fern = [[au FileType fern if &winfixwidth || &winfixheight | silent! PinFiletype | endif]],
		neogit = [[au FileType NeogitStatus,NeogitLog,NeogitGitCommandHistory if winnr('$') > 1 | silent! PinFiletype | endif]],
	},
})
