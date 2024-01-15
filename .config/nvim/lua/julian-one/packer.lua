vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	-- Telescope
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	-- Color Scheme
	use 'folke/tokyonight.nvim'
	-- Treesitter
	use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	-- Undotree
	use( 'mbbill/undotree' )
	-- Fugitive
	use( 'tpope/vim-fugitive' )
	-- LSP
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},
			{'neovim/nvim-lspconfig'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/nvim-cmp'},
			{'L3MON4D3/LuaSnip'},
		}
	}

end)
