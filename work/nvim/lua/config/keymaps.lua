-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

------------------
-- Will keymaps
------------------
local map = vim.keymap.set
map("n", "<M-q>", "<C-w>q", { noremap = true, desc = "Kills the current window" })
map("n", "<M-w>", "<C-w>q", { noremap = true, desc = "Kills the current window" })
map("n", "<M-e>", function()
  Snacks.explorer({ focus })
end, { desc = "Neotree focus" })
map("n", "<M-m>", function()
  Snacks.zen.zoom()
end, { desc = "Maximize window" })
map("n", "<M-d>", function()
  Snacks.bufdelete()
end, { desc = "Deletes buffer in one command" })
map("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { noremap = true, desc = "Starts Fugitive Diff window" })
map("n", "<leader>xc", function()
  vim.cmd("command! ClearQuickfixList cexpr []")
end, { noremap = true, desc = "Clear the quickfix list" })
-- Open compiler
map("n", "<C-ScrollWheelDown>", "5zl", { desc = "Scroll right" })
map("n", "<C-ScrollWheelUp>", "5zh", { desc = "Scroll left" })
vim.api.nvim_set_keymap("n", "<F6>", "<cmd><cr>", { noremap = true, silent = true })
map("n", "<leader>cj", function()
  local schema = require("yaml-companion").get_buf_schema(0)
  if schema.result[1].name == "none" then
    return ""
  end
  return schema.result[1].name
end, { noremap = true, desc = "Shows current yaml/json schema loaded" })
map("n", "<leader>cJ", function()
  require("yaml-companion").open_ui_select()
end, { noremap = true, desc = "Shows current yaml/json schema loaded" })
map("n", "<leader>cP", "<cmd>PeekOpen<CR>", { desc = "Markdown PeekOpen" })

vim.api.nvim_set_keymap("n", "<S-F6>", "<cmd>OverseerRun CMake Configure<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-F7>", "<cmd>OverseerRun CMake Build<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "]<Tab>", ":tabnext<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "[<S-Tab>", ":tabprevious<CR>", { desc = "Go to previous tab" })
