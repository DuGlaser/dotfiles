require("plugins.lsp.trouble")

local utils = require("plugins.lsp.utils")
local border = utils.border

local saga = require("lspsaga")
local diagnosticsGroup = utils.diagnosticsGroup
saga.init_lsp_saga({
	-- error_sign = diagnosticsGroup.err_group.sign,
	-- warn_sign = diagnosticsGroup.warn_group.sign,
	-- hint_sign = diagnosticsGroup.hint_group.sign,
	-- infor_sign = diagnosticsGroup.info_group.sign,
	code_action_prompt = {
		enable = true,
		sign = false,
		sign_priority = 20,
		virtual_text = false,
	},
})

-- NOTE: same lspsaga.nvim
for _, g in pairs(diagnosticsGroup) do
	vim.fn.sign_define(g.highlight, {
		text = g.sign,
		texthl = g.highlight,
		linehl = string.format("%sLine", g.highlight),
	})
end

require("lspinstall").setup()
require("lspinstall").post_install_hook = function()
	vim.cmd("bufdo e")
end

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }

	vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<Space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<Space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<Space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<Space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<Space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<Space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "<Space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

	buf_set_keymap("n", "<Space>rn", "<cmd>Lspsaga rename<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	buf_set_keymap("n", "<Space>cc", "<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>", opts)

	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_exec(
			[[
           augroup LspFormatOnSave
               autocmd! * <buffer>
               autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_seq_sync(nil, 10000, {"efm"})
           augroup END
      ]],
			false
		)
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = border,
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = border,
	})

	-- NOTE: same textDocument/publishDiagnostics
	vim.diagnostic.config({
		underline = true,
		update_in_insert = false,
		virtual_text = { spacing = 4, prefix = "●" },
		severity_sort = true,
	})
end

-- Custom initialize
require("plugins.lsp.server.rust").setup(on_attach)
require("plugins.lsp.server.typescript").setup(on_attach)
require("plugins.lsp.server.lua").setup(on_attach)

local other_lsp_list = { "terraform" }
for _, lsp in ipairs(other_lsp_list) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	})
end

vim.cmd([[hi NormalFloat guibg=#32302f]])
vim.cmd([[hi FloatBorder guifg=#fe8019]])
