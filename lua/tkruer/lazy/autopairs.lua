return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",          -- lazy-load on first insert
  opts  = {
    check_ts = true,             -- use Treesitter to avoid stupid pairs
    fast_wrap = {},              -- <M-e> wraps the next text object
  },
}
