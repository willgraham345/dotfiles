return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  version = "2.*",
  config = function()
    require("window-picker").setup({
      hint = "floating-letter",
      picker_config = {
        handle_mouse_click = true,
        floating_big_letter = {
          -- window picker plugin provides bunch of big letter fonts
          -- fonts will be lazy loaded as they are being requested
          -- additionally, user can pass in a table of fonts in to font
          -- property to use instead

          font = "ansi-shadow", -- ansi-shadow |
        },
      },
      show_prompt = true,
    })
  end,
}
