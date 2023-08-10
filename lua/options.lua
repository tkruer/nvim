vim.g.mapleader = ' '

local options = {
    undofile       = '~/.vim/undodir',
    undofile       = true,
    clipboard      = 'unnamedplus',
    hlsearch       = false,
    ignorecase     = true,
    smartcase      = true,
    backupcopy     = 'yes',
    inccommand     = 'split',
    hidden         = true,
    termguicolors  = true,
    number         = true,
    relativenumber = true,
    wrap           = false,
    expandtab      = true,
    shiftwidth     = 4,
    softtabstop    = -1,
    autoindent     = true,
    splitbelow     = true,
    splitright     = true,
    signcolumn     = 'yes',
    completeopt    = 'menuone,noselect',
    laststatus     = 3,
    scrolloff      = 5,
    sidescrolloff  = 5,
    wildignorecase = true,
    wildoptions    = 'pum',
    title          = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
