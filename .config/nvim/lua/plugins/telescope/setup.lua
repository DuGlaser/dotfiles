local opts = { noremap = true, silent = true }

local find_files = function()
	return require("telescope.builtin").find_files()
end

local buffers = function()
	return require("telescope.builtin").buffers()
end

local live_grep = function()
	require("telescope").extensions.live_grep_args.live_grep_args(require("telescope.themes").get_dropdown({}))
end

vim.keymap.set("n", "<Space>F", find_files, opts)
vim.keymap.set("n", "<Space>B", buffers, opts)
vim.keymap.set("n", "<Space>G", live_grep, opts)

local getVisualSelection = function()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

vim.keymap.set("v", "gs", function()
	local text = getVisualSelection()
	require("telescope.builtin").live_grep({ default_text = text })
end, opts)
