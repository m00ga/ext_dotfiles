require("toggleterm").setup{}

-- vim.keymap.set('n', '<Leader>th', ':ToggleTerm direction=horizontal<CR>')

vim.keymap.set('n', '<Leader><Leader>', ':ToggleTerm direction=horizontal<CR>')

vim.keymap.set('n', '<Leader>tt', ':ToggleTerm direction=tab<CR>')

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
