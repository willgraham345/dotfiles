-- ~/.config/nvim/ftplugin/d2.lua
-- Insert mode: Shift+Tab to de-indent
vim.keymap.set("i", "<S-Tab>", "<C-d>", { buffer = true, desc = "De-indent in markdown" })
-- Normal mode: Shift+Tab to unindent line
vim.keymap.set("n", "<S-Tab>", "<<", { buffer = true, desc = "Normal de-indent in markdown" })
-- Visual mode: Shift+Tab to unindent selection
vim.keymap.set("v", "<S-Tab>", "<gv", { buffer = true, desc = "Visual de-indent in markdown" })
