-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- options
vim.g.snacks_animate = false
vim.g.lazyvim_picker = "fzf"
vim.g.lazyvim_cmp = "nvim.cmp"
vim.g.mkdp_theme = "light"
vim.g.auto_close = 0
vim.g.mkdp_update_time = 250
vim.opt.relativenumber = false
vim.g.lazygit_floating_window_scaling_factor = 0.99 -- scaling factor for floating window
vim.g.lazyvim_python_lsp = "pyright" -- Can also be "basedpyright"
vim.g.lazyvim_rust_diagnostics = "bacon-ls"
local opt = vim.opt
vim.opt.expandtab = true
vim.opt.tabstop = 4
opt.mouse = "a"
opt.sidescroll = 1

vim.opt.pumblend = 0 -- Turns off transparency for windows
vim.opt.winblend = 0

-- Commands to run
-- TODO: Figure out how to add a different color for visual mode
