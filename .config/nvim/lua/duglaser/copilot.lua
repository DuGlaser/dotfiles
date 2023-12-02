local M = {}

local statusMap = {
	["Normal"] = "😎",
	["InProgress"] = "🤔",
	["Offline"] = "😴",
}

M.status = statusMap["Offline"]
M.setup = function()
	local api = require("copilot.api")
	api.register_status_notification_handler(function(data)
		print("copilot status: " .. data.status)
		M.status = statusMap[data.status] or statusMap["Offline"]
	end)
end

return M
