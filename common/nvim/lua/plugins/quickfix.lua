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
      auto_enable = true,
      auto_resize_height = false,
      preview = {
        winblend = 0,
      },
      filter = {
        fzf = {
            action_for = {
                ['ctrl-t'] = {
                    description = [[Press ctrl-t to open up the item in a new tab]],
                    default = 'tabedit'
                },
                ['ctrl-X'] = {
                    description = [[Press ctrl-v to open up the item in a new vertical split]],
                    default = 'vsplit'
                },
                ['ctrl-x'] = {
                    description = [[Press ctrl-x to open up the item in a new horizontal split]],
                    default = 'split'
                },
                ['ctrl-q'] = {
                    description = [[Press ctrl-q to toggle sign for the selected items]],
                    default = 'signtoggle'
                },
                ['ctrl-c'] = {
                    description = [[Press ctrl-c to close quickfix window and abort fzf]],
                    default = 'closeall'
                }
            },
        }
      }

    })
  end,
}
