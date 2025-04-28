return {
  -- {
  -- "NeogitOrg/neogit",
  -- dependencies = {
  --   "nvim-lua/plenary.nvim", -- required
  --   "sindrets/diffview.nvim", -- optional - Diff integration
  --
  --   -- Only one of these is needed.
  --   -- "nvim-telescope/telescope.nvim", -- optional
  --   "ibhagwan/fzf-lua", -- optional
  --   -- "echasnovski/mini.pick", -- optional
  -- },
  -- config = true,
  -- }
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb", "nvim-tree/nvim-web-devicons" },
    cmd = { "Git", "G" },
    lazy = false,
  },
  -- {
  -- Only supports GitHub for now :(
  --   "pwntester/octo.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     -- 'nvim-telescope/telescope.nvim',
  --     -- OR 'ibhagwan/fzf-lua',
  --     -- OR 'folke/snacks.nvim',
  --     "ibhagwan/fzf-lua",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   opts = {
  --     enable_builtin = true,
  --     default_to_projects_v2 = true,
  --     default_merge_method = "squash",
  --     picker = "fzf-lua",
  --   },
  --   opts = function(_, opts)
  --     vim.treesitter.language.register("markdown", "octo")
  --     -- if LazyVim.has_extra("editor.telescope") then
  --     --   opts.picker = "telescope"
  --     if LazyVim.has_extra("editor.fzf") then
  --       opts.picker = "fzf-lua"
  --     elseif LazyVim.has_extra("editor.snacks_picker") then
  --       opts.picker = "snacks"
  --     else
  --       LazyVim.error("`octo.nvim` requires `telescope.nvim` or `fzf-lua` or `snacks.nvim`")
  --     end
  --
  --     -- Keep some empty windows in sessions
  --     vim.api.nvim_create_autocmd("ExitPre", {
  --       group = vim.api.nvim_create_augroup("octo_exit_pre", { clear = true }),
  --       callback = function(ev)
  --         local keep = { "octo" }
  --         for _, win in ipairs(vim.api.nvim_list_wins()) do
  --           local buf = vim.api.nvim_win_get_buf(win)
  --           if vim.tbl_contains(keep, vim.bo[buf].filetype) then
  --             vim.bo[buf].buftype = "" -- set buftype to empty to keep the window
  --           end
  --         end
  --       end,
  --     })
  --   end,
  -- },
}
