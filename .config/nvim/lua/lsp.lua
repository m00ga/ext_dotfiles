local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')
    nmap('<leader>lf', function()
        vim.lsp.buf.format { timeout_ms = 2000 }
    end, 'Format')
    -- require('lsp_signature').on_attach(signature_setup, bufnr)
end

local util = require 'lspconfig/util'

local path = util.path

local function get_python_path(workspace)
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
    end

    if vim.env.CONDA_PREFIX then
        return path.join(vim.env.CONDA_PREFIX, 'bin', 'python')
    end

    for _, pattern in ipairs { '*', '.*' } do
        local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
        if match ~= '' then
            return path.join(path.dirname(match), 'bin', 'python')
        end
    end

    -- Fallback to system Python.
    -- return exepath 'python3' or exepath 'python' or 'python'
end

local servers = {
    sumneko_lua = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            format = { enable = false },
        },
    },
    -- pylsp = {
    --   settings = {
    --     pylsp = {
    --       plugins = {
    --         pycodestyle = { enabled = false },
    --         pyflakes = { enabled = false },
    --         pylint = { enabled = false },
    --         jedi_completion = { fuzzy = true },
    --         pyls_isort = { enabled = true },
    --         pylsp_mypy = { enabled = true },
    --         jedi = {
    --           environment = get_python_path(_G.rootdir),
    --         },
    --       },
    --     },
    --   },
    --   -- before_init = function(_, _)
    --   --   vim.env.VIRTUAL_ENV = os.getenv("CONDA_PREFIX")
    --   -- end,
    -- },
    pyright = {
        python = {
            pythonPath = get_python_path(_G.rootdir),
        },
    },
    yamlls = {
        yaml = {
            schemas = {
                ['https://raw.githubusercontent.com/docker/cli/master/cli/compose/schema/data/config_schema_v3.9.json'] = '*docker-compose*.{yml,yaml}',
            },
        },
    },
    tsserver = {
        diagnostics = { ignoredCodes = { 6133 } }
    }
}

-- require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.offsetEncoding = { 'utf-16' }

require('mason').setup()
require('mason-nvim-dap').setup {
    automatic_setup = true,
    handlers = {},
}
local null_ls = require 'null-ls'
null_ls.setup {
    sources = {
        -- lua
        null_ls.builtins.formatting.stylua,
        -- php
        null_ls.builtins.diagnostics.phpcs.with {
            diagnostics_postprocess = function(diagnostic)
                diagnostic.severity = vim.diagnostic.severity.HINT
            end,
        },
        null_ls.builtins.formatting.phpcbf,
        -- cpp
        null_ls.builtins.diagnostics.cpplint,
        -- null_ls.builtins.formatting.clang_format,
        -- python
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.flake8,
        -- text
        null_ls.builtins.diagnostics.ltrs,
        -- css
        null_ls.builtins.diagnostics.stylelint.with {
            diagnostics_postprocess = function(diagnostic)
                diagnostic.severity = vim.diagnostic.severity.HINT
            end,
        },
        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.diagnostics.eslint_d,
        require 'typescript.extensions.null-ls.code-actions',
    },
}
require('mason-null-ls').setup {
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = true,
}

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {}

mason_lspconfig.setup_handlers {
    function(server_name)
        if server_name == 'tsserver' then
            require('typescript').setup {
                server = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers['tsserver']
                },
                disable_commands = true,
            }
            return
        end
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}
require('lspconfig')['clangd'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = servers['clangd'],
}

require('fidget').setup()
require 'nvim-cmp'
