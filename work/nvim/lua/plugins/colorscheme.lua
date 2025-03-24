return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    opts = {
      cursorline = true, -- Use cursorline highlighting?
      transparency = false, -- Use a transparent background?
      terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
      lualine_transparency = false, -- Center bar transparency?
      highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
    },
    styles = {
      types = "NONE",
      methods = "NONE",
      numbers = "NONE",
      strings = "NONE",
      comments = "italic",
      keywords = "bold,italic",
      constants = "NONE",
      functions = "italic",
      operators = "NONE",
      variables = "NONE",
      parameters = "NONE",
      conditionals = "italic",
      virtual_text = "NONE",
    },
  },
  { "projekt0n/github-nvim-theme", name = "github-theme" },
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      -- vim.g.sonokai_style = "atlantis"
      vim.g.sonokai_enable_italic = true
      vim.cmd.colorscheme("sonokai")
    end,
  },
}

-- return {
--   { "navarasu/onedark.nvim" },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       style = "cool", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
--       transparent = false, -- Show/hide background
--       term_colors = true, -- Change terminal color as per the selected theme style
--       ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
--       cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
--
--       -- toggle theme style ---
--       toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
--       toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
--
--       -- Change code style ---
--       -- Options are italic, bold, underline, none
--       -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
--       code_style = {
--         comments = "italic",
--         keywords = "none",
--         functions = "none",
--         strings = "none",
--         variables = "none",
--       },
--
--       -- Lualine options --
--       lualine = {
--         transparent = true, -- lualine center bar transparency
--       },
--
--       -- Custom Highlights --
--       colors = {}, -- Override default colors
--       highlights = {}, -- Override highlight groups
--
--       -- Plugins Config --
--       diagnostics = {
--         darker = true, -- darker colors for diagnostic
--         undercurl = true, -- use undercurl instead of underline for diagnostics
--         background = true, -- use background color for virtual text
--       },
--       colorscheme = "onedark",
--     },
--   },
-- }
