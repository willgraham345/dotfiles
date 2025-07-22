require("config.lazy")

vim.cmd("colorscheme sonokai")
local symbols_to_d2 = require("utilities.symbols_to_d2")

-- Create a custom Neovim command
vim.api.nvim_create_user_command(
  "SymbolsToD2", -- The name of your command
  symbols_to_d2.convert_symbols_buffer_to_d2, -- The Lua function to call
  {
    desc = "Converts symbols.nvim output (selection/buffer) to D2 and copies to clipboard",
    range = true, -- Allows the command to operate on a visual selection
    -- You can add `bang = true` if you want a ! version, etc.
  }
)
