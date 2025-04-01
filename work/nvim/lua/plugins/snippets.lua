return {
  -- {
  --   "echasnovski/mini.snippets",
  --   opts = function(_, opts)
  --     -- By default, for opts.snippets, the extra for mini.snippets only adds gen_loader.from_lang()
  --     -- This provides a sensible quickstart, integrating with friendly-snippets
  --     -- and your own language-specific snippets
  --     --
  --     -- In order to change opts.snippets, replace the entire table inside your own opts
  --
  --     local snippets, config_path = require("mini.snippets"), vim.fn.stdpath("config")
  --
  --     opts.snippets = { -- override opts.snippets provided by extra...
  --       -- Load custom file with global snippets first (order matters)
  --       snippets.gen_loader.from_file(config_path .. "/snippets/global.json"),
  --
  --       -- Load snippets based on current language by reading files from
  --       -- "snippets/" subdirectories from 'runtimepath' directories.
  --       snippets.gen_loader.from_lang(), -- this is the default in the extra...
  --     }
  --   end,
  -- },
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
    "L3MON4D3/LuaSnip",
    event = "LspAttach",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "v2.*",
    build = "make install_jsregexp",
    init = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
    end,
  },
}
