-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    use 'nvim-treesitter/nvim-treesitter-context'

    use 'ray-x/lsp_signature.nvim'
    
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/plenary.nvim'
    
    use 'tpope/vim-commentary'
    
    use 'tpope/vim-fugitive'
    
    use 'tbastos/vim-lua'
    use 'nvim-lua/completion-nvim'
    use 'nvim-lua/lsp-status.nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    
    use({
        'projekt0n/github-nvim-theme',
        config = function()
          require('github-theme').setup({
            -- ...
          })
        end
      })
    
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use { 'mhartington/formatter.nvim' }

    use "akinsho/toggleterm.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use "mbbill/undotree"

    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'

    use 'github/copilot.vim'


end)
