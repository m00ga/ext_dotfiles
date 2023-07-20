vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
	
	use 'wbthomason/packer.nvim'
	-- use 'neovim/nvim-lspconfig'
	-- use 'hrsh7th/cmp-nvim-lsp'
	-- use 'hrsh7th/cmp-buffer'
	-- use 'hrsh7th/cmp-path'
	-- use 'hrsh7th/cmp-cmdline'
	-- use 'hrsh7th/nvim-cmp'
	-- use 'hrsh7th/cmp-vsnip'
	-- use 'hrsh7th/vim-vsnip'
	-- use 'onsails/lspkind.nvim'
	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use {
		'numToStr/Comment.nvim',
		config = function()
      		require('Comment').setup()
  		end
	}
	use {
		"windwp/nvim-autopairs",
    	config = function() require("nvim-autopairs").setup {} end
	}
	use {"akinsho/toggleterm.nvim", tag = '*', config = function()
  		require("toggleterm").setup()
		end
	}
	use {
  		"ray-x/lsp_signature.nvim",
	}
	use "windwp/nvim-ts-autotag"
	use 'morhetz/gruvbox'
	use 'RRethy/vim-illuminate'
	use 'cdelledonne/vim-cmake'
	use {
  		"ahmedkhalf/project.nvim",
  		config = function()
    		require("project_nvim").setup {}
  		end
	}
	use 'mfussenegger/nvim-dap'
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
	use {
  		'nvim-tree/nvim-tree.lua',
  		requires = {
    		'nvim-tree/nvim-web-devicons', -- optional, for file icons
  		},
  		tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}
end)
