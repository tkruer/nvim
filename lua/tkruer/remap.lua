vim.g.mapleader = " "

vim.opt.clipboard:append("unnamedplus")

-- vim.keymap.set(
--     "n",
--     "<leader>fcf",
--     "lua: vim.lsp.buf.format",
--     { desc = "LSP: format current file" }
-- )

vim.keymap.set("n", "<leader>e", ":Ex<CR>")
