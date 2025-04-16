return {
  {
    "hedyhli/outline.nvim",
    keys = { { "<leader>cs", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
    cmd = "Outline",
    opts = function()
      local defaults = require("outline.config").defaults
      local opts = {
        symbols = {
          icons = {},
          filter = vim.deepcopy(LazyVim.config.kind_filter),
          symbol_folding = {
            autofold_depth = 1,
            auto_unfold = {
              only = 3,
            },
          },
          outline_items = {
            -- show_symbol_details = false,
            show_symbol_lineno = true,
          },
          preview_window = {
            auto_preview = false,
          },
        },
        keymaps = {
          up_and_jump = "<up>",
          down_and_jump = "<down>",
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
  -- Rust configs
  {
    "mrcjkb/rustaceanvim",
    lazy = true,
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>cR", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust if using rust-analyzer
            checkOnSave = true,
            check = {
              command = "clippy",
            },
            -- Enable diagnostics if using rust-analyzer
            diagnostics = {
              enable = true,
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
            },
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mrcjkb/rustaceanvim",
    },
    opts = {},
  },
  -- Rust configs
  -- {
  --   "mrcjkb/rustaceanvim",
  --   lazy = true,
  --   opts = {},
  -- },
}

-- return {
--   {
--     "simrat39/symbols-outline.nvim",
--     opts = function(_, opts)
--       table.insert(opts.sources, {
--         symbol_folding = {
--           autofold_depth = 1,
--           auto_unfold = {
--             hovered = true,
--             only = 2,
--           },
--         },
--       })
--     end,
--   },
-- }
--{
