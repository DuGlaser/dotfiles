local hint_words = function()
	require("hop").hint_words()
end

vim.keymap.set("n", "ss", hint_words, { noremap = true, silent = true })
