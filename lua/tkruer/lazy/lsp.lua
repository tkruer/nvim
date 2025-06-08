return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    -------------------------------------------------
    -- 0 ▸ Formatting (unchanged)
    -------------------------------------------------
    require("conform").setup({
      formatters_by_ft = {},
    })

    -------------------------------------------------
    -- 1 ▸ nvim-cmp (single, full setup)
    -------------------------------------------------
    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
      }),
    })

    -------------------------------------------------
    -- 2 ▸ LSP capabilities
    -------------------------------------------------
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities =
      vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

    -------------------------------------------------
    -- 3 ▸ on_attach with buffer-local mappings
    -------------------------------------------------
    local on_attach = function(_, bufnr)
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
      end

      map("gd", vim.lsp.buf.definition, "Go to Definition")
      -- (optional but useful)
      map("gD", vim.lsp.buf.declaration, "Go to Declaration")
      map("gi", vim.lsp.buf.implementation, "Go to Implementation")
      map("gr", vim.lsp.buf.references, "Go to References")
    end

    -------------------------------------------------
    -- 4 ▸ Plugin setups
    -------------------------------------------------
    require("fidget").setup({})
    require("mason").setup()

    require("mason-lspconfig").setup({
      automatic_enable = true,
      ensure_installed = { 
        "lua_ls", "rust_analyzer", "gopls",
        "clangd", 
      },

      handlers = {
        -- default handler for every server
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,

        -- zls customisation
        zls = function()
          local lspconfig = require("lspconfig")
          lspconfig.zls.setup({
            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              zls = {
                enable_inlay_hints = true,
                enable_snippets = true,
                warn_style = true,
              },
            },
          })
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave = 0
        end,

        -- lua_ls customisation
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                format = {
                  enable = true,
                  defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                  },
                },
              },
            },
          })
        end,
      },
    })

    -------------------------------------------------
    -- 5 ▸ Diagnostics UI (unchanged)
    -------------------------------------------------
    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end,
}
