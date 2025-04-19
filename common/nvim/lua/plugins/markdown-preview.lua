return {
  -- For markdown preview, see opts file
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    opts = function(_, opts)
      vim.g.mkdp_auto_close = 0
    end,
    -- config = function()
    --   -- vim.g.mkdp_auto_start = 1 -- Automatically start
    --   -- vim.g.mkdp_refresh_slow = 1 -- Update preview in real-time
    --   -- vim.g.mkdp_combine_preview = 1
    --   -- vim.g.mkdp_combine_preview_auto_refresh = 1
    -- end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        enabled = true,
        render_modes = false,
        sign = false,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        position = "overlay",
        signs = { "󰫎 " },
        width = "block",
        left_margin = 0,
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = false,
        border_virtual = false,
        border_prefix = false,
        above = "",
        below = "",
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
        custom = {},
      },
      code = {
        enabled = true,
        render_modes = false,
        sign = true,
        style = "full",
        position = "left",
        language_pad = 0,
        language_icon = true,
        language_name = true,
        disable_background = { "diff" },
        width = "full",
        left_margin = 0,
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = "thin",
        above = " ",
        below = " ",
        highlight = "RenderMarkdownCode",
        highlight_language = nil,
        highlight_fallback = "RenderMarkdownCodeFallback",
        inline_pad = 0,
        highlight_inline = "RenderMarkdownCodeInline",
      },
      indent = {
        enabled = true,
        render_modes = false,
        per_level = 2,
        skip_level = 1,
        skip_heading = false,
        highlight = "RenderMarkdownIndent",
      },
    },
  },
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "Space Dynamics Lab",
        path = "/mnt/c/Users/wgraham/Documents/Obsidian_vaults/Space Dynamics Lab",
      },
      {
        name = "work",
        path = "mnt/c/Users/wgraham/Documents/Obsidian_vaults/Work",
      },
    },

    -- see below for full list of options 👇
  },
  -- {
  --   "toppair/peek.nvim",
  --   event = { "VeryLazy" },
  --   build = "deno task --quiet build:fast",
  --   config = function()
  --     require("peek").setup({
  --       theme = "light",
  --     })
  --     vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
  --     vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  --   end,
  -- },
}
