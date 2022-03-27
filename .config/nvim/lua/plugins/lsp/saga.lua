local saga = require("lspsaga")
local diagnosticsGroup = require("plugins.lsp.utils").diagnosticsGroup

saga.init_lsp_saga({
	error_sign = diagnosticsGroup.err_group.sign,
	warn_sign = diagnosticsGroup.warn_group.sign,
	hint_sign = diagnosticsGroup.hint_group.sign,
	infor_sign = diagnosticsGroup.info_group.sign,
	code_action_prompt = {
		enable = false,
	},
})
