return {
  "tpope/vim-fugitive",
  dependencies = { "tpope/vim-rhubarb" }, -- Fugitive depends on vim-rhubarb
  cmd = { "Git", "G" }, -- Optional: Add Fugitive commands to the command list
  lazy = false, -- Or true if you want it to be lazy-loaded
}
