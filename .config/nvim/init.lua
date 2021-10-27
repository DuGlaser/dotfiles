require("impatient")
require("defaults")
require("plugins")
require("packer_compiled")

vim.cmd("autocmd BufWritePost lua.plugins PackerCompile")
