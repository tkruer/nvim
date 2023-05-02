vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	'nvim-telescope/telescope.nvim', tag = '0.1.1',
  	requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {  
	'nvim-tree/nvim-tree.lua',
	requires = {
		'nvim-tree/nvim-web-devicons', -- optional
  	},
  	config = function()
    	require("nvim-tree").setup {}
  	end
  }

  use({
  	'projekt0n/github-nvim-theme', tag = 'v0.0.7',
	config = function()
	require('github-theme').setup({
      	-- ...
    	})

    	vim.cmd('colorscheme github_dark_default')
  	end
  })


  use {
	"williamboman/mason.nvim",
  }

  use("github/copilot.vim")

  use {
	'VonHeikemen/lsp-zero.nvim',
  	branch = 'v2.x',
  	requires = {
    		{'neovim/nvim-lspconfig'},             -- Required
    		{'williamboman/mason.nvim', run = function()
        	pcall(vim.cmd, 'MasonUpdate')
      			end,
    		},
    		{'williamboman/mason-lspconfig.nvim'}, -- Optional
   		{'hrsh7th/nvim-cmp'},     -- Required
    		{'hrsh7th/cmp-nvim-lsp'}, -- Required
    		{'L3MON4D3/LuaSnip'},     -- Required
	}
   }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
   use {'romgrk/barbar.nvim', requires = {
  	'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
  	'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
	}
   }

use("numToStr/FTerm.nvim")

end)
