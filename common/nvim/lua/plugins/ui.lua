return {
  -- {
  --   "s1n7ax/nvim-window-picker",
  --   name = "window-picker",
  --   event = "VeryLazy",
  --   version = "2.*",
  --   config = function()
  --     require("window-picker").setup()
  --   end,
  -- },
  {
    "bufferline.nvim",
    opts = {
      options = {
        separator_style = "thin", -- Made this as small as possible
        max_name_length = 30, --Increased this, most files are too short for me
        -- stylua: ignore
        close_command = function(n) Snacks.bufdelete(n) end,
        -- stylua: ignore
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
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
      },
    },
  },
  {
    "tiagovla/scope.nvim",
    config = true,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
	  ██╗    ██╗██╗██╗     ██╗      ██╗   ██╗██╗███╗   ███╗
	  ██║    ██║██║██║     ██║      ██║   ██║██║████╗ ████║
	  ██║ █╗ ██║██║██║     ██║█████╗██║   ██║██║██╔████╔██║
	  ██║███╗██║██║██║     ██║╚════╝╚██╗ ██╔╝██║██║╚██╔╝██║
	  ╚███╔███╔╝██║███████╗███████╗  ╚████╔╝ ██║██║ ╚═╝ ██║
	  ╚══╝╚══╝ ╚═╝╚══════╝╚══════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
	  ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
            statuslin = false
          },
        config = {
        picker = {
          hidden = true,
          ignored = true,
        },
        header = vim.split(logo, "\n"),
        center = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "e", desc = "File explorer", action = ":lua Snacks.explorer({ focus })" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", action = ':lua require("persistence").load()' },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
        },
      }
      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
            end)
          end,
        })
      end
      return opts
    end,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      picker = {
        hidden = true,
        ignored = true,
      },
    },
  },
  {
    "ellisonleao/glow.nvim",
    -- config = true,
    cmd = "Glow",
    config = function()
      require("glow").setup({
        pager = true,
      })
    end,
  },
  {
    -- FIXME: This may cause a problem with the flash delete, not sure what is does.
      "kylechui/nvim-surround",
      version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  }
  --   {
  --   "echasnovski/mini.surround",
  --   keys = function(_, keys)
  --     -- Populate the keys based on the user's options
  --     local opts = LazyVim.opts("mini.surround")
  --     local mappings = {
  --       { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
  --       { opts.mappings.delete, desc = "Delete Surrounding" },
  --       { opts.mappings.find, desc = "Find Right Surrounding" },
  --       { opts.mappings.find_left, desc = "Find Left Surrounding" },
  --       { opts.mappings.highlight, desc = "Highlight Surrounding" },
  --       { opts.mappings.replace, desc = "Replace Surrounding" },
  --       { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
  --     }
  --     mappings = vim.tbl_filter(function(m)
  --       return m1 and #m[1] > 0
  --     end, mappings)
  --     return vim.list_extend(mappings, keys)
  --   end,
  --   opts = {
  --     mappings = {
  --       add = "gsa", -- Add surrounding in Normal and Visual modes
  --       delete = "gsd", -- Delete surrounding
  --       find = "gsf", -- Find surrounding (to the right)
  --       find_left = "gsF", -- Find surrounding (to the left)
  --       highlight = "gsh", -- Highlight surrounding
  --       replace = "gsr", -- Replace surrounding
  --       update_n_lines = "gsn", -- Update `n_lines`
  --     },
  --   },
  -- }
}
