local GH_BROWSE_CMD = "!gh browse"

vim.api.nvim_create_user_command("GhBrowse", function()
	vim.cmd(GH_BROWSE_CMD)
end, {})

local getCurrentFilePath = function()
	return vim.fn.expand("%")
end

vim.api.nvim_create_user_command("GhBrowseFile", function()
	local path = getCurrentFilePath()
	local cmd = string.format("%s %s", GH_BROWSE_CMD, path)
	vim.cmd(cmd)
end, {})

vim.api.nvim_create_user_command("GhBrowseLine", function()
	local path = getCurrentFilePath()
	local lineNumber, _ = unpack(vim.api.nvim_win_get_cursor(0))

	local cmd = string.format("%s %s:%s", GH_BROWSE_CMD, path, lineNumber)
	vim.cmd(cmd)
end, {})
