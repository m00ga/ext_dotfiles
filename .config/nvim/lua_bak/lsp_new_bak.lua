local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local diagnostic = vim.diagnostic

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
	local map = function(mode, l, r, opts)
    	opts = opts or {}
    	opts.silent = true
    	opts.buffer = bufnr
    	keymap.set(mode, l, r, opts)
  	end
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
	require "lsp_signature".on_attach(signature_setup, bufnr)
	-- require 'illuminate'.on_attach(client)
end


local nvim_lsp = require('lspconfig')

-- nvim_lsp["pyright"].setup{
--   	capabilities = capabilities,
-- 	on_attach = function(client, bufnr)
-- 		-- on_attach(client, bufnr)
-- 		client.server_capabilities.completionProvider = false
--     	client.server_capabilities.hoverProvider = false
--     	client.server_capabilities.definitionProvider = false
--     	client.server_capabilities.rename = false
--     	client.server_capabilities.signature_help = false
-- 	end,
-- }
--
-- nvim_lsp['jedi_language_server'].setup {
-- 	  capabilities = capabilities,
-- 	  on_attach = on_attach,
-- }

  nvim_lsp.pylsp.setup {
    on_attach = on_attach,
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
    flags = {
      debounce_text_changes = 200,
    },
    capabilities = capabilities,
	cmd_env = {VIRTUAL_ENV = os.getenv("CONDA_PREFIX")},
	before_init = function(_, _)
		vim.env.VIRTUAL_ENV = os.getenv("CONDA_PREFIX")
	end
  }

nvim_lsp['html'].setup{
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp['clangd'].setup{
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp['cssls'].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp['tsserver'].setup{
	on_attach = on_attach,
	capabilities = capabilities
}

-- nvim_lsp['intelephense'].setup{
-- 	on_attach = on_attach,
-- 	capabilities = capabilities
-- }

nvim_lsp['phpactor'].setup{
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		["language_server_phpstan.enabled"] = true,
        ["language_server_psalm.enabled"] = false,
	}
}

nvim_lsp['yamlls'].setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			schemas = {
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "**/docker-compose*.yml"
			}
		}
	}
}

nvim_lsp['cmake'].setup{
	on_attach = on_attach,
	capabilities = capabilities,
}
