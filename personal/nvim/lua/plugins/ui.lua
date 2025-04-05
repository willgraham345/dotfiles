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
    opts = function(_, opts)
      local logo = [[
	  ██╗    ██╗██╗██╗     ██╗      ██╗   ██╗██╗███╗   ███╗
	  ██║    ██║██║██║     ██║      ██║   ██║██║████╗ ████║
	  ██║ █╗ ██║██║██║     ██║█████╗██║   ██║██║██╔████╔██║
	  ██║███╗██║██║██║     ██║╚════╝╚██╗ ██╔╝██║██║╚██╔╝██║
	  ╚███╔███╔╝██║███████╗███████╗  ╚████╔╝ ██║██║ ╚═╝ ██║
	  ╚══╝╚══╝ ╚═╝╚══════╝╚══════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
	  ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
      opts.theme = "doom"

      -- local opts = {
      -- config = {
      -- picker = {
      --   hidden = true,
      --   ignored = true,
      -- },
      -- header = vim.split(logo, "\n"),
      -- center = {
      --   { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      --   { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
      --   { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
      --   { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
      --   {
      --     icon = " ",
      --     key = "c",
      --     desc = "Config",
      --     action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
      --   },
      --   { icon = " ", key = "s", desc = "Restore Session", section = "session" },
      --   { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
      --   { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
      --   { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      -- },
      -- footer = function()
      --   local stats = require("lazy").stats()
      --   local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      --   return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
      -- end,
      -- },
      -- }
      -- for _, button in ipairs(opts.config.center) do
      --   button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      --   button.key_format = "  %s"
      -- end
      --
      -- if vim.o.filetype == "lazy" then
      --   vim.api.nvim_create_autocmd("WinClosed", {
      --     pattern = tostring(vim.api.nvim_get_current_win()),
      --     once = true,
      --     callback = function()
      --       vim.schedule(function()
      --         vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
      --       end)
      --     end,
      --   })
      -- end
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
}
