local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<Leader>,', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<Leader>.', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<Leader><', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<Leader>>', '<Cmd>BufferMoveNext<CR>', opts)
map('n', '<Leader>bc', '<Cmd>BufferClose<CR>', opts)
map('n', '<Leader>bp', '<Cmd>BufferPin<CR>', opts)

require('barbar').setup {
  clickable = false,
  icons = {
    filetype = {
      enabled = true
    },
    modified = {button = '●'},
    button = " "
  },
}
