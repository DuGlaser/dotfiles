local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", {
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"2html",
				"gzip",
				"matchit",
				"matchparen",
				"netrw",
				"netrwPlugin",
				"remote_plugins",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	change_detection = {
		enabled = false,
		notify = false,
	},
	ui = {
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			source = "📄",
			start = "🚀",
			task = "📌",
		},
	},
})
