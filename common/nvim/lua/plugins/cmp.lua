return {
  {
  "hrsh7th/nvim-cmp",
  optional = true,
  dependencies = { "saadparwaiz1/cmp_luasnip" },
  opts = function(_, opts)
    opts.snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    }
    table.insert(opts.sources, { name = "luasnip" })
  end,
  -- stylua: ignore
  -- keys = {
    -- { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
    -- { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
  -- }
  },
  {
    "saghen/blink.cmp",
    opts = {
      snippets = {
        expand = function(snippet, _)
          return LazyVim.cmp.expand(snippet)
        end,
      },
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true
          }
        }
      },

      -- experimental signature help support
      -- signature = { enabled = true },
      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {},
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- FIXME: Still trying to suggest on command line
      cmdline = {
        enabled = false,
      },

      keymap = {
        preset = "super-tab"
      },
    }
  }

  -- FIXME: cmp not working (not sure if this is what is handling the cmp, might be blink)
--   {
--   "hrsh7th/nvim-cmp",
--   optional = true,
--   dependencies = { "saadparwaiz1/cmp_luasnip",
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--   },
--   opts = function(_, opts)
--     local cmp = require("cmp")
--     local defaults = require("cmp.config.default")()
--     local auto_select = false
--     opts.snippet = {
--       expand = function(args)
--         require("luasnip").lsp_expand(args.body)
--       end,
--     }
--     opts.completion = {
--         completeopt = "menu,menyuone,noinsert" .. (auto_select and "" or ",noselect")
--       }
--     opts.preselect = cmp.PreselectMode.None
--     opts.mapping = vim.tbl_extend("force", opts.mapping, {
--       ["<C-y>"] = cmp.mapping.confirm({ select = true }),
--       ["<CR>"] = function(fallback)
--           cmp.abort()
--           fallback()
--         end,
--       -- ["<C-l>"] = cmp.mapping(function()
--       --   if luasnip.expand_or_locally_jumpable() then
--       --     luasnip.expand_or_jump()
--       --   end
--       -- end, { "i", "s" }),
--       -- ["<C-h>"] = cmp.mapping(function()
--       --   if luasnip.locally_jumpable(-1) then
--       --     luasnip.jump(-1)
--       --   end
--       -- end, { "i", "s" }),
--     })
--
--     table.insert(opts.sources, { name = "luasnip" })
--   end,
--   -- stylua: ignore
--   -- keys = {
--     -- { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
--     -- { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
--   -- }
-- }
}
