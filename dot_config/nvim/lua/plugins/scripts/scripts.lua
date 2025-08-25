-- ~/.config/nvim/lua/plugins/scripts/commands.lua

-- Ensure which-key is loaded. If you're using a plugin manager like Lazy.nvim,
-- it will handle loading which-key for you. If not, make sure it's set up
-- in your main init.lua.
local wk_status, which_key = pcall(require, "which-key")
if not wk_status then
  vim.notify(
    "which-key.nvim is not loaded. Script commands will not be registered with which-key.",
    vim.log.levels.WARN
  )
end

-- Define the path to your Vimscript file.
-- vim.fn.stdpath('config') gets the path to your Neovim config directory (e.g., ~/.config/nvim)
local script_dir = vim.fn.stdpath("config") .. "/lua/plugins/scripts/"
local fix_squashed_table_script_path = script_dir .. "fix_squashed_table.vim"

vim.api.nvim_create_user_command("ScriptFixSquashedTable", function()
  -- Check if the script file exists before attempting to source it
  if vim.fn.filereadable(fix_squashed_table_script_path) == 1 then
    vim.cmd("source " .. fix_squashed_table_script_path)
  else
    vim.notify("Error: fix_squashed_table.vim not found at " .. fix_squashed_table_script_path, vim.log.levels.ERROR)
  end
end, {
  desc = "Run the script to fix squashed tables", -- Description shown in :h :FixSquashedTable
  -- You can add other attributes here, e.g., 'range', 'nargs', 'bang'
  -- See :h nvim_create_user_command for more options.
})

if which_key then
  which_key.add({
    { "<BS>s", group = "MyScripts" },
    { "<BS>sf", "<cmd>ScriptFixSquashedTable<CR>", desc = "Fix squashed md tables", mode = "n" },
  })
end

-- You can add a simple print statement to confirm this file was sourced
-- vim.notify("scripts.lua scripts commands was loaded", vim.log.levels.WARN)
