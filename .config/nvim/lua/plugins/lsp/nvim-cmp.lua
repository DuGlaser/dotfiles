local cmp = require("cmp")

local lspkind = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

local border = require("plugins.lsp.utils").border

cmp.setup({
	documentation = {
		border = border,
		winhighlight = "Normal:FloatBorder",
	},
	experimental = {
		ghost_text = false,
	},
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = string.format("%s %s", lspkind[vim_item.kind], vim_item.kind)
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				ultisnips = "[Snip]",
				nvim_lua = "[Lua]",
				latex_symbols = "[LaTeX]",
			})[entry.source.name]
			return vim_item
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<C-y>"] = cmp.config.disable,
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp", max_item_count = 20, priority = 51 },
		{ name = "ultisnips", max_item_count = 2 },
		{ name = "path" },
		{ name = "nvim_lua" },
	}, {
		{ name = "buffer", max_item_count = 4, priority = 49 },
	}),
})

vim.cmd([[hi CmpItemAbbrMatch guifg=#fe8019]])
