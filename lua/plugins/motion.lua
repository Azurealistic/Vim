return {
  -- Fast, Smooth Physics-Based Scrolling Animation (Zed Style)
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing = "quadratic",
      duration_multiplier = 0.4, -- 40% duration for ultra-fast, snappy Zed-style smooth scrolling
    },
  },
}
