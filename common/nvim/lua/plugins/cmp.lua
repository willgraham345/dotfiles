return {
  -- {
  -- "hrsh7th/nvim-cmp",
  -- optional = true,
  -- dependencies = { "saadparwaiz1/cmp_luasnip" },
  -- opts = function(_, opts)
  --   opts.snippet = {
  --     expand = function(args)
  --       require("luasnip").lsp_expand(args.body)
  --     end,
  --   }
  --   table.insert(opts.sources, { name = "luasnip" })
  -- end,
  -- -- stylua: ignore
  -- -- keys = {
  --   -- { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
  --   -- { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
  -- -- }
  -- },
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
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
      },

      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        -- ['<CR>'] = nil,

        ['<Tab>'] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.accept()
            else return cmp.select_and_accept() end
          end,
          'snippet_forward',
          'fallback'
        },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },

      term = {
        enabled = false,
        keymap = { preset = 'inherit' }, -- Inherits from top level `keymap` config when not set
        sources = {},
        completion = {
          trigger = {
            show_on_blocked_trigger_characters = {},
            show_on_x_blocked_trigger_characters = nil, -- Inherits from top level `completion.trigger.show_on_blocked_trigger_characters` config when not set
          },
          -- Inherits from top level config options when not set
          list = {
            selection = {
              -- When `true`, will automatically select the first item in the completion list
              preselect = nil,
              -- When `true`, inserts the completion item automatically when selecting it
              auto_insert = nil,
            },
          },
          -- Whether to automatically show the window when new completion items are available
          menu = { auto_show = nil },
          -- Displays a preview of the selected item on the current line
          ghost_text = { enabled = nil },
        }
      }
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
