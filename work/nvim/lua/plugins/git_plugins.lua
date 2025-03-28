return {
  -- {
  -- "NeogitOrg/neogit",
  -- dependencies = {
  --   "nvim-lua/plenary.nvim", -- required
  --   "sindrets/diffview.nvim", -- optional - Diff integration
  --
  --   -- Only one of these is needed.
  --   -- "nvim-telescope/telescope.nvim", -- optional
  --   "ibhagwan/fzf-lua", -- optional
  --   -- "echasnovski/mini.pick", -- optional
  -- },
  -- config = true,
  -- }
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    cmd = { "Git", "G" },
    lazy = false,
  },
  {
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- OR 'ibhagwan/fzf-lua',
      -- OR 'folke/snacks.nvim',
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  },
}
