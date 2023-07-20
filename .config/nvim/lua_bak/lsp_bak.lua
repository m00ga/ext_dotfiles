-- local fn = vim.fn
-- local api = vim.api
-- local keymap = vim.keymap
-- local lsp = vim.lsp
-- local diagnostic = vim.diagnostic
--
-- local utils = require("utils")

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  --
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	require "lsp_signature".on_attach(signature_setup, bufnr)
	-- require 'illuminate'.on_attach(client)
end


local nvim_lsp = require('lspconfig')

nvim_lsp["pyright"].setup{
  	capabilities = capabilities,
	on_attach = function(client, bufnr)
		-- on_attach(client, bufnr)
		client.server_capabilities.completionProvider = false
    	client.server_capabilities.hoverProvider = false
    	client.server_capabilities.definitionProvider = false
    	client.server_capabilities.rename = false
    	client.server_capabilities.signature_help = false
	end,
}

nvim_lsp['jedi_language_server'].setup {
	  capabilities = capabilities,
	  on_attach = on_attach,
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
