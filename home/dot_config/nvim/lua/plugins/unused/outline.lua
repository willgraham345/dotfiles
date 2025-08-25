return {
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
          -- FIXME: Icons aren't being recognized
          -- icons = {
          --   File = { icon = '󰈔', hl = 'Identifier' },
          --   Module = { icon = '󰆧', hl = 'Include' },
          --   Namespace = { icon = '󰅪', hl = 'Include' },
          --   Package = { icon = '󰏗', hl = 'Include' },
          --   Class = { icon = '𝓒', hl = 'Type' },
          --   Method = { icon = 'ƒ', hl = 'Function' },
          --   Property = { icon = '', hl = 'Identifier' },
          --   Field = { icon = '󰆨', hl = 'Identifier' },
          --   Constructor = { icon = '', hl = 'Special' },
          --   Enum = { icon = 'ℰ', hl = 'Type' },
          --   Interface = { icon = '󰜰', hl = 'Type' },
          --   Function = { icon = '', hl = 'Function' },
          --   Variable = { icon = '', hl = 'Constant' },
          --   Constant = { icon = '', hl = 'Constant' },
          --   String = { icon = '𝓐', hl = 'String' },
          --   Number = { icon = '#', hl = 'Number' },
          --   Boolean = { icon = '⊨', hl = 'Boolean' },
          --   Array = { icon = '󰅪', hl = 'Constant' },
          --   Object = { icon = '⦿', hl = 'Type' },
          --   Key = { icon = '🔐', hl = 'Type' },
          --   Null = { icon = 'NULL', hl = 'Type' },
          --   EnumMember = { icon = '', hl = 'Identifier' },
          --   Struct = { icon = '𝓢', hl = 'Structure' },
          --   Event = { icon = '🗲', hl = 'Type' },
          --   Operator = { icon = '+', hl = 'Identifier' },
          --   TypeParameter = { icon = '𝙏', hl = 'Identifier' },
          --   Component = { icon = '󰅴', hl = 'Function' },
          --   Fragment = { icon = '󰅴', hl = 'Constant' },
          --   TypeAlias = { icon = ' ', hl = 'Type' },
          --   Parameter = { icon = ' ', hl = 'Identifier' },
          --   StaticMethod = { icon = ' ', hl = 'Function' },
          --   Macro = { icon = ' ', hl = 'Function' },
          -- },
        },
        keymaps = {
          up_and_jump = "<up>",
          down_and_jump = "<down>",
        },
        outline_window = {
          auto_close = true
        },
        symbol_folding = {
          autofold_depth = 2,
          auto_unfold = {
            only = 2,
            hovered = false
          },
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
}
