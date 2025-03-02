-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- vim.keymap.set(
--   "n",
--   "<M-N>",
--   "<Cmd>BufferLineCyclePrev<CR>",
-- )
vim.keymap.set("n", "<M-e>", "<cmd>Neotree focus<cr>", { desc = "Neotree focus" })
vim.keymap.set("n", "<Space>wz", "<cmd>Toggle zoom mode<cr>", { desc = "Toggle Zoom mode" })
