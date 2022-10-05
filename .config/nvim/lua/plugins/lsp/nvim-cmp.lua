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
	experimental = {
		ghost_text = false,
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
	mapping = {
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
	},
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

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	enabled = false,
})

vim.cmd([[hi CmpItemAbbrMatch guifg=#fe8019]])
