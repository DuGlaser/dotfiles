local common = require("plugins.lsp.common")
local nvim_lsp = require("lspconfig")

local loop = vim.loop

local function set_from_poetry(settings)
	if loop.fs_stat("poetry.lock") then
		local f = io.popen("poetry env info -p 2>/dev/null", "r")
		if f then
			local virtual_env = f:read()
			settings.python.pythonPath = string.format("%s/bin/python", virtual_env)
			f:close()
			return true
		end
	end
	return false
end

local python_root_files = {
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"requirements.txt",
	"Pipfile",
	"pyrightconfig.json",
}

local M = {}

M.setup = function()
	local setting = {
		on_attach = function(client, bufnr)
			common.on_attach(client, bufnr)

			set_from_poetry(client.config.settings)
		end,
		root_dir = nvim_lsp.util.root_pattern(python_root_files),
		filetypes = { "python" },
		settings = {
			python = {
				analysis = {
					autoImportCompletions = true,
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "workspace",
				},
			},
		},
	}

	return setting
end

M.use_mason = true

return M
