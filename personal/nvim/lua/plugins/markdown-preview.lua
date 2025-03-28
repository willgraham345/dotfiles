return {
  -- "iamcco/markdown-preview.nvim",
  -- cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  -- build = "cd app && yarn install",
  -- init = function()
  --   vim.g.mkdp_filetypes = { "markdown" }
  -- end,
  -- ft = { "markdown" },
  -- config = function()
  --   -- vim.g.mkdp_auto_start = 1 -- Automatically start
  --   -- vim.g.mkdp_refresh_slow = 1 -- Update preview in real-time
  --   -- vim.g.mkdp_combine_preview = 1
  --   -- vim.g.mkdp_combine_preview_auto_refresh = 1
  -- end,
  -- This is included in LazyVim as an extra :)
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  -- },
  -- {
  --   { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  -- },
  -- For blink.cmp's completion
  -- source
  -- dependencies = {
  --     "saghen/blink.cmp"
  -- },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
}
