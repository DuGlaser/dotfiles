local M = {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdLineEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
		{
			"zbirenbaum/copilot-cmp",
			dependencies = {
				{
					"zbirenbaum/copilot.lua",
					cmd = "Copilot",
					event = "InsertEnter",
					config = function()
						require("copilot").setup({
							suggestion = { enabled = false },
							panel = { enabled = false },
						})
					end,
				},
			},
			config = function()
				require("copilot_cmp").setup()
			end,
		},
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

	vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

	local has_words_before = function()
		if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
			return false
		end
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
	end

	cmp.setup({
		sorting = {
			priority_weight = 2,
			comparators = {
				require("copilot_cmp.comparators").prioritize,
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.locality,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
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
				symbol_map = { Copilot = "" },
				menu = {
					copilot = "[Copilot]",
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
			["<Tab>"] = vim.schedule_wrap(function(fallback)
				if cmp.visible() and has_words_before() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end),
		}),
		sources = cmp.config.sources({
			{ name = "vsnip" },
			{ name = "copilot" },
			{ name = "nvim_lsp", max_item_count = 20 },
			{ name = "buffer", keyword_length = 2, max_item_count = 4 },
			{ name = "path" },
			{ name = "nvim_lua", max_item_count = 20 },
		}),
	})

	vim.cmd([[hi CmpItemAbbrMatch guifg=#fe8019]])
end

return M
