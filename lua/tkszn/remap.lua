vim.g.mapleader = " "
vim.g.maplocalleader = " "

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- Terminal remaps --


-- File Tree remaps --
local tree_cb = require('nvim-tree.api')

vim.keymap.set('n', '<leader>ee', tree_cb.tree.open, {})
vim.keymap.set('n', '<leader>ec', tree_cb.tree.close, {})
