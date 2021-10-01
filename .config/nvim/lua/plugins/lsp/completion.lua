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
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "ultisnips" },
		{ name = "buffer" },
		{ name = "path" },
	},
})

require("nvim-autopairs.completion.cmp").setup({
	map_cr = true,
	map_complete = true,
	auto_select = true,
	insert = false,
	map_char = {
		all = "(",
		tex = "{",
	},
})
