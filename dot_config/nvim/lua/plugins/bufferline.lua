return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<leader>bs", "<Cmd>BufferLineSortByDirectory<CR>", desc = "Sort Buffers by Directory" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = {
      options = {
        -- stylua: ignore
        close_command = function(n) Snacks.bufdelete(n) end,
        -- stylua: ignore
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
        name_formatter = function(buf)
          local filename = vim.fn.fnamemodify(buf.name, ":t")
          local parent = vim.fn.fnamemodify(buf.path, ":h:t")
          return parent .. "/" .. filename
        end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        diagnostics_indicator = function(_, _, diag)
          local icons = LazyVim.config.icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
          {
            filetype = "snacks_layout_box",
          },
        },
        ---@param opts bufferline.IconFetcherOpts
        get_element_icon = function(opts)
          return LazyVim.config.icons.ft[opts.filetype]
        end,
        sort_by = "relative_directory",
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
      -- FIXME: Groups not being created
      -- local groups = require("bufferline.groups")
      -- groups = {
      --   items = {
      --     {
      --       name = "Tests", -- Mandatory
      --       highlight = { underline = true, sp = "blue" }, -- Optional
      --       priority = 2, -- determines where it will appear relative to other groups (Optional)
      --       icon = " ", -- Optional
      --       matcher = function(buf) -- Mandatory
      --         return buf.filename:match("%_test") or buf.filename:match("%_spec")
      --       end,
      --     },
      --     {
      --       name = "docs",
      --       priority = 2,
      --       -- auto_close = true,
      --       matcher = function(buf)
      --         return buf.filename:match("%.md") or buf.filename:match("%.txt")
      --       end,
      --       separator = {
      --         style = require("bufferline.groups").separator.tab,
      --       },
      --     },
      --   },
      -- }
    end,
  },
}
