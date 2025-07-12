return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {}, -- Optional
        handlers = {
          -- Prevent auto-setup of rust_analyzer
          rust_analyzer = function() end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lsp = require("lspconfig")
      local caps = require("cmp_nvim_lsp").default_capabilities()

      -- Example: other servers
      lsp.pyright.setup({ capabilities = caps })
      lsp.jdtls.setup({
        capabilities = caps,
        cmd = { "jdtls" }, -- assumes it's installed via mason
        root_dir = lsp.util.root_pattern(".git", "build.gradle", "pom.xml"),
      })
    end,
  },
  -- cmp config remains the same...
}
