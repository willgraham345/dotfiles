return {
  "rmagatti/goto-preview",
  dependencies = { "rmagatti/logger.nvim" },
  event = "BufEnter",
  -- config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  config = function()
    require("goto-preview").setup({
      width = 150,
      height = 50,
      config = true,
      default_mappings = true,
    })
  end,
}
