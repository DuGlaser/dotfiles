local M = {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdLineEnter" },
	commit = "950d0e3a93ba61c13b031c086d11eacf4bd48d24",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
		{
			"hrsh7th/vim-vsnip",
			config = function()
				vim.cmd([[
          imap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
          smap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
          imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
          smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

          let g:vsnip_filetypes = {}
          let g:vsnip_filetypes.javascriptreact = ['javascript']
          let g:vsnip_filetypes.typescriptreact = ['typescript']
        ]])

				vim.g.vsnip_snippet_dir = vim.fn.expand("$HOME/.config/nvim/.vsnip")
			end,
		},
		{
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({
					check_ts = true,
				})
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				local cmp = require("cmp")
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end,
		},
	},
}

function M.config()
	local cmp = require("cmp")
	local types = require("cmp.types")
	local border = require("plugins.lsp.utils").border
	local lspkind = require("lspkind")

	cmp.setup({
		window = {
			documentation = {
				border = border,
				winhighlight = "FloatBorder:FloatBorder",
			},
			completion = {
				border = border,
				winhighlight = "FloatBorder:FloatBorder,CursorLine:Visual",
			},
		},
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body)
			end,
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				menu = {
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[Latex]",
				},
			}),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<C-y>"] = cmp.config.disable,
			["<C-n>"] = cmp.mapping({
				i = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
			}),
			["<C-p>"] = cmp.mapping({
				i = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
			}),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
			{ name = "vsnip" },
			{ name = "nvim_lsp", max_item_count = 20 },
			{ name = "buffer", keyword_length = 2, max_item_count = 4 },
			{ name = "path" },
			{ name = "nvim_lua" },
		}),
	})

	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	vim.cmd([[hi CmpItemAbbrMatch guifg=#fe8019]])
end

return M
