return {
  "hedyhli/outline.nvim",
  opts = function()
    local defaults = require("outline.config").defaults
    local opts = {
      symbols = {
        icons = {},
        filter = vim.deepcopy(LazyVim.config.kind_filter),
      },
      keymaps = {
        up_and_jump = "<up>",
        down_and_jump = "<down>",
      },
      symbol_folding = {
        autofold_depth = 3,
        auto_unfold = {
          hovered = true,
          only = true,
        },
      },
      outline_items = {
        show_symbol_lineno = true,
        show_symbol_details = true,
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
