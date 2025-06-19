return {
  "nvim-treesitter/nvim-treesitter-context",
  keys = {
    { "<C-a>", ":TSContextToggle<CR>", { noremap = true, silent = true } },
  },
  lazy = false,
  config = function()
    require("treesitter-context").setup({
      enable = true,
      multiwindow = false,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 1,
      trim_scope = "outer",
      mode = "cursor",
      separator = nil,
      zindex = 20,
      on_attach = nil,
    })
  end,
}
