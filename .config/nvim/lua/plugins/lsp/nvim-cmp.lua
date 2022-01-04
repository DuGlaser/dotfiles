local cmp = require("cmp")

local lspkind = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "ﰠ",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "塞",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "פּ",
	Event = "",
	Operator = "",
	TypeParameter = "",
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
		deprecated = true,
		format = function(entry, vim_item)
			vim_item.kind = lspkind[vim_item.kind] .. " " .. vim_item.kind
			vim_item.menu = ({
				buffer = "[Buffer]",
				path = "[Path]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				user_dictionary = "[Dictionary]",
			})[entry.source.name]
			vim_item.dup = ({
				buffer = 0,
			})[entry.source.name] or 1
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
		{ name = "buffer", max_item_count = 4, priority = 49 },
		{ name = "ultisnips", max_item_count = 2 },
		{ name = "path" },
		{ name = "nvim_lua" },
	}),
})
