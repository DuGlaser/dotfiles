local common = require("plugins.lsp.common")

local tsHandlers = {
	["textDocument/definition"] = function(_, result, params)
		local util = require("vim.lsp.util")
		local client = vim.lsp.get_client_by_id(params.client_id)
		local offset_encoding = client.offset_encoding

		if result == nil or vim.tbl_isempty(result) then
			return nil
		end

		if vim.tbl_islist(result) then
			util.jump_to_location(result[1], offset_encoding)

			if #result > 1 then
				local isReactDTs = false
				---@diagnostic disable-next-line: unused-local
				for key, value in pairs(result) do
					if string.match(value.uri, "react/index.d.ts") then
						isReactDTs = true
						break
					end
				end
				if not isReactDTs then
					vim.fn.setqflist({}, " ", {
						title = "Language Server",
						items = util.locations_to_items(result, offset_encoding),
					})
					vim.api.nvim_command("copen")
					vim.api.nvim_command("wincmd p")
				end
			end
		else
			util.jump_to_location(result, offset_encoding)
		end
	end,
}

return {
	handlers = tsHandlers,
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		common.on_attach(client, bufnr)
	end,
	capabilities = common.capabilities,
}
