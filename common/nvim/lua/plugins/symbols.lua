return {
  {
    "oskarrrrrrr/symbols.nvim",
    config = function()
      local r = require("symbols.recipes")
      require("symbols").setup(
        r.DefaultFilters,
        r.AsciiSymbols,
        {
          -- TODO: Add unfold by default (https://github.com/oskarrrrrrr/symbols.nvim/issues/14)
          sidebar = {
            -- custom settings here
            -- e.g. hide_cursor = false
            cursor_follow = true,
            on_open_make_windows_equal = false,
            -- show_details_pop_up = true,
            auto_resize = {
              enabled = true,
            },
          keymaps = {
             ["tr"] = "toggle-auto-resize",
            ["<Tab>"] = "toggle-fold",
            }
          },
        }
      )
      vim.keymap.set("n", "<space>cs", "<cmd>SymbolsToggle<CR>")
    end
  },
  {
    -- Default trouble.nvim install, without cS turned on...
    "folke/trouble.nvim",
    opts = {
      modes = {
        lsp = {
          -- mode = "diagnostics",
          -- preview = {
          --   type = "float",
          --   relative = "editor",
          --   border = "rounded",
          --   title = "LSP Symbol",
          --   title_pos = "center",
          --   position = { 0, -2 },
          --   size = { width = 0.3, height = 0.3 },
          --   zindex = 200,
          -- },
          -- -- win = { position = "right" },
        },
      },
    },
    -- cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle <cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      -- { "<leader>xx", "<cmd>Trouble diagnostics toggle win.position=right<cr>", desc = "Diagnostics (Trouble)" },
      -- { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0< win.position=right cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", false },
      -- { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      -- { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      -- { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
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
}
