return {
  --  {
  --    "L3MON4D3/LuaSnip",
  --    -- follow latest release.
  --    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  --    -- install jsregexp (optional!).
  --    build = "make install_jsregexp",
  --    dependencies = { "rafamadriz/friendly-snippets" },
  -- local luasnip = require("luasnip"),
  -- local vscode_loader = require("luasnip.loaders.from_vscode"),
  -- vscode_loader.load({ paths = {vim.fn.stdpath("config") .. "/snippets"}}),
  --
  --  },

  {
    "rafamadriz/friendly-snippets",

  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (not LazyVim.is_win())
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
        end,
      },
    },
    opts = {
      history = true,
      region_check_events = "CursorMoved",
      delete_check_events = "TextChanged"
    },
  },
}
