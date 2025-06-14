-- ~/.config/nvim/lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------
--  Pretend LazyVim’s option file is already loaded → it won’t run.
--------------------------------------------------------------------
package.loaded["lazyvim.config.options"] = true

require("lazy").setup({
  spec = {
    -- ❶  **Your** plugins & overrides.
    import = "tkruer.lazy",

    -- ❷  **LazyVim library, but with everything switched off.**
    -- {
    --   "LazyVim/LazyVim",
    --   import = "lazyvim.plugins",  -- makes extras resolvable
    --   lazy  = true,                -- skip its config() call
    --   opts  = {
    --     defaults = {
    --       autocmds = false,
    --       keymaps  = false,
    --       plugins  = false,  -- turns off the “starter bundle”
    --     },
    --   },
    -- },
    --
    -- ❸  **Just the extra you need.**
    -- { import = "lazyvim.plugins.extras.lang.go" },
  },

  change_detection = { notify = false },
})
