local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local luasnip = require("luasnip")
luasnip.config.setup {}

cmp.setup {
	snippet = {
		expand = function (args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" }
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete {},
		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true
		},
		["<Tab>"] = cmp.mapping(
			function (fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(
			function (fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.expand_or_locally_jumpable(-1) then
					luasnip.expand_or_jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
	},
}
