-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- options
vim.g.snacks_animate = false
vim.g.lazyvim_picker = "fzf"
vim.g.lazyvim_cmp = "nvim.cmp"
vim.opt.relativenumber = false
vim.g.lazygit_floating_window_scaling_factor = 0.95 -- scaling factor for floating window
local opt = vim.opt
vim.opt.expandtab = false
vim.opt.tabstop = 4

-- Commands to run
-- TODO: Figure out how to add a different color for visual mode
