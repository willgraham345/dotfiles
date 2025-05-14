return {
  -- {
  --   "mg979/vim-visual-multi",
  -- },
  -- lazy.nvim:
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
        'nvimtools/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    -- TODO: Find a way to add this into the keymaps
    -- keys = {
    --     {
    --         mode = { 'v', 'n' },
    --         '<Leader>m',
    --         '<cmd>MCstart<cr>',
    --         desc = 'Create a selection for selected text or word under the cursor',
    --     },
    -- },
  }
}
