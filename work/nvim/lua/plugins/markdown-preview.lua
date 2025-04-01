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
    config = function()
      -- vim.g.mkdp_auto_start = 1 -- Automatically start
      -- vim.g.mkdp_refresh_slow = 1 -- Update preview in real-time
      -- vim.g.mkdp_combine_preview = 1
      -- vim.g.mkdp_combine_preview_auto_refresh = 1
    end,
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
        border = "thick",
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
  -- {
  --   ""OXY2DEV/markview.nvim"",
  --   lazy = false,
  -- },
  -- {
  --   { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  -- },
  -- For blink.cmp's completion
  -- source
  -- dependencies = {
  --     "saghen/blink.cmp"
  -- },
  -- {
  --   "toppair/peek.nvim",
  --   event = { "VeryLazy" },
  --   build = "deno task --quiet build:fast",
  --   config = function()
  --     require("peek").setup()
  --     vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
  --     vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  --   end,
  -- },
}
