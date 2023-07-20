local lsp = require('lsp-zero')
local cmp = require('cmp')

lsp.preset('recommended')

lsp.configure("pylsp", {
	settings = {
		pylsp = {
			plugins = {
				pylint = { enabled = true, executable = "pylint" },
				pyflakes = { enabled = false },
				pycodestyle = { enabled = false },
				jedi_completion = { fuzzy = true },
				pyls_isort = { enabled = true },
				pylsp_mypy = { enabled = true },
			},
		},
	},
})

lsp.setup_nvim_cmp({
	mapping = {
		['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			end
		end, { "i", "s" }),
	}
})

lsp.setup()
