local wk = require("which-key")

-- Registering keymaps
wk.add({
  -- Top-level groups for organization
  { "<leader>b", group = "Buffer" },
  { "<leader>c", group = "Code" },
  { "<leader>d", group = "DAP (Debug)" },
  { "<leader>g", group = "Git" },
  { "<leader>l", group = "LSP / Lists" },
  { "<leader>m", group = "Make/CMake/Clangd" },
  { "<leader>r", group = "Refactor" },
  { "<leader>s", group = "Search" },
  { "<leader>t", group = "Test" },
  { "<leader>u", group = "Usage" },
  { "<leader>x", group = "Trouble/Quickfix" },
  { "<leader><Tab>", group = "Tab" },
  { "<BS>", group = "Commands", mode = { "n", "v" } },
  -- Window and Tab keymaps (no common prefix, so list them individually)
})
return {
  {
    "folke/which-key.nvim",
    opts = {
      preset = "helix",
    },
  },
}
