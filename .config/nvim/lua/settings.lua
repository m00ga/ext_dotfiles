vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.o.termguicolors = true
vim.cmd [[set termguicolors]]
vim.cmd [[set background=dark]]
vim.cmd [[colorscheme gruvbox]]

vim.cmd [[set expandtab ts=4 sw=4]]

vim.wo.number = true
vim.o.breakindent = true
vim.o.completeopt = 'menuone,noselect'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = false,
}

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'gruvbox',
    component_separators = '|',
    section_separators = '',
    disabled_filetypes = { 'packer', 'NvimTree' },
  },
}

require('Comment').setup()

require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    initial_mode = 'normal',
  },
}

pcall(require('telescope').load_extension, 'fzf')
-- require('telescope').load_extension 'file_browser'
-- vim.keymap.set('n', '<leader>ft', ':Telescope file_browser<CR>')
require('nvim-tree').setup()
vim.keymap.set('n', '<leader>ft', ':NvimTreeToggle<CR>')
-- require('telescope').load_extension 'projects'
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- require('lsp_signature').setup {
--   floating_window = true,
--   hint_enable = false,
-- }

require('toggleterm').setup {}
-- local Terminal = require('toggleterm.terminal').Terminal
-- local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }
-- local lazydocker = Terminal:new { cmd = 'lazydocker', hidden = true, direction = 'float' }

vim.keymap.set('n', '<Leader><Leader>', ':ToggleTerm direction=horizontal<CR>')

vim.keymap.set('n', '<Leader>tt', ':ToggleTerm direction=tab<CR>')

-- vim.keymap.set('n', '<Leader>lg', function()
--   lazygit:toggle()
-- end)
--
-- vim.keymap.set('n', '<Leader>ld', function()
--   lazydocker:toggle()
-- end)

vim.keymap.set('t', 'ii', '<C-\\><C-n>')

vim.keymap.set('', '<Leader>ll', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })
vim.keymap.set('', '<Leader>sd', ':lua vim.diagnostic.open_float(nil, {})<CR>', { silent = true })

-- cmake
vim.g.cmake_generate_options = {
  '-DCMAKE_EXPORT_COMPILE_COMMANDS=1',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'h', 'cpp', 'hpp' },
  callback = function()
    vim.keymap.set('n', 'cg', ':CMakeGenerate<CR>')
    vim.keymap.set('n', 'cb', ':CMakeBuild<CR>')
    vim.keymap.set('n', 'cc', ':CMakeClean<CR>')
  end,
})

require('telescope').load_extension 'session-lens'
vim.keymap.set('n', '<leader>fp', ':Telescope session-lens search_session<CR>', { silent = true })

require 'treesitter'
require 'rooter'
require 'lsp'
require 'bline'
require 'nv-dap'
