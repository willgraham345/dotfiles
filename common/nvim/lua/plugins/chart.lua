return {
  {
    "3rd/image.nvim",
    build = false,
    opts = {
      backend = "kitty",
      processor = "magick_cli", -- or "magick_rock"
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          only_render_image_at_cursor_mode = "popup",
          floating_windows = false, -- if true, images will be rendered in floating markdown windows
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled = true,
          filetypes = { "norg" },
        },
        typst = {
          enabled = true,
          filetypes = { "typst" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
      editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
    }
  },

  -- Trying with default config, image as dependency
  --
  -- {
  --   "3rd/diagram.nvim",
  --   dependencies = {
  --     "3rd/image.nvim",
  --   },
  --   opts = { -- you can just pass {}, defaults below
  --     events = {
  --       render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
  --       clear_buffer = {"BufLeave"},
  --     },
  --     renderer_options = {
  --       -- mermaid = {
  --       --   background = nil, -- nil | "transparent" | "white" | "#hex"
  --       --   theme = nil, -- nil | "default" | "dark" | "forest" | "neutral"
  --       --   scale = 1, -- nil | 1 (default) | 2  | 3 | ...
  --       --   width = nil, -- nil | 800 | 400 | ...
  --       --   height = nil, -- nil | 600 | 300 | ...
  --       -- },
  --       -- plantuml = {
  --       --   charset = nil,
  --       -- },
  --       d2 = {
  --         theme_id = nil,
  --         dark_theme_id = nil,
  --         scale = nil,
  --         layout = nil,
  --         sketch = nil,
  --       },
  --       -- gnuplot = {
  --       --   size = nil, -- nil | "800,600" | ...
  --       --   font = nil, -- nil | "Arial,12" | ...
  --       --   theme = nil, -- nil | "light" | "dark" | custom theme string
  --       -- },
  --     }
  --   },
  -- },
  -- {
  --   "3rd/diagram.nvim",
  --   dependencies = {
  --     "3rd/image.nvim",
  --   },
  --   opts = { -- you can just pass {}, defaults below
  --     events = {
  --       render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
  --       clear_buffer = { "BufLeave" },
  --     },
  --     renderer_options = {
  --       mermaid = {
  --         background = nil, -- nil | "transparent" | "white" | "#hex"
  --         theme = nil, -- nil | "default" | "dark" | "forest" | "neutral"
  --         scale = 1, -- nil | 1 (default) | 2  | 3 | ...
  --         width = nil, -- nil | 800 | 400 | ...
  --         height = nil, -- nil | 600 | 300 | ...
  --       },
  --       plantuml = {
  --         charset = nil,
  --       },
  --       d2 = {
  --         theme_id = nil,
  --         dark_theme_id = nil,
  --         scale = nil,
  --         layout = nil,
  --         sketch = nil,
  --       },
  --       gnuplot = {
  --         size = nil, -- nil | "800,600" | ...
  --         font = nil, -- nil | "Arial,12" | ...
  --         theme = nil, -- nil | "light" | "dark" | custom theme string
  --       },
  --     },
  --   },
  -- },
}
