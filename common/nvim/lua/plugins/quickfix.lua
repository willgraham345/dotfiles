return {
  "kevinhwang91/nvim-bqf",
  event = "VeryLazy",

  -- opts = function(_, opts)
  --   preview = {
  --     winblend = 100,
  --   }
  -- end,

  config = function()
    require("bqf").setup({
      preview = {
        winblend = 0,
      },
    })
  end,
}
