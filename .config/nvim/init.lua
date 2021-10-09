require("impatient")
require("defaults")
require("plugins")

vim.cmd("autocmd BufWritePost lua.plugins PackerCompile")
