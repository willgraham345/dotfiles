return {
  {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = { -- Example mapping to toggle outline
    { "n", "<leader>cs", "<cmd>Outline<CR>", {desc = "Toggle outline", noremap = true} },
    },
  opts = {
      outline_window = {
        relative_width = true,
        outline = 20,
      },
      outline_items = {
        show_symbol_lineno = true,
        show_symbol_details = true,
      },
      keymaps = {
        up_and_jump = '<C-p>',
        down_and_jump = '<C-n>',
      },
      symbol_folding = {
        autofold_depth = 2,
          auto_unfold = {
            hovered = true,
            only = true,
        },
      },
      symbols = {
        icon_fetcher = function(kind, bufnr, symbol)
          local access_icons = { public = '○', protected = '◉', private = '●' }
          local icon = require('outline.config').o.symbols.icons[kind].icon
          -- ctags provider might add an `access` key
          if symbol and symbol.access then
            return icon .. ' ' .. access_icons[symbol.access]
          end
          return icon
        end,
      },
    },
  -- opts = function(_, opts)
  --   local defaults = require("outline.config").defaults
  --   local opts = {
  --     symbols = {
  --       icons = {},
  --       filter = vim.deepcopy(LazyVim.config.kind_filter),
  --     },
  --     keymaps = {
  --       up_and_jump = "<up>",
  --       down_and_jump = "<down>",
  --     },
  --     symbol_folding = {
  --       autofold_depth = 3,
  --       auto_unfold = {
  --         hovered = true,
  --         only = true,
  --       },
  --     },
  --     outline_items = {
  --       show_symbol_lineno = true,
  --       show_symbol_details = true,
  --     },
  --   }
  --
  --   for kind, symbol in pairs(defaults.symbols.icons) do
  --     opts.symbols.icons[kind] = {
  --       icon = LazyVim.config.icons.kinds[kind] or symbol.icon,
  --       hl = symbol.hl,
  --     }
  --   end
  --   return opts
  -- end,
  },
  {
  "folke/trouble.nvim",
  optional = true,
  keys = {
    { "<leader>cs", false },
  },
  },
  -- {
  --   "stevearc/aerial.nvim",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   event = {"BufReadPost", "BufWritePost", "BufNewFile"},
  --   opts = function()
  --     local icons = vim.deepcopy(LazyVim.config.icons.kinds)
  --
  --     -- HACK: fix lua's weird choice for `Package` for control
  --     -- structures like if/else/for/etc.
  --     icons.lua = { Package = icons.Control }
  --
  --     ---@type table<string, string[]>|false
  --     local filter_kind = false
  --     if LazyVim.config.kind_filter then
  --       filter_kind = assert(vim.deepcopy(LazyVim.config.kind_filter))
  --       filter_kind._ = filter_kind.default
  --       filter_kind.default = nil
  --     end
  --
  --     local opts = {
  --       attach_mode = "global",
  --       backends = { "lsp", "treesitter", "markdown", "man" },
  --       show_guides = true,
  --       layout = {
  --         resize_to_content = false,
  --         win_opts = {
  --           winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
  --           signcolumn = "yes",
  --           statuscolumn = " ",
  --         },
  --       },
  --       icons = icons,
  --       filter_kind = false,
  --       -- stylua: ignore
  --       guides = {
  --         mid_item   = "├╴",
  --         last_item  = "└╴",
  --         nested_top = "│ ",
  --         whitespace = "  ",
  --       },
  --       nerd_font = true,
  --     }
  --     return opts
  --   end,
  -- },
}
