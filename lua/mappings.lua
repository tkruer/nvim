vim.g.mapleader = ' '

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- List of color schemes

-- Variable to track the current color scheme index
-- local current_scheme = 1

-- -- Function to toggle through color schemes
-- local function toggle_color_scheme()
--     current_scheme = current_scheme + 1
--     if current_scheme > #color_schemes then
--         current_scheme = 1
--     end
--     vim.cmd('colorscheme ' .. color_schemes[current_scheme])
-- end

-- -- Export the toggle_color_scheme function
-- return {
--     toggle_color_scheme = toggle_color_scheme
-- }


-- -- Key mapping to toggle color schemes

-- vim.api.nvim_set_keymap('n', '<leader>tt', ':lua require("mappings").toggle_color_scheme()<CR>', { noremap = true, silent = true })

