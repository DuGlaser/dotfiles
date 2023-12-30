local M = {}

M.ENV = {
	["WSL"] = "wsl",
	["DARWIN"] = "darwin",
}

local is_wsl = function()
	local name = vim.loop.os_uname().release
	if name == nil then
		return false
	end

	return name:find("microsoft") ~= nil
end

local is_darwin = function()
	return vim.loop.os_uname().sysname == "Darwin"
end

local current_env = nil

M.get_env = function()
	local function _get_env()
		if is_wsl() then
			return M.ENV.WSL
		end

		if is_darwin() then
			return M.ENV.DARWIN
		end

		print("unsupported environment")
		return nil
	end

	if current_env == nil then
		current_env = _get_env()
	end

	return current_env
end

return M
