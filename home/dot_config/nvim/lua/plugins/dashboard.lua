return {
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
          statusline = false,
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
}
