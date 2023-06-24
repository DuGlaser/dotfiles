local GH_BROWSE_CMD = "silent! !gh browse"

vim.api.nvim_create_user_command("GhBrowse", function()
	vim.cmd(GH_BROWSE_CMD)
end, {})

local getCurrentFilePath = function()
	local rootDirFullPath = vim.fn.getcwd()
	local currentFullPath = vim.fn.expand("%:p")
	return string.sub(currentFullPath, string.len(rootDirFullPath) - string.len(currentFullPath) + 1)
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

vim.api.nvim_create_user_command("GhBrowsePR", function()
	vim.cmd("silent! !gh pr view --web")
end, {})
