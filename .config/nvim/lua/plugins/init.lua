local function runtime(file)
	vim.cmd("runtime lua/plugins/" .. file)
end

require("plugins.plugins")

runtime("grepper/init.vim")
runtime("sandwich/init.vim")
