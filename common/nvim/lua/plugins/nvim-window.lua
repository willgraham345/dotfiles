return {
  "yorickpeterse/nvim-window",
  keys = {
    { "<leader>wc", "<cmd>lua require('nvim-window').pick()<cr>", desc = "nvim-window: Jump to window" },
    { "<C-w>c", "<cmd>lua require('nvim-window').pick()<cr>", desc = "nvim-window: Jump to window" },
  },
  config = true,
}
