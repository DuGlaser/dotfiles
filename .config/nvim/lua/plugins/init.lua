local function runtime(file)
	vim.cmd("runtime lua/plugins/" .. file)
end

require("plugins.plugins")

require("plugins.bufferline")
require("plugins.defx")
require("plugins.gitsign")
require("plugins.hlslens")
require("plugins.hop")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.ultisnips")

runtime("grepper/init.vim")
runtime("sandwich/init.vim")
