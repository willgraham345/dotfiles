-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- options
local globals = vim.g
globals.snacks_animate = false
globals.lazyvim_picker = "fzf"
globals.lazyvim_cmp = "nvim.cmp"
globals.mkdp_theme = "light"
globals.auto_close = 0
globals.mkdp_update_time = 250
globals.lazygit_floating_window_scaling_factor = 0.99 -- scaling factor for floating window
globals.lazyvim_python_lsp = "pyright" -- Can also be "basedpyright"
globals.markdown_recommended_style = 1
globals.autoformat = true
-- globals.expandtab = true -- Not sure why this was set, if I leave it blank the tab won't put the cursor one character to the left after tab.
local opt = vim.opt
opt.relativenumber = false
-- opt.smartindent = true
-- opt.expandtab = true -- Not sure why this was set, if I leave it blank the tab won't put the cursor one character to the left after tab.
-- opt.softtabstop = -1 -- Uses the width of "shiftwidth"
-- opt.smarttab = true
opt.mouse = "a"
opt.sidescroll = 1
-- opt.shiftwidth = 4
opt.splitbelow = false

vim.opt.pumblend = 0 -- Turns off transparency for windows
vim.opt.winblend = 0

-- Commands to run
-- TODO: Figure out how to add a different color for visual mode
