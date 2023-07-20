vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set('n', '<Space>', '<Nop>')
vim.g.mapleader = " "


require('treesitter')
require('terminal')
require('lsp')
require('dap-nvim')
require('dap-ui')


-- theme

vim.o.termguicolors = true
vim.cmd [[ colorscheme gruvbox ]]

-- indents

vim.cmd [[ set tabstop=4 shiftwidth=4 ]]

-- numbers

vim.cmd [[ set number ]]

-- lualine

require('lualine').setup{
	options = {
		theme = 'gruvbox',
		disabled_filetypes = { 'NvimTree' }
	},
}

-- telescope

require('telescope').setup{
	defaults = {
		file_ignore_patterns = {
			"Debug"
		}
	}	
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', ':lua require("telescope.builtin").find_files({ hidden = true })<CR>', {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
require('telescope').load_extension('projects')

require('Comment').setup()

require("toggleterm").setup{}

require "lsp_signature".setup{
	floating_window = true,
	hint_enable = false,
}

require('nvim-ts-autotag').setup()

-- cmake
vim.g.cmake_generate_options = {
	"-DCMAKE_EXPORT_COMPILE_COMMANDS=1"
}

vim.keymap.set('n', 'cg', ":CMakeGenerate<CR>")
vim.keymap.set('n', 'cb', ":CMakeBuild<CR>")
vim.keymap.set('n', 'cc', ":CMakeClean<CR>")

require("project_nvim").setup {}
vim.keymap.set('n', '<leader>fp', ':Telescope projects<CR>')

-- nvim-tree
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set('n', '<Leader>t', ":NvimTreeToggle<CR>")
vim.keymap.set('n', '<Leader>ft', ":NvimTreeFocus<CR>")
