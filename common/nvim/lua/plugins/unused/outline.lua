return {
  -- {
  -- "hedyhli/outline.nvim",
  -- lazy = true,
  -- cmd = { "Outline", "OutlineOpen" },
  -- keys = { -- Example mapping to toggle outline
  --   { "n", "<leader>co", "<cmd>Outline<CR>", {desc = "Toggle outline", noremap = true} },
  --   },
    --   outline_window = {
    --     relative_width = true,
    --     outline = 45,
    --   },
    --   outline_items = {
    --     show_symbol_lineno = true,
    --     show_symbol_details = true,
    --   },
    --   keymaps = {
    --     up_and_jump = '<C-p>',
    --     down_and_jump = '<C-n>',
    --   },
    --   symbol_folding = {
    --     autofold_depth = 2,
    --       auto_unfold = {
    --         hovered = true,
    --         only = true,
    --     },
    --   },
    --   symbols = {
    --     icon_fetcher = function(kind, bufnr, symbol)
    --       local access_icons = { public = '○', protected = '◉', private = '●' }
    --       local icon = require('outline.config').o.symbols.icons[kind].icon
    --       -- ctags provider might add an `access` key
    --       if symbol and symbol.access then
    --         return icon .. ' ' .. access_icons[symbol.access]
    --       end
    --       return icon
    --     end,
    --   },
    -- },
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
  -- },
  {
    "hedyhli/outline.nvim",
    keys = { { "<leader>co", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
    cmd = "Outline",
    opts = function()
      local defaults = require("outline.config").defaults
      local opts = {
        symbols = {
          icons = {},
          -- filter = vim.deepcopy(LazyVim.config.kind_filter),
        },
        keymaps = {
          up_and_jump = "<up>",
          down_and_jump = "<down>",
        },
        outline_window = {
          auto_close = true
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
  },
  {
    -- Default trouble.nvim install, without cS turned on...
    "folke/trouble.nvim",
    opts = {
      modes = {
        lsp = {
          mode = "diagnostics",
          preview = {
            type = "float",
            relative = "editor",
            border = "rounded",
            title = "LSP Symbol",
            title_pos = "center",
            position = { 0, -2 },
            size = { width = 0.3, height = 0.3 },
            zindex = 200,
          },
          -- win = { position = "right" },
        },
      },
    },
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", false },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
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
