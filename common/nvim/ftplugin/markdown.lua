-- ~/.config/nvim/ftplugin/markdown.lua
-- Insert mode: Tab to indent
vim.keymap.set("i", "<Tab>", "<Tab>", { buffer = true, desc = "Indent in markdown" })

-- Normal mode: Tab to indent line
vim.keymap.set("n", "<Tab>", ">>", { buffer = true, desc = "Normal indent in markdown" })

-- Visual mode: Tab to indent selection
vim.keymap.set("v", "<Tab>", ">gv", { buffer = true, desc = "Visual indent in markdown" })

-- Insert mode: Shift+Tab to de-indent
vim.keymap.set("i", "<S-Tab>", "<C-d>", { buffer = true, desc = "De-indent in markdown" })
-- Normal mode: Shift+Tab to unindent line
vim.keymap.set("n", "<S-Tab>", "<<", { buffer = true, desc = "Normal de-indent in markdown" })
-- Visual mode: Shift+Tab to unindent selection
vim.keymap.set("v", "<S-Tab>", "<gv", { buffer = true, desc = "Visual de-indent in markdown" })
