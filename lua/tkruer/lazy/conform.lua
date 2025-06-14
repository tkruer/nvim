return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      format_on_save = { -- you added this earlier
        lsp_fallback = true,
        timeout_ms = 1000,
      },

      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofmt" },
        rust = { "rustfmt" },
        zig = { "zigfmt" },

        javascript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },

        c = { "clang_format" },
        cpp = { "clang_format" },
        h = { "clang_format" },

        python = {
          "isort",
          "black",
        },

      },
    })
  end,
}
