return {
  "rmagatti/goto-preview",
  dependencies = { "rmagatti/logger.nvim" },
  event = "BufEnter",
  config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  opts = {
    default_mappings = true,
    references = {
      provider = "snacks",
      -- snacks = require("snacks.picker").get_dropdown({ hide_preview = false }),
      snacks = require("snacks").picker.picker_preview,
    },
    focus_on_open = true,
    -- dismiss_on_move = true,
    width = 150,
    height = 50,
  },
}
