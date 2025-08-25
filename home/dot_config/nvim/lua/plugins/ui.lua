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
  -- FIXME: Needs to either be added or completely removed
  {
    "ellisonleao/glow.nvim",
    -- config = true,
    cmd = "Glow",
    config = function()
      -- require("glow").setup({
      --   pager = true,
      -- })
    end,
  },
  -- {
  --   -- FIXME: This may cause a problem with the flash delete, not sure what is does.
  --     "kylechui/nvim-surround",
  --     version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
  --     event = "VeryLazy",
  --     config = function()
  --         require("nvim-surround").setup({
  --             -- Configuration here, or leave empty to use defaults
  --         })
  --     end
  -- },
}
