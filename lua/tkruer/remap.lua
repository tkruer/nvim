vim.g.mapleader = " "

vim.opt.clipboard:append("unnamedplus")

vim.keymap.set(
    "n",
    "<leader>fcf",
    function()
        vim.lsp.buf.format { async = true }
    end,
    { desc = "LSP: format current file" }
)
