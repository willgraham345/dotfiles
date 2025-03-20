if vim.g.vscode then
  -- require("user.vscode_keymaps")
  require("config.lazy")
else
  local FileUtilities = require("utilities.file_utilities")
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.loader.enable()

  -- Set working directory
  if vim.fn.argc() == 1 then
    local arg = vim.fn.argv()[1]
    -- If the argument is a non-existing directory, create it
    if arg:sub(-1) == "/" and not FileUtilities.isDirectory(arg) then
      -- Create the directory
      vim.fn.mkdir(arg, "p")
    end

    if FileUtilities.isDirectory(arg) then
      vim.cmd("cd " .. arg)
    end
  end
  require("config.lazy")
  -- require("onedarkpro").setup({
  --   "olimorris/onedarkpro.nvim",
  --   -- colors = {
  --   --   -- onelight = { bg = "#263823" },
  --   --   onedark_vivid = { bg = "#263823" },
  --   -- },
  --   -- highlights = {
  --   --   Normal = { bg = "#263853" },
  --   --   NormalNC = { bg = "#263853" },
  --   --   NormalFloat = { bg = "#263853" },
  --   --   NvimTreeNormalNC = { bg = "#263853" },
  --   --   Pmenu = { bg = "#263853" },
  --   --   CursorLine = { bg = "#2C3D58" },
  --   --   Whitespace = { bg = "#2C3D58" },
  --   -- },
  --   priority = 1000, -- Ensure it loads first
  --   opts = {
  --     cursorline = false, -- Use cursorline highlighting?
  --     transparency = true, -- Use a transparent background?
  --     terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
  --     lualine_transparency = false, -- Center bar transparency?
  --     highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
  --   },
  --   styles = {
  --     types = "NONE",
  --     methods = "NONE",
  --     numbers = "NONE",
  --     strings = "NONE",
  --     comments = "italic",
  --     keywords = "bold,italic",
  --     constants = "NONE",
  --     functions = "italic",
  --     operators = "NONE",
  --     variables = "NONE",
  --     parameters = "NONE",
  --     conditionals = "italic",
  --     virtual_text = "NONE",
  --   },
  -- })
  vim.cmd("colorscheme onedarkpro")
  -- vim.cmd("colorscheme onedark_vivid")
  -- require("onedark").setup({
  --   style = "dark",
  --   transparent = true,
  -- })
  -- require("onedark").load()
end
