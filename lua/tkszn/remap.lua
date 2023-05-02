vim.g.mapleader = " "
vim.g.maplocalleader = " "

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- Terminal remaps --
vim.keymap.set('n', '<leader>to>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<leader>tc', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- File Tree remaps --
local tree_cb = require('nvim-tree.api')

vim.keymap.set('n', '<leader>ee', tree_cb.tree.open, {})
vim.keymap.set('n', '<leader>ec', tree_cb.tree.close, {})

-- File Tab remaps --
vim.keymap.set('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', {})
vim.keymap.set('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', {})
vim.keymap.set('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', {})
vim.keymap.set('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', {})
vim.keymap.set('n', '<leader>c', '<Cmd>BufferClose<CR>', {})