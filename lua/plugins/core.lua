return {
  {
    "LazyVim/LazyVim",
    {
      "folke/trouble.nvim",
      opts = { use_diagnostic_signs = true },
    },
    { "folke/trouble.nvim", enabled = false },
    {
      "simrat39/symbols-outline.nvim",
      cmd = "SymbolsOutline",
      keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
      config = true,
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = { "hrsh7th/cmp-emoji" },
      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        table.insert(opts.sources, { name = "emoji" })
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      keys = {
        {
          "<leader>fp",
          function()
            require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root, hidden = false })
          end,
          desc = "Find Plugin File",
        },
      },
      opts = {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
        },
      },
    },
    {
      "telescope.nvim",
      dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "jose-elias-alvarez/typescript.nvim",
        init = function()
          require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
            vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
          end)
        end,
      },
      ---@class PluginLspOpts
      opts = {
        ---@type lspconfig.options
        servers = {
          tsserver = {
            settings = {},
          },
          pyright = {
            settings = {},
          },
          pylsp = {
            settings = {},
          },
          tailwindcss = {
            settings = {},
          },
          lua_ls = {
            settings = {},
          },
          jsonls = {
            settings = {},
          },
          rust_analyzer = {
            settings = {},
          },
          html = {
            settings = {},
          },
          mojo = {
            settings = {},
          },
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          tsserver = function(_, opts)
            require("typescript").setup({ server = opts })
            return true
          end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      },
    },

    -- add more treesitter parsers
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "bash",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
      },
    },

    -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
    -- would overwrite `ensure_installed` with the new value.
    -- If you'd rather extend the default config, use the code below instead:
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        -- add tsx and treesitter
        vim.list_extend(opts.ensure_installed, {
          "tsx",
          "typescript",
        })
      end,
    },

    -- the opts function can also be used to change the default opts:
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = function(_, opts)
        table.insert(opts.sections.lualine_x, "🤠")
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = function()
        return {
          --[[add your custom lualine config here]]
        }
      end,
    },

    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "stylua",
          "shellcheck",
          "shfmt",
          "flake8",
        },
      },
    },

    -- Use <tab> for completion and snippets (supertab)
    -- first: disable default <tab> and <s-tab> behavior in LuaSnip
    {
      "L3MON4D3/LuaSnip",
      keys = function()
        return {}
      end,
    },
    -- then: setup supertab in cmp
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-emoji",
      },
      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        local has_words_before = function()
          unpack = unpack or table.unpack
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local luasnip = require("luasnip")
        local cmp = require("cmp")

        opts.mapping = vim.tbl_extend("force", opts.mapping, {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        })
      end,
    },
    -- Some of the hacked together plugins for Theme and Mojo usage
    {
      "czheo/mojo.vim",
      ft = { "mojo" },
      init = function()
        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
          pattern = { "*.🔥" },
          callback = function()
            if vim.bo.filetype ~= "mojo" then
              vim.bo.filetype = "mojo"
            end
          end,
        })
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "mojo",
          callback = function()
            local modular = vim.env.MODULAR_HOME
            local lsp_cmd = modular .. "/pkg/packages.modular.com_mojo/bin/mojo-lsp-server"
            vim.bo.expandtab = true
            vim.bo.shiftwidth = 4
            vim.bo.softtabstop = 4
            vim.lsp.start({
              name = "mojo",
              cmd = { lsp_cmd },
            })
          end,
        })
      end,
    },
    {
      "projekt0n/github-nvim-theme",
      lazy = false,
      priority = 1000,
      config = function()
        require("github-theme").setup({})
        vim.cmd("colorscheme primer_dark")
      end,
    },
    opts = {
      colorscheme = "github_dark_high_contrast",
    },
    {
      "projekt0n/github-nvim-theme",
    },
    {
      "LunarVim/primer.nvim",
    },
  },
}
