-- return {
--   {
--     "simrat39/symbols-outline.nvim",
--     opts = function(_, opts)
--       table.insert(opts.sources, {
--         symbol_folding = {
--           autofold_depth = 1,
--           auto_unfold = {
--             hovered = true,
--             only = 2,
--           },
--         },
--       })
--     end,
--   },
-- }
--{
return {
  "hedyhli/outline.nvim",
  keys = { { "<leader>cs", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
  cmd = "Outline",
  opts = function()
    local defaults = require("outline.config").defaults
    local opts = {
      symbols = {
        icons = {},
        filter = vim.deepcopy(LazyVim.config.kind_filter),
        symbol_folding = {
          autofold_depth = 1,
          auto_unfold = {
            only = 3,
          },
        },
        outline_items = {
          -- show_symbol_details = false,
          show_symbol_lineno = true,
        },
        preview_window = {
          auto_preview = false,
        },
      },
      keymaps = {
        up_and_jump = "<up>",
        down_and_jump = "<down>",
      },
    }

    for kind, symbol in pairs(defaults.symbols.icons) do
      opts.symbols.icons[kind] = {
        icon = LazyVim.config.icons.kinds[kind] or symbol.icon,
        hl = symbol.hl,
      }
    end
    return opts
  end,
}
